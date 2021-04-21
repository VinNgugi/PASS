page 51513605 "Fee Waiver Application"
{
    PageType = Card;
    SourceTable = "Fee Waiver Application";
    Caption = 'Fee Waiver Application';
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Navigate,Applicant';
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
                field("Application Date"; "Application Date")
                {
                    ShowMandatory = true;
                }
                field("Waive all fees"; "Waive all fees")
                {


                    trigger Onvalidate()

                    begin
                        if "Waive all fees" then
                            WaiverAll := false
                        else
                            WaiverAll := true;

                    end;

                }
                field("Fee Type"; "Fee Type")
                {
                    Enabled = WaiverAll;
                }

                field("Client No."; "Client No.")
                {
                    ShowMandatory = true;
                }
                field("Client Name"; "Client Name")
                {

                }

                field(Product; Product)
                {

                }
                field("Project Description"; "Project Description")
                {

                }
                field("Requested Loan Amount"; "Requested Loan Amount")
                {

                }
                field("Currency Code"; "Currency Code")
                {

                }

                field("Created By"; "Created By")
                {

                }
                field(Status; Status)
                {

                }
                field(Reason; Reason)
                {
                    MultiLine = true;
                    ShowMandatory = true;
                }
            }
        }
        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {

            }
            systempart(Links; Links)
            {

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
                    Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;


                    trigger OnAction()

                    begin
                        TestField(Reason);
                        TestField("Client No.");
                        TestField("Application Date");
                        IF not "Waive all fees" then
                            TestField("Fee Type");
                        if ApprovalsMgmtExt.CheckFeeWaiverAppApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendFeeWaiverAppforApproval(Rec);
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
                    Enabled = CanCancelApprovalForRecord;

                    trigger OnAction()

                    begin
                        TestField(Status, Status::"Pending Approval");
                        ApprovalsMgmtExt.OnCancelFeeWaiverAppforApproval(Rec);

                    end;
                }
            }
        }
    }

    trigger OnOpenPage()

    begin
        SetControlAppearance;
    end;

    trigger OnInit()

    begin
        WaiverAll := true;
    end;

    trigger OnAfterGetCurrRecord()
    var


    begin
        EditableData := true;
        SetControlAppearance;
        CanCancelApprovalForRecord := true;

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

    var
        EditableData: Boolean;
        WaiverAll: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmtExt: Codeunit "Approval Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
}