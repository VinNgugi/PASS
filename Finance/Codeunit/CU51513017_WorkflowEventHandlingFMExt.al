codeunit 51513017 "Workflow Event Handling FMExt"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendPettyCash: TextConst ENU = 'Approval Request for Petty Cash Requisition is requested', ENG = 'Approval Request for Petty Cash Requisition is requested';
        CancelPettyCash: TextConst ENU = 'Approval Request for Petty Cash Requisition is Canceled', ENG = 'Approval Request for Petty Cash Requisition is Canceled';
        AppReqPettyCash: TextConst ENU = 'Approval Request for Petty Cash Requisition is approved', ENG = 'Approval Request for Petty Cash Requisition is approved';
        RejReqPettyCash: TextConst ENU = 'Approval Request for Petty Cash Requisition is rejected', ENG = 'Approval Request for Petty Cash Requisition is rejected';
        DelReqPettyCash: TextConst ENU = 'Approval Request for Petty Cash Requisition is delegated', ENG = 'Approval Request Petty Cash Requisition is delegated';
        SendForPendPettyCash: TextConst ENU = 'Status of Petty Cash Requisition changed to Pending approval', ENG = 'Status of Petty Cash Requisition changed to Pending approval';
        ReleasePettyCash: TextConst ENU = 'Release Petty Cash Requisition', ENG = 'Release Petty Cash Requisition';
        ReOpenPettyCash: TextConst ENU = 'ReOpen Petty Cash Requisition', ENG = 'ReOpen Petty Cash Requisition';
        //PettyCash
        SendImprest: TextConst ENU = 'Approval Request for Imprest Requisition is requested', ENG = 'Approval Request for Imprest Requisition is requested';
        CancelImprest: TextConst ENU = 'Approval Request for Imprest Requisition is Canceled', ENG = 'Approval Request for Imprest Requisition is Canceled';
        AppReqImprest: TextConst ENU = 'Approval Request for Imprest Requisition is approved', ENG = 'Approval Request for Imprest Requisition is approved';
        RejReqImprest: TextConst ENU = 'Approval Request for Imprest Requisition is rejected', ENG = 'Approval Request for Imprest Requisition is rejected';
        DelReqImprest: TextConst ENU = 'Approval Request for Imprest Requisition is delegated', ENG = 'Approval Request Imprest Requisition is delegated';
        SendForPendImprest: TextConst ENU = 'Status of Imprest Requisition changed to Pending approval', ENG = 'Status of Imprest Requisition changed to Pending approval';
        ReleaseImprest: TextConst ENU = 'Release Imprest Requisition', ENG = 'Release Imprest Requisition';
        ReOpenImprest: TextConst ENU = 'ReOpen Imprest Requisition', ENG = 'ReOpen Imprest Requisition';
        //Imprest

        SendSurrender: TextConst ENU = 'Approval Request for Imprest Surrender is requested', ENG = 'Approval Request for Imprest Surrender is requested';
        CancelSurrender: TextConst ENU = 'Approval Request for Imprest Surrender is Canceled', ENG = 'Approval Request for Imprest Surrender is Canceled';
        AppReqSurrender: TextConst ENU = 'Approval Request for Imprest Surrender is approved', ENG = 'Approval Request for Imprest Surrender is approved';
        RejReqSurrender: TextConst ENU = 'Approval Request for Imprest Surrender is rejected', ENG = 'Approval Request for Imprest Surrender is rejected';
        DelReqSurrender: TextConst ENU = 'Approval Request for Imprest Surrender is delegated', ENG = 'Approval Request Imprest Surrender is delegated';
        SendForPendSurrender: TextConst ENU = 'Status of Imprest Surrender changed to Pending approval', ENG = 'Status of Imprest Surrender changed to Pending approval';
        ReleaseSurrender: TextConst ENU = 'Release Imprest Surrender', ENG = 'Release Imprest Surrender';
        ReOpenSurrender: TextConst ENU = 'ReOpen Imprest Surrender', ENG = 'ReOpen Imprest Surrender';
        //Surrender

        SendPayment: TextConst ENU = 'Approval Request for Payment Vourcher is requested', ENG = 'Approval Request for Payment Vourcher is requested';
        CancelPayment: TextConst ENU = 'Approval Request for Payment Vourcher is Canceled', ENG = 'Approval Request for Payment Vourcher is Canceled';
        AppReqPayment: TextConst ENU = 'Approval Request for Payment Vourcher is approved', ENG = 'Approval Request for Payment Vourcher is approved';
        RejReqPayment: TextConst ENU = 'Approval Request for Payment Vourcher is rejected', ENG = 'Approval Request for Payment Vourcher is rejected';
        DelReqPayment: TextConst ENU = 'Approval Request for Payment Vourcher is delegated', ENG = 'Approval Request Payment Vourcher is delegated';
        SendForPendPayment: TextConst ENU = 'Status of Payment Vourcher changed to Pending approval', ENG = 'Status of Payment Vourcher changed to Pending approval';
        ReleasePayment: TextConst ENU = 'Release Payment Vourcher', ENG = 'Release Payment Vourcher';
        ReOpenPayment: TextConst ENU = 'ReOpen Payment Vourcher', ENG = 'ReOpen Payment Vourcher';
        //Payment


        SendPurchaseReq: TextConst ENU = 'Approval Request for Purchase Requisition is requested', ENG = 'Approval Request for Purchase Requisition is requested';
        CancelPurchaseReq: TextConst ENU = 'Approval Request for Purchase Requisition is Canceled', ENG = 'Approval Request for Purchase Requisition is Canceled';
        AppReqPurchaseReq: TextConst ENU = 'Approval Request for Purchase Requisition is approved', ENG = 'Approval Request for Purchase Requisition is approved';
        RejReqPurchaseReq: TextConst ENU = 'Approval Request for Purchase Requisition is rejected', ENG = 'Approval Request for Purchase Requisition is rejected';
        DelReqPurchaseReq: TextConst ENU = 'Approval Request for Purchase Requisition is delegated', ENG = 'Approval Request Purchase Requisition is delegated';
        SendForPendPurchaseReq: TextConst ENU = 'Status of Purchase Requisition changed to Pending approval', ENG = 'Status of Purchase Requisition changed to Pending approval';
        ReleasePurchaseReq: TextConst ENU = 'Release Purchase Requisition', ENG = 'Release Purchase Requisition';
        ReOpenPurchaseReq: TextConst ENU = 'ReOpen Purchase Requisition', ENG = 'ReOpen Purchase Requisition';
        //Purchase Requisition

        //****Travel Memo
        SendTravelMemoReq: TextConst ENU = 'Approval Request for Travel Memo is requested', ENG = 'Approval Request for Travel Memo is requested';
        CancelTravelMemoReq: TextConst ENU = 'Approval Request for Travel Memo is Canceled', ENG = 'Approval Request for Travel Memo is Canceled';

        //***Hotel request
        SendHotelReq: TextConst ENU = 'Approval Request for Hotel Requisition is requested', ENG = 'Approval Request for Hotel Requisition is requested';
        CancelHotelReq: TextConst ENU = 'Approval Request for Hotel Requisition is Canceled', ENG = 'Approval Request for Hotel Requisition is Canceled';

        //***InterBank Transfer
        SendInterbankTrans: TextConst ENU = 'Approval Request for InterBank Transfer is requested', ENG = 'Approval Request for InterBank Transfer is requested';
        CancelInterbankTrans: TextConst ENU = 'Approval Request for InterBank Transfer is Canceled', ENG = 'Approval Request for Interbank Transfer is Canceled';


    //OnSend PettyCash>> 
    procedure RunWorkflowOnSendPettyCashApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPettyCashApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtFM, 'OnSendPettyCashforApproval', '', true, true)]
    procedure RunWorkflowOnSendPettyCashApproval(var PettyCash: Record "Payments HeaderFin")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendPettyCashApprovalCode, PettyCash);
    end;

    //<< End OnSend PettyCash

    //OnCancel PettyCash>>
    procedure RunWorkflowOnCancelPettyCashApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPettyCashApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtFM, 'OnCancelPettyCashForApproval', '', true, true)]
    procedure RunWorkflowOnCancelPettyCashApproval(var PettyCash: Record "Payments HeaderFin")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelPettyCashApprovalCode, PettyCash);
    end;

    //<<EndOnCancel PettyCash

    //>>OnApprove PettyCash
    procedure RunWorkflowOnApprovePettyCashApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprovePettyCashApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApprovePettyCashApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprovePettyCashApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove PettyCash

    //>>OnReject PettyCash
    procedure RunWorkflowOnRejectPettyCashApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPettyCashApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectPettyCashApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectPettyCashApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject PettyCash

    //>>OnDelegate PettyCash
    procedure RunWorkflowOnDelegatePettyCashApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegatePettyCashApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegatePettyCashApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegatePettyCashApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate PettyCash

    //>>OnSend Imprest
    procedure RunWorkflowOnSendImprestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendImprestApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtFM, 'OnSendImprestforApproval', '', true, true)]
    procedure RunWorkflowOnSendImprestApproval(var Imprest: Record "Payments HeaderFin")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendImprestApprovalCode, Imprest);
    end;

    //<< End OnSend Imprest

    //OnCancel Imprest>>
    procedure RunWorkflowOnCancelImprestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelImprestApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtFM, 'OnCancelImprestForApproval', '', true, true)]
    procedure RunWorkflowOnCancelImprestApproval(var Imprest: Record "Payments HeaderFin")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelImprestApprovalCode, Imprest);
    end;

    //<<EndOnCancel Imprest

    //>>OnApprove Imprest
    procedure RunWorkflowOnApproveImprestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveImprestApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveImprestApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveImprestApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove Imprest

    //>>OnReject Imprest
    procedure RunWorkflowOnRejectImprestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectImprestApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectImprestApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectImprestApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject Imprest

    //>>OnDelegate Imprest
    procedure RunWorkflowOnDelegateImprestApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateImprestApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateImprestApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateImprestApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate Imprest

    //OnSend Surrender>> 
    procedure RunWorkflowOnSendSurrenderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendSurrenderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtFM, 'OnSendSurrenderforApproval', '', true, true)]
    procedure RunWorkflowOnSendSurrenderApproval(var Surrender: Record "Payments HeaderFin")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendSurrenderApprovalCode, Surrender);
    end;

    //<< End OnSend Surrender

    //OnCancel Surrender>>
    procedure RunWorkflowOnCancelSurrenderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelSurrenderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtFM, 'OnCancelSurrenderForApproval', '', true, true)]
    procedure RunWorkflowOnCancelSurrenderApproval(var Surrender: Record "Payments HeaderFin")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelSurrenderApprovalCode, Surrender);
    end;

    //<<EndOnCancel Surrender

    //>>OnApprove Surrender
    procedure RunWorkflowOnApproveSurrenderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveSurrenderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveSurrenderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveSurrenderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove Surrender

    //>>OnReject Surrender
    procedure RunWorkflowOnRejectSurrenderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectSurrenderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectSurrenderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectSurrenderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject Surrender

    //>>OnDelegate Surrender
    procedure RunWorkflowOnDelegateSurrenderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateSurrenderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateSurrenderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateSurrenderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate Surrender

    //OnSend Payment>> 
    procedure RunWorkflowOnSendPaymentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPaymentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtFM, 'OnSendPaymentforApproval', '', true, true)]
    procedure RunWorkflowOnSendPaymentApproval(var Payment: Record "Payments HeaderFin")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendPaymentApprovalCode, Payment);
    end;

    //<< End OnSend Payment

    //OnCancel Payment>>
    procedure RunWorkflowOnCancelPaymentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPaymentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtFM, 'OnCancelPaymentForApproval', '', true, true)]
    procedure RunWorkflowOnCancelPaymentApproval(var Payment: Record "Payments HeaderFin")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelPaymentApprovalCode, Payment);
    end;

    //<<EndOnCancel Payment

    //>>OnApprove Payment
    procedure RunWorkflowOnApprovePaymentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprovePaymentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApprovePaymentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprovePaymentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove Payment

    //>>OnReject Payment
    procedure RunWorkflowOnRejectPaymentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPaymentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectPaymentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectPaymentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject Payment

    //>>OnDelegate Payment
    procedure RunWorkflowOnDelegatePaymentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegatePaymentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegatePaymentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegatePaymentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate Payment



    //OnSend Purchase Requisiotion>> 
    procedure RunWorkflowOnSendPurchaseReqApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendPurchaseReqApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtFM, 'OnSendPurchaseReqforApproval', '', true, true)]
    procedure RunWorkflowOnSendPurchaseReqApproval(var PurchaseReq: Record "Requisition Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendPurchaseReqApprovalCode, PurchaseReq);
    end;

    //<< End OnSend PurchaseReq

    //OnCancel PurchaseReq>>
    procedure RunWorkflowOnCancelPurchaseReqApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelPurchaseReqApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ApprovalMgtFM, 'OnCancelPurchaseReqForApproval', '', true, true)]
    procedure RunWorkflowOnCancelPurchaseReqApproval(var PurchaseReq: Record "Requisition Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelPurchaseReqApprovalCode, PurchaseReq);
    end;

    //<<EndOnCancel PurchaseReq

    //>>OnApprove PurchaseReq
    procedure RunWorkflowOnApprovePurchaseReqApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApprovePurchaseReqApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApprovePurchaseReqApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApprovePurchaseReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove PurchaseReq

    //>>OnReject PurchaseReq
    procedure RunWorkflowOnRejectPurchaseReqApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectPurchaseReqApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectPurchaseReqApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectPurchaseReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject PurchaseReq

    //>>OnDelegate PurchaseReq
    procedure RunWorkflowOnDelegatePurchaseReqApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegatePurchaseReqApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegatePurchaseReqApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegatePurchaseReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate PurchaseReq


    //********************************************Travel Memo***********************//
    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalMgtFM, 'OnSendTravelMemoReqforApproval', '', false, false)]
    procedure RunWorkflowOnSendTravelMemoReqForApproval(var ObjTrMemo: Record "Memo Request Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendTravelMemoReqForApprovalCode, ObjTrMemo);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalMgtFM, 'OnCancelTravelMemoReqforApproval', '', false, false)]
    procedure RunWorkflowOnCancelTravelMemoReqApprovalRequest(var ObjTrMemo: Record "Memo Request Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelTravelMemoReqApprovalRequestCode, ObjTrMemo);
    end;

    procedure RunWorkflowOnSendTravelMemoReqForApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSendTravelMemoReqForApproval')
    end;

    procedure RunWorkflowOnCancelTravelMemoReqApprovalRequestCode(): Code[128]
    begin
        exit('RunWorkflowOnCancelTravelMemoReqApprovalRequest')
    end;

    //********************************************End Travel Memo***********************//

    //********************************************Travel Memo***********************//
    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalMgtFM, 'OnSendHotelReqforApproval', '', false, false)]
    procedure RunWorkflowOnSendHotelReqForApproval(var ObjHotReq: Record "Hotel Request Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendHotelReqForApprovalCode, ObjHotReq);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalMgtFM, 'OnCancelHotelReqforApproval', '', false, false)]
    procedure RunWorkflowOnCancelHotelReqApprovalRequest(var ObjHotReq: Record "Hotel Request Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelHotelReqApprovalRequestCode, ObjHotReq);
    end;

    procedure RunWorkflowOnSendHotelReqForApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSendHotelReqForApproval')
    end;

    procedure RunWorkflowOnCancelHotelReqApprovalRequestCode(): Code[128]
    begin
        exit('RunWorkflowOnCancelHotelReqApprovalRequest')
    end;

    //********************************************End Travel Memo***********************//

    //********************************************Interbank Transfer***********************//
    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalMgtFM, 'OnSendInterbankTransforApproval', '', false, false)]
    procedure RunWorkflowOnSendInterbankTransForApproval(var ObjIntB: Record "InterBank Transfer Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendInterbankTransForApprovalCode, ObjIntB);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ApprovalMgtFM, 'OnCancelInterbankTransforApproval', '', false, false)]
    procedure RunWorkflowOnCancelInterbankTransApprovalRequest(var ObjIntB: Record "InterBank Transfer Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelInterbankTransApprovalRequestCode, ObjIntB);
    end;

    procedure RunWorkflowOnSendInterbankTransForApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSendInterbankTransForApproval')
    end;

    procedure RunWorkflowOnCancelInterbankTransApprovalRequestCode(): Code[128]
    begin
        exit('RunWorkflowOnCancelInterbankTransApprovalRequest')
    end;

    //********************************************End Interbank Transfer***********************//


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure AddWorkFlowEventToLibrary()
    begin

        //PettyCash
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPettyCashApprovalCode(), Database::"Payments HeaderFin", SendPettyCash, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPettyCashApprovalCode(), Database::"Payments HeaderFin", CancelPettyCash, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprovePettyCashApprovalCode(), Database::"Payments HeaderFin", AppReqPettyCash, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectPettyCashApprovalCode(), Database::"Approval Entry", RejReqPettyCash, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegatePettyCashApprovalCode(), Database::"Approval Entry", DelReqPettyCash, 0, false);
        //<<PettyCash

        //Imprest
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendImprestApprovalCode(), Database::"Payments HeaderFin", SendImprest, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelImprestApprovalCode(), Database::"Payments HeaderFin", CancelImprest, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveImprestApprovalCode(), Database::"Payments HeaderFin", AppReqImprest, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectImprestApprovalCode(), Database::"Approval Entry", RejReqImprest, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateImprestApprovalCode(), Database::"Approval Entry", DelReqImprest, 0, false);

        //Imprest
        //Surrender
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendSurrenderApprovalCode(), Database::"Payments HeaderFin", SendSurrender, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelSurrenderApprovalCode(), Database::"Payments HeaderFin", CancelSurrender, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveSurrenderApprovalCode(), Database::"Payments HeaderFin", AppReqSurrender, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectSurrenderApprovalCode(), Database::"Approval Entry", RejReqSurrender, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateSurrenderApprovalCode(), Database::"Approval Entry", DelReqSurrender, 0, false);

        //Surrender

        //Payment
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPaymentApprovalCode(), Database::"Payments HeaderFin", SendPayment, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPaymentApprovalCode(), Database::"Payments HeaderFin", CancelPayment, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprovePaymentApprovalCode(), Database::"Payments HeaderFin", AppReqPayment, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectPaymentApprovalCode(), Database::"Approval Entry", RejReqPayment, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegatePaymentApprovalCode(), Database::"Approval Entry", DelReqPayment, 0, false);

        //Payment

        //PurchaseReq
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendPurchaseReqApprovalCode(), Database::"Requisition Header", SendPurchaseReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelPurchaseReqApprovalCode(), Database::"Requisition Header", CancelPurchaseReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApprovePurchaseReqApprovalCode(), Database::"Requisition Header", AppReqPurchaseReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectPurchaseReqApprovalCode(), Database::"Approval Entry", RejReqPurchaseReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegatePurchaseReqApprovalCode(), Database::"Approval Entry", DelReqPurchaseReq, 0, false);

        //PurchaseReq

        //Travel Memo
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendTravelMemoReqForApprovalCode(), Database::"Memo Request Header", SendTravelMemoReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelTravelMemoReqApprovalRequestCode(), Database::"Memo Request Header", CancelTravelMemoReq, 0, false);

        //Travel Memo

        //Hotel Req
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendHotelReqForApprovalCode(), Database::"Hotel Request Header", SendHotelReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelHotelReqApprovalRequestCode(), Database::"Hotel Request Header", CancelHotelReq, 0, false);

        //Hotel Req

        //Interbank Transfer
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendInterbankTransForApprovalCode(), Database::"InterBank Transfer Header", SendInterbankTrans, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelInterbankTransApprovalRequestCode(), Database::"InterBank Transfer Header", CancelInterbankTrans, 0, false);

        //InterBankTransfer
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        //*************************Add Event Predecessors**********************//
        case EventFunctionName of

            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPettyCashApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendImprestApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPaymentApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendSurrenderApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendPurchaseReqApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendTravelMemoReqForApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendHotelReqForApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInterbankTransForApprovalCode());
                end;

            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPettyCashApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendImprestApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPaymentApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendSurrenderApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendPurchaseReqApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendTravelMemoReqForApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendHotelReqForApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendInterbankTransForApprovalCode());
                end;

            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPettyCashApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendImprestApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPaymentApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendSurrenderApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendPurchaseReqApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendTravelMemoReqForApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendHotelReqForApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendInterbankTransForApprovalCode());
                end;

        end;
        //*************************Add Event Predecessors**********************//
    end;

}
