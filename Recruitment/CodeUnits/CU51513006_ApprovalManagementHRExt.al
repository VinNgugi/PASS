codeunit 51513006 "Approvals Mgmt. HR Ext"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        NoworkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
        WFCode: Codeunit "Workflow Event Handling HR Ext";

        //>> Recruitment Requisition

    [IntegrationEvent(false, false)]
    procedure OnSendRecruitmentforApproval(Var Recruitment: Record "Recruitment Needs")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelRecruitmentforApproval(Var Recruitment: Record "Recruitment Needs")
    begin
    end;

    procedure IsRecruitmentEnabled(var Recruitment: Record "Recruitment Needs"): Boolean

    begin
        
        EXIT(WFMngt.CanExecuteWorkflow(Recruitment, WFCode.RunWorkflowOnSendRecruitmentApprovalCode()));
    end;

    procedure CheckRecruitmentApprovalWorkflowEnabled(var Recruitment: Record "Recruitment Needs"): Boolean

    begin

        if not IsRecruitmentEnabled(Recruitment) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //<< Recruitment Requisition 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        Recruitment: Record "Recruitment Needs";
    begin
        case RecRef.Number of
            DATABASE::"Recruitment Needs":
                begin
                    RecRef.SetTable(Recruitment);
                    ApprovalEntryArgument."Document No." := Recruitment."No.";
                end;
        end;
    end;

}
