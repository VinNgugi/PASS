codeunit 51513804 "Wf ResponseHandling IncubExt"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Incub: Record Incubation;
    begin
        case RecRef.Number of
            Database::Incubation:
                begin
                    RecRef.SetTable(Incub);
                    Incub.Status := Incub.Status::Open;
                    Incub.Modify();
                    Handled := true;

                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Incub: Record Incubation;
    begin
        case RecRef.Number of
            Database::Incubation:
                begin
                    RecRef.SetTable(Incub);
                    Incub.Status := Incub.Status::Released;
                    Incub.Modify();
                    Handled := true;

                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        Incub: Record Incubation;
    begin
        case RecRef.Number of
            Database::Incubation:
                begin
                    RecRef.SetTable(Incub);
                    Incub.Status := Incub.Status::"Pending Approval";
                    Incub.Modify();
                    IsHandled := true;

                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[120])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEvenHandlingExt: Codeunit "Workflow Event Handling AICExt";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendIncubForApprovalCode());
                end;

            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendIncubForApprovalCode());
                end;

            WorkflowResponseHandling.ReleaseDocumentCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendIncubForApprovalCode());
                end;

            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnCancelIncubApprovalRequestCode());
                end;

            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnCancelIncubApprovalRequestCode());
                end;

        end;
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnAfterIncubStatusChange(var Incub: Record Incubation)
    begin

    end;
}