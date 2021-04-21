page 51513035 "Approved Imprest Surrender"
{
    DeleteAllowed = false;
    PageType = Card;

    Caption = 'Approved Imprest Surrender';
    SourceTable = "Payments HeaderFin";
    SourceTableView = WHERE("Surrender Type" = FILTER(Surrender), Surrendered = CONST(false), Status = filter(Released));
    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = false;
                field("No."; "No.")
                {

                }
                field(Date; Date)
                {

                }
                field("Surrender Imprest No"; "Surrender Imprest No")
                {

                }
                field("Imprest Surrender Date"; "Imprest Surrender Date")
                {

                }
                field("Account Type"; "Account Type")
                {

                }
                field("Account No."; "Account No.")
                {

                }
                field("Account Name"; "Account Name")
                {

                }
                field(Cashier; Cashier)
                {

                }
                field(Posted; Posted)
                {

                }
                field(Surrendered; Surrendered)
                {

                }
                field(Status; Status)
                {

                }
                field("Paying Bank Account"; "Paying Bank Account")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    Visible = false;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    Visible = false;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    Visible = false;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    Visible = false;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    Visible = false;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    Visible = false;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Imprest Amount"; "Imprest Amount")
                {

                }
                field("Remaining Amount"; "Remaining Amount")
                {

                }
                field(Currency; Currency)
                {

                }
            }
            group(MemoDetails)
            {
                Editable = false;
                Caption = 'Memo Reference Details';
                field("Memo Reference"; "Memo Reference")
                {
                    Caption = 'Memo Reference Number';
                    Editable = false;
                }
                field("Employee No"; "Employee No")
                {
                    Editable = false;
                }
                field("Imprest Rate"; "Imprest Rate")
                {
                    Editable = false;
                }
                field("No. of Days"; "No. of Days")
                {
                    Caption = 'Approved Days';
                    Editable = false;
                }
                field("Total Days Spent"; "Total Days Spent")
                {

                }
            }
            part(ImprestLine; "Surrender Lines")
            {
                SubPageLink = No = FIELD("No.");
                //Editable = false;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Post;

                trigger OnAction()

                begin
                    PaymentMngt.PostImprestSurrender(Rec);
                end;

            }
            action(Approvals)
            {
                Caption = 'Approvals';
                ApplicationArea = "#Basic,#Suite";
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'See document Approvers';

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    DocumentType := DocumentType::" ";
                    WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID, DATABASE::"Payments HeaderFin", DocumentType, "No.");
                end;
            }
            group(AttachmentstoEDMS)
            {
                action("Attach Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Add a file as an attachment to EDMS. You can attach images as well as documents.';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                    begin
                        OnAttachDocuments(Rec);
                    end;
                }
                action("View Attached Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'View attached files in EDMS.';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var

                    begin
                        OnViewAttachedDocuments(Rec);
                    end;
                }
            }
        }
    }




    var
        PaymentMngt: Codeunit "Payment Management";
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmtExt: Codeunit ApprovalMgtFM;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        DocumentType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order"," ";
        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
        ShortcutDimCode: array[8] of Code[20];


    trigger OnOpenPage()

    begin
        SetControlAppearance();

    end;

    trigger OnNewRecord(BelowRec: Boolean)

    begin

        "Payment Type" := "Payment Type"::"Imprest Surrender";
        "Surrender Type" := "Surrender Type"::Surrender;
        Cashier := USERID;
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