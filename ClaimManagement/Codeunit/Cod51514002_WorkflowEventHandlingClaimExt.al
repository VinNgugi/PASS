codeunit 51514002 "Workflow Event Handling ClmExt"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendClaimRecTxt: TextConst ENU = 'Approval Request for Claim Application is requested', ENG = 'Approval Request for Claim Application is requested';
        CancelClaimRecTxt: TextConst ENU = 'Approval Request for Claim Application is Canceled', ENG = 'Approval Request for Claim Application is Canceled';


        //********************************************Leave Recall***********************//
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt. Claim Ext", 'OnSendClaimRecForApproval', '', false, false)]

    procedure RunWorkflowOnSendClaimRecForApproval(var ClaimRec: Record "Claim")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendClaimRecForApprovalCode, ClaimRec);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt. Claim Ext", 'OnCancelClaimRecApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelClaimRecApprovalRequest(var ClaimRec: Record "Claim")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelClaimRecApprovalRequestCode, ClaimRec);
    end;

    procedure RunWorkflowOnSendClaimRecForApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSendClaimRecForApproval')
    end;

    procedure RunWorkflowOnCancelClaimRecApprovalRequestCode(): Code[128]
    begin
        exit('RunWorkflowOnCancelClaimRecApprovalRequest')
    end;

    //********************************************End Leave Recall***********************//


    //***********************Add events to Library*************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure AddWorkFlowEventToLibrary()
    begin
        //** Recall
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendClaimRecForApprovalCode(), Database::"Claim", SendClaimRecTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelClaimRecApprovalRequestCode(), Database::"Claim", CancelClaimRecTxt, 0, false);
        //**
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        //*************************Add Event Predecessors**********************//
        case EventFunctionName of

            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendClaimRecForApprovalCode());
                end;

            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode:
                begin

                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendClaimRecForApprovalCode());
                end;

            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode:
                begin

                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendClaimRecForApprovalCode());
                end;

        end;
        //*************************Add Event Predecessors**********************//
    end;
}
