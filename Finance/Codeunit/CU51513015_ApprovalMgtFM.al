codeunit 51513015 ApprovalMgtFM
{
    var
        WFMngt: Codeunit "Workflow Management";
        NoworkflowEnb: TextConst ENU = 'No workflow Enabled for this Record type', ENG = 'No workflow Enabled for this Record type';
        WFCode: Codeunit "Workflow Event Handling FMExt";


    //>> PettyCash Requisition

    [IntegrationEvent(false, false)]
    procedure OnSendPettyCashforApproval(Var PettyCash: Record "Payments HeaderFin")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPettyCashforApproval(Var PettyCash: Record "Payments HeaderFin")
    begin
    end;

    procedure IsPettyCashEnabled(var PettyCash: Record "Payments HeaderFin"): Boolean

    begin
        if PettyCash.Status <> PettyCash.Status::Open then
            exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(PettyCash, WFCode.RunWorkflowOnSendPettyCashApprovalCode()));
    end;

    procedure CheckPettyCashApprovalWorkflowEnabled(var PettyCash: Record "Payments HeaderFin"): Boolean

    begin

        if not IsPettyCashEnabled(PettyCash) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //<< PettyCash Requisition 


    //>> Imprest

    [IntegrationEvent(false, false)]
    procedure OnSendImprestforApproval(Var Imprest: Record "Payments HeaderFin")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelImprestforApproval(Var Imprest: Record "Payments HeaderFin")
    begin
    end;

    procedure IsImprestEnabled(var Imprest: Record "Payments HeaderFin"): Boolean

    begin
        if Imprest.Status <> Imprest.Status::Open then
            exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(Imprest, WFCode.RunWorkflowOnSendImprestApprovalCode()));
    end;

    procedure CheckImprestApprovalWorkflowEnabled(var Imprest: Record "Payments HeaderFin"): Boolean

    begin

        if not IsImprestEnabled(Imprest) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //<< Imprest Requisition 


    //>> Surrender

    [IntegrationEvent(false, false)]
    procedure OnSendSurrenderforApproval(Var Surrender: Record "Payments HeaderFin")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelSurrenderforApproval(Var Surrender: Record "Payments HeaderFin")
    begin
    end;

    procedure IsSurrenderEnabled(var Surrender: Record "Payments HeaderFin"): Boolean

    begin
        if Surrender.Status <> Surrender.Status::Open then
            exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(Surrender, WFCode.RunWorkflowOnSendSurrenderApprovalCode()));
    end;

    procedure CheckSurrenderApprovalWorkflowEnabled(var Surrender: Record "Payments HeaderFin"): Boolean

    begin

        if not IsSurrenderEnabled(Surrender) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //<< Surrender Requisition 


    //>> Payment

    [IntegrationEvent(false, false)]
    procedure OnSendPaymentforApproval(Var Payment: Record "Payments HeaderFin")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPaymentforApproval(Var Payment: Record "Payments HeaderFin")
    begin
    end;

    procedure IsPaymentEnabled(var Payment: Record "Payments HeaderFin"): Boolean

    begin
        if Payment.Status <> Payment.Status::Open then
            exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(Payment, WFCode.RunWorkflowOnSendPaymentApprovalCode()));
    end;

    procedure CheckPaymentApprovalWorkflowEnabled(var Payment: Record "Payments HeaderFin"): Boolean

    begin

        if not IsPaymentEnabled(Payment) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //<< Payment Requisition 


    //>> Purchase Requisition

    [IntegrationEvent(false, false)]
    procedure OnSendPurchaseReqforApproval(Var PurchaseReq: Record "Requisition Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelPurchaseReqforApproval(Var PurchaseReq: Record "Requisition Header")
    begin
    end;

    procedure IsPurchaseReqEnabled(var PurchaseReq: Record "Requisition Header"): Boolean

    begin
        if PurchaseReq.Status <> PurchaseReq.Status::Open then
            exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(PurchaseReq, WFCode.RunWorkflowOnSendPurchaseReqApprovalCode()));
    end;

    procedure CheckPurchaseReqApprovalWorkflowEnabled(var PurchaseReq: Record "Requisition Header"): Boolean

    begin

        if not IsPurchaseReqEnabled(PurchaseReq) then
            Error(NoworkflowEnb);
        exit(true);
    end;


    //<< Purchase Requisition 

    //***********************Travel Memo Application*********************//

    [IntegrationEvent(false, false)]
    procedure OnSendTravelMemoReqforApproval(Var ObjTrMemo: Record "Memo Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelTravelMemoReqforApproval(Var ObjTrMemo: Record "Memo Request Header")
    begin
    end;

    procedure IsTravelMemoReqEnabled(var ObjTrMemo: Record "Memo Request Header"): Boolean

    begin
        //if ObjTrMemo."Approval Status" <> ObjTrMemo."Approval Status"::New then
        //  exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(ObjTrMemo, WFCode.RunWorkflowOnSendTravelMemoReqForApprovalCode()));
    end;

    procedure CheckTravelMemoReqApprovalWorkflowEnabled(var ObjTrMemo: Record "Memo Request Header"): Boolean

    begin

        if not IsTravelMemoReqEnabled(ObjTrMemo) then
            Error(NoworkflowEnb);
        exit(true);
    end;

    ////***********************Travel Memo Application*********************//

    //***********************Hotel Application*********************//

    [IntegrationEvent(false, false)]
    procedure OnSendHotelReqforApproval(Var ObjHotReq: Record "Hotel Request Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelHotelReqforApproval(Var ObjHotReq: Record "Hotel Request Header")
    begin
    end;

    procedure IsHotelReqEnabled(var ObjHotReq: Record "Hotel Request Header"): Boolean

    begin
        //if ObjTrMemo."Approval Status" <> ObjTrMemo."Approval Status"::New then
        //  exit(false);
        EXIT(WFMngt.CanExecuteWorkflow(ObjHotReq, WFCode.RunWorkflowOnSendHotelReqForApprovalCode()));
    end;

    procedure CheckHotelReqApprovalWorkflowEnabled(var ObjHotReq: Record "Hotel Request Header"): Boolean

    begin

        if not IsHotelReqEnabled(ObjHotReq) then
            Error(NoworkflowEnb);
        exit(true);
    end;

    ////***********************End Hotel Application*********************//

    //***********************Interbank Transfer*********************//

    [IntegrationEvent(false, false)]
    procedure OnSendInterbankTransforApproval(Var ObjIntB: Record "InterBank Transfer Header")
    begin
    end;

    [IntegrationEvent(false, false)]
    procedure OnCancelInterbankTransforApproval(Var ObjIntB: Record "InterBank Transfer Header")
    begin
    end;

    procedure IsInterbankTransEnabled(var ObjIntB: Record "InterBank Transfer Header"): Boolean

    begin
        EXIT(WFMngt.CanExecuteWorkflow(ObjIntB, WFCode.RunWorkflowOnSendInterbankTransForApprovalCode()));
    end;

    procedure CheckInterbankTransApprovalWorkflowEnabled(var ObjIntB: Record "InterBank Transfer Header"): Boolean

    begin

        if not IsInterbankTransEnabled(ObjIntB) then
            Error(NoworkflowEnb);
        exit(true);
    end;

    ////***********************End Interbank Transfer*********************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnPopulateApprovalEntryArgument', '', true, true)]
    local procedure OnPopulateApprovalEntryArgument(var RecRef: RecordRef; var ApprovalEntryArgument: Record "Approval Entry"; WorkflowStepInstance: Record "Workflow Step Instance")
    var
        PaymentRec: Record "Payments HeaderFin";
        PurchaseReq: Record "Requisition Header";
        ImprestSurrender: Record "Imprest Lines";
        ObjTrMemo: Record "Memo Request Header";
        ObjHotReq: Record "Hotel Request Header";
        ObjIntB: Record "InterBank Transfer Header";
    begin
        case RecRef.Number of
            DATABASE::"Payments HeaderFin":
                begin
                    RecRef.SetTable(PaymentRec);
                    ApprovalEntryArgument."Document No." := PaymentRec."No.";
                    if PaymentRec."Payment Type" = PaymentRec."Payment Type"::"Payment Voucher" then begin
                        ApprovalEntryArgument.Amount := PaymentRec."Total Amount";
                        ApprovalEntryArgument."Amount (LCY)" := PaymentRec."Total Amount";
                    end

                    else
                        if PaymentRec."Payment Type" = PaymentRec."Payment Type"::"Imprest Requisitioning" then begin
                            ImprestSurrender.Reset;
                            ImprestSurrender.SetRange(No, PaymentRec."No.");
                            if ImprestSurrender.FindFirst then begin
                                ApprovalEntryArgument.Amount := ImprestSurrender.Amount;
                                ApprovalEntryArgument."Amount (LCY)" := ImprestSurrender."Amount LCY";
                            end;

                        End
                        else
                            if PaymentRec."Payment Type" = PaymentRec."Payment Type"::"Imprest Surrender" then begin
                                ImprestSurrender.Reset;
                                ImprestSurrender.SetRange(No, PaymentRec."No.");
                                if ImprestSurrender.FindFirst then begin
                                    ApprovalEntryArgument.Amount := ImprestSurrender.Amount;
                                    ApprovalEntryArgument."Amount (LCY)" := ImprestSurrender."Amount LCY";
                                end;
                            end
                            else
                                if PaymentRec."Payment Type" = PaymentRec."Payment Type"::"Petty Cash" then begin
                                    ApprovalEntryArgument.Amount := PaymentRec."Petty Cash Amount";
                                    ApprovalEntryArgument."Amount (LCY)" := PaymentRec."Petty Cash Amount";
                                end;

                    ApprovalEntryArgument."Currency Code" := PaymentRec.Currency;
                end;
            Database::"Requisition Header":
                begin
                    RecRef.SetTable(PurchaseReq);
                    PurchaseReq.CalcFields(Amount);
                    ApprovalEntryArgument."Document No." := PurchaseReq."No.";
                    ApprovalEntryArgument."Currency Code" := PurchaseReq."Currency Code";
                    ApprovalEntryArgument.Amount := PurchaseReq.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := PurchaseReq.Amount;


                end;
            Database::"Memo Request Header":
                begin
                    RecRef.SetTable(ObjTrMemo);
                    //ObjTrMemo.CalcFields(Amount);
                    ApprovalEntryArgument."Document No." := ObjTrMemo."Request No.";
                    // ApprovalEntryArgument."Currency Code" := ObjTrMemo."Currency Code";
                    // ApprovalEntryArgument.Amount := ObjTrMemo.Amount;
                    // ApprovalEntryArgument."Amount (LCY)" := ObjTrMemo.Amount;
                end;
            Database::"Hotel Request Header":
                begin
                    RecRef.SetTable(ObjHotReq);
                    //ObjTrMemo.CalcFields(Amount);
                    ApprovalEntryArgument."Document No." := ObjHotReq."Request No";
                    // ApprovalEntryArgument."Currency Code" := ObjTrMemo."Currency Code";
                    // ApprovalEntryArgument.Amount := ObjTrMemo.Amount;
                    // ApprovalEntryArgument."Amount (LCY)" := ObjTrMemo.Amount;
                end;
            Database::"InterBank Transfer Header":
                begin
                    RecRef.SetTable(ObjIntB);
                    ApprovalEntryArgument."Document No." := ObjIntB."No.";
                    ApprovalEntryArgument."Currency Code" := ObjIntB."Currency Code";
                    ApprovalEntryArgument.Amount := ObjIntB.Amount;
                    ApprovalEntryArgument."Amount (LCY)" := ObjIntB."Amount (LCY)";
                end;
        end;
    end;
}