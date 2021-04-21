codeunit 51513502 "Workflow Event Handling InvExt"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
         SendInvestmentAppTxt: TextConst ENU = 'Approval Request for Investment Application is requested', ENG = 'Approval Request for Investment Application is requested';
        CancelInvestmentAppTxt: TextConst ENU = 'Approval Request for Investment Application is Canceled', ENG = 'Approval Request for Investment Application is Canceled';


    //********************************************Leave Recall***********************//
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt. Inv Ext", 'OnSendInvestmentAppForApproval', '', false, false)]
    procedure RunWorkflowOnSendInvestmentAppForApproval(var Investment: Record "Investment Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendInvestmentAppForApprovalCode, Investment);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt. inv Ext", 'OnCancelInvestmentAppApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelInvestmentAppApprovalRequest(var Investment: Record "Investment Header")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelInvestmentAppApprovalRequestCode, Investment);
    end;

    procedure RunWorkflowOnSendInvestmentAppForApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSendInvestmentAppForApproval')
    end;

    procedure RunWorkflowOnCancelInvestmentAppApprovalRequestCode(): Code[128]
    begin
        exit('RunWorkflowOnCancelInvestmentAppApprovalRequest')
    end;

    //********************************************End Leave Recall***********************//


    //***********************Add events to Library*************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure AddWorkFlowEventToLibrary()
    begin
        //** Recall
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendInvestmentAppForApprovalCode(), Database::"Investment Header", SendInvestmentAppTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelInvestmentAppApprovalRequestCode(), Database::"Investment Header", CancelInvestmentAppTxt, 0, false);
        //**
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        //*************************Add Event Predecessors**********************//
        case EventFunctionName of

            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendInvestmentAppForApprovalCode());
                end;

            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode:
                begin
                    
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendInvestmentAppForApprovalCode());
                end;

            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode:
                begin
                    
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendInvestmentAppForApprovalCode());
                end;

        end;
        //*************************Add Event Predecessors**********************//
    end;

}
