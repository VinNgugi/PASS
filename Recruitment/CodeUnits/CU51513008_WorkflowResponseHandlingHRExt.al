codeunit 51513008 "WorkflowResponseHandling HRExt"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Recruitment: Record "Recruitment Needs";
    begin
        case RecRef.Number of
            Database::"Recruitment Needs":
                begin
                    RecRef.SetTable(Recruitment);
                    Recruitment.Status := Recruitment.Status::Open;
                    Recruitment.modify;
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        Recruitment: Record "Recruitment Needs";
    begin
        case RecRef.Number of
            Database::"Recruitment Needs":
                begin
                    RecRef.SetTable(Recruitment);
                    Recruitment.Status := Recruitment.Status::Released;
                    Recruitment.modify;
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        Recruitment: Record "Recruitment Needs";
    begin
        case RecRef.Number of
            Database::"Recruitment Needs":
                begin
                    RecRef.SetTable(Recruitment);
                    Recruitment.Status := Recruitment.Status::"Pending Approval";
                    Recruitment.modify;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[120])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEvenHandlingExt: Codeunit "Workflow Event Handling HR Ext";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                WorkflowEvenHandlingExt.RunWorkflowOnSendRecruitmentApprovalCode);

            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                WorkflowEvenHandlingExt.RunWorkflowOnSendRecruitmentApprovalCode);

            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                WorkflowEvenHandlingExt.RunWorkflowOnCancelRecruitmentApprovalCode);

            WorkflowResponseHandling.OpenDocumentCode:
                WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                WorkflowEvenHandlingExt.RunWorkflowOnCancelRecruitmentApprovalCode);
        end;
    end;

}