codeunit 51513001 "Approval Management"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        NoworkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
        WFCode: Codeunit "Workflow Event Handling Ext";

    //>> Guarantee Application

    [IntegrationEvent(false, false)]
    procedure OnSendGuaranteeAppforApproval(Var GuaranteeApp: Record "Guarantee Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelGuaranteeAppforApproval(Var GuaranteeApp: Record "Guarantee Application")
    begin
    end;

    procedure IsGuaranteeAppEnabled(var GuaranteeApp: Record "Guarantee Application"): Boolean

    begin
        if GuaranteeApp.Status <> GuaranteeApp.Status::Open then
            exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(GuaranteeApp, WFCode.RunWorkflowOnSendGuaranteeAppApprovalCode()));
    end;

    procedure CheckGuaranteeAppApprovalWorkflowEnabled(var GuaranteeApp: Record "Guarantee Application"): Boolean

    begin

        if not IsGuaranteeAppEnabled(GuaranteeApp) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //>> CGC Approval

    [IntegrationEvent(false, false)]
    procedure OnSendCGCforApproval(Var CGC: Record "Guarantee Contracts")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelCGCforApproval(Var CGC: Record "Guarantee Contracts")
    begin
    end;

    procedure IsCGCEnabled(var CGC: Record "Guarantee Contracts"): Boolean

    begin
        if CGC.Status <> CGC.Status::Open then
            exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(CGC, WFCode.RunWorkflowOnSendCGCApprovalCode()));
    end;

    procedure CheckCGCApprovalWorkflowEnabled(var CGC: Record "Guarantee Contracts"): Boolean

    begin

        if not IsCGCEnabled(CGC) then
            Error(NoworkflowEnb);
        exit(true);
    end;

    //>> Waiver Application

    [IntegrationEvent(false, false)]
    procedure OnSendFeeWaiverAppforApproval(Var FeeWaiverApp: Record "Fee Waiver Application")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelFeeWaiverAppforApproval(Var FeeWaiverApp: Record "Fee Waiver Application")
    begin
    end;

    procedure IsFeeWaiverAppEnabled(var FeeWaiverApp: Record "Fee Waiver Application"): Boolean

    begin
        if FeeWaiverApp.Status <> FeeWaiverApp.Status::Open then
            exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(FeeWaiverApp, WFCode.RunWorkflowOnSendFeeWaiverAppApprovalCode()));
    end;

    procedure CheckFeeWaiverAppApprovalWorkflowEnabled(var FeeWaiverApp: Record "Fee Waiver Application"): Boolean

    begin

        if not IsFeeWaiverAppEnabled(FeeWaiverApp) then
            Error(NoworkflowEnb);
        exit(true);
    end;

    //>> LO General Journal Header    

    [IntegrationEvent(false, false)]
    procedure OnSendLOHeaderforApproval(Var LOHeader: Record "Lenders Option Journal Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelLOHeaderforApproval(Var LOHeader: Record "Lenders Option Journal Header")
    begin
    end;

    procedure IsLOHeaderEnabled(var LOHeader: Record "Lenders Option Journal Header"): Boolean

    begin
        if LOHeader.Status <> LOHeader.Status::Open then
            exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(LOHeader, WFCode.RunWorkflowOnSendLOHeaderApprovalCode()));
    end;

    procedure CheckLOHeaderApprovalWorkflowEnabled(var LOHeader: Record "Lenders Option Journal Header"): Boolean

    begin

        if not IsLOHeaderEnabled(LOHeader) then
            Error(NoworkflowEnb);
        exit(true);
    end;

    //>> Restructuring ApprovalChangeReq

    [IntegrationEvent(false, false)]
    procedure OnSendRestructforApproval(Var Restruct: Record "Restructuring Memo Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelRestructforApproval(Var Restruct: Record "Restructuring Memo Header")
    begin
    end;

    procedure IsRestructEnabled(var Restruct: Record "Restructuring Memo Header"): Boolean

    begin
        if Restruct.Status <> Restruct.Status::Open then
            exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(Restruct, WFCode.RunWorkflowOnSendRestructApprovalCode()));
    end;

    procedure CheckRestructApprovalWorkflowEnabled(var Restruct: Record "Restructuring Memo Header"): Boolean

    begin

        if not IsRestructEnabled(Restruct) then
            Error(NoworkflowEnb);
        exit(true);
    end;

    //>> ChangeReq Approval

    [IntegrationEvent(false, false)]
    procedure OnSendChangeReqforApproval(Var ChangeReq: Record "Change Request")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelChangeReqforApproval(Var ChangeReq: Record "Change Request")
    begin
    end;

    procedure IsChangeReqEnabled(var ChangeReq: Record "Change Request"): Boolean

    begin
        if ChangeReq."Approval Status" <> ChangeReq."Approval Status"::Open then
            exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(ChangeReq, WFCode.RunWorkflowOnSendChangeReqApprovalCode()));
    end;

    procedure CheckChangeReqApprovalWorkflowEnabled(var ChangeReq: Record "Change Request"): Boolean

    begin

        if not IsChangeReqEnabled(ChangeReq) then
            Error(NoworkflowEnb);
        exit(true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        GuaranteeApp: Record "Guarantee Application";
        CGC: Record "Guarantee Contracts";
        FeeWaiverApp: Record "Fee Waiver Application";
        LOHeader: Record "Lenders Option Journal Header";
        Restruct: Record "Restructuring Memo Header";
        ChangeReq: Record "Change Request";
    begin
        case RecRef.Number of
            DATABASE::"Guarantee Application":
                begin
                    RecRef.SetTable(GuaranteeApp);
                    ApprovalEntryArgument."Document No." := GuaranteeApp."No.";
                end;

            Database::"Guarantee Contracts":
                begin
                    RecRef.SetTable(CGC);
                    ApprovalEntryArgument."Document No." := CGC."No.";
                end;
            DATABASE::"Fee Waiver Application":
                begin
                    RecRef.SetTable(FeeWaiverApp);
                    ApprovalEntryArgument."Document No." := FeeWaiverApp."No.";
                end;
            Database::"Lenders Option Journal Header":
                begin
                    RecRef.SetTable(LOHeader);
                    ApprovalEntryArgument."Document No." := LOHeader."No.";
                end;
            Database::"Restructuring Memo Header":
                begin
                    RecRef.SetTable(Restruct);
                    ApprovalEntryArgument."Document No." := Restruct."No.";
                end;
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeReq);
                    ApprovalEntryArgument."Document No." := ChangeReq."Request No";
                end;
        end;
    end;

}
