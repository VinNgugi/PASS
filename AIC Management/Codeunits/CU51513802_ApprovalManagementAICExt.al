codeunit 51513802 "Approvals Mgmt. AIC Ext"
{
    trigger OnRun()

    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        NoworkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
        WFCode: Codeunit "Workflow Event Handling AICExt";


    //***************************** Investment
    [IntegrationEvent(false, false)]
    procedure OnSendIncubForApproval(var Incub: Record Incubation)
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelIncubApprovalRequest(var Incub: Record Incubation)
    begin

    end;

    procedure IsIncubApprovalEnabled(var Incub: Record Incubation): Boolean
    begin
        exit(WFMngt.CanExecuteWorkflow(Incub, WFCode.RunWorkflowOnSendIncubForApprovalCode()))

    end;

    procedure CheckIncubWorkflowEnabled(var Incub: Record Incubation): Boolean
    begin
        if not IsIncubApprovalEnabled(Incub) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //************************* Populate Approval Entry****************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var

        Incub: Record Incubation;
    begin
        case RecRef.Number of
            Database::Incubation:
                begin
                    RecRef.SetTable(Incub);
                    ApprovalEntryArgument."Document No." := Incub."No.";
                end;
        end;
    end;

}
