page 51513639 "Restructuring Memo"
{
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "Restructuring Memo Header";
    PromotedActionCategories = 'New,Process,Report,Documents,Approve,Request Approval,Navigate,Applicant';


    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {


                }
                field("Document Date"; "Document Date")
                {

                }
                field(Subject; Subject)
                {

                }
                field("Contract No."; "Contract No.")
                {

                }
                field(Name; Name)
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Loan Amount"; "Loan Amount")
                {

                }
                field("Restructturing Amount"; "Restructturing Amount")
                {

                }
                field(Product; Product)
                {

                }

                field("Created By"; "Created By")
                {

                }
                field(Status; Status)
                {

                }
                field(Background; Background)
                {
                    MultiLine = true;
                }
                field("Reason of Restructure"; "Reason of Restructure")
                {
                    MultiLine = true;
                }
                field("Way Forward"; "Way Forward")
                {
                    MultiLine = true;
                }
                field(Recommendations; Recommendations)
                {
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Visible = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()

                    begin
                        if ApprovalsMgmtExt.CheckRestructApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendRestructforApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Visible = CanCancelApprovalForRecord or CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()

                    begin
                        ApprovalsMgmtExt.OnCancelRestructforApproval(Rec);

                    end;
                }
            }
        }
    }
    var
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmtExt: Codeunit "Approval Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";

    trigger OnOpenPage()

    begin
        SetControlAppearance();

    end;

    trigger OnAfterGetCurrRecord()
    begin
        SetControlAppearance();

    end;

    trigger OnAfterGetRecord()

    begin
        SetControlAppearance;

    end;

    local procedure SetControlAppearance()

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForRecord);

    end;

}