page 51513462 "Requisition Line"
{
    PageType = ListPart;
    AutoSplitKey = true;
    SourceTable = "Requisition Lines";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Procurement Plan Item"; "Procurement Plan Item")
                {
                    Visible = false;
                }
                field("Requisition No"; "Requisition No")
                {
                    Visible = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                    Visible = false;
                }
                field("Line No"; "Line No")
                {
                    Visible = false;
                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    Visible = false;
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
                field(Type; Type)
                {

                }
                field(No; No)
                {

                }
                field("Account Type"; "Account Type")
                {

                }
                field("Account No."; "Account No.")
                {

                }
                field(Description; Description)
                {

                }
                field(Quantity; Quantity)
                {

                }
                field("Unit of Measure"; "Unit of Measure")
                {

                }
                field("Currency Code"; "Currency Code")
                {

                }
                field("Unit Price"; "Unit Price")
                {

                }
                field(Amount; Amount)
                {

                }
                field("Amount LCY"; "Amount LCY")
                {

                }

                field("Available amount"; "Available amount")
                {
                    Visible = false;
                }
                field("Approved Budget Amount"; "Approved Budget Amount")
                {
                    Visible = false;
                }
                field("Commitment Amount"; "Commitment Amount")
                {
                    Visible = false;
                }
                field("Actual Expense"; "Actual Expense")
                {
                    Visible = false;
                }
                field("Procurement Plan"; "Procurement Plan")
                {
                    Visible = false;
                }
                field("Budget Line"; "Budget Line")
                {
                    Visible = false;
                }
            }
        }

    }

    var
        RequisitionHeader: Record "Requisition Header";
        ShortcutDimCode: array[8] of Code[20];
}