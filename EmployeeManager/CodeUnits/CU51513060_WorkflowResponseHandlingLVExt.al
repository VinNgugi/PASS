codeunit 51513060 "WorkflowResponseHandling LVExt"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        LeaveApplication: Record "Employee Leave Application";
        Recall: Record "Leave Recall";
        ApprObj: Record "Employee Appraisal Objectives";
        Appraisal: Record "Employee Appraisals";
    begin
        case RecRef.Number of
            Database::"Employee Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Status := LeaveApplication.Status::Open;
                    LeaveApplication.modify;
                    Handled := true;
                    //**************Notification Sending****************//
                    FnOnAfterLeaveStatusChange(LeaveApplication);
                end;
            Database::"Leave Recall":
                begin
                    RecRef.SetTable(Recall);
                    Recall.Status := Recall.Status::Open;
                    Recall.Modify();
                    Handled := true;

                    FnOnAfterRecallStatusChange(Recall);
                end;
            Database::"Employee Appraisal Objectives":
                begin
                    RecRef.SetTable(ApprObj);
                    ApprObj.Status := ApprObj.Status::Open;
                    ApprObj.Modify();
                    Handled := true;
                end;
            Database::"Employee Appraisals":
                begin
                    RecRef.SetTable(Appraisal);
                    Appraisal.Status := Appraisal.Status::Open;
                    Appraisal.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        LeaveApplication: Record "Employee Leave Application";
        Recall: Record "Leave Recall";
        ApprObj: Record "Employee Appraisal Objectives";
        Appraisal: Record "Employee Appraisals";
        CodeFactory: Codeunit "Code Factory";
    begin
        case RecRef.Number of
            Database::"Employee Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Status := LeaveApplication.Status::Approved;
                    LeaveApplication.modify;
                    Handled := true;
                    //**************Notification Sending****************//
                    FnOnAfterLeaveStatusChange(LeaveApplication);

                    //*************************Execute if leave Allowance payable is true.*******************//
                    if LeaveApplication."Leave Allowance Payable" then begin
                        LeaveApplication.CreateLeaveAllowancePayroll(LeaveApplication);
                        //******************Create Leave Allowance PV
                        OnAfterInsertLeaveAllowance(LeaveApplication);

                        CodeFactory.FnSendLeaveAllowanceMailToFin(LeaveApplication);
                    end;
                    //*************************Execute if leave Allowance payable is true.*******************//

                end;
            Database::"Leave Recall":
                begin
                    RecRef.SetTable(Recall);
                    Recall.Status := Recall.Status::Released;
                    Recall.Modify();
                    Handled := true;

                    FnOnAfterRecallStatusChange(Recall);
                end;
            Database::"Employee Appraisal Objectives":
                begin
                    RecRef.SetTable(ApprObj);
                    ApprObj.Status := ApprObj.Status::Released;
                    ApprObj.Modify();
                    Handled := true;
                end;
            Database::"Employee Appraisals":
                begin
                    RecRef.SetTable(Appraisal);
                    Appraisal.Status := Appraisal.Status::Released;
                    Appraisal.Modify();
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        LeaveApplication: Record "Employee Leave Application";
        Recall: Record "Leave Recall";
        ApprObj: Record "Employee Appraisal Objectives";
        Appraisal: Record "Employee Appraisals";
    begin
        case RecRef.Number of
            Database::"Employee Leave Application":
                begin
                    RecRef.SetTable(LeaveApplication);
                    LeaveApplication.Status := LeaveApplication.Status::"Pending Approval";
                    LeaveApplication.modify;
                    IsHandled := true;
                    //**************Notification Sending****************//
                    FnOnAfterLeaveStatusChange(LeaveApplication);
                end;
            Database::"Leave Recall":
                begin
                    RecRef.SetTable(Recall);
                    Recall.Status := recall.Status::"Pending Approval";
                    Recall.Modify();
                    IsHandled := true;

                    FnOnAfterRecallStatusChange(Recall);
                end;
            Database::"Employee Appraisal Objectives":
                begin
                    RecRef.SetTable(ApprObj);
                    ApprObj.Status := ApprObj.Status::"Pending Approval";
                    ApprObj.Modify();
                    IsHandled := true;
                end;
            Database::"Employee Appraisals":
                begin
                    RecRef.SetTable(Appraisal);
                    Appraisal.Status := Appraisal.Status::"Pending Approval";
                    Appraisal.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[120])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEvenHandlingExt: Codeunit "Workflow Event Handling LV Ext";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendLeaveApplicationApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendLeaveRecallForApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                   WorkflowEvenHandlingExt.RunWorkflowOnSendApprObjApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
 WorkflowEvenHandlingExt.RunWorkflowOnSendAppraisalApprovalCode());
                end;

            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendLeaveApplicationApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendLeaveRecallForApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendApprObjApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendAppraisalApprovalCode());
                end;

            WorkflowResponseHandling.ReleaseDocumentCode():
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                                    WorkflowEvenHandlingExt.RunWorkflowOnSendLeaveApplicationApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnSendLeaveRecallForApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendApprObjApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendAppraisalApprovalCode());
                end;

            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnCancelLeaveApplicationApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnCancelLeaveRecallApprovalRequestCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelApprObjApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelAppraisalApprovalCode());
                end;

            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnCancelLeaveApplicationApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                                    WorkflowEvenHandlingExt.RunWorkflowOnCancelLeaveRecallApprovalRequestCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                  WorkflowEvenHandlingExt.RunWorkflowOnCancelApprObjApprovalCode());
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelAppraisalApprovalCode());
                end;

        end;
    end;

    [IntegrationEvent(false, false)]
    procedure FnOnAfterLeaveStatusChange(var LeaveApplication: Record "Employee Leave Application")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure FnOnAfterRecallStatusChange(var Recall: Record "Leave Recall")
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnAfterInsertLeaveAllowance(var LeaveApp: Record "Employee Leave Application")

    begin

    end;
}