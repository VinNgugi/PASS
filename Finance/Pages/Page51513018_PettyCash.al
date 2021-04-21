page 51513018 "Petty Cash"
{
    PageType = Card;
    Caption = 'Petty Cash';
    SourceTable = "Payments HeaderFin";
    DeleteAllowed = false;
    SourceTableView = WHERE("Payment Type" = CONST("Petty Cash"), Posted = CONST(false), Status = FILTER(Open | "Pending Approval" | "Pending Approval"));
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
                    Editable = false;
                }
                field("Cheque No"; "Cheque No")
                {
                    Visible = false;
                }
                field("Cheque Date"; "Cheque Date")
                {
                    Visible = false;
                }
                field("Paying Bank Account"; "Paying Bank Account")
                {
                    Editable = false;
                }
                field(Payee; Payee)
                {

                }
                field("Transaction Description"; "Transaction Description")
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
                field("Dimension Set ID"; "Dimension Set ID")
                {

                }
                field(Currency; Currency)
                {
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        ChangeExchangeRate.SetParameter(Currency, "Currency Factor", Date);
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);

                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field(Status; Status)
                {

                }
                field("Petty Cash Amount"; "Petty Cash Amount")
                {

                }
                field("Petty Cash Amount(LCY)"; "Petty Cash Amount(LCY)")
                {

                }
            }
            part(PettyCashLines; "Petty Cash Lines")
            {
                SubPageLink = No = FIELD("No.");

            }
        }
        area(Factboxes)
        {
            systempart(Link; Links)
            {

            }
            systempart(Notes; Notes)
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
                    PromotedCategory = Process;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()

                    begin
                        CashMng.Get;
                        TESTFIELD(Payee);
                        TESTFIELD("Pay Mode");
                        TESTFIELD(Date);
                        TESTFIELD("Petty Cash Amount");
                        TESTFIELD("Global Dimension 1 Code");
                        TestField("Transaction Description");

                        CalcFields("Petty Cash Amount");
                        if "Petty Cash Amount" > CashMng."Petty Cash Limit" then
                            // Error('Petty Cash amount should not exceed %1', CashMng."Petty Cash Limit");
                            IF "Pay Mode" = 'CHEQUE' THEN BEGIN
                                TESTFIELD("Cheque Date");
                                TESTFIELD("Cheque No");
                            END;

                        if ApprovalsMgmtExt.CheckPettyCashApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendPettyCashforApproval(Rec);
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

                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Visible = CanCancelApprovalForRecord;
                    ApplicationArea = "#Basic,#Suite";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()

                    begin
                        ApprovalsMgmtExt.OnCancelPettyCashforApproval(Rec);

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
        CashMng: Record "Cash Management Setup";
        DataEditable: Boolean;
        ChangeExchangeRate: Page "Change Exchange Rate";
        DocumentType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order"," ";
        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
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

    trigger OnAfterGetCurrRecord()
    begin
        if Status <> Status::Open then begin
            CurrPage.Editable := false;
            DataEditable := false;
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