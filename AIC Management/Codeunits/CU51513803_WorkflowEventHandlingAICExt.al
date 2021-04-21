codeunit 51513803 "Workflow Event Handling AICExt"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendIncubTxt: TextConst ENU = 'Approval Request for Incubation program is requested', ENG = 'Approval Request for Incubation program is requested';
        CancelIncubAppTxt: TextConst ENU = 'Approval Request for Incubation program  is Canceled', ENG = 'Approval Request for Incubation program is Canceled';


    //********************************************Leave Recall***********************//
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt. AIC Ext", 'OnSendIncubForApproval', '', false, false)]
    procedure RunWorkflowOnSendIncubForApproval(var Incub: Record Incubation)
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendIncubForApprovalCode, Incub);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt. AIC Ext", 'OnCancelIncubApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelIncubApprovalRequest(var Incub: Record Incubation)
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelIncubApprovalRequestCode, Incub);
    end;

    procedure RunWorkflowOnSendIncubForApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSendIncubForApproval')
    end;

    procedure RunWorkflowOnCancelIncubApprovalRequestCode(): Code[128]
    begin
        exit('RunWorkflowOnCancelIncubApprovalRequest')
    end;

    //********************************************End Leave Recall***********************//


    //***********************Add events to Library*************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure AddWorkFlowEventToLibrary()
    begin
        //** Recall
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendIncubForApprovalCode(), Database::Incubation, SendIncubTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelIncubApprovalRequestCode(), Database::Incubation, CancelIncubAppTxt, 0, false);
        //**
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        //*************************Add Event Predecessors**********************//
        case EventFunctionName of

            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendIncubForApprovalCode());
                end;

            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode:
                begin

                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendIncubForApprovalCode());
                end;

            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode:
                begin

                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendIncubForApprovalCode());
                end;

        end;
        //*************************Add Event Predecessors**********************//
    end;

}
