codeunit 51513003 "Workflow Response Handling Ext"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        GuaranteeApp: Record "Guarantee Application";
        CGC: Record "Guarantee Contracts";
        FeeWaiverApp: Record "Fee Waiver Application";
        LOHeader: Record "Lenders Option Journal Header";
        Restruct: Record "Restructuring Memo Header";
        ChangeReq: Record "Change Request";
    begin
        case RecRef.Number of
            Database::"Guarantee Application":
                begin
                    RecRef.SetTable(GuaranteeApp);
                    GuaranteeApp.Status := GuaranteeApp.Status::Open;
                    GuaranteeApp.modify;
                    Handled := true;
                end;
            Database::"Guarantee Contracts":
                begin
                    RecRef.SetTable(CGC);
                    CGC.Status := CGC.Status::Open;
                    CGC.modify;
                    Handled := true;
                end;
            Database::"Fee Waiver Application":
                begin
                    RecRef.SetTable(FeeWaiverApp);
                    FeeWaiverApp.Status := FeeWaiverApp.Status::Open;
                    FeeWaiverApp.modify;
                    Handled := true;
                end;
            Database::"Lenders Option Journal Header":
                begin
                    RecRef.SetTable(LOHeader);
                    LOHeader.Status := LOHeader.Status::Open;
                    LOHeader.Modify();
                    Handled := true;
                end;
            Database::"Restructuring Memo Header":
                begin
                    RecRef.SetTable(Restruct);
                    Restruct.Status := Restruct.Status::Open;
                    Restruct.Modify();
                    Handled := true;
                end;
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeReq);
                    ChangeReq."Approval Status" := ChangeReq."Approval Status"::Open;
                    ChangeReq.Modify(true);
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        GuaranteeApp: Record "Guarantee Application";
        GuaranteeSetup: Codeunit "Guarantee Management";
        CGC: Record "Guarantee Contracts";
        FeeWaiverApp: Record "Fee Waiver Application";
        GuaranteeContract: Record "Guarantee Contracts";
        LOHeader: Record "Lenders Option Journal Header";
        Restruct: Record "Restructuring Memo Header";
        FeeType: Option "Restructuring Fee";
        ChangeReq: Record "Change Request";
    begin
        case RecRef.Number of
            Database::"Guarantee Application":
                begin
                    RecRef.SetTable(GuaranteeApp);
                    GuaranteeApp.Status := GuaranteeApp.Status::Released;
                    GuaranteeApp.modify;
                    Handled := true;
                    GuaranteeSetup.CreateApplicationFeeAndCustNo(GuaranteeApp);
                end;
            Database::"Guarantee Contracts":
                begin
                    RecRef.SetTable(CGC);
                    CGC.Status := CGC.Status::Released;
                    CGC."Contract Status" := CGC."Contract Status"::"CGC Prepared";
                    CGC.modify;
                    Handled := true;

                end;
            Database::"Lenders Option Journal Header":
                begin
                    RecRef.SetTable(LOHeader);
                    LOHeader.Status := LOHeader.Status::Released;
                    LOHeader.Modify();
                    Handled := true;
                end;

            Database::"Fee Waiver Application":
                begin
                    RecRef.SetTable(FeeWaiverApp);
                    FeeWaiverApp.Status := FeeWaiverApp.Status::Released;
                    case FeeWaiverApp."Fee Type" of
                        FeeWaiverApp."Fee Type"::"Application Fee":
                            begin
                                if GuaranteeApp.GET(FeeWaiverApp."Client No.") then begin
                                    GuaranteeApp."Application fee Waived" := true;
                                    GuaranteeApp.Modify();
                                end;
                            end;
                        FeeWaiverApp."Fee Type"::Consultancy:
                            begin
                                if GuaranteeApp.GET(FeeWaiverApp."Client No.") then begin
                                    GuaranteeApp."Consultancy fee Waived" := true;
                                    GuaranteeApp.Modify();
                                end;
                            end;
                        FeeWaiverApp."Fee Type"::"Lenders Option":
                            begin
                                if GuaranteeContract.GET(FeeWaiverApp."Client No.") then begin
                                    GuaranteeContract."Lenders Option fee Waived" := true;
                                    GuaranteeContract.Modify();
                                end;
                            end;
                        FeeWaiverApp."Fee Type"::"Linkage Banking":
                            begin
                                if GuaranteeContract.GET(FeeWaiverApp."Client No.") then
                                    GuaranteeContract."Linkage fee Waived" := true;
                                GuaranteeContract.Modify();
                            end;
                    end;
                    if FeeWaiverApp."Waive all fees" then begin
                        if GuaranteeApp.Get(FeeWaiverApp."Client No.") then
                            GuaranteeApp."Waive all fees" := true;
                        GuaranteeApp.Modify();
                    end;


                    FeeWaiverApp.modify;
                    Handled := true;

                end;
            Database::"Restructuring Memo Header":
                begin
                    RecRef.SetTable(Restruct);
                    Restruct.Status := Restruct.Status::Released;
                    Restruct.Modify();
                    Handled := true;
                    GuaranteeSetup.RestructuringFee(Restruct, FeeType::"Restructuring Fee", Restruct."Restructturing Amount", false, Restruct."Customer No.", '');
                end;
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeReq);
                    ChangeReq."Approval Status" := ChangeReq."Approval Status"::Approved;
                    ChangeReq.Modify();
                    ChangeReq.FnProcessChanges(ChangeReq."Contract No");
                    Handled := true;
                end;

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        GuaranteeApp: Record "Guarantee Application";
        CGC: Record "Guarantee Contracts";
        FeeWaiverApp: Record "Fee Waiver Application";
        LOHeader: Record "Lenders Option Journal Header";
        Restruct: Record "Restructuring Memo Header";
        ChangeReq: Record "Change Request";
    begin
        case RecRef.Number of
            Database::"Guarantee Application":
                begin
                    RecRef.SetTable(GuaranteeApp);
                    GuaranteeApp.Status := GuaranteeApp.Status::"Pending Approval";
                    GuaranteeApp.modify;
                    IsHandled := true;
                end;

            Database::"Guarantee Contracts":
                begin
                    RecRef.SetTable(CGC);
                    CGC.Status := CGC.Status::"Pending Approval";
                    CGC.modify;
                    IsHandled := true;
                end;
            Database::"Fee Waiver Application":
                begin
                    RecRef.SetTable(FeeWaiverApp);
                    FeeWaiverApp.Status := FeeWaiverApp.Status::"Pending Approval";
                    FeeWaiverApp.modify;
                    IsHandled := true;
                end;
            Database::"Lenders Option Journal Header":
                begin
                    RecRef.SetTable(LOHeader);
                    LOHeader.Status := LOHeader.Status::"Pending Approval";
                    LOHeader.Modify();
                    IsHandled := true;
                end;
            Database::"Restructuring Memo Header":
                begin
                    RecRef.SetTable(Restruct);
                    Restruct.Status := Restruct.Status::"Pending Approval";
                    Restruct.Modify();
                    IsHandled := true;
                end;
            Database::"Change Request":
                begin
                    RecRef.SetTable(ChangeReq);
                    ChangeReq."Approval Status" := ChangeReq."Approval Status"::"Pending Approval";
                    ChangeReq.Modify();
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[120])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEvenHandlingExt: Codeunit "Workflow Event Handling Ext";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendGuaranteeAppApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendCGCApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendFeeWaiverAppApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendLOHeaderApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendRestructApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendChangeReqApprovalCode);
                end;
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendGuaranteeAppApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendCGCApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendFeeWaiverAppApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendLOHeaderApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendRestructApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnSendChangeReqApprovalCode);
                end;

            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelGuaranteeAppApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelCGCApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelFeeWaiverAppApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelLOHeaderApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelRestructApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelChangeReqApprovalCode);
                end;

            WorkflowResponseHandling.OpenDocumentCode:
                begin
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelGuaranteeAppApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelCGCApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelFeeWaiverAppApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelLOHeaderApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelRestructApprovalCode);

                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode,
                    WorkflowEvenHandlingExt.RunWorkflowOnCancelChangeReqApprovalCode);
                end;
        end;
    end;

}