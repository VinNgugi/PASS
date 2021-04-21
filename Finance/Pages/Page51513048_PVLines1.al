page 51513048 "PV Lines1"
{
    PageType = ListPart;
    SourceTable = "PV Lines1";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Account Type"; "Account Type")
                {

                }
                field("Account No"; "Account No")
                {

                }
                field("Account Name"; "Account Name")
                {

                }
                field(Currency; Currency)
                {

                }
                field("Applies to Doc. No"; "Applies to Doc. No")
                {

                }
                field(Description; Description)
                {

                }
                field(Amount; Amount)
                {

                }
                field("Amount(LCY)"; "Amount(LCY)")
                {

                }
                field("VAT Code"; "VAT Code")
                {

                }
                field("VAT Amount"; "VAT Amount")
                {

                }
                field("VAT Amount(LCY)"; "VAT Amount(LCY)")
                {

                }
                field("W/Tax Code"; "W/Tax Code")
                {

                }
                field("W/Tax Amount"; "W/Tax Amount")
                {

                }
                field("W/Tax Amount(LCY)"; "W/Tax Amount(LCY)")
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
                field("Net Amount"; "Net Amount")
                {

                }
                field("Net Amount LCY"; "Net Amount LCY")
                {

                }
            }
        }

    }

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;


    var
        ShortcutDimCode: array[8] of Code[20];
        DimMgt: Codeunit DimensionManagement;


    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8] of Code[20])
    var
        myInt: Integer;
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;
}