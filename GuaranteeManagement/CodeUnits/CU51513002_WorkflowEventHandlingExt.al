codeunit 51513002 "Workflow Event Handling Ext"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendGuaranteeReq: TextConst ENU = 'Approval Request for Guarantee Application is requested', ENG = 'Approval Request for Guarantee Application is requested';
        CancelGuaranteeReq: TextConst ENU = 'Approval Request for Guarantee Application is Canceled', ENG = 'Approval Request for Guarantee Application is Canceled';
        AppReqGuarantee: TextConst ENU = 'Approval Request for Guarantee Application is approved', ENG = 'Approval Request for Guarantee Application is approved';
        RejReqGuarantee: TextConst ENU = 'Approval Request for Guarantee Application is rejected', ENG = 'Approval Request for Guarantee Application is rejected';
        DelReqGuarantee: TextConst ENU = 'Approval Request for Guarantee Application is delegated', ENG = 'Approval Request for Guarantee Application is delegated';
        SendForPendAppTxt: TextConst ENU = 'Status of Guarantee Application changed to Pending approval', ENG = 'Status of Guarantee Application changed to Pending approval';
        ReleaseJobTxt: TextConst ENU = 'Release Guarantee Application', ENG = 'Release Guarantee Application';
        ReOpenJobTxt: TextConst ENU = 'ReOpen Guarantee Application', ENG = 'ReOpen Guarantee Application';
        //Guarantee
        SendCGCReq: TextConst ENU = 'Approval Request for Credit Guarantee Certificate is requested', ENG = 'Approval Request for Credit Guarantee Certificate is requested';
        CancelCGCReq: TextConst ENU = 'Approval Request for Credit Guarantee Certificate is Canceled', ENG = 'Approval Request for Credit Guarantee Certificate is Canceled';
        AppReqCGC: TextConst ENU = 'Approval Request for Credit Guarantee Certificate is approved', ENG = 'Approval Request for Credit Guarantee Certificate is approved';
        RejReqCGC: TextConst ENU = 'Approval Request for Credit Guarantee Certificate is rejected', ENG = 'Approval Request for Credit Guarantee Certificate is rejected';
        DelReqCGC: TextConst ENU = 'Approval Request for Credit Guarantee Certificate is delegated', ENG = 'Approval Request for Credit Guarantee Certificate is delegated';
        SendForCGCTxt: TextConst ENU = 'Status of Credit Guarantee Certificate changed to Pending approval', ENG = 'Status of Credit Guarantee Certificate changed to Pending approval';
        ReleaseCGCTxt: TextConst ENU = 'Release Credit Guarantee Certificate', ENG = 'Release Credit Guarantee Certificate';
        ReOpenCGCTxt: TextConst ENU = 'ReOpen Credit Guarantee Certificate', ENG = 'ReOpen Credit Guarantee Certificate';
        //CGC

        SendFeeWaiver: TextConst ENU = 'Approval Request for Fee Waiver is requested', ENG = 'Approval Request for Fee Waiver is requested';
        CancelFeeWaiver: TextConst ENU = 'Approval Request for Fee Waiver is Canceled', ENG = 'Approval Request for Fee Waiver is Canceled';
        AppReqFeeWaiver: TextConst ENU = 'Approval Request for Fee Waiver is approved', ENG = 'Approval Request for Fee Waiver is approved';
        RejReqFeeWaiver: TextConst ENU = 'Approval Request for Fee Waiver is rejected', ENG = 'Approval Request for Fee Waiver is rejected';
        DelReqFeeWaiver: TextConst ENU = 'Approval Request for Fee Waiver is delegated', ENG = 'Approval Request for Fee Waiver is delegated';
        SendForFeeWaiverTxt: TextConst ENU = 'Status of Fee Waiver changed to Pending approval', ENG = 'Status of Fee Waiver changed to Pending approval';
        ReleaseFeeWaiverTxt: TextConst ENU = 'Release Fee Waiver', ENG = 'Release Fee Waiver';
        ReOpenFeeWaiverTxt: TextConst ENU = 'ReOpen Fee Waiver', ENG = 'ReOpen Fee Waiver';
        //FeeWaiver

        //LO Import
        SendLOHeader: TextConst ENU = 'Approval Request for Lenders Option Journal is requested', ENG = 'Approval Request for Lenders Option Journal is requested';
        CancelLOHeader: TextConst ENU = 'Approval Request for Lenders Option Journal is Canceled', ENG = 'Approval Request for Lenders Option Journal is Canceled';
        AppReqLOHeader: TextConst ENU = 'Approval Request for Lenders Option Journal is approved', ENG = 'Approval Request for Lenders Option Journal is approved';
        RejReqLOHeader: TextConst ENU = 'Approval Request for Lenders Option Journal is rejected', ENG = 'Approval Request for Lenders Option Journal is rejected';
        DelReqLOHeader: TextConst ENU = 'Approval Request for Lenders Option Journal is delegated', ENG = 'Approval Request for Lenders Option Journal is delegated';
        SendForLOHeaderTxt: TextConst ENU = 'Status of Lenders Option Journal changed to Pending approval', ENG = 'Status of Lenders Option Journal changed to Pending approval';
        ReleaseLOHeaderTxt: TextConst ENU = 'Release Lenders Option Journal', ENG = 'Release Lenders Option Journal';
        ReOpenLOHeaderTxt: TextConst ENU = 'ReOpen Lenders Option Journal', ENG = 'ReOpen Lenders Option Journal';


        //Restructuring
        SendRestruct: TextConst ENU = 'Approval Request for Restructuring Memo is requested', ENG = 'Approval Request for Restructuring Memo is requested';
        CancelRestruct: TextConst ENU = 'Approval Request for Restructuring Memo is Canceled', ENG = 'Approval Request for Restructuring Memo is Canceled';
        AppReqRestruct: TextConst ENU = 'Approval Request for Restructuring Memo is approved', ENG = 'Approval Request for Restructuring Memo is approved';
        RejReqRestruct: TextConst ENU = 'Approval Request for Restructuring Memo is rejected', ENG = 'Approval Request for Restructuring Memo is rejected';
        DelReqRestruct: TextConst ENU = 'Approval Request for Restructuring Memo is delegated', ENG = 'Approval Request for Restructuring Memo is delegated';
        SendForRestructTxt: TextConst ENU = 'Status of Restructuring Memo changed to Pending approval', ENG = 'Status of Restructuring Memo changed to Pending approval';
        ReleaseRestructTxt: TextConst ENU = 'Release Restructuring Memo', ENG = 'Release Restructuring Memo';
        ReOpenRestructTxt: TextConst ENU = 'ReOpen Restructuring Memo', ENG = 'ReOpen Restructuring Memo';

        //Change Request
        SendChangeReq: TextConst ENU = 'Approval Request for Change Request Memo is requested', ENG = 'Approval Request for Change Request Memo is requested';
        CancelChangeReq: TextConst ENU = 'Approval Request for Change Request Memo is Canceled', ENG = 'Approval Request for Change Request Memo is Canceled';
        AppChangeReq: TextConst ENU = 'Approval Request for Change Request Memo is approved', ENG = 'Approval Request for Change Request Memo is approved';
        RejChangeReq: TextConst ENU = 'Approval Request for Change Request Memo is rejected', ENG = 'Approval Request for Change Request Memo is rejected';
        DelChangeReq: TextConst ENU = 'Approval Request for Change Request Memo is delegated', ENG = 'Approval Request for Change Request Memo is delegated';
        SendForChangeReqTxt: TextConst ENU = 'Status of Change Request Memo changed to Pending approval', ENG = 'Status of Change Request Memo changed to Pending approval';
        ReleaseChangeReqTxt: TextConst ENU = 'Release Change Request Memo', ENG = 'Release Change Request Memo';
        ReOpenChangeReqTxt: TextConst ENU = 'ReOpen Change Request Memo', ENG = 'ReOpen Change Request Memo';

        //OnSend GuaranteeApp>> 
    procedure RunWorkflowOnSendGuaranteeAppApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendGuaranteeAppApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnSendGuaranteeAppforApproval', '', true, true)]
    procedure RunWorkflowOnSendGuaranteeAppApproval(var GuaranteeApp: Record "Guarantee Application")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendGuaranteeAppApprovalCode, GuaranteeApp);
    end;

    //<< End OnSend GuaranteeApp

    //OnCancel GuaranteeApp>>
    procedure RunWorkflowOnCancelGuaranteeAppApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelGuaranteeAppApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnCancelGuaranteeAppForApproval', '', true, true)]
    procedure RunWorkflowOnCancelGuaranteeAppApproval(var GuaranteeApp: Record "Guarantee Application")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelGuaranteeAppApprovalCode, GuaranteeApp);
    end;

    //<<EndOnCancel GuaranteeApp

    //>>OnApprove GuaranteeApp
    procedure RunWorkflowOnApproveGuaranteeAppApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveGuaranteeAppApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveGuaranteeAppApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveGuaranteeAppApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove GuaranteeApp

    //>>OnReject GuaranteeApp
    procedure RunWorkflowOnRejectGuaranteeAppApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectGuaranteeAppApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectGuaranteeAppApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectGuaranteeAppApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject GuaranteeApp

    //>>OnDelegate GuaranteeApp
    procedure RunWorkflowOnDelegateGuaranteeAppApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateGuaranteeAppApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateGuaranteeAppApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateGuaranteeAppApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate GuaranteeApp 


    //OnSend CGC>> 
    procedure RunWorkflowOnSendCGCApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendCGCApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnSendCGCforApproval', '', true, true)]
    procedure RunWorkflowOnSendCGCApproval(var CGC: Record "Guarantee Contracts")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendCGCApprovalCode, CGC);
    end;

    //<< End OnSend CGC

    //OnCancel CGC>>
    procedure RunWorkflowOnCancelCGCApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelCGCApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnCancelCGCForApproval', '', true, true)]
    procedure RunWorkflowOnCancelCGCApproval(var CGC: Record "Guarantee Contracts")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelCGCApprovalCode, CGC);
    end;

    //<<EndOnCancel CGC

    //>>OnApprove CGC
    procedure RunWorkflowOnApproveCGCApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveCGCApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveCGCApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveCGCApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove CGC

    //>>OnReject CGC
    procedure RunWorkflowOnRejectCGCApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectCGCApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectCGCApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectCGCApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject CGC

    //>>OnDelegate CGC
    procedure RunWorkflowOnDelegateCGCApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateCGCApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateCGCApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateCGCApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate CGC 

    //OnSend FeeWaiverApp>> 
    procedure RunWorkflowOnSendFeeWaiverAppApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendFeeWaiverAppApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnSendFeeWaiverAppforApproval', '', true, true)]
    procedure RunWorkflowOnSendFeeWaiverAppApproval(var FeeWaiverApp: Record "Fee Waiver Application")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendFeeWaiverAppApprovalCode, FeeWaiverApp);
    end;

    //<< End OnSend FeeWaiverApp

    //OnCancel FeeWaiverApp>>
    procedure RunWorkflowOnCancelFeeWaiverAppApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelFeeWaiverAppApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnCancelFeeWaiverAppForApproval', '', true, true)]
    procedure RunWorkflowOnCancelFeeWaiverAppApproval(var FeeWaiverApp: Record "Fee Waiver Application")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelFeeWaiverAppApprovalCode, FeeWaiverApp);
    end;

    //<<EndOnCancel FeeWaiverApp

    //>>OnApprove FeeWaiverApp
    procedure RunWorkflowOnApproveFeeWaiverAppApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveFeeWaiverAppApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveFeeWaiverAppApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveFeeWaiverAppApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove FeeWaiverApp

    //>>OnReject FeeWaiverApp
    procedure RunWorkflowOnRejectFeeWaiverAppApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectFeeWaiverAppApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectFeeWaiverAppApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectFeeWaiverAppApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject FeeWaiverApp

    //>>OnDelegate FeeWaiverApp
    procedure RunWorkflowOnDelegateFeeWaiverAppApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateFeeWaiverAppApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateFeeWaiverAppApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateFeeWaiverAppApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate FeeWaiverApp 


    //OnSend LOHeader>> 
    procedure RunWorkflowOnSendLOHeaderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendLOHeaderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnSendLOHeaderforApproval', '', true, true)]
    procedure RunWorkflowOnSendLOHeaderApproval(var LOHeader: Record "Lenders Option Journal Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendLOHeaderApprovalCode, LOHeader);
    end;

    //<< End OnSend LOHeader

    //OnCancel LOHeader>>
    procedure RunWorkflowOnCancelLOHeaderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLOHeaderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnCancelLOHeaderForApproval', '', true, true)]
    procedure RunWorkflowOnCancelLOHeaderApproval(var LOHeader: Record "Lenders Option Journal Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelLOHeaderApprovalCode, LOHeader);
    end;

    //<<EndOnCancel LOHeader

    //>>OnApprove LOHeader
    procedure RunWorkflowOnApproveLOHeaderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveLOHeaderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveLOHeaderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveLOHeaderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove LOHeader

    //>>OnReject LOHeader
    procedure RunWorkflowOnRejectLOHeaderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectLOHeaderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectLOHeaderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectLOHeaderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject LOHeader

    //>>OnDelegate LOHeader
    procedure RunWorkflowOnDelegateLOHeaderApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateLOHeaderApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateLOHeaderApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateLOHeaderApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate LOHeader 

    //OnSend Restruct>> 
    procedure RunWorkflowOnSendRestructApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendRestructApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnSendRestructforApproval', '', true, true)]
    procedure RunWorkflowOnSendRestructApproval(var Restruct: Record "Restructuring Memo Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendRestructApprovalCode, Restruct);
    end;

    //<< End OnSend Restruct

    //OnCancel Restruct>>
    procedure RunWorkflowOnCancelRestructApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelRestructApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnCancelRestructForApproval', '', true, true)]
    procedure RunWorkflowOnCancelRestructApproval(var Restruct: Record "Restructuring Memo Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelRestructApprovalCode, Restruct);
    end;

    //<<EndOnCancel Restruct

    //>>OnApprove Restruct
    procedure RunWorkflowOnApproveRestructApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveRestructApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveRestructApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveRestructApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove Restruct

    //>>OnReject Restruct
    procedure RunWorkflowOnRejectRestructApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectRestructApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectRestructApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectRestructApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject Restruct

    //>>OnDelegate Restruct
    procedure RunWorkflowOnDelegateRestructApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateRestructApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateRestructApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateRestructApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate Restruct 


    //OnSend ChangeReq>> 
    procedure RunWorkflowOnSendChangeReqApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendChangeReqApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnSendChangeReqforApproval', '', true, true)]
    procedure RunWorkflowOnSendChangeReqApproval(var ChangeReq: Record "Change Request")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendChangeReqApprovalCode, ChangeReq);
    end;

    //<< End OnSend ChangeReq

    //OnCancel ChangeReq>>
    procedure RunWorkflowOnCancelChangeReqApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelChangeReqApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approval Management", 'OnCancelChangeReqForApproval', '', true, true)]
    procedure RunWorkflowOnCancelChangeReqApproval(var ChangeReq: Record "Change Request")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelChangeReqApprovalCode, ChangeReq);
    end;

    //<<EndOnCancel ChangeReq

    //>>OnApprove ChangeReq
    procedure RunWorkflowOnApproveChangeReqApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveChangeReqApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveChangeReqApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveChangeReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove ChangeReq

    //>>OnReject ChangeReq
    procedure RunWorkflowOnRejectChangeReqApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectChangeReqApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectChangeReqApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectChangeReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject ChangeReq

    //>>OnDelegate ChangeReq
    procedure RunWorkflowOnDelegateChangeReqApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateChangeReqApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateChangeReqApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateChangeReqApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate Restruct 

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure AddWorkFlowEventToLibrary()
    begin
        //Guarantee App
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendGuaranteeAppApprovalCode(), Database::"Guarantee Application", SendGuaranteeReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelGuaranteeAppApprovalCode(), Database::"Guarantee Application", CancelGuaranteeReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveGuaranteeAppApprovalCode(), Database::"Approval Entry", AppReqGuarantee, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectGuaranteeAppApprovalCode(), Database::"Approval Entry", RejReqGuarantee, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateGuaranteeAppApprovalCode(), Database::"Approval Entry", DelReqGuarantee, 0, false);
        //<<Guarantee

        //CGC
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendCGCApprovalCode(), Database::"Guarantee Contracts", SendCGCReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelCGCApprovalCode(), Database::"Guarantee Contracts", CancelCGCReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveCGCApprovalCode(), Database::"Approval Entry", AppReqCGC, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectCGCApprovalCode(), Database::"Approval Entry", RejReqCGC, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateCGCApprovalCode(), Database::"Approval Entry", DelReqCGC, 0, false);
        //<<CGC

        //FeeWaiver
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendFeeWaiverAppApprovalCode(), Database::"Fee Waiver Application", SendFeeWaiver, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelFeeWaiverAppApprovalCode(), Database::"Fee Waiver Application", CancelFeeWaiver, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveFeeWaiverAppApprovalCode(), Database::"Approval Entry", AppReqFeeWaiver, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectFeeWaiverAppApprovalCode(), Database::"Approval Entry", RejReqFeeWaiver, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateFeeWaiverAppApprovalCode(), Database::"Approval Entry", DelReqFeeWaiver, 0, false);
        //<<FeeWaiver

        //LOHeader
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendLOHeaderApprovalCode(), Database::"Lenders Option Journal Header", SendLOHeader, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelLOHeaderApprovalCode(), Database::"Lenders Option Journal Header", CancelLOHeader, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveLOHeaderApprovalCode(), Database::"Approval Entry", AppReqLOHeader, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectLOHeaderApprovalCode(), Database::"Approval Entry", RejReqLOHeader, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateLOHeaderApprovalCode(), Database::"Approval Entry", DelReqLOHeader, 0, false);
        //<<LOHeader

        //Restructuring
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRestructApprovalCode(), Database::"Restructuring Memo Header", SendRestruct, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRestructApprovalCode(), Database::"Restructuring Memo Header", CancelRestruct, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveRestructApprovalCode(), Database::"Approval Entry", AppReqRestruct, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectRestructApprovalCode(), Database::"Approval Entry", RejReqRestruct, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateRestructApprovalCode(), Database::"Approval Entry", DelReqRestruct, 0, false);
        //<<Restructuring

        //ChangeReq
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendChangeReqApprovalCode(), Database::"Change Request", SendChangeReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelChangeReqApprovalCode(), Database::"Change Request", CancelChangeReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveChangeReqApprovalCode(), Database::"Approval Entry", AppChangeReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectChangeReqApprovalCode(), Database::"Approval Entry", RejChangeReq, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateChangeReqApprovalCode(), Database::"Approval Entry", DelChangeReq, 0, false);
        //<<ChangeReq

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin

        case EventFunctionName of
            //>>Guarantee
            RunWorkflowOnCancelGuaranteeAppApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelGuaranteeAppApprovalCode, RunWorkflowOnSendGuaranteeAppApprovalCode);

            RunWorkflowOnCancelCGCApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelCGCApprovalCode, RunWorkflowOnSendCGCApprovalCode);

            RunWorkflowOnCancelFeeWaiverAppApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelFeeWaiverAppApprovalCode, RunWorkflowOnSendFeeWaiverAppApprovalCode);

            RunWorkflowOnCancelLOHeaderApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelLOHeaderApprovalCode, RunWorkflowOnSendLOHeaderApprovalCode);

            RunWorkflowOnCancelRestructApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelRestructApprovalCode, RunWorkflowOnSendRestructApprovalCode);


            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendGuaranteeAppApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendCGCApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendFeeWaiverAppApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLOHeaderApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendRestructApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendChangeReqApprovalCode());
                end;



        end;


    end;

}
