codeunit 51513450 "Training Management"
{
    trigger OnRun()
    begin

    end;

    procedure FnCheckIfUserTrainingDatesClash(Var EmployeeCode: Code[20]; Var TrainingNo: Code[20]; var StartDate: date; var EndDate: Date)
    var
        ObjParticipants: Record "Training Participants Lines";

    begin
        ObjParticipants.Reset();
        ObjParticipants.SetRange("Employee No.", EmployeeCode);
        //ObjParticipants.SetRange("Training Header No.", '<>%1', TrainingNo);
        if ObjParticipants.FindSet() then
            repeat
                if ObjParticipants."Training Header No." <> TrainingNo then begin
                    if ((StartDate >= ObjParticipants."Training Start Date") and (StartDate <= ObjParticipants."Training End Date"))
                                    or ((EndDate >= ObjParticipants."Training Start Date") and (EndDate <= ObjParticipants."Training End Date")) then
                        Error('%1 has another training number %2 within the same date ranges. Training dates cannot overlap', ObjParticipants."Employee Name", ObjParticipants."Training Header No.");
                end;

            until ObjParticipants.Next() = 0;
    end;

    procedure FnSendTrainingNotification(var ObjParticipants: Record "Training Participants Lines")
    var
        CodeFactory: Codeunit "Code Factory";
        ObjEmp: Record Employee;
        SenderName: Text;
        SenderAddress: Text;
        Subject: Text;
        TrainingName: Text;
        TrainingDest: Text;
        CCMails: Text;
        TrainingRec: Record "Training Plan";
        ObjResponsibility: Record "Responsibility Center";
        TrainingMessage: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1,</b></p><p style="font-family:Verdana,Arial;font-size:10pt">This is to notify you that you have been selected for a training titled: <b>%2</b>, which will take place in <b>%3</b>. The training is scheduled to run from <b>%4</b> through to <b>%5</b>. </p><p style="font-family:Verdana,Arial;font-size:10pt">All logistics issues this training are being handled from the HR office in the HQ and you will receive a notification reminder once the training is due.</p><p style="font-family:Verdana,Arial;font-size:10pt">Kind Regards,</p><p style="font-family:Verdana,Arial;font-size:10pt"><b>%6</b></p><p style="font-family:Verdana,Arial;font-size:10pt"><b>%7</b></p><p style="font-family:Verdana,Arial;font-size:10pt"><b>HR Department.</b></p>';

    begin
        TrainingRec.Reset();
        TrainingRec.SetRange("Request No.", ObjParticipants."Training Header No.");
        if TrainingRec.Find('-') then begin
            Subject := TrainingRec."Training Description";
            TrainingName := TrainingRec."Training Objective";
            TrainingDest := TrainingRec."Training Destination";
            if ObjResponsibility.Get(TrainingRec."Responsibility Center") then begin
                SenderName := ObjResponsibility.Name;
                SenderAddress := ObjResponsibility."E-Mail";
            end;
        end;

        repeat
            CCMails := '';

            if ObjEmp.Get(ObjParticipants."Employee No.") then begin

                if ObjResponsibility.Get(ObjEmp."Responsibility Center") then begin
                    CCMails := ObjResponsibility."E-Mail";
                end;
                //====================Create the message.
                CodeFactory.GlobalSendEmailNotification(ObjParticipants."Training Header No.", SenderName, SenderAddress, ObjEmp."First Name", ObjEmp."E-Mail", Subject,
                STRSUBSTNO(TrainingMessage, ObjParticipants."Employee Name", TrainingName, TrainingDest, FORMAT(ObjParticipants."Training Start Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                                  FORMAT(ObjParticipants."Training End Date", 0, '<Day,2>/<Month,2>/<Year4>'), ' ', ''), CCMails);
            end;

        until ObjParticipants.Next() = 0;
    end;

    procedure FnInsertEvaluationEntries(var EvaluationH: Record "Training Evaluation H")
    var
        EvaluationLines: Record "Training Evaluation Line";
        EvaluationTemplate: Record "Training Evaluation Template";
    begin
        EvaluationLines.Reset();
        EvaluationLines.SetRange("Header No.", EvaluationH."No.");
        if EvaluationLines.FindSet() then
            EvaluationLines.DeleteAll();

        EvaluationTemplate.Reset();
        if EvaluationTemplate.FindSet() then
            repeat
                with EvaluationLines do begin
                    Init();
                    "Header No." := EvaluationH."No.";
                    "Employee No" := EvaluationH."Employee No";
                    "Evaluation Area" := EvaluationTemplate."Evaluation Area";
                    "Evaluation Question" := EvaluationTemplate.Question;
                    Insert();
                end;
            until EvaluationTemplate.Next() = 0;

    end;


    var
        myInt: Integer;
}