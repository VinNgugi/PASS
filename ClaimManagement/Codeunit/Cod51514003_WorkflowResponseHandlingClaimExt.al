codeunit 51514003 "Wf ResponseHandling ClaimExt"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ClaimRec: Record "Claim";
    begin
        case RecRef.Number of
            Database::"Claim":
                begin
                    RecRef.SetTable(ClaimRec);
                    ClaimRec."Approval Status" := ClaimRec."Approval Status"::Open;
                    ClaimRec.Modify();
                    Handled := true;

                    FnOnAfterClaimRecStatusChange(ClaimRec);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        ClaimRec: Record "Claim";
        ClaimLines: Record "Guarantee Claim Line";
    begin
        case RecRef.Number of
            Database::"Claim":
                begin
                    RecRef.SetTable(ClaimRec);
                    ClaimRec."Approval Status" := ClaimRec."Approval Status"::Released;
                    ClaimRec.Status := ClaimRec.Status::Pending;
                    ClaimRec.Modify();
                    Handled := true;

                    ClaimLines.Reset();
                    ClaimLines.SetRange("Claim No.", ClaimRec."No.");
                    if ClaimLines.FindSet() then
                        repeat
                            ClaimLines.Completed := true;
                            ClaimLines.Modify();
                        until ClaimLines.Next() = 0;

                    FnOnAfterClaimRecStatusChange(ClaimRec);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        ClaimRec: Record "Claim";
    begin
        case RecRef.Number of
            Database::"Claim":
                begin
                    RecRef.SetTable(ClaimRec);
                    ClaimRec."Approval Status" := ClaimRec."Approval Status"::"Pending Approval";
                    ClaimRec.Modify();
                    IsHandled := true;

                    FnOnAfterClaimRecStatusChange(ClaimRec);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[120])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEvenHandlingExt: Codeunit "Workflow Event Handling ClmExt";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendClaimRecForApprovalCode());
                end;

            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendClaimRecForApprovalCode());
                end;

            WorkflowResponseHandling.ReleaseDocumentCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendClaimRecForApprovalCode());
                end;

            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnCancelClaimRecApprovalRequestCode());
                end;

            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnCancelClaimRecApprovalRequestCode());
                end;

        end;
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnAfterClaimRecStatusChange(var ClaimRec: Record "Claim")
    begin

    end;
}