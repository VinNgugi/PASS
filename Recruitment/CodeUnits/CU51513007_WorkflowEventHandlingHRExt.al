codeunit 51513007 "Workflow Event Handling HR Ext"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendRecruitment: TextConst ENU = 'Approval Request for Recruitment Requisition is requested', ENG = 'Approval Request for Recruitment Requisition is requested';
        CancelRecruitment: TextConst ENU = 'Approval Request for Recruitment Requisition is Canceled', ENG = 'Approval Request for Recruitment Requisition is Canceled';
        AppReqRecruitment: TextConst ENU = 'Approval Request for Recruitment Requisition is approved', ENG = 'Approval Request for Recruitment Requisition is approved';
        RejReqRecruitment: TextConst ENU = 'Approval Request for Recruitment Requisition is rejected', ENG = 'Approval Request for Recruitment Requisition is rejected';
        DelReqRecruitment: TextConst ENU = 'Approval Request for Recruitment Requisition is delegated', ENG = 'Approval Request Recruitment Requisition is delegated';
        SendForPendRecruitment: TextConst ENU = 'Status of Recruitment Requisition changed to Pending approval', ENG = 'Status of Recruitment Requisition changed to Pending approval';
        ReleaseRecruitment: TextConst ENU = 'Release Recruitment Requisition', ENG = 'Release Recruitment Requisition';
        ReOpenRecruitment: TextConst ENU = 'ReOpen Recruitment Requisition', ENG = 'ReOpen Recruitment Requisition';

        //OnSend Recruitment>> 
    procedure RunWorkflowOnSendRecruitmentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnSendRecruitmentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. HR Ext", 'OnSendRecruitmentforApproval', '', true, true)]
    procedure RunWorkflowOnSendRecruitmentApproval(var Recruitment: Record "Recruitment Needs")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendRecruitmentApprovalCode, Recruitment);
    end;

    //<< End OnSend Recruitment

    //OnCancel Recruitment>>
    procedure RunWorkflowOnCancelRecruitmentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelRecruitmentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. HR Ext", 'OnCancelRecruitmentForApproval', '', true, true)]
    procedure RunWorkflowOnCancelRecruitmentApproval(var Recruitment: Record "Recruitment Needs")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelRecruitmentApprovalCode, Recruitment);
    end;

    //<<EndOnCancel Recruitment

    //>>OnApprove Recruitment
    procedure RunWorkflowOnApproveRecruitmentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveRecruitmentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveRecruitmentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveRecruitmentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove Recruitment

    //>>OnReject Recruitment
    procedure RunWorkflowOnRejectRecruitmentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectRecruitmentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectRecruitmentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectRecruitmentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject Recruitment

    //>>OnDelegate Recruitment
    procedure RunWorkflowOnDelegateRecruitmentApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateRecruitmentApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateRecruitmentApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateRecruitmentApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate Recruitment



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure AddWorkFlowEventToLibrary()
    begin

        //Recruitment
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendRecruitmentApprovalCode(), Database::"Recruitment Needs", SendRecruitment, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelRecruitmentApprovalCode(), Database::"Recruitment Needs", CancelRecruitment, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveRecruitmentApprovalCode(), Database::"Approval Entry", AppReqRecruitment, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectRecruitmentApprovalCode(), Database::"Approval Entry", RejReqRecruitment, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateRecruitmentApprovalCode(), Database::"Approval Entry", DelReqRecruitment, 0, false);
        //<<Recruitment
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        //>>Recruitment 
        case EventFunctionName of
            RunWorkflowOnCancelRecruitmentApprovalCode:
                WorkflowEventHandling.AddEventPredecessor(RunWorkflowOnCancelRecruitmentApprovalCode, RunWorkflowOnSendRecruitmentApprovalCode);
            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendRecruitmentApprovalCode());
        end;
        //<<Recruitment
    end;

}
