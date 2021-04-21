page 51513019 "Petty Cash Lines"
{
    PageType = ListPart;
    Caption = 'Petty Cash Lines';
    SourceTable = "Petty Cash Lines";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Transaction Type"; "Transaction Type")
                {

                }
                field("Account Type"; "Account Type")
                {
                    Editable = false;
                }
                field("Account No"; "Account No")
                {
                    Editable = false;
                }
                field("Account Name"; "Account Name")
                {
                    Editable = false;
                }
                field(Description; Description)
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    // Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    // Visible = false;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    //Visible = false;
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
                field(Amount; Amount)
                {

                }
                field("Amount LCY"; "Amount LCY")
                {

                }
                field("VAT Code"; "VAT Code")
                {

                }
                field("VAT Amount"; "VAT Amount")
                {

                }
                field("VAT Amount LCY"; "VAT Amount LCY")
                {

                }
                field("W/Tax Code"; "W/Tax Code")
                {

                }
                field("W/Tax Amount"; "W/Tax Amount")
                {

                }
                field("W/Tax Amount LCY"; "W/Tax Amount LCY")
                {

                }
                field("Net Amount"; "Net Amount")
                {

                }
                field("Net Amount LCY"; "Net Amount LCY")
                {

                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)

    begin

        IF ImprestHeader.GET(No) THEN
            ImprestHeader.TESTFIELD(Status, ImprestHeader.Status::Open);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean

    begin

        IF ImprestHeader.GET(No) THEN
            ImprestHeader.TESTFIELD(Status, ImprestHeader.Status::Open);
    end;

    trigger OnModifyRecord(): Boolean

    begin

        IF ImprestHeader.GET(No) THEN;
        ImprestHeader.TESTFIELD(Status, ImprestHeader.Status::Open);
    end;

    trigger OnDeleteRecord(): Boolean

    begin

        IF ImprestHeader.GET(No) THEN
            ImprestHeader.TESTFIELD(Status, ImprestHeader.Status::Open);
    end;

    var

    var
        ImprestHeader: Record "Payments HeaderFin";
        ShortcutDimCode: array[8] of Code[20];
}



