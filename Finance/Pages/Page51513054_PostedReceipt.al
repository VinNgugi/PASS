page 51513054 "Posted Receipt"
{
    // version FINANCE

    PageType = Card;
    SourceTable = "Receipts Header";
    SourceTableView = WHERE (Posted = CONST (true));
    Caption = 'Posted Receipt';
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group(Receipt)
            {
                Caption = 'Receipt';
                field("No."; "No.")
                {
                    Editable = false;
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
                field("Received From"; "Received From")
                {
                }
                field("On Behalf Of"; "On Behalf Of")
                {
                    Caption = 'Payment For';
                }
                field("Cheque Date"; "Cheque Date")
                {
                    Editable = true;
                }
                field("Bank Code"; "Bank Code")
                {
                    Caption = 'Bank Account';
                }
                field(Cashier; Cashier)
                {
                    Editable = false;
                }
                field("Total Amount"; "Total Amount")
                {
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                    Editable = false;
                }

                field(Status; Status)
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
            }
            part(Control1000000034; "Receipts Line")
            {
                SubPageLink = "Receipt No." = FIELD ("No.");
                Editable = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Functions)
            {


                action("Print Receipt")
                {
                    Caption = 'Print Receipt';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        BankLedgerEntry.RESET;
                        BankLedgerEntry.SETFILTER("Document No.", "No.");
                        if receiptrec.FINDSET then begin
                            REPORT.RUN(51513005, true, true, BankLedgerEntry);
                        end;
                    end;
                }
            }
        }
    }

    var
        BankLedgerEntry: Record "Bank Account Ledger Entry";
        receiptrec: Record "Receipts Header";
        PostRcpt: Codeunit "Receipts-Post";
        ShortcutDimCode: array[8] of Code[20];
}

