page 51513803 "Incubation"
{
    PageType = Card;
    SourceTable = Incubation;
    SourceTableView = sorting ("No.") order(ascending);
    Caption = 'Incubation Request';
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Applicants,Report,Job,Approve,Request Approval,Navigate,Interviews';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = EditableData;
                field("No."; "No.")
                {

                }
                field("Document Date"; "Document Date")
                {

                }
                field(Name; Name)
                {
                    Caption = 'Description';
                }

                field("Search Name"; "Search Name")
                {

                }
                field("Incubation Start Date"; "Incubation Start Date")
                {

                }


                field("Incubation Duration"; "Incubation Duration")
                {

                }
                field("Incubation End Date"; "Incubation End Date")
                {

                }
                field("Applications Start Date"; "Applications Start Date")
                {

                }
                field("Applications End Date"; "Applications End Date")
                {

                }
                field("No. of Participants"; "No. of Participants")
                {

                }

                field("Requested By"; "Requested By")
                {

                }
                field("Requester Name"; "Requester Name")
                {

                }
                field(Status; Status)
                {

                }
                field("Incubation Status"; "Incubation Status")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {

                }

            }


            part(Advertisement; "Advertising Lines_")
            {
                Editable = EditableData;
                SubPageLink = "Need Code" = field ("No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {


            group(Applicants)
            {
                action("View Applicants")
                {
                    Caption = 'View Applicants';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page "AIC Applicants List";
                    RunPageLink = "Incubation Code" = FIELD ("No.");
                }


            }
        }
        area(Processing)
        {

            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    //Visible = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Request approval of the document.';
                    Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;

                    trigger OnAction()

                    begin
                        TestField("Applications Start Date");
                        TestField("Applications End Date");
                        TestField("Incubation Start Date");
                        TestField("Incubation Duration");
                        TestField("No. of Participants");
                        if ApprovalsMgmtExt.CheckIncubWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendIncubForApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    //Visible = CanCancelApprovalForRecord or CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Cancel the approval request.';
                    Enabled = CanCancelApprovalForRecord;

                    trigger OnAction()

                    begin
                        ApprovalsMgmtExt.OnCancelIncubApprovalRequest(Rec);

                    end;
                }
            }
        }
    }

    var
        JobApplicationsTable: Record "Job Applicants";
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmtExt: Codeunit "Approvals Mgmt. AIC Ext";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        EditableData: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;



    trigger OnOpenPage()

    begin
        SetControlAppearance();

    end;

    trigger OnNewRecord(BelowRec: Boolean)
    var
        myInt: Integer;
    begin

    end;

    trigger OnAfterGetRecord()

    begin
        SetControlAppearance;

    end;


    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        EditableData := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := TRUE;
        IF Status = Status::Released then begin
            OpenApprovalEntriesExist := FALSE;
            CanCancelApprovalForRecord := FALSE;
            EnabledApprovalWorkflowsExist := FALSE;
            EditableData := false;
        end;

        if Status <> Status::Open then begin
            CurrPage.Editable := false;
            EditableData := false;
        end;


    end;

    local procedure SetControlAppearance()

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForRecord);

    end;

}