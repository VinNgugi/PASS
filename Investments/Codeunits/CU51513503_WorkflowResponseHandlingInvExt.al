codeunit 51513503 "Wf ResponseHandling InvExt"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Investment: Record "Investment Header";
    begin
        case RecRef.Number of
            Database::"Investment Header":
                begin
                    RecRef.SetTable(Investment);
                    Investment.Status := Investment.Status::Open;
                    Investment.Modify();
                    Handled := true;

                    FnOnAfterInvestmentStatusChange(Investment);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Investment: Record "Investment Header";
    begin
        case RecRef.Number of
            Database::"Investment Header":
                begin
                    RecRef.SetTable(Investment);
                    Investment.Status := Investment.Status::Released;
                    Investment.Modify();
                    Handled := true;

                    FnOnAfterInvestmentStatusChange(Investment);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        Investment: Record "Investment Header";
    begin
        case RecRef.Number of
            Database::"Investment Header":
                begin
                    RecRef.SetTable(Investment);
                    Investment.Status := Investment.Status::"Pending Approval";
                    Investment.Modify();
                    IsHandled := true;

                    FnOnAfterInvestmentStatusChange(Investment);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[120])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEvenHandlingExt: Codeunit "Workflow Event Handling InvExt";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendInvestmentAppForApprovalCode());
                end;

            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendInvestmentAppForApprovalCode());
                end;

            WorkflowResponseHandling.ReleaseDocumentCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendInvestmentAppForApprovalCode());
                end;

            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnCancelInvestmentAppApprovalRequestCode());
                end;

            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnCancelInvestmentAppApprovalRequestCode());
                end;

        end;
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnAfterInvestmentStatusChange(var Investment: Record "Investment Header")
    begin

    end;
}