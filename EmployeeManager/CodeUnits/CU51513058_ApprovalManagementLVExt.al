codeunit 51513058 "Approvals Mgmt. LV Ext"
{
    trigger OnRun()

    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        NoworkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
        WFCode: Codeunit "Workflow Event Handling LV Ext";

        //***************************** LeaveApplication Requisition

    [IntegrationEvent(false, false)]
    procedure OnSendLeaveApplicationforApproval(Var LeaveApplication: Record "Employee Leave Application")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveApplicationforApproval(Var LeaveApplication: Record "Employee Leave Application")
    begin

    end;

    procedure IsLeaveApplicationEnabled(var LeaveApplication: Record "Employee Leave Application"): Boolean

    begin
        EXIT(WFMngt.CanExecuteWorkflow(LeaveApplication, WFCode.RunWorkflowOnSendLeaveApplicationApprovalCode()));
    end;

    procedure CheckLeaveApplicationApprovalWorkflowEnabled(var LeaveApplication: Record "Employee Leave Application"): Boolean

    begin

        if not IsLeaveApplicationEnabled(LeaveApplication) then
            Error(NoworkflowEnb);
        exit(true);
    end;

    //***************************** Leave Recall
    [IntegrationEvent(false, false)]
    procedure OnSendLeaveRecallForApproval(var Recall: Record "Leave Recall")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLeaveRecallApprovalRequest(var Recall: Record "Leave Recall")
    begin

    end;

    procedure IsLeaveRecallApprovalEnabled(var Recall: Record "Leave Recall"): Boolean
    begin
        exit(WFMngt.CanExecuteWorkflow(Recall, WFCode.RunWorkflowOnSendLeaveRecallForApprovalCode()))

    end;

    procedure CheckLeaveRecallWorkflowEnabled(var Recall: Record "Leave Recall"): Boolean
    begin
        if not IsLeaveRecallApprovalEnabled(Recall) then
            Error(NoworkflowEnb);
        exit(true);
    end;
    //*********************** End Leave Application 

    //********************** Appraisal Objectives 

    [IntegrationEvent(false, false)]
    procedure OnSendApprObjforApproval(Var ApprObj: Record "Employee Appraisal Objectives")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelApprObjforApproval(Var ApprObj: Record "Employee Appraisal Objectives")
    begin

    end;

    procedure IsApprObjEnabled(var ApprObj: Record "Employee Appraisal Objectives"): Boolean

    begin
        EXIT(WFMngt.CanExecuteWorkflow(ApprObj, WFCode.RunWorkflowOnSendApprObjApprovalCode()));
    end;

    procedure CheckApprObjApprovalWorkflowEnabled(var ApprObj: Record "Employee Appraisal Objectives"): Boolean

    begin

        if not IsApprObjEnabled(ApprObj) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //*********************** End  Appraisal Objectives

    //********************** Employee Appraisals

    [IntegrationEvent(false, false)]
    procedure OnSendAppraisalforApproval(Var Appraisal: Record "Employee Appraisals")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelAppraisalforApproval(Var Appraisal: Record "Employee Appraisals")
    begin

    end;

    procedure IsAppraisalEnabled(var Appraisal: Record "Employee Appraisals"): Boolean

    begin
        EXIT(WFMngt.CanExecuteWorkflow(Appraisal, WFCode.RunWorkflowOnSendAppraisalApprovalCode()));
    end;

    procedure CheckAppraisalApprovalWorkflowEnabled(var Appraisal: Record "Employee Appraisals"): Boolean

    begin

        if not IsAppraisalEnabled(Appraisal) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //*********************** End  Appraisal Objectives

    //************************* Populate Approval Entry****************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        LeaveApplication: Record "Employee Leave Application";
        Recall: Record "Leave Recall";
        ApprObj: Record "Employee Appraisal Objectives";
        Appraisal: Record "Employee Appraisals";
    begin
        case RecRef.Number of
            DATABASE::"Employee Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    ApprovalEntryArgument."Document No." := LeaveApplication."Application No"
                end;
            Database::"Leave Recall":
                begin
                    RecRef.SetTable(Recall);
                    ApprovalEntryArgument."Document No." := Recall."No.";

                end;
            Database::"Employee Appraisal Objectives":
                begin
                    RecRef.SetTable(ApprObj);
                    ApprovalEntryArgument."Document No." := ApprObj."Objective No";
                end;
            Database::"Employee Appraisals":
                begin
                    RecRef.SetTable(Appraisal);
                    ApprovalEntryArgument."Document No." := Appraisal."Appraisal No";
                end;
        end;
    end;

}
