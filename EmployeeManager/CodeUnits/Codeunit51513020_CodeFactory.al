codeunit 51513020 "Code Factory"
{

    trigger OnRun();
    begin

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

        SMTPMail.CreateMessage(SenderName, SMTPSetup."User ID", RecipientAddress, Subject, '', true);
        SMTPMail.AppendBody(EmailMessage);
        SMTPMail.AppendBody('<br><br>');
        if CCEmails <> '' then
            SMTPMail.AddCC(CCEmails);
        SMTPMail.AppendBody('<br><br>');
        SMTPMail.Send;


        /*
        Company.CALCFIELDS(Picture);
        IF Company.Picture.HASVALUE THEN
          BEGIN
            TempBlob.INIT;
            TempBlob.DELETEALL;
            TempBlob.Blob := Company.Picture;
            TempBlob.INSERT;
            FileName := FileManagment.BLOBExport(TempBlob,'Signature.jpg',FALSE);
            END;
        SMTPMail.AppendBody('<IMG style="HEIGHT: 153px; WIDTH: 445px" src="file:///'+ FileName +'"'+ 'width=300 height=100>');
        */

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"WorkflowResponseHandling LVExt", 'FnOnAfterRecallStatusChange', '', false, false)]
    procedure FnSendRecallNotifications(var Recall: Record "Leave Recall");
    var
        ObjLvRecall: Record "Leave Recall";
        ObjLeave: Record "Employee Leave Application";
        ObjEmp: Record Employee;
        ObjHRSetup: Record "Human Resources Setup";
        ObjUserSet: Record "User Setup";
        HREmail: Text;
        SupervisorMail: Text;
        RecallMessage: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Hello <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:10pt">This is to notify you that you have been recalled from your <b>%2</b> leave for <b>%3</b> days.</p> <p style="font-family:Verdana,Arial;font-size:10pt">The recall starts from <b>%4</b> through to <b>%5</b>.</p> <p style="font-family:Verdana,Arial;font-size:10pt">Reason for recall is <b>%6</b>, as requested by <b>%7</b> department.</p> <p style="font-family:Verdana,Arial;font-size:10pt"><b>%8</b></p> <p style="font-family:Verdana,Arial;font-size:10pt"><b>%9</b></p>';
        LineNum: Integer;
        LeaveCode: Code[20];
        CCMails: Text;
    begin
        ObjLvRecall.RESET;
        ObjLvRecall.SETRANGE("No.", Recall."No.");
        if ObjLvRecall.FIND('-') then begin
            if ObjLeave.GET(ObjLvRecall."Leave Application") then
                LeaveCode := ObjLeave."Leave Code";

            //****************Get HR Email*******************//
            ObjHRSetup.GET;
            /*ObjHRSetup.TESTFIELD("HR HOD");
            if ObjUserSet.GET(ObjHRSetup."HR HOD") then
                HREmail := ObjUserSet."E-Mail";*/
            //****************Get Hr Email*******************//

            //****************Supervisor Hr Email*******************//
            if ObjUserSet.GET(USERID) then
                SupervisorMail := ObjUserSet."E-Mail";
            //****************Get Supervisor Email*******************//

            //****************Get Supervisor Email*******************//
            if ObjEmp.GET(ObjLvRecall."Employee No") then begin
                ObjEmp.TESTFIELD("E-Mail");

                case Recall.Status of
                    recall.Status::Open:
                        begin

                        end;
                    Recall.Status::"Pending Approval":
                        begin

                        end;
                    Recall.Status::Released:
                        begin
                            //**********************************Post Adjustment*********************//
                            if Recall.Status = Recall.Status::Released then begin
                                ObjJnlline.RESET;
                                ObjJnlline.SETRANGE("Journal Template Name", ObjHRSetup."Leave Template");
                                ObjJnlline.SETRANGE("Journal Batch Name", 'LEAVERECALL');
                                if ObjJnlline.FIND('-') then begin
                                    ObjJnlline.DELETEALL;
                                end;

                                LineNum := LineNum + 10000;
                                FnCreateLeaveLedgerEntries(LineNum, ObjHRSetup."Leave Template", 'LEAVERECALL', ObjLvRecall."No.", ObjLvRecall."Employee No", FORMAT(DATE2DMY(TODAY, 3)),
                                                TODAY, ObjJnlline."Leave Entry Type"::Positive, TODAY, LeaveCode + ' Leave Recalled', LeaveCode, ObjLvRecall."No. of Off Days", ObjEmp."Global Dimension 1 Code",
                                                ObjEmp."Global Dimension 2 Code", ObjLvRecall."Leave Application", false, ObjJnlline."Transaction Type"::"Leave Recall");



                                ObjJnlline.RESET;
                                ObjJnlline.SETRANGE("Journal Template Name", ObjHRSetup."Leave Template");
                                ObjJnlline.SETRANGE("Journal Batch Name", 'LEAVERECALL');
                                if ObjJnlline.FIND('-') then begin
                                    CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post Line", ObjJnlline);
                                end;
                            end;
                            //**********************************Post Adjustment*********************//

                            //**********************************Send Approved Notification*********************//
                            GlobalSendEmailNotification(ObjLvRecall."No.", COMPANYNAME, SupervisorMail, ObjLvRecall.Name, ObjEmp."E-Mail", 'Leave Recall',
                                  STRSUBSTNO(RecallMessage, ObjLvRecall."Employee Name", LeaveCode, ObjLvRecall."No. of Off Days", FORMAT(ObjLvRecall."Recalled From", 0, '<Day,2>/<Month,2>/<Year4>'),
                                  FORMAT(ObjLvRecall."Recalled To", 0, '<Day,2>/<Month,2>/<Year4>'), ObjLvRecall."Reason for Recall",
                                      ObjLvRecall."Department Name", 'PASS Human Resources', ''), CCMails);
                            //**********************************Send Notification*********************//
                        end;
                end

            end;
            //****************Get Supervisor Email*******************//
        end;

    end;

    procedure FnCreateLeaveLedgerEntries(LineNo: Integer; TemplateName: Code[20]; BatchName: Code[20]; ApplicationNo: Code[20]; EmpNo: Code[20]; LeavePeriod: Code[20]; PostingDate: Date; LeaveEntryType: Option Negative,Positive; ApprovalDate: Date; Description: Text; LeaveType: Code[20]; Days: Decimal; Dim1: Code[20]; Dim2: Code[20]; LeaveRecalled: Code[20]; CreditedBack: Boolean; TransactionType: Option " ",Allocation,"Carry Forward","Credit Back","Leave Recall","Leave Applied",Reversal);
    var
        LeaveGjline: Record "HR Journal Line";
    begin
        LeaveGjline.INIT;
        LeaveGjline."Journal Template Name" := TemplateName;
        LeaveGjline."Journal Batch Name" := BatchName;
        LeaveGjline."Line No." := LineNo;
        LeaveGjline."Leave Application No." := ApplicationNo;
        LeaveGjline."Document No." := ApplicationNo;
        LeaveGjline."Leave Recalled No." := LeaveRecalled;
        LeaveGjline."Staff No." := EmpNo;
        LeaveGjline.VALIDATE(LeaveGjline."Staff No.");
        LeaveGjline."Posting Date" := PostingDate;
        LeaveGjline."Leave Period" := FORMAT(DATE2DMY(PostingDate, 3));
        LeaveGjline."Leave Entry Type" := LeaveEntryType;
        LeaveGjline."Leave Approval Date" := TODAY;
        LeaveGjline.Description := Description;
        LeaveGjline."Leave Type" := LeaveType;
        LeaveGjline."Leave Period Start Date" := CALCDATE('-CY', PostingDate);
        LeaveGjline."Leave Period End Date" := CALCDATE('CY', PostingDate);
        LeaveGjline."Shortcut Dimension 1 Code" := Dim1;
        LeaveGjline."Shortcut Dimension 2 Code" := Dim2;
        LeaveGjline."Credited Back" := CreditedBack;
        LeaveGjline."Transaction Type" := TransactionType;

        case LeaveGjline."Leave Entry Type" of
            LeaveGjline."Leave Entry Type"::Positive:
                begin
                    LeaveGjline."No. of Days" := Days;
                end;
            LeaveGjline."Leave Entry Type"::Negative:
                begin
                    LeaveGjline."No. of Days" := Days * -1;
                end;
        end;

        if LeaveGjline."No. of Days" <> 0 then
            LeaveGjline.INSERT(true);
    end;

    procedure CheckForOverLappingDays(StaffNo: Code[20]; Startdate: Date; EndDate: Date; CurrLeaveCode: Code[20]);
    var
        LeaveApp: Record "Employee Leave Application";
        ImpDocs: Text;
    begin
        LeaveApp.RESET;
        LeaveApp.SETRANGE(LeaveApp."Employee No", StaffNo);
        LeaveApp.SETFILTER("Application No", '<>%1', CurrLeaveCode);
        LeaveApp.SETFILTER(Status, '<>%1', LeaveApp.Status::Rejected);
        if LeaveApp.FIND('-') then begin
            repeat
                if ((Startdate >= LeaveApp."Start Date") and (Startdate <= LeaveApp."End Date"))
                  or ((EndDate >= LeaveApp."Start Date") and (EndDate <= LeaveApp."End Date")) then begin
                    ERROR('You already have a leave application %1 within the same dates you are applying', LeaveApp."Application No");
                end;
            until LeaveApp.NEXT = 0;
        end;
    end;

    procedure FnInsertCasualEmployees(EmpNo: Code[10]; EmpName: Text; RegDate: Date; IdNum: Code[50]; Dept: Code[50]; Comp: Code[50]);
    var
        CasualsMaster: Record "Casuals Master";
    begin
        with CasualsMaster do begin
            CasualsMaster.INIT;
            CasualsMaster."No." := EmpNo;
            CasualsMaster."Employee Name" := EmpName;
            CasualsMaster."Registration Date" := RegDate;
            CasualsMaster."ID Num" := IdNum;
            CasualsMaster.Department := Dept;
            CasualsMaster.Company := Comp;
            CasualsMaster.INSERT;
        end;
    end;

    procedure FnInsertCasualEmployeeDailyTrans(EntryNo: Integer; EmpNo: Code[20]; Dept: Code[20]; DateTimeIn: DateTime; DateTimeOut: DateTime);
    var
        ObjCasDMaster: Record "Casuals Daily Master";
    begin
        with ObjCasDMaster do begin
            ObjCasDMaster."Entry No" := EntryNo;
            ObjCasDMaster."Employee No." := EmpNo;
            ObjCasDMaster.Department := Dept;
            ObjCasDMaster."Date Time In" := DateTimeIn;
            ObjCasDMaster."Date Time out" := DateTimeOut;
            ObjCasDMaster.INSERT;
        end;
    end;

    procedure FnGetTheLastEntryEmployees() LastEntry: Code[10];
    var
        ObjCasuals: Record "Casuals Master";
    begin
        ObjCasuals.RESET;
        ObjCasuals.SETCURRENTKEY("No.");
        if ObjCasuals.FINDLAST then
            LastEntry := ObjCasuals."No.";
    end;

    procedure FnGetLastEntryEmployeeDaily() LastEntry: Integer;
    var
        ObjCasDaily: Record "Casuals Daily Master";
    begin
        ObjCasDaily.RESET;
        ObjCasDaily.SETCURRENTKEY("Entry No");
        if ObjCasDaily.FINDLAST then
            LastEntry := ObjCasDaily."Entry No";
    end;

    procedure FnValidateRecallDays(DocNo: Code[20]; Days: Decimal);
    var
        ObjLeaveApp: Record "Employee Leave Application";
    begin
        ObjLeaveApp.RESET;
        ObjLeaveApp.SETRANGE("Application No", DocNo);
        if ObjLeaveApp.FIND('-') then begin
            if ObjLeaveApp."Days Applied" < Days then
                ERROR('The days you are trying to recall for %1 are more than the leave days applied they for', ObjLeaveApp."Employee Name");

            ObjLeaveApp.CALCFIELDS("Recalled Days");

            if (ObjLeaveApp."Days Applied" - ObjLeaveApp."Recalled Days") < Days then
                ERROR('The remaining balance on this leave application that can be recalled is %1 day(s)', (ObjLeaveApp."Days Applied" - ObjLeaveApp."Recalled Days"));
        end;

    end;

    procedure FnGetLeavesToRecall(SVEmpNo: Code[20]);
    var
        ObjEmployee: Record Employee;
        ObjUserSetUp: Record "User Setup";
        ObjUserSetUp1: Record "User Setup";
        ObjLeaveApp: Record "Employee Leave Application";
        ObjLeaveBuffer: Record "Leave Recall Portal";
    begin
        ObjUserSetUp.RESET;
        ObjUserSetUp.SETRANGE("Employee No.", SVEmpNo);
        if ObjUserSetUp.FIND('-') then begin
            //********************************Clear all entries******************************//
            ObjLeaveBuffer.RESET;
            ObjLeaveBuffer.SETRANGE("Supervisor Emp No", ObjUserSetUp."Employee No.");
            if ObjLeaveBuffer.FINDSET then
                ObjLeaveBuffer.DELETEALL;

            //********************************Clear all entries******************************//
            ObjUserSetUp1.RESET;
            ObjUserSetUp1.SETRANGE("Approver ID", ObjUserSetUp."User ID");
            if ObjUserSetUp1.FINDSET then
                repeat
                    ObjLeaveApp.RESET;
                    ObjLeaveApp.SETRANGE("Employee No", ObjUserSetUp1."Employee No.");
                    ObjLeaveApp.SETRANGE(Status, ObjLeaveApp.Status::Approved);
                    ObjLeaveApp.SETFILTER("End Date", '>%1', TODAY);
                    if ObjLeaveApp.FINDSET then
                        repeat
                            if (ObjLeaveApp."Leave Code" = 'ANNUAL') or (ObjLeaveApp."Leave Code" = 'MATERNITY') then begin
                                with ObjLeaveBuffer do begin
                                    INIT;
                                    "Leave Application No" := ObjLeaveApp."Application No";
                                    "Employee No" := ObjLeaveApp."Employee No";
                                    "Employee Name" := ObjLeaveApp."Employee Name";
                                    "Leave Code" := ObjLeaveApp."Leave Code";
                                    "Start Date" := ObjLeaveApp."Start Date";
                                    "End Date" := ObjLeaveApp."End Date";
                                    "Days Applied" := ObjLeaveApp."Days Applied";
                                    "Supervisor Emp No" := ObjUserSetUp."Employee No.";
                                    INSERT;
                                end;
                            end;
                        until ObjLeaveApp.NEXT = 0;
                until ObjUserSetUp1.NEXT = 0;
            //********************************Insert own Leaves***************************************//
            ObjLeaveApp.RESET;
            ObjLeaveApp.SETRANGE("Employee No", ObjUserSetUp."Employee No.");
            ObjLeaveApp.SETRANGE(Status, ObjLeaveApp.Status::Approved);
            ObjLeaveApp.SETFILTER("End Date", '>%1', TODAY);
            if ObjLeaveApp.FINDSET then
                repeat
                    if (ObjLeaveApp."Leave Code" = 'ANNUAL') or (ObjLeaveApp."Leave Code" = 'MATERNITY') then begin
                        with ObjLeaveBuffer do begin
                            INIT;
                            "Leave Application No" := ObjLeaveApp."Application No";
                            "Employee No" := ObjLeaveApp."Employee No";
                            "Employee Name" := ObjLeaveApp."Employee Name";
                            "Leave Code" := ObjLeaveApp."Leave Code";
                            "Start Date" := ObjLeaveApp."Start Date";
                            "End Date" := ObjLeaveApp."End Date";
                            "Days Applied" := ObjLeaveApp."Days Applied";
                            "Supervisor Emp No" := ObjUserSetUp."Employee No.";
                            INSERT;
                        end;
                    end;
                until ObjLeaveApp.NEXT = 0;
            //********************************Insert own Leaves***************************************//
        end;
    end;

    procedure StartOralInterview("code": Code[10]);
    var
        ApplicantInterviewTable: Record "Applicant Interview Table";
        ApplicantInterviewLines: Record "Applicant Interview Lines";
        Interviewers: Record "Job Interviewers";
        JobApplicationsTable: Record "Job Applicants";
        JobInterviewList: Record "Job Interview List";
        testnumbers: Integer;
        appnumber: Integer;
        ApplicantInterview: Record "Applicant Interview Table";
        RecNeed: Record "Recruitment Needs";
    begin
        RecNeed.RESET;
        RecNeed.SETRANGE("No.", code);
        if RecNeed.FINDFIRST then begin

            RecNeed.TESTFIELD(Status, RecNeed.Status::Released);
            testnumbers := 200;
            appnumber := 100;
            ApplicantInterview.SETCURRENTKEY(Code);
            ApplicantInterview.ASCENDING(false);
            if ApplicantInterview.FINDFIRST then begin
                appnumber := ApplicantInterview.Code + 1;
            end;

            if RecNeed."Short Listing Done?" = false then
                ERROR('Sorry!!,Shortilisting Has Not Been Done!');
            if CONFIRM('Are You Sure You Want to Start Oral Interview Test??', false) = true then begin
                Interviewers.RESET;
                Interviewers.SETRANGE("Recruitment Need", RecNeed."No.");
                Interviewers.SETRANGE("Interview Type", Interviewers."Interview Type"::"Oral Interview");
                if Interviewers.FINDFIRST then begin
                    repeat
                        JobApplicationsTable.RESET;
                        JobApplicationsTable.SETRANGE("Job ID", Interviewers."Recruitment Need");
                        //JobApplicationsTable.SETRANGE("Passed Short Listing",TRUE);
                        JobApplicationsTable.SETRANGE(Qualified, true);
                        if JobApplicationsTable.FINDFIRST then begin
                            repeat
                                ApplicantInterviewTable.INIT;
                                ApplicantInterviewTable.Code := appnumber;
                                ApplicantInterviewTable."Recruitment Code" := JobApplicationsTable."Job ID";
                                ApplicantInterviewTable."Applicant ID" := JobApplicationsTable."No.";
                                ApplicantInterviewTable."Applicant Name" := JobApplicationsTable."First Name" + ' ' + JobApplicationsTable."Middle Name" + ' ' + JobApplicationsTable."Last Name";
                                ApplicantInterviewTable."Interview Type" := Interviewers."Interview Type"::"Oral Interview";
                                if not ApplicantInterviewTable.GET(appnumber) then begin
                                    ApplicantInterviewTable.INSERT;
                                    appnumber := appnumber + 1;
                                    // MESSAGE('this is name %1 and number %2',JobApplicationsTable.ApplicantName,appnumber);
                                    // ================lines
                                    JobInterviewList.RESET;
                                    JobInterviewList.SETRANGE("Recruitment No.", ApplicantInterviewTable."Recruitment Code");
                                    JobInterviewList.SETRANGE("Interview Type", ApplicantInterviewTable."Interview Type");
                                    if JobInterviewList.FINDFIRST then begin
                                        repeat
                                            ApplicantInterviewLines.INIT;
                                            ApplicantInterviewLines."Line Number" := testnumbers;
                                            ;
                                            ApplicantInterviewLines."Recruitment Code" := ApplicantInterviewTable."Recruitment Code";
                                            ApplicantInterviewLines."Applicant ID" := ApplicantInterviewTable."Applicant ID";
                                            ApplicantInterviewLines.Description := JobInterviewList.Description;
                                            ApplicantInterviewLines.Score := 0;
                                            ApplicantInterviewLines."Interview Type" := ApplicantInterviewTable."Interview Type";
                                            ApplicantInterviewLines."Maximum Score" := JobInterviewList."Maximum Score";
                                            ApplicantInterviewLines."User ID" := Interviewers.Interviewer;
                                            ApplicantInterviewLines.Code := ApplicantInterviewTable.Code;
                                            ApplicantInterviewLines.INSERT;
                                            testnumbers := testnumbers + 1;
                                        until JobInterviewList.NEXT = 0;
                                    end;
                                    //===========================end lines
                                end;

                            until JobApplicationsTable.NEXT = 0;
                        end;

                    until Interviewers.NEXT = 0;
                end;
                RecNeed."In Oral Test" := true;
                MESSAGE('Oral Interview Successfully Started!!');
            end;
        end;
    end;

    procedure ComputeOralInterviewScores(RecNeeds: Code[10]);
    var
        RecruitmentNeed: Record "Recruitment Needs";
        Interviewers: Record "Job Interviewers";
        conting: Integer;
        ApplicantInterviewLines: Record "Applicant Interview Lines";
        totalscore: Decimal;
        averagescore: Decimal;
        JobApplicationsTable: Record "Job Applicants";
    begin
        RecruitmentNeed.RESET;
        RecruitmentNeed.SETRANGE("No.", RecNeeds);
        if RecruitmentNeed.FINDFIRST then begin
            conting := 0;
            Interviewers.RESET;
            Interviewers.SETRANGE("Recruitment Need", RecruitmentNeed."No.");
            Interviewers.SETRANGE("Interview Type", Interviewers."Interview Type"::"Oral Interview");
            conting := Interviewers.COUNT;
            //MESSAGE('this is what I want %1',conting);
            JobApplicationsTable.RESET;
            JobApplicationsTable.SETRANGE("Job ID", RecruitmentNeed."No.");
            JobApplicationsTable.SETRANGE(Qualified, true);
            if JobApplicationsTable.FINDFIRST then begin
                repeat
                    totalscore := 0;
                    averagescore := 0;
                    //MESSAGE(JobApplicationsTable.ApplicantName);
                    ApplicantInterviewLines.RESET;
                    ApplicantInterviewLines.SETRANGE("Recruitment Code", RecruitmentNeed."No.");
                    ApplicantInterviewLines.SETRANGE("Applicant ID", JobApplicationsTable."No.");
                    ApplicantInterviewLines.SETRANGE("Interview Type", Interviewers."Interview Type"::"Oral Interview");
                    if ApplicantInterviewLines.FINDFIRST then begin
                        repeat
                            totalscore := totalscore + ApplicantInterviewLines.Score;
                        until ApplicantInterviewLines.NEXT = 0;
                    end;
                    averagescore := ROUND(totalscore / conting, 0.02);
                    //  MESSAGE('this is the marks %1',averagescore);
                    JobApplicationsTable."Oral Interview Total Score" := averagescore;
                    JobApplicationsTable.MODIFY;
                until JobApplicationsTable.NEXT = 0;
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WorkflowResponseHandling LVExt", 'FnOnAfterLeaveStatusChange', '', true, true)]
    procedure FnPostLeaveApplication(var LeaveApplication: Record "Employee Leave Application");
    var
        LeaveGjline: Record "HR Journal Line";
        HumanResSetup: Record "Human Resources Setup";
        LineNumber: Integer;

    begin
        if LeaveApplication.Status = LeaveApplication.Status::Approved then begin
            HumanResSetup.RESET;
            if HumanResSetup.FIND('-') then begin
                HumanResSetup.TESTFIELD(HumanResSetup."Leave Template");
                HumanResSetup.TESTFIELD(HumanResSetup."Leave Batch");

                //**************************Clear Journal***********************//
                LeaveGjline.RESET;
                LeaveGjline.SETRANGE("Journal Template Name", HumanResSetup."Leave Template");
                LeaveGjline.SETRANGE("Journal Batch Name", HumanResSetup."Leave Batch");
                LeaveGjline.DELETEALL;
                //**************************Clear Journal***********************//

                //**************************Create Jn Entry*********************//
                LineNumber := LineNumber + 1000;
                FnCreateLeaveLedgerEntries(LineNumber, HumanResSetup."Leave Template", HumanResSetup."Leave Batch", LeaveApplication."Application No", LeaveApplication."Employee No",
                                      FORMAT(DATE2DMY(LeaveApplication."Fiscal Start Date", 3)), TODAY, LeaveGjline."Leave Entry Type"::Negative, 0D, FORMAT(LeaveApplication."Leave Code") + ' ' + 'Leave Applied',
                                      LeaveApplication."Leave Code", LeaveApplication."Days Applied", LeaveApplication."Global Dimension 1 Code", LeaveApplication."Global Dimension 2 Code", '', false, LeaveGjline."Transaction Type"::"Leave Applied");
                //**************************Create Jn Entry*********************//

                //**************************Post Jn Entry*********************//
                LeaveGjline.RESET;
                LeaveGjline.SETRANGE("Journal Template Name", HumanResSetup."Leave Template");
                LeaveGjline.SETRANGE("Journal Batch Name", HumanResSetup."Leave Batch");
                if LeaveGjline.FIND('-') then begin
                    CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post Line", LeaveGjline);
                end;
                //**************************Post Jn Entry*********************//
            end;

            LeaveApplication.Post := true;
            LeaveApplication.MODIFY;
        end;

    end;

    procedure FnPostLeaveReversal(var LeaveApplication: Record "Employee Leave Application");
    var
        LeaveGjline: Record "HR Journal Line";
        HumanResSetup: Record "Human Resources Setup";
        LineNumber: Integer;
    begin
        if LeaveApplication.Post then begin
            HumanResSetup.RESET;
            if HumanResSetup.FIND('-') then begin
                HumanResSetup.TESTFIELD(HumanResSetup."Leave Template");
                HumanResSetup.TESTFIELD(HumanResSetup."Leave Batch");

                //**************************Clear Journal***********************//
                LeaveGjline.RESET;
                LeaveGjline.SETRANGE("Journal Template Name", HumanResSetup."Leave Template");
                LeaveGjline.SETRANGE("Journal Batch Name", HumanResSetup."Leave Batch");
                LeaveGjline.DELETEALL;
                //**************************Clear Journal***********************//

                //**************************Create Jn Entry*********************//
                LineNumber := LineNumber + 1000;
                FnCreateLeaveLedgerEntries(LineNumber, HumanResSetup."Leave Template", HumanResSetup."Leave Batch", LeaveApplication."Application No", LeaveApplication."Employee No",
                                      FORMAT(DATE2DMY(LeaveApplication."Fiscal Start Date", 3)), TODAY, LeaveGjline."Leave Entry Type"::Positive, 0D, FORMAT(LeaveApplication."Leave Code") + ' ' + 'Leave Reversed',
                                      LeaveApplication."Leave Code", LeaveApplication."Days Applied", LeaveApplication."Global Dimension 1 Code", LeaveApplication."Global Dimension 2 Code", '', false, LeaveGjline."Transaction Type"::Reversal);
                //**************************Create Jn Entry*********************//

                //**************************Post Jn Entry*********************//
                LeaveGjline.RESET;
                LeaveGjline.SETRANGE("Journal Template Name", HumanResSetup."Leave Template");
                LeaveGjline.SETRANGE("Journal Batch Name", HumanResSetup."Leave Batch");
                if LeaveGjline.FIND('-') then begin
                    CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post Line", LeaveGjline);
                end;
                //**************************Post Jn Entry*********************//
            end;

            LeaveApplication.Post := false;
            LeaveApplication.MODIFY;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WorkflowResponseHandling LVExt", 'FnOnAfterLeaveStatusChange', '', true, true)]
    procedure FnSendLeaveNotifications(var LeaveApplication: Record "Employee Leave Application");
    var
        SMTPSetup: Record "SMTP Mail Setup";
        ObjCommentLine: Record "Approval Comment Line";
        RejectionComment: Text;
        EmpRec: Record Employee;
        CCMails: Text;
        Result: Boolean;
        ObjLeavePeriod: Record "HR Leave Periods";
        UserSetup: Record "User Setup";
        LeaveMessageApproved: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:10pt">Your <b>%2</b> Leave Application has been approved. </p> <p style="font-family:Verdana,Arial;font-size:10pt">Your approved days are <b>%3</b>, Starting from <b>%4</b>, through to <b>%5</b>.</p> <p style="font-family:Verdana,Arial;font-size:10pt">You will be expected to resume normal duties as on <b>%6</b>.</p> <p style="font-family:Verdana,Arial;font-size:10pt">Regards,</p> <p style="font-family:Verdana,Arial;font-size:10pt">%7</p> <p style="font-family:Verdana,Arial;font-size:10pt">%8</p>';
        LeaveMessage: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that your leave application has been received and undergoing approval. Your supervisor will be notified of this for approval.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%3</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%4</b></p>';
        SupervisorAppMail: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt"> This is to notify you that a staff, employee Number <b>%2</b> ,Name <b>%3</b> who is under your supervision has applied for a <b>%4</b> days leave starting from <b>%5</b> through to date <b>%6</b>. </p> <p style="font-family:Verdana,Arial;font-size:9pt">The reliever selected is <b>%7</b>.</p> <p style="font-family:Verdana,Arial;font-size:9pt">Should this affect your planned work schedule, or in the case that you don''t approve this, Kindly notify the HR department for further Actions.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%8,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%9,</b></p>';
        LeaveMessageCancel: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt"> This is to notify you that your leave application serial No <b>%2</b> has been cancelled. Your supervisor will be notified of this for better work planning.</p> <p style="font-family:Verdana,Arial;font-size:9pt">Kindly do not proceed for any leave before you get an approval notification.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%3</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%4</b></p>';
        SupervisorAppMailCancel: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt"> This is to notify you that a staff, employee Number <b>%2</b> ,Name <b>%3</b> who is under your supervision has applied for a <b>%4</b> days leave starting from <b>%5</b> through to date <b>%6</b>. </p> <p style="font-family:Verdana,Arial;font-size:9pt">The reliever selected is <b>%7</b>.</p> <p style="font-family:Verdana,Arial;font-size:9pt">Should this affect your planned work schedule, or in the case that you don''t approve this, Kindly notify the HR department for further Actions.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%8,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%9,</b></p>';
        RelieverEmail: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1,</b></p> <p style="font-family:Verdana,Arial;font-size:10pt">This is to notify you that <b>%2</b> has applied for leave and appointed you as the acting person while he/she is away. You are therefore expected to take over his/her duties as from <b>%3</b> to <b>%4</b>.</p> <p style="font-family:Verdana,Arial;font-size:10pt"><b> Regards</b></p> <p style="font-family:Verdana,Arial;font-size:10pt"><b> %5</b></p> <p style="font-family:Verdana,Arial;font-size:10pt"><b> %6</b></p>';
        LeaveRejection: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:10pt">This is to notify you that your leave application for the dates <b>%2</b> to <b>%3</b> has been rejected.</p> <p style="font-family:Verdana,Arial;font-size:10pt">Reason for rejection is :- <b>%4</b>.</p> <p style="font-family:Verdana,Arial;font-size:10pt">Regards,</p> <p style="font-family:Verdana,Arial;font-size:10pt"> <b>%5</b></p> <p style="font-family:Verdana,Arial;font-size:10pt"> <b>%6</b></p>';

    begin

        case LeaveApplication.Status of
            LeaveApplication.Status::"Pending Approval":
                begin
                    //***********************************************************************
                    //***************************Send Application Email Notification*******************************
                    SMTPSetup.GET();
                    //*****************************Applicant Mail**************************
                    if EmpRec.GET(LeaveApplication."Employee No") then begin
                        GlobalSendEmailNotification(LeaveApplication."Application No", 'PASS HR OFFICE', '', LeaveApplication."Employee Name", EmpRec."E-Mail", 'LEAVE APPLICATION',
                                    STRSUBSTNO(LeaveMessage, LeaveApplication."Employee Name", LeaveApplication."Application No", 'PASS Human Resources', ''), '');
                    end;
                    //*****************************End Applicant Mail*************************

                    //*************************************Reliever Mail************************************
                    if EmpRec.GET(LeaveApplication."Acting Person") then begin
                        GlobalSendEmailNotification(LeaveApplication."Application No", 'PASS HR OFFICE', '', LeaveApplication.Name, EmpRec."E-Mail", 'LEAVE RELIEVER NOTIFICATION',
                                    STRSUBSTNO(RelieverEmail, LeaveApplication.Name, LeaveApplication."Employee Name", FORMAT(LeaveApplication."Start Date", 0, '<Day,2>/<Month,2>/<Year4>'), FORMAT(LeaveApplication."End Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                    'PASS Human Resources', ''), '');
                    end;
                    //*************************************Reliever Mail*************************************
                    //***************************Send Application Email Notification*******************************

                    //***********************************************************************

                end;
            LeaveApplication.Status::Approved:
                begin
                    //*****************************Applicant Mail**************************
                    if EmpRec.GET(LeaveApplication."Employee No") then begin
                        GlobalSendEmailNotification(LeaveApplication."Application No", 'PASS HR OFFICE', '', LeaveApplication."Employee Name", EmpRec."E-Mail", 'LEAVE APPLICATION APPROVAL',
                                    STRSUBSTNO(LeaveMessageApproved, LeaveApplication."Employee Name", LeaveApplication."Leave Code", LeaveApplication."Days Applied", FORMAT(LeaveApplication."Start Date", 0, '<Day,2>/<Month,2>/<Year4>'), FORMAT(LeaveApplication."End Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                    FORMAT(LeaveApplication."Resumption Date", 0, '<Day,2>/<Month,2>/<Year4>'), 'PASS Human Resources', ''), CCMails);
                    end;

                    //*****************************End Applicant Mail**************************
                end;
            LeaveApplication.Status::Rejected:
                begin
                    if EmpRec.GET(LeaveApplication."Employee No") then begin
                        ObjCommentLine.RESET;
                        ObjCommentLine.SETRANGE("Document No.", LeaveApplication."Application No");
                        if ObjCommentLine.FIND('-') then begin
                            RejectionComment := ObjCommentLine.Comment;
                        end;

                        //***********************************************************************
                        GlobalSendEmailNotification(LeaveApplication."Application No", 'PASS HR OFFICE', '', LeaveApplication."Employee Name", EmpRec."E-Mail", 'LEAVE REJECTION',
                                     STRSUBSTNO(LeaveRejection, LeaveApplication."Employee Name", FORMAT(LeaveApplication."Start Date", 0, '<Day,2>/<Month,2>/<Year4>'), FORMAT(LeaveApplication."End Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                     RejectionComment, 'PASS Human Resources', ''), CCMails);
                        //**********************************************************************
                    end;

                end;
        end;


    end;

    procedure FnSendLeaveAllowanceMailToFin(var LeaveApp: Record "Employee Leave Application");
    var
        SMTPSetup: Record "SMTP Mail Setup";
        ObjCommentLine: Record "Approval Comment Line";
        RejectionComment: Text;
        EmpRec: Record Employee;
        CCMails: Text;
        Result: Boolean;
        ObjLeavePeriod: Record "HR Leave Periods";
        UserSetup: Record "User Setup";
        HRSetup: Record "Human Resources Setup";
        LeavePayMessage: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:10pt">This is to notify you that Leave application Number <b>%2</b>has been fully approved and it includes a request for leave pay which is awaiting your processing.  </p> <p style="font-family:Verdana,Arial;font-size:10pt">The payment voucher number created for the leave pay is  <b>%3</b>. </p> <p style="font-family:Verdana,Arial;font-size:10pt">Please check the document and process accordingly. <b></b>.</p> <p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,</p> <p style="font-family:Verdana,Arial;font-size:10pt">%4</p> <p style="font-family:Verdana,Arial;font-size:10pt">%5</p>';


    begin
        HRSetup.Get();
        if LeaveApp.Post then begin
            if EmpRec.Get(LeaveApp."Employee No") then begin
                CCMails := HRSetup."Payroll Administrator Email" + EmpRec."E-Mail";
                //***********************************************************************
                GlobalSendEmailNotification(LeaveApp."Application No", 'PASS HR OFFICE', '', 'PASS Finance Team', HRSetup."Finance Emails", 'LEAVE ALLOWANCE PAYMENT',
                             STRSUBSTNO(LeavePayMessage, 'Finance Dept.', LeaveApp."Application No", LeaveApp."PV No.", 'PASS Human Resources', ''), CCMails);
                //**********************************************************************
            end;
        end;


    end;

    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; Dimension1: Code[40]; Dimension2: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; Currency: Code[10]; AppliesToDocType: Option "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; AppliesToDocNo: Code[50]; CurrencyFactor: Decimal; DimSetID: Integer)
    var
        myInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine."Currency Code" := Currency;
        IF GenJournalLine."Currency Code" <> '' THEN
            GenJournalLine.VALIDATE("Currency Code");
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := Dimension1;
        GenJournalLine."Shortcut Dimension 2 Code" := Dimension2;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."Dimension Set ID" := DimSetID;
        GenJournalLine."Applies-to Doc. Type" := AppliesToDocType;
        GenJournalLine."Applies-to Doc. No." := AppliesToDocNo;
        GenJournalLine."Currency Factor" := CurrencyFactor;
        GenJournalLine.VALIDATE(Amount);
        IF GenJournalLine.Amount <> 0 THEN
            GenJournalLine.INSERT;
    end;

    procedure FnTransferPayrollToJournal(var PayrollPeriod: Date; var StaffPostingGroup: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
        AssignMatrix: Record "Assignment Matrix";
        HRSetup: Record "Human Resources Setup";
        PostingGroup: Record "Staff Posting Group";
        ObjEmployee: Record Employee;
        DedRec: Record Deductions;
        EarnRec: Record Earnings;
        Customer: Record Customer;
        TotalEarnings: Decimal;
        TotalDeductions: Decimal;
        PayablesAcc: Code[20];
        FringeAcc: Code[20];
        JTemplate: Code[20];
        JBatch: Code[20];
        DocNo: Code[20];
        LineNo: Integer;
        Window: Dialog;
        TotalCount: Integer;
        Counter: Integer;
        AccNo: Code[20];

    begin
        if PayrollPeriod = 0D then
            ERROR('Please Enter Payroll Period!');
        if StaffPostingGroup = '' then
            Error('Please Specify The Staff posting Group');


        HRSetup.Get();
        HRSetup.TestField("Payroll Template");
        HRSetup.TestField("Payroll Batch");
        JTemplate := HRSetup."Payroll Template";
        //JBatch := HRSetup."Payroll Batch";
        JBatch := StaffPostingGroup;
        LineNo := 0;

        PostingGroup.RESET;
        PostingGroup.SetRange(Code, StaffPostingGroup);
        if PostingGroup.FIND('-') then begin
            PayablesAcc := PostingGroup."Net Salary Payable";
            FringeAcc := PostingGroup."Fringe benefits";
        end;


        GenJournalLine.RESET;
        GenJournalLine.SETRANGE("Journal Template Name", JTemplate);
        GenJournalLine.SETRANGE("Journal Batch Name", JBatch);
        GenJournalLine.DELETEALL;

        DocNo := FORMAT(DATE2DMY(PayrollPeriod, 2)) + '-' + FORMAT(DATE2DMY(PayrollPeriod, 3));


        ObjEmployee.Reset();
        ObjEmployee.SetRange(Status, ObjEmployee.Status::Active);
        ObjEmployee.SetRange("Posting Group", StaffPostingGroup);
        if ObjEmployee.FindSet() then
            Window.OPEN(FORMAT('Processing Employee') + ': #1###############' + 'Record:#2###############');
        repeat
            Counter := Counter + 1;
            Window.Update(1, ObjEmployee."First Name");
            Window.Update(2, Counter);

            TotalEarnings := 0;
            TotalDeductions := 0;
            //*******************************Earnings
            EarnRec.Reset();
            EarnRec.SetRange(Block, false);
            EarnRec.SetFilter("Posting Account Type", '%1|%2|%3', EarnRec."Posting Account Type"::Customer, EarnRec."Posting Account Type"::"G/L Account", EarnRec."Posting Account Type"::Vendor);
            if EarnRec.FindSet() then
                repeat
                    AssignMatrix.Reset();
                    AssignMatrix.SetRange(Code, EarnRec.Code);
                    AssignMatrix.SetRange("Employee No", ObjEmployee."No.");
                    AssignMatrix.SetRange("Payroll Period", PayrollPeriod);
                    AssignMatrix.SetRange(Type, AssignMatrix.Type::Payment);
                    if AssignMatrix.Find('-') then begin
                        AssignMatrix.Validate("Global Dimension 1 code");
                        AssignMatrix.Validate("Global Dimension 2 code");
                        AssignMatrix.Validate("Shortcut Dimension 3 code");
                        if not (EarnRec."Non-Cash Benefit") then begin
                            //********************************Create Entry**********************************//
                            LineNo := LineNo + 1;
                            FnCreateGnlJournalLine(JTemplate, JBatch, DocNo, LineNo, EarnRec."Posting Account Type", EarnRec."Account No.", Today, AssignMatrix.Amount, ObjEmployee."Global Dimension 1 Code",
                                                    ObjEmployee."Global Dimension 2 Code", ObjEmployee."No.", EarnRec.Description + ' : ' + ObjEmployee."No." + ' ' + FORMAT(PayrollPeriod, 0, '<month text> <year4>'), '', '',
                                                    GenJournalLine."Applies-to Doc. Type"::" ", '', 0, AssignMatrix."Dimension Set ID");

                            TotalEarnings := TotalEarnings + AssignMatrix.Amount;
                        end
                        else begin
                            if EarnRec.Fringe then begin
                                //********************************Create Entry**********************************//
                                LineNo := LineNo + 1;
                                FnCreateGnlJournalLine(JTemplate, JBatch, DocNo, LineNo, EarnRec."Posting Account Type", EarnRec."Account No.", Today, AssignMatrix.Amount, ObjEmployee."Global Dimension 1 Code",
                                                        ObjEmployee."Global Dimension 2 Code", ObjEmployee."No.", EarnRec.Description + ' : ' + ObjEmployee."No." + ' ' + FORMAT(PayrollPeriod, 0, '<month text> <year4>'), '', '',
                                                        GenJournalLine."Applies-to Doc. Type"::" ", '', 0, AssignMatrix."Dimension Set ID");
                            end;

                        end;

                    end;

                until EarnRec.Next() = 0;

            //*******************************Deductions
            DedRec.Reset();
            DedRec.SetRange(Block, false);
            DedRec.SetFilter("Posting Account Type", '%1|%2|%3', DedRec."Posting Account Type"::Customer, DedRec."Posting Account Type"::"G/L Account", DedRec."Posting Account Type"::Vendor);
            if DedRec.FindSet() then
                repeat
                    AccNo := '';
                    case DedRec."Posting Account Type" of
                        DedRec."Posting Account Type"::"G/L Account":
                            begin
                                AccNo := DedRec."Account No.";
                            end;
                        DedRec."Posting Account Type"::Vendor:
                            begin
                                AccNo := DedRec."Account No.";
                            end;
                        DedRec."Posting Account Type"::Customer:
                            begin
                                Customer.Reset();
                                Customer.SetRange("No.", ObjEmployee."Customer Acc No.");
                                Customer.SetFilter(Blocked, '<>%1|%2', Customer.Blocked::All, Customer.Blocked::Invoice);
                                if Customer.Find('-') then begin
                                    AccNo := Customer."No.";
                                end;
                            end;
                    end;
                    AssignMatrix.Reset();
                    AssignMatrix.SetRange(Code, DedRec.Code);
                    AssignMatrix.SetRange("Employee No", ObjEmployee."No.");
                    AssignMatrix.SetRange("Payroll Period", PayrollPeriod);
                    AssignMatrix.SetRange(Type, AssignMatrix.Type::Deduction);
                    if AssignMatrix.Find('-') then begin
                        AssignMatrix.Validate("Global Dimension 1 code");
                        AssignMatrix.Validate("Global Dimension 2 code");
                        AssignMatrix.Validate("Shortcut Dimension 3 code");
                        //********************************Create Employee Entry**********************************//
                        LineNo := LineNo + 1;
                        FnCreateGnlJournalLine(JTemplate, JBatch, DocNo, LineNo, DedRec."Posting Account Type", AccNo, Today, AssignMatrix.Amount, ObjEmployee."Global Dimension 1 Code",
                                                ObjEmployee."Global Dimension 2 Code", ObjEmployee."No.", DedRec.Description + ' : ' + ObjEmployee."No." + ' ' + FORMAT(PayrollPeriod, 0, '<month text> <year4>'), '', '',
                                                GenJournalLine."Applies-to Doc. Type"::" ", '', 0, AssignMatrix."Dimension Set ID");

                        TotalDeductions := TotalDeductions + AssignMatrix.Amount;

                        //********************************Create Employer Entry**********************************//

                        if AssignMatrix."Employer Amount" <> 0 then begin
                            //**************Credit
                            LineNo := LineNo + 1;
                            FnCreateGnlJournalLine(JTemplate, JBatch, DocNo, LineNo, DedRec."Posting Account Type", AccNo, Today, (AssignMatrix."Employer Amount" * -1), ObjEmployee."Global Dimension 1 Code",
                                                    ObjEmployee."Global Dimension 2 Code", ObjEmployee."No.", DedRec.Description + 'Employer' + ' : ' + ObjEmployee."No." + ' ' + FORMAT(PayrollPeriod, 0, '<month text> <year4>'), '', '',
                                                    GenJournalLine."Applies-to Doc. Type"::" ", '', 0, AssignMatrix."Dimension Set ID");
                            //**************Debit
                            LineNo := LineNo + 1;
                            FnCreateGnlJournalLine(JTemplate, JBatch, DocNo, LineNo, GenJournalLine."Account Type"::"G/L Account", DedRec."G/L Account Employer", Today, AssignMatrix."Employer Amount", ObjEmployee."Global Dimension 1 Code",
                                                    ObjEmployee."Global Dimension 2 Code", ObjEmployee."No.", DedRec.Description + 'Employer' + ' : ' + ObjEmployee."No." + ' ' + FORMAT(PayrollPeriod, 0, '<month text> <year4>'), '', '',
                                                    GenJournalLine."Applies-to Doc. Type"::" ", '', 0, AssignMatrix."Dimension Set ID");

                        end;

                        //********************************Create Voluntary Entries**********************************//
                        /*
                                                    if AssignMatrix."Employee Voluntary" <> 0 then begin
                                                        //**************Credit
                                                        LineNo := LineNo + 1;
                                                        FnCreateGnlJournalLine(JTemplate, JBatch, DocNo, LineNo, DedRec."Posting Account Type", DedRec."Account No.", Today, (AssignMatrix."Employee Voluntary" * -1), ObjEmployee."Global Dimension 1 Code",
                                                                                ObjEmployee."Global Dimension 2 Code", ObjEmployee."No.", DedRec.Description + 'Voluntary' + ': ' + FORMAT(PayrollPeriod, 0, '<month text> <year4>'), '', '',
                                                                                GenJournalLine."Applies-to Doc. Type"::" ", '', 0);
                                                        //**************Debit
                                                        LineNo := LineNo + 1;
                                                        FnCreateGnlJournalLine(JTemplate, JBatch, DocNo, LineNo, GenJournalLine."Account Type"::"G/L Account", DedRec."G/L Account Employer", Today, AssignMatrix."Employer Amount", ObjEmployee."Global Dimension 1 Code",
                                                                                ObjEmployee."Global Dimension 2 Code", ObjEmployee."No.", DedRec.Description + 'Voluntary' + ': ' + FORMAT(PayrollPeriod, 0, '<month text> <year4>'), '', '',
                                                                                GenJournalLine."Applies-to Doc. Type"::" ", '', 0);

                                                    end;*/

                    end;
                until DedRec.Next() = 0;

            PostingGroup.RESET;
            PostingGroup.SetRange(Code, ObjEmployee."Posting Group");
            if PostingGroup.FIND('-') then begin
                LineNo := LineNo + 1;
                FnCreateGnlJournalLine(JTemplate, JBatch, DocNo, LineNo, PostingGroup."Account Type", PostingGroup."Net Salary Payable", Today, ((TotalEarnings - ABS(TotalDeductions)) * -1), ObjEmployee."Global Dimension 1 Code",
                                        ObjEmployee."Global Dimension 2 Code", ObjEmployee."No.", 'Net Salaries Payable: ' + ObjEmployee."No." + ' ' + FORMAT(PayrollPeriod, 0, '<month text> <year4>'), '', '',
                                        GenJournalLine."Applies-to Doc. Type"::" ", '', 0, AssignMatrix."Dimension Set ID");
            end;

        until ObjEmployee.Next() = 0;
        MESSAGE('Salaries Journals successfuly created and ready for posting. Journal Template = %1, Journal Batch = %2', JTemplate, JBatch);
        Window.CLOSE;
    end;

    procedure GetLeaveBalance(EmpNo: Code[10]) Response: Boolean;
    var
        Bal: Decimal;
        Entitlement: Decimal;
        ObjEmp: Record Employee;
        ObjLeaveSetup: Record "Leave Types";
        ObjLedger: Record "HR Leave Ledger Entries";
        ObjSetup: Record "User Setup";
        DaysTaken: Decimal;
        LeaveBal: Integer;
    begin
        ObjEmp.RESET;
        ObjEmp.SETRANGE("No.", EmpNo);
        if ObjEmp.FIND('-') then begin
            //***************Delete Leave buffer entries
            LeaveBuffer.RESET;
            LeaveBuffer.SETRANGE("Employee No.", ObjEmp."No.");
            if LeaveBuffer.FIND('-') then
                LeaveBuffer.DELETEALL;

            ObjLeaveSetup.RESET;
            if ObjEmp.Gender = ObjEmp.Gender::Female then
                ObjLeaveSetup.SETFILTER(Gender, '%1|%2', ObjLeaveSetup.Gender::Female, ObjLeaveSetup.Gender::Both)
            else
                ObjLeaveSetup.SETFILTER(Gender, '%1|%2', ObjLeaveSetup.Gender::Male, ObjLeaveSetup.Gender::Both);
            if ObjLeaveSetup.FIND('-') then begin
                repeat
                    ObjEmp.SETFILTER("Date Filter", '%1..%2', CALCDATE('-CY', TODAY), CALCDATE('CY', TODAY));
                    ObjEmp.SETRANGE("Leave Type Filter", ObjLeaveSetup.Code);
                    ObjEmp.CALCFIELDS("Total Leavedays Taken", "Total Leavedays Allocated", "Total Recalled Days", "Total Credited Back", "Balance Carried Forward");
                    Bal := ObjEmp."Total Leavedays Allocated" + ObjEmp."Balance Carried Forward";
                    Entitlement := ObjEmp."Total Leavedays Allocated";


                    //Insert***********
                    LeaveBuffer.INIT;
                    LeaveBuffer."Employee No." := ObjEmp."No.";
                    LeaveBuffer."Leave Code" := ObjLeaveSetup.Code;
                    if Bal = 0 then begin
                        LeaveBuffer.Entitlement := Entitlement;
                        LeaveBuffer.Balance := Entitlement - (ObjEmp."Total Leavedays Taken" - ObjEmp."Total Recalled Days" - ObjEmp."Total Credited Back")
                    end else begin
                        LeaveBuffer.Entitlement := Bal;
                        LeaveBuffer.Balance := Bal - (ObjEmp."Total Leavedays Taken" - ObjEmp."Total Recalled Days" - ObjEmp."Total Credited Back");
                    end;
                    LeaveBuffer."Days Taken" := ObjEmp."Total Leavedays Taken";
                    LeaveBuffer."Recalled Days" := ObjEmp."Total Recalled Days";
                    LeaveBuffer."Days Credited Back" := ObjEmp."Total Credited Back";
                    LeaveBuffer."Balance Brought Forward" := ObjEmp."Balance Carried Forward";
                    if (LeaveBuffer.Entitlement <> 0) and (LeaveBuffer.Balance <> 0) then
                        LeaveBuffer.INSERT;


                until ObjLeaveSetup.NEXT = 0;
            end;
            Response := true;
        end else
            Response := false

    end;



    var
        ObjJnlline: Record "HR Journal Line";
        LeaveBuffer: Record "Leave Balance Buffer";
        LeSetup: Record "Additional Leave Set-Up";
}

