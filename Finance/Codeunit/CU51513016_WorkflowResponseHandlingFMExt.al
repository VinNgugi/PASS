codeunit 51513016 "WorkflowResponseHandling FMExt"
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnOpenDocument', '', true, true)]
    local procedure OnOpenDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PettyCash: Record "Payments HeaderFin";
        PurchaseReq: Record "Requisition Header";
        ObjTrMemo: Record "Memo Request Header";
        ObjHotReq: Record "Hotel Request Header";
        ObjIntB: Record "InterBank Transfer Header";
    begin
        case RecRef.Number of
            Database::"Payments HeaderFin":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Status := PettyCash.Status::Open;
                    PettyCash.modify;
                    Handled := true;
                end;
            Database::"Requisition Header":
                begin
                    RecRef.SetTable(PurchaseReq);
                    PurchaseReq.Status := PurchaseReq.Status::Open;
                    PurchaseReq.modify;
                    Handled := true;

                end;
            Database::"Memo Request Header":
                begin
                    RecRef.SetTable(ObjTrMemo);
                    ObjTrMemo."Approval Status" := ObjTrMemo."Approval Status"::New;
                    ObjTrMemo.modify;
                    Handled := true;
                end;
            Database::"Hotel Request Header":
                begin
                    RecRef.SetTable(ObjHotReq);
                    ObjHotReq."Approval Status" := ObjHotReq."Approval Status"::New;
                    ObjHotReq.modify;
                    Handled := true;
                end;
            Database::"InterBank Transfer Header":
                begin
                    RecRef.SetTable(ObjIntB);
                    ObjIntB."Approval Status" := ObjIntB."Approval Status"::New;
                    ObjIntB.modify;
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnReleaseDocument', '', true, true)]
    local procedure OnReleaseDocument(RecRef: RecordRef; var Handled: Boolean)
    var
        PettyCash: Record "Payments HeaderFin";
        PurchaseReq: Record "Requisition Header";
        ObjTrMemo: Record "Memo Request Header";
        ObjHotReq: Record "Hotel Request Header";
        ObjIntB: Record "InterBank Transfer Header";
    begin
        case RecRef.Number of
            Database::"Payments HeaderFin":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Status := PettyCash.Status::Released;
                    PettyCash.modify;
                    Handled := true;
                end;
            Database::"Requisition Header":
                begin
                    RecRef.SetTable(PurchaseReq);
                    PurchaseReq.Status := PurchaseReq.Status::Released;
                    PurchaseReq.modify;
                    Handled := true;
                end;
            Database::"Memo Request Header":
                begin
                    RecRef.SetTable(ObjTrMemo);
                    ObjTrMemo."Approval Status" := ObjTrMemo."Approval Status"::Approved;
                    ObjTrMemo.modify;
                    Handled := true;

                    OnAfterApproveMemo(ObjTrMemo);
                end;
            Database::"Hotel Request Header":
                begin
                    RecRef.SetTable(ObjHotReq);
                    ObjHotReq."Approval Status" := ObjHotReq."Approval Status"::Approved;
                    ObjHotReq.modify;
                    Handled := true;

                end;
            Database::"InterBank Transfer Header":
                begin
                    RecRef.SetTable(ObjIntB);
                    ObjIntB."Approval Status" := ObjIntB."Approval Status"::Approved;
                    ObjIntB.modify;
                    Handled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnSetStatusToPendingApproval', '', true, true)]
    local procedure OnSetStatusToPendingApproval(RecRef: RecordRef; var Variant: Variant; var IsHandled: Boolean)
    var
        PettyCash: Record "Payments HeaderFin";
        PurchaseReq: Record "Requisition Header";
        ObjTrMemo: Record "Memo Request Header";
        ObjHotReq: Record "Hotel Request Header";
        ObjTrvReqLines: Record "Memo Request Lines";
        ObjIntB: Record "InterBank Transfer Header";
    begin
        case RecRef.Number of
            Database::"Payments HeaderFin":
                begin
                    RecRef.SetTable(PettyCash);
                    PettyCash.Status := PettyCash.Status::"Pending Approval";
                    PettyCash.modify();

                    if (PettyCash."Payment Type" = PettyCash."Payment Type"::Imprest) or (PettyCash."Payment Type" = PettyCash."Payment Type"::"Imprest Requisitioning") then begin
                        if ObjTrMemo.Get(PettyCash."Memo Reference") then begin

                            ObjTrvReqLines.Reset();
                            ObjTrvReqLines.SetRange("Header No.", ObjTrMemo."Request No.");
                            ObjTrvReqLines.SetRange("Employee No", PettyCash."Employee No");
                            if ObjTrvReqLines.Find('-') then begin
                                ObjTrvReqLines."Attached to Imprest" := true;
                                ObjTrvReqLines.Modify();
                            end;
                        end;
                    end;

                    IsHandled := true;
                end;
            Database::"Requisition Header":
                begin
                    RecRef.SetTable(PurchaseReq);
                    PurchaseReq.Status := PurchaseReq.Status::"Pending Approval";
                    PurchaseReq.modify;
                    IsHandled := true;
                end;
            Database::"Memo Request Header":
                begin
                    RecRef.SetTable(ObjTrMemo);
                    ObjTrMemo."Approval Status" := ObjTrMemo."Approval Status"::"Pending Approval";
                    ObjTrMemo.modify;
                    IsHandled := true;
                end;
            Database::"Hotel Request Header":
                begin
                    RecRef.SetTable(ObjHotReq);
                    ObjHotReq."Approval Status" := ObjHotReq."Approval Status"::"Pending Approval";
                    ObjHotReq.modify;
                    IsHandled := true;
                end;
            Database::"InterBank Transfer Header":
                begin
                    RecRef.SetTable(ObjIntB);
                    ObjIntB."Approval Status" := ObjIntB."Approval Status"::"Pending Approval";
                    ObjIntB.modify;
                    IsHandled := true;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Response Handling", 'OnAddWorkflowResponsePredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowResponsePredecessorsToLibrary(ResponseFunctionName: Code[120])
    var
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        WorkflowEvenHandlingExt: Codeunit "Workflow Event Handling FMExt";
    begin
        case ResponseFunctionName of
            WorkflowResponseHandling.SetStatusToPendingApprovalCode:
                BEGIN
                    //Petty Cash
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendPettyCashApprovalCode);
                    //Imprest
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendImprestApprovalCode);
                    //Surrender
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendSurrenderApprovalCode);
                    //Payment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendPaymentApprovalCode);
                    //PurchaseReq
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendPurchaseReqApprovalCode);
                    //Travel Memo
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendTravelMemoReqforApprovalCode);
                    //Hotel Req
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendHotelReqforApprovalCode);
                    //Interbank Transfer
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SetStatusToPendingApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendInterbankTransForApprovalCode());
                END;
            WorkflowResponseHandling.SendApprovalRequestForApprovalCode:
                BEGIN
                    //Petty Cash
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendPettyCashApprovalCode);
                    //Imprest
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendImprestApprovalCode);
                    //Surrender
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendSurrenderApprovalCode);
                    //Payment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendPaymentApprovalCode);
                    //PurchaseReq
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendPurchaseReqApprovalCode);
                    //Travel Memo
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendTravelMemoReqforApprovalCode);
                    //Hotel Req
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendHotelReqforApprovalCode);
                    //Intrbank Transfer
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.SendApprovalRequestForApprovalCode, WorkflowEvenHandlingExt.RunWorkflowOnSendInterbankTransForApprovalCode());
                END;
            WorkflowResponseHandling.CancelAllApprovalRequestsCode:
                BEGIN
                    //Petty Cash
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelPettyCashApprovalCode);
                    //Imprest
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelImprestApprovalCode);
                    //Surrender
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelSurrenderApprovalCode);
                    //Payment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelPaymentApprovalCode);
                    //PurchaseReq
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelPurchaseReqApprovalCode);
                    //Travel Memo
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelTravelMemoReqApprovalRequestCode());
                    //Hotel Req
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelHotelReqApprovalRequestCode());
                    //Interbank Trasnfer
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.CancelAllApprovalRequestsCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelInterbankTransApprovalRequestCode());
                END;
            WorkflowResponseHandling.OpenDocumentCode:
                BEGIN
                    //Petty Cash
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelPettyCashApprovalCode);
                    //Imprest
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelImprestApprovalCode);
                    //Surrender
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelSurrenderApprovalCode);
                    //Payment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelPaymentApprovalCode);
                    //PurchaseReq
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelPurchaseReqApprovalCode);
                    //Travel Memo
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelTravelMemoReqApprovalRequestCode);
                    //Hotel Req
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelHotelReqApprovalRequestCode);
                    //InterBank Transfer
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.OpenDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnCancelInterbankTransApprovalRequestCode());

                END;
            WorkflowResponseHandling.ReleaseDocumentCode():
                begin
                    //Petty Cash
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.ReleaseDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnSendPettyCashApprovalCode);
                    //Imprest
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.ReleaseDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnSendImprestApprovalCode);
                    //Surrender
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.ReleaseDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnSendSurrenderApprovalCode);
                    //Payment
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.ReleaseDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnSendPaymentApprovalCode);
                    //PurchaseReq
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.ReleaseDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnSendPurchaseReqApprovalCode);
                    //Travel Memo
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.ReleaseDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnSendTravelMemoReqforApprovalCode);
                    //Hotel Req
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.ReleaseDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnSendHotelReqforApprovalCode);
                    //InterBank Transfer
                    WorkflowResponseHandling.AddResponsePredecessor(WorkflowResponseHandling.ReleaseDocumentCode, WorkflowEvenHandlingExt.RunWorkflowOnSendInterbankTransForApprovalCode());
                end;
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterApproveMemo(var ObjMemo: Record "Memo Request Header")
    var

    begin

    end;

}