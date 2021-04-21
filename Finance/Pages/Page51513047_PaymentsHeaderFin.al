page 51513047 "Payments HeaderFin"
{
    PageType = Card;
    Caption = 'Payments HeaderFin';
    DeleteAllowed = false;
    SourceTable = "Payments HeaderFin";
    SourceTableView = WHERE("Payment Type" = CONST("Payment Voucher"), Posted = CONST(false), Status = FILTER(<> Released));
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {

                }
                field(Date; Date)
                {

                }
                field("Bank Call-Up "; "Bank Call-Up ")
                {
                    trigger OnValidate()

                    begin
                        if "Bank Call-Up " then
                            claimPayment := true
                        else
                            claimPayment := false;
                    end;
                }
                field("Paying Bank Account"; "Paying Bank Account")
                {

                }
                field(Payee; Payee)
                {

                }
                field("Transaction Description"; "Transaction Description")
                {

                }
                field(Currency; Currency)
                {
                    AssistEdit = true;
                }
                field("Total Amount"; "Total Amount")
                {

                }
                field("Pay Mode"; "Pay Mode")
                {

                }
                field("On behalf of"; "On behalf of")
                {

                }
                field("Cheque No"; "Cheque No")
                {

                }
                field("Cheque Date"; "Cheque Date")
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
                    Visible = true;
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
                field("Dimension Set ID"; "Dimension Set ID")
                {

                }
                field(Posted; Posted)
                {

                }
                field(Status; Status)
                {

                }

            }
            group("Claim Detalis")
            {
                Visible = claimPayment;
                field("Claim No."; "Claim No.")
                {

                }
                field("Claiming Bank Name"; "Claiming Bank Name")
                {

                }
                field("Referrence No."; "Referrence No.")
                {

                }
                field("Total Approved Claim Amount"; "Total Approved Claim Amount")
                {

                }
                field("Approved Clients"; "Approved Clients")
                {

                }
            }
            part(Lines; "PV Lines1")
            {
                //Editable = DataEditable;
                SubPageLink = No = FIELD("No.");
            }
        }

        area(Factboxes)
        {
            systempart(link; Links)
            {

            }
            systempart(note; Notes)
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
                Caption = 'Post';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Post;
                Enabled = PostEnabled and (not Posted);

                trigger OnAction()

                begin
                    PaymentMngt.PostPaymentVoucher(Rec);
                end;

            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Visible = CanCancelApprovalForRecord or CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()

                    begin
                        ApprovalsMgmtExt.OnCancelPaymentforApproval(Rec);

                    end;
                }
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Visible = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        PVLines: Record "PV Lines1";
                    begin

                        TESTFIELD("Pay Mode");
                        TESTFIELD("Transaction Description");
                        TESTFIELD("Global Dimension 1 Code");
                        IF "Pay Mode" = 'CHEQUE' THEN BEGIN
                            TESTFIELD("Cheque No");
                            TESTFIELD("Cheque Date");
                        END;

                        PVLines.RESET;
                        PVLines.SETRANGE(PVLines.No, "No.");
                        IF PVLines.FIND('-') THEN BEGIN
                            REPEAT
                                PVLines.TESTFIELD("Global Dimension 1 Code");
                                PVLines.TESTFIELD(Description);
                                //PVLines.TESTFIELD(Amount);
                                //PVLines.TESTFIELD("Account Type");
                                PVLines.TESTFIELD("Account No");
                            UNTIL PVLines.NEXT = 0;
                        END;
                        if "Bank Call-Up " then begin
                            TestField("Claim No.");
                            CalcFields("Total Approved Claim Amount", "Total Amount");

                            if "Total Approved Claim Amount" <> "Total Amount" then
                                Error('Total approved claim amount must be equal to total amount');
                        end;
                        if ApprovalsMgmtExt.CheckPaymentApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendPaymentforApproval(Rec);
                    end;
                }
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
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmtExt: Codeunit ApprovalMgtFM;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        PaymentMngt: Codeunit "Payment Management";
        claimPayment: Boolean;
        DataEditable: Boolean;
        PostEnabled: Boolean;
        ShortcutDimCode: array[8] of Code[20];

    trigger OnNewRecord(BelowxRec: Boolean)

    begin

        "Payment Type" := "Payment Type"::"Payment Voucher";
        Cashier := USERID;
    end;


    trigger OnOpenPage()

    begin
        SetControlAppearance();
        Validate("Bank Call-Up ");
    end;

    trigger OnAfterGetRecord()

    begin
        SetControlAppearance;
        Validate("Bank Call-Up ");
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnAfterGetCurrRecord()
    begin
        PostEnabled := false;
        if Status <> Status::Open then begin
            CurrPage.Editable := false;
            DataEditable := false;
        end;

        if "Bank Call-Up " then
            claimPayment := true
        else
            claimPayment := false;

        //*****Control Posting************//
        IF Status = Status::Released THEN
            PostEnabled := true;
    end;

    local procedure SetControlAppearance()

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForRecord);

    end;
}



