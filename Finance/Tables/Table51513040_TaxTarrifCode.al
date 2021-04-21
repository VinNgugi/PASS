table 51513040 "Tax Tarriff Code"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Tax Tarrif Codes";
    LookupPageId = "Tax Tarrif Codes";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[50])
        {

        }
        field(3; Percentage; Decimal)
        {

        }
        field(4; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" where(Blocked = const(false), "Direct Posting" = const(true))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer where(Blocked = const(" "))
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor where(Blocked = const(" "))
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset" where(Blocked = const(false))
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account" where(Blocked = const(false));
        }
        field(5; Type; Option)
        {
            OptionMembers = " ","W/Tax",VAT,Excise,"W/VTax",Retention,"Income Tax";
        }
        field(6; "Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}