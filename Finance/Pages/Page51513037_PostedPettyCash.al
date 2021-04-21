page 51513037 "Posted Petty Cash"
{
    PageType = Card;
    Caption = 'Posted Petty Cash';
    SourceTable = "Payments HeaderFin";
    DeleteAllowed = false;
    Editable = false;
    SourceTableView = WHERE("Payment Type" = CONST("Petty Cash"), Posted = CONST(true), Status = FILTER(Released));
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("No."; "No.")
                {

                }
                field(Date; Date)
                {

                }
                field("Pay Mode"; "Pay Mode")
                {

                }
                field("Cheque No"; "Cheque No")
                {

                }
                field("Cheque Date"; "Cheque Date")
                {

                }
                field("Paying Bank Account"; "Paying Bank Account")
                {

                }
                field(Payee; Payee)
                {

                }
                field(Cashier; Cashier)
                {

                }
                field(Posted; Posted)
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
                field(Status; Status)
                {

                }
                field("Petty Cash Amount"; "Petty Cash Amount")
                {

                }
            }
            part(PettyCashLines; "Petty Cash Lines")
            {
                SubPageLink = No = FIELD("No.");
                Editable = false;
            }
        }
        area(FactBoxes)
        {
            systempart(Link; Links)
            {

            }
            systempart(Note; Notes)
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(Post)
            {
                Visible = false;
                Caption = 'Post';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Post;

                trigger OnAction()

                begin
                    PaymentMngt.PostPettyCash(Rec);
                end;

            }

            action("Print Petty Cash Voucher")
            {
                Caption = 'Print Petty Cash Voucher';
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                Image = Print;

                trigger OnAction()

                begin

                    RESET;
                    SETFILTER("No.", "No.");
                    REPORT.RUN(51513001, TRUE, TRUE, Rec);
                end;
            }
            group(AttachmentstoEDMS)
            {
                /* action("Attach Documents")
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
                } */
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
        ShortcutDimCode: array[8] of Code[20];

    trigger OnNewRecord(BelowxRec: Boolean)

    begin

        "Payment Type" := "Payment Type"::"Petty Cash";
        Cashier := USERID;
    end;

    trigger OnOpenPage()

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