page 51513076 "InterBank Transfer Card"
{
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "InterBank Transfer Header";
    SourceTableView = sorting ("No.") where ("Transaction Type" = filter ("InterBank Transfer"));

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Editable = EditableData;
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Creation Date"; "Creation Date")
                {

                }
                field("Transaction Description"; "Transaction Description")
                {

                }
                field("Bank Account"; "Bank Account")
                {

                }
                field("Bank Account Name"; "Bank Account Name")
                {

                }
                field("Bank Acc Balance"; "Bank Acc Balance")
                {

                }
                field("Currency Code"; "Currency Code")
                {

                }
                field(Amount; Amount)
                {

                }
                field("Amount (LCY)"; "Amount (LCY)")
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
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (3), Blocked = const (false));

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
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (4), Blocked = const (false));

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
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (5), Blocked = const (false));

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
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (6), Blocked = const (false));

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
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (7), Blocked = const (false));

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
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (8), Blocked = const (false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Created By"; "Created By")
                {

                }

            }
            part(TransferLines; "InterBank Transfer Lines")
            {
                Caption = 'Destination Account Details';
                SubPageLink = "Header No." = field ("No.");
                Editable = EditableData;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(FundsTransfer)
            {
                Caption = 'Process Transaction';

                action("Post Transfer")
                {
                    ApplicationArea = All;

                    trigger OnAction()
                    begin

                        PaymentMgmt.FnPostInterBankTransfer(Rec);
                    end;
                }

            }
            group(Approvals)
            {
                Caption = 'Documents Approvals';
                action("Send Approval Request")
                {
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        TestField("Global Dimension 1 Code");

                        if ApprovalMgmt.CheckInterbankTransApprovalWorkflowEnabled(Rec) then begin
                            ApprovalMgmt.OnSendInterbankTransforApproval(Rec);
                        end;
                    end;
                }
                action("Cancel Approval Requests")
                {
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Enabled = CanCancelApprovalForRecord;

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        if ApprovalMgmt.CheckInterbankTransApprovalWorkflowEnabled(Rec) then begin
                            ApprovalMgmt.OnCancelInterbankTransforApproval(Rec);
                        end;
                    end;
                }
                action("Document Approval Entries")
                {
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                }
            }

        }
    }

    var
        ApprovalMgmt: Codeunit ApprovalMgtFM;
        EditableData: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        PaymentMgmt: Codeunit "Payment Management";
        ShortcutDimCode: array[8] of Code[20];

    trigger OnAfterGetRecord()

    begin

    end;

    trigger OnNewRecord(BelowRec: Boolean)

    begin
        "Transaction Type" := "Transaction Type"::"InterBank Transfer";
    end;


    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        EditableData := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := TRUE;

        IF "Approval Status" = "Approval Status"::Approved then begin
            OpenApprovalEntriesExist := FALSE;
            CanCancelApprovalForRecord := FALSE;
            EnabledApprovalWorkflowsExist := FALSE;
            EditableData := false;
        end;

        IF "Approval Status" = "Approval Status"::"Pending Approval" then begin
            CurrPage.Editable := false;
            EditableData := false;
        end;
    end;
}