codeunit 51514001 "Approvals Mgmt. Claim Ext"
{
    trigger OnRun()

    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        NoworkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
        WFCode: Codeunit "Workflow Event Handling ClmExt";


        //***************************** Claim
    [IntegrationEvent(false, false)]
    procedure OnSendClaimRecForApproval(var ClaimRec: Record "Claim")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelClaimRecApprovalRequest(var ClaimRec: Record "Claim")
    begin

    end;

    procedure IsClaimRecApprovalEnabled(var ClaimRec: Record "Claim"): Boolean
    begin
        exit(WFMngt.CanExecuteWorkflow(ClaimRec, WFCode.RunWorkflowOnSendClaimRecForApprovalCode()))

    end;

    procedure CheckClaimRecWorkflowEnabled(var ClaimRec: Record "Claim"): Boolean
    begin
        if not IsClaimRecApprovalEnabled(ClaimRec) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //************************* Populate Approval Entry****************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var

        ClaimRec: Record "Claim";
    begin
        case RecRef.Number of
            Database::"Claim":
                begin
                    RecRef.SetTable(ClaimRec);
                    ClaimRec.CalcFields("Total Amount");
                    ApprovalEntryArgument."Document No." := ClaimRec."No.";
                    ApprovalEntryArgument.Amount := ClaimRec."Total Amount";
                    ApprovalEntryArgument."Amount (LCY)" := ClaimRec."Claiming Bank Amount(LCY)";
                    ApprovalEntryArgument."Currency Code" := ClaimRec."Currency Code";
                end;
        end;
    end;

}
