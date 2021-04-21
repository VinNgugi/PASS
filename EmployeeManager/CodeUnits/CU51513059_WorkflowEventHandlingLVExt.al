codeunit 51513059 "Workflow Event Handling LV Ext"
{
    trigger OnRun()
    begin

    end;

    var
        WFMngt: Codeunit "Workflow Management";
        AppMgmt: Codeunit "Approvals Mgmt.";
        WorkflowEventHandling: Codeunit "Workflow Event Handling";
        WorkflowResponseHandling: Codeunit "Workflow Response Handling";
        SendLeaveApplication: TextConst ENU = 'Approval Request for Leave Application is requested', ENG = 'Approval Request for Leave Application is requested';
        CancelLeaveApplication: TextConst ENU = 'Approval Request for Leave Application is Canceled', ENG = 'Approval Request for Leave Application is Canceled';
        AppReqLeaveApplication: TextConst ENU = 'Approval Request for Leave Application is approved', ENG = 'Approval Request for Leave Application is approved';
        RejReqLeaveApplication: TextConst ENU = 'Approval Request for Leave Application is rejected', ENG = 'Approval Request for Leave Application is rejected';
        DelReqLeaveApplication: TextConst ENU = 'Approval Request for Leave Application is delegated', ENG = 'Approval Request Leave Application is delegated';
        SendForPendLeaveApplication: TextConst ENU = 'Status of Leave Application changed to Pending approval', ENG = 'Status of Leave Application changed to Pending approval';
        ReleaseLeaveApplication: TextConst ENU = 'Release Leave Application', ENG = 'Release Leave Application';
        ReOpenLeaveApplication: TextConst ENU = 'ReOpen Leave Application', ENG = 'ReOpen Leave Application';
        SendLeaveRecallTxt: TextConst ENU = 'Approval Request for Leave Recall is requested', ENG = 'Approval Request for Leave Recall is requested';
        CancelLeaveRecallTxt: TextConst ENU = 'Approval Request for Leave Recall is Canceled', ENG = 'Approval Request for Leave Recall is Canceled';

        //***************************************LeaveApplication>> 

        SendApprObj: TextConst ENU = 'Approval Request for Appraisal Objectives is requested', ENG = 'Approval Request for Appraisal Objectives is requested';
        CancelApprObj: TextConst ENU = 'Approval Request for Appraisal Objectives is Cancelled', ENG = 'Approval Request for Appraisal Objectives is Canceled';
        AppReqApprObj: TextConst ENU = 'Approval Request for Appraisal Objectives is approved', ENG = 'Approval Request for Appraisal Objectives is approved';
        RejReqApprObj: TextConst ENU = 'Approval Request for Appraisal Objectives is rejected', ENG = 'Approval Request for Appraisal Objectives is rejected';
        DelReqApprObj: TextConst ENU = 'Approval Request for Appraisal Objectives is delegated', ENG = 'Approval Request for Appraisal Objectivesi s delegated';
        SendForApprObjTxt: TextConst ENU = 'Status of Appraisal Objectives changed to Pending approval', ENG = 'Status of Appraisal Objectives changed to Pending approval';
        ReleaseApprObjTxt: TextConst ENU = 'Release Appraisal Objectives', ENG = 'Release Appraisal Objectives';
        ReOpenApprObjTxt: TextConst ENU = 'ReOpen Appraisal Objectives', ENG = 'ReOpen Appraisal Objectives';
        //*********************************************Appraisal Objectives 

        SendAppr: TextConst ENU = 'Approval Request for Employee Appraisal is requested', ENG = 'Approval Request for Employee Appraisal is requested';
        CancelAppr: TextConst ENU = 'Approval Request for Employee Appraisal is Cancelled', ENG = 'Approval Request for Employee Appraisal is Cancelled';
        AppReqAppr: TextConst ENU = 'Approval Request for Employee Appraisal is approved', ENG = 'Approval Request for Employee Appraisal is approved';
        RejReqAppr: TextConst ENU = 'Approval Request for Employee Appraisal is rejected', ENG = 'Approval Request for Employee Appraisal is rejected';
        DelReqAppr: TextConst ENU = 'Approval Request for Employee Appraisal is delegated', ENG = 'Approval Request for Employee Appraisal is delegated';
        SendForApprTxt: TextConst ENU = 'Status of Employee Appraisal changed to Pending approval', ENG = 'Status of Employee Appraisal changed to Pending approval';
        ReleaseApprTxt: TextConst ENU = 'Release Employee Appraisal', ENG = 'Release Employee Appraisal';
        ReOpenApprTxt: TextConst ENU = 'ReOpen Employee Appraisal', ENG = 'ReOpen Employee Appraisal';
        //*********************************************Employee Appraisal 

    procedure RunWorkflowOnSendLeaveApplicationApprovalCode(): Code[128]
    begin

        exit(UpperCase('RunWorkflowOnSendLeaveApplicationApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. LV Ext", 'OnSendLeaveApplicationforApproval', '', true, true)]
    procedure RunWorkflowOnSendLeaveApplicationApproval(var LeaveApplication: Record "Employee Leave Application")
    begin

        WFMngt.HandleEvent(RunWorkflowOnSendLeaveApplicationApprovalCode, LeaveApplication);
    end;

    //<< End OnSend LeaveApplication

    //OnCancel LeaveApplication>>
    procedure RunWorkflowOnCancelLeaveApplicationApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelLeaveApplicationApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. LV Ext", 'OnCancelLeaveApplicationForApproval', '', true, true)]
    procedure RunWorkflowOnCancelLeaveApplicationApproval(var LeaveApplication: Record "Employee Leave Application")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelLeaveApplicationApprovalCode, LeaveApplication);
    end;

    //<<EndOnCancel LeaveApplication

    //>>OnApprove LeaveApplication
    procedure RunWorkflowOnApproveLeaveApplicationApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveLeaveApplicationApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveLeaveApplicationApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveLeaveApplicationApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove LeaveApplication

    //>>OnReject LeaveApplication
    procedure RunWorkflowOnRejectLeaveApplicationApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectLeaveApplicationApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectLeaveApplicationApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectLeaveApplicationApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject LeaveApplication

    //>>OnDelegate LeaveApplication
    procedure RunWorkflowOnDelegateLeaveApplicationApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateLeaveApplicationApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateLeaveApplicationApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateLeaveApplicationApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate LeaveApplication

    //********************************************Leave Recall***********************//
    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt. LV Ext", 'OnSendLeaveRecallForApproval', '', false, false)]
    procedure RunWorkflowOnSendLeaveRecallForApproval(var Recall: Record "Leave Recall")
    begin
        WFMngt.HandleEvent(RunWorkflowOnSendLeaveRecallForApprovalCode, Recall);
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt. LV Ext", 'OnCancelLeaveRecallApprovalRequest', '', false, false)]
    procedure RunWorkflowOnCancelLeaveRecallApprovalRequest(var Recall: Record "Leave Recall")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelLeaveRecallApprovalRequestCode, Recall);
    end;

    procedure RunWorkflowOnSendLeaveRecallForApprovalCode(): Code[128]
    begin
        exit('RunWorkflowOnSendLeaveRecallForApproval')
    end;

    procedure RunWorkflowOnCancelLeaveRecallApprovalRequestCode(): Code[128]
    begin
        exit('RunWorkflowOnCancelLeaveRecallApprovalRequest')
    end;

    //********************************************End Leave Recall***********************//
    procedure RunWorkflowOnSendApprObjApprovalCode(): Code[128]
    begin

        exit(UpperCase('RunWorkflowOnSendApprObjApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. LV Ext", 'OnSendApprObjforApproval', '', true, true)]
    procedure RunWorkflowOnSendApprObjApproval(var ApprObj: Record "Employee Appraisal Objectives")
    begin

        WFMngt.HandleEvent(RunWorkflowOnSendApprObjApprovalCode, ApprObj);
    end;

    //<< End OnSend ApprObj

    //OnCancel ApprObj>>
    procedure RunWorkflowOnCancelApprObjApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelApprObjApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. LV Ext", 'OnCancelApprObjForApproval', '', true, true)]
    procedure RunWorkflowOnCancelApprObjApproval(var ApprObj: Record "Employee Appraisal Objectives")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelApprObjApprovalCode, ApprObj);
    end;

    //<<EndOnCancel ApprObj

    //>>OnApprove ApprObj
    procedure RunWorkflowOnApproveApprObjApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveApprObjApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveApprObjApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveApprObjApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove ApprObj

    //>>OnReject ApprObj
    procedure RunWorkflowOnRejectApprObjApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectApprObjApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectApprObjApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectApprObjApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject ApprObj

    //>>OnDelegate ApprObj
    procedure RunWorkflowOnDelegateApprObjApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateApprObjApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateApprObjApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateApprObjApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate ApprObj

    //********************************************End Appraisal Objectives***********************//

    procedure RunWorkflowOnSendAppraisalApprovalCode(): Code[128]
    begin

        exit(UpperCase('RunWorkflowOnSendAppraisalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. LV Ext", 'OnSendAppraisalforApproval', '', true, true)]
    procedure RunWorkflowOnSendAppraisalApproval(var Appraisal: Record "Employee Appraisals")
    begin

        WFMngt.HandleEvent(RunWorkflowOnSendAppraisalApprovalCode, Appraisal);
    end;

    //<< End OnSend Appraisal

    //OnCancel Appraisal>>
    procedure RunWorkflowOnCancelAppraisalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnCancelAppraisalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt. LV Ext", 'OnCancelAppraisalForApproval', '', true, true)]
    procedure RunWorkflowOnCancelAppraisalApproval(var Appraisal: Record "Employee Appraisals")
    begin
        WFMngt.HandleEvent(RunWorkflowOnCancelAppraisalApprovalCode, Appraisal);
    end;

    //<<EndOnCancel Appraisal

    //>>OnApprove Appraisal
    procedure RunWorkflowOnApproveAppraisalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnApproveAppraisalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', false, false)]
    procedure RunWorkflowOnApproveAppraisalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnApproveAppraisalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;

    //>>EndOnApprove Appraisal

    //>>OnReject Appraisal
    procedure RunWorkflowOnRejectAppraisalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnRejectAppraisalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnRejectApprovalRequest', '', false, false)]
    procedure RunWorkflowOnRejectAppraisalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnRejectAppraisalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnReject Appraisal

    //>>OnDelegate Appraisal
    procedure RunWorkflowOnDelegateAppraisalApprovalCode(): Code[128]
    begin
        exit(UpperCase('RunWorkflowOnDelegateAppraisalApproval'))
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Approvals Mgmt.", 'OnDelegateApprovalRequest', '', false, false)]
    procedure RunWorkflowOnDelegateAppraisalApproval(var ApprovalEntry: Record "Approval Entry")
    begin
        WFMngt.HandleEventOnKnownWorkflowInstance(RunWorkflowOnDelegateAppraisalApprovalCode(), ApprovalEntry, ApprovalEntry."Workflow Step Instance ID");
    end;
    //<<EndOnDelegate Appraisal

    //***********************Add events to Library*************************//

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventsToLibrary', '', true, true)]
    procedure AddWorkFlowEventToLibrary()
    begin

        //LeaveApplication
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendLeaveApplicationApprovalCode(), Database::"Employee Leave Application", SendLeaveApplication, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelLeaveApplicationApprovalCode(), Database::"Employee Leave Application", CancelLeaveApplication, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveLeaveApplicationApprovalCode(), Database::"Approval Entry", AppReqLeaveApplication, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectLeaveApplicationApprovalCode(), Database::"Approval Entry", RejReqLeaveApplication, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateLeaveApplicationApprovalCode(), Database::"Approval Entry", DelReqLeaveApplication, 0, false);
        //<<LeaveApplication
        //** Recall
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendLeaveRecallForApprovalCode(), Database::"Leave Recall", SendLeaveRecallTxt, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelLeaveRecallApprovalRequestCode(), Database::"Leave Recall", CancelLeaveRecallTxt, 0, false);
        //**
        //AppraisalObjectives
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendApprObjApprovalCode(), Database::"Employee Appraisal Objectives", SendApprObj, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelApprObjApprovalCode(), Database::"Employee Appraisal Objectives", CancelApprObj, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveApprObjApprovalCode(), Database::"Approval Entry", AppReqApprObj, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectApprObjApprovalCode(), Database::"Approval Entry", RejReqApprObj, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateApprObjApprovalCode(), Database::"Approval Entry", DelReqApprObj, 0, false);
        //<<AppraisalObjectives

        //Appraisal
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnSendAppraisalApprovalCode(), Database::"Employee Appraisals", SendAppr, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnCancelAppraisalApprovalCode(), Database::"Employee Appraisals", CancelAppr, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnApproveAppraisalApprovalCode(), Database::"Approval Entry", AppReqAppr, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnRejectAppraisalApprovalCode(), Database::"Approval Entry", RejReqAppr, 0, false);
        WorkflowEventHandling.AddEventToLibrary(RunWorkflowOnDelegateAppraisalApprovalCode(), Database::"Approval Entry", DelReqAppr, 0, false);
        //<<Appraisal
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Workflow Event Handling", 'OnAddWorkflowEventPredecessorsToLibrary', '', true, true)]
    local procedure OnAddWorkflowEventPredecessorsToLibrary(EventFunctionName: Code[128])
    begin
        //*************************Add Event Predecessors**********************//
        case EventFunctionName of

            WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeaveApplicationApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendLeaveRecallForApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendApprObjApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnApproveApprovalRequestCode, RunWorkflowOnSendAppraisalApprovalCode());
                end;

            WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLeaveApplicationApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendLeaveRecallForApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendApprObjApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnRejectApprovalRequestCode, RunWorkflowOnSendAppraisalApprovalCode());
                end;

            WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode:
                begin
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLeaveApplicationApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendLeaveRecallForApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendApprObjApprovalCode());
                    WorkflowEventHandling.AddEventPredecessor(WorkflowEventHandling.RunWorkflowOnDelegateApprovalRequestCode, RunWorkflowOnSendAppraisalApprovalCode());
                end;

        end;
        //*************************Add Event Predecessors**********************//
    end;

}
