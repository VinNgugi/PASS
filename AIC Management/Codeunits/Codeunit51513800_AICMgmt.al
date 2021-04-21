codeunit 51513800 "AIC Management"
{
    trigger OnRun()
    begin

    end;


    procedure SubmitApplication(var Applicants: Record "Incubation Applicants")
    var
        myInt: Integer;
    begin
        with Applicants do begin
            TestField("Incubation Code");
            TestField("Date Of Birth");
            TestField(Gender);
            TestField("E-Mail");
            if not "Application fee Paid" then
                error('Application fee is not paid, kindly make payement before submitting your application');
            //If passes testfields then matk as submitted
            Submitted := true;
            "Submitted Date" := Today;
            "Submitted Time" := Time;
            Modify();

            OnAfterSubmitApplication(Applicants);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSubmitApplication(var JobApp: Record "Incubation Applicants")
    var

    begin

    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"AIC Management", 'OnAfterSubmitApplication', '', false, false)]
    local procedure AfterSubmitApplication(var JobApp: Record "Incubation Applicants")
    var
        myInt: Integer;

    begin
        if JobApp.Submitted then begin

            GlobalSendEmailNotification(JobApp."No.", 'PASS AIC RECRUITMENT', '', JobApp."Name", JobApp."E-Mail", 'JOB APPLICATION-' + JobApp."Incubation Name", 'You are welcome', '');

        end;
    end;

    procedure GlobalSendEmailNotification(DocumentNo: Code[20]; SenderName: Text; SenderAddress: Text; RecipientName: Text; RecipientAddress: Text; Subject: Text; EmailMessage: Text; CCEmails: Text);
    var
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        Company: Record "Company Information";
        TempBlob: Record TempBlob;
        FileName: Text;
        FileManagment: Codeunit "File Management";
    begin
        SMTPSetup.GET;
        Company.GET();
        Company.CALCFIELDS(Picture);

        SMTPMail.CreateMessage(SenderName, SMTPSetup."User ID", RecipientAddress, Subject, '', true);
        SMTPMail.AppendBody(EmailMessage);
        SMTPMail.AppendBody('<br><br>');
        if CCEmails <> '' then
            SMTPMail.AddCC(CCEmails);
        SMTPMail.AppendBody('<br><br>');

        //********************************Company Logo
        /* IF Company.Picture.HASVALUE THEN BEGIN
             TempBlob.INIT;
             TempBlob.DELETEALL;
             TempBlob.Blob := Company.Picture;
             TempBlob.INSERT;
             FileName := FileManagment.BLOBExport(TempBlob, 'Signature.jpg', FALSE);
         END;
         SMTPMail.AppendBody('<IMG style="HEIGHT: 153px; WIDTH: 445px" src="file:///' + FileName + '"' + 'width=300 height=100>');*/

        SMTPMail.Send;

    end;

    procedure PopulateQuestionnaireEntriesForApplicant(var Applicant: Record "Incubation Applicants")
    var

        QuestionSetup: Record "Questionnaire Setup";
        QuestionOptions: Record "Questionnaire Options";
        ApplicantQuestions: Record "Applicant Questionnaire";
        ObjEntTest: Record "Enterprenuership Test";
        ObjEntTestOpt: Record "Enterprenuership Test Options";
        ObjEnttestEntry: Record "Enterprenuership Test Entry";
        EntryNo: Integer;
    begin
        //**********************Delete Entries
        ApplicantQuestions.Reset();
        ApplicantQuestions.SetRange("Applicant No", Applicant."No.");
        if ApplicantQuestions.FindSet() then
            ApplicantQuestions.DeleteAll();

        //****************************Get Entry No
        ApplicantQuestions.Reset();
        ApplicantQuestions.SetCurrentKey("Entry No");
        if ApplicantQuestions.FindLast() then
            EntryNo := ApplicantQuestions."Entry No";

        //**************************Insert Entries
        QuestionSetup.Reset();
        QuestionSetup.SetRange("Incubation Code", Applicant."Incubation Code");
        if QuestionSetup.FindSet() then
            repeat
                EntryNo := EntryNo + 1;
                with ApplicantQuestions do begin
                    Init();
                    "Applicant No" := Applicant."No.";
                    "Incubation Code" := QuestionSetup."Incubation Code";
                    "Question Code" := QuestionSetup."Question Code";
                    Questionnaire := QuestionSetup.Questionnaire;
                    "Answer Type" := QuestionSetup."Answer Type";
                    "Entry No" := EntryNo;
                    Insert(true);
                end;
            until QuestionSetup.Next() = 0;


        //**********************Delete Entries
        ObjEnttestEntry.Reset();
        ObjEnttestEntry.SetRange("Application ID", Applicant."No.");
        if ObjEnttestEntry.FindSet() then
            ObjEnttestEntry.DeleteAll();
        //**********************Insert Entries
        ObjEntTest.Reset();
        if ObjEntTest.FindSet() then
            repeat
                with ObjEnttestEntry do begin
                    Init();
                    "Application ID" := Applicant."No.";
                    "Test Code" := ObjEntTest."Test Code";
                    Validate("Test Code");
                    Insert(true);
                end;
            until ObjEntTest.Next() = 0;

    end;

    procedure PopulateEnterprenuershipTestEntries(var ObjNonwall: Record "Non-Wall Applications")
    var
        ObjEntTest: Record "Enterprenuership Test";
        ObjEntTestOpt: Record "Enterprenuership Test Options";
        ObjEnttestEntry: Record "Enterprenuership Test Entry";
        EntryNo: Integer;
    begin

        //**********************Delete Entries
        ObjEnttestEntry.Reset();
        ObjEnttestEntry.SetRange("Application ID", ObjNonwall."Application ID");
        if ObjEnttestEntry.FindSet() then
            ObjEnttestEntry.DeleteAll();
        //**********************Insert Entries
        ObjEntTest.Reset();
        if ObjEntTest.FindSet() then
            repeat
                with ObjEnttestEntry do begin
                    Init();
                    "Application ID" := ObjNonwall."Application ID";
                    "Test Code" := ObjEntTest."Test Code";
                    Validate("Test Code");
                    Insert(true);
                end;
            until ObjEntTest.Next() = 0;

    end;

    procedure PopulateResidentialTestEntries(var ResidentialHeader: Record "Residential Selection Header"; Selection: option " ","Business Skills","Technical Training","Face to Face Interviews")
    var
        TestRec: Record "Residential Selection Test";
        TestEntry: Record "Residential Assessment";
        EntryNo: Integer;
        ResidentialLines: Record "Residential Selection Lines";
    begin
        if Confirm('Are you sure you want to start %1 assessments for %2', false, Selection, ResidentialHeader."No.") then begin
            TestEntry.Reset();
            TestEntry.SetRange("Incubation Code", ResidentialHeader."Incubation Code");
            TestEntry.SetRange(Selection, Selection);
            if TestEntry.FindSet() then
                TestEntry.DeleteAll()
            else begin
                TestEntry.Reset();
                TestEntry.SetCurrentKey("Entry No.");
                if TestEntry.FindLast() then
                    EntryNo := TestEntry."Entry No.";
                ResidentialLines.Reset();
                ResidentialLines.SetRange("Document No", ResidentialHeader."No.");
                ResidentialLines.SetRange(Selection, Selection);
                if ResidentialLines.FindFirst() then begin
                    repeat
                        TestRec.Reset();
                        TestRec.SetRange("Incubation Code", ResidentialHeader."Incubation Code");
                        TestRec.SetRange(Selection, Selection);
                        if TestRec.FindFirst() then begin
                            repeat
                                TestEntry.Init();
                                TestEntry."Entry No." := TestEntry."Entry No." + 100;
                                TestEntry."Application ID" := ResidentialLines."Applicant No.";
                                TestEntry.Code := TestRec.Code;
                                TestEntry.Question := TestRec.Question;
                                TestEntry."Residential Selection No." := ResidentialLines."Document No";
                                TestEntry."Incubation Code" := ResidentialHeader."Incubation Code";
                                TestEntry.Selection := Selection;
                                TestEntry.Insert(true);
                            until TestRec.Next() = 0;

                        end else
                            Error('There is no residentail selection test setup for %1 %2', ResidentialHeader."Incubation Code", Selection);
                    until ResidentialLines.Next() = 0;
                end else
                    Error('There are no applicants proceeded to %1 residential selection', Selection);
            end;
        end;
    end;

    var
        myInt: Integer;
}