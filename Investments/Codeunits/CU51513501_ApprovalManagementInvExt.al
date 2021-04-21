codeunit 51513501 "Approvals Mgmt. Inv Ext"
{
    trigger OnRun()

    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        NoworkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
        WFCode: Codeunit "Workflow Event Handling InvExt";


        //***************************** Investment
    [IntegrationEvent(false, false)]
    procedure OnSendInvestmentAppForApproval(var Investment: Record "Investment Header")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelInvestmentAppApprovalRequest(var Investment: Record "Investment Header")
    begin

    end;

    procedure IsInvestmentAppApprovalEnabled(var Investment: Record "Investment Header"): Boolean
    begin
        exit(WFMngt.CanExecuteWorkflow(Investment, WFCode.RunWorkflowOnSendInvestmentAppForApprovalCode()))

    end;

    procedure CheckInvestmentAppWorkflowEnabled(var Investment: Record "Investment Header"): Boolean
    begin
        if not IsInvestmentAppApprovalEnabled(Investment) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //************************* Populate Approval Entry****************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var

        Investment: Record "Investment Header";
    begin
        case RecRef.Number of
            Database::"Investment Header":
                begin
                    RecRef.SetTable(Investment);
                    ApprovalEntryArgument."Document No." := Investment."No.";
                    ApprovalEntryArgument.Amount := Investment."Investment Principal";
                    ApprovalEntryArgument."Amount (LCY)" := Investment."Investment Principle(LCY)";
                    ApprovalEntryArgument."Currency Code" := Investment."Currency Code";
                end;
        end;
    end;

}
