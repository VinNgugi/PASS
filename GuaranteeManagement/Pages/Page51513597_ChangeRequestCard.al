page 51513597 "Change Request Card"
{

    Caption = 'Change Request Card';
    PageType = Card;
    SourceTable = "Change Request";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Request No"; Rec."Request No")
                {
                    ApplicationArea = All;
                }
                field("Requested Date"; Rec."Requested Date")
                {
                    ApplicationArea = All;
                }
                field("Requested Time"; Rec."Requested Time")
                {
                    ApplicationArea = All;
                }
                field("Client No"; Rec."Client No")
                {
                    ApplicationArea = All;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = All;
                }
                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = All;
                }
                field("Change Type"; Rec."Change Type")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                    end;
                }

                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
            }
            group(ProductDetail)
            {
                Caption = 'Products';
                Visible = ProductDetailsVisible;
                field(Type; Type)
                {

                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                }
                field("New Type"; "New Type")
                {

                }
                field("New Product type"; Rec."New Product type")
                {
                    ApplicationArea = All;
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
                        if ApprovalsMgmtExt.CheckChangeReqApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendChangeReqforApproval(Rec);
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
                        ApprovalsMgmtExt.OnCancelChangeReqforApproval(Rec);

                    end;
                }
                action(ProcessChange)
                {
                    Caption = 'Process Change';
                    Enabled = ProcessChangeEnabled;
                    ApplicationArea = "#Basic,#Suite";
                    Image = Process;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Process the changes requested.';
                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        FnProcessChanges("Contract No");
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
        ProductDetailsVisible: Boolean;
        ProcessChangeEnabled: Boolean;

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

        ProductDetailsVisible := false;
        ProcessChangeEnabled := false;
        if "Change Type" = "Change Type"::"Product Type Change" then
            ProductDetailsVisible := true;
        if "Approval Status" = "Approval Status"::Approved then
            ProcessChangeEnabled := true;

    end;

}
