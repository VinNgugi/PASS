table 51513015 "Transaction Types"
{
    // version FINANCE
    Caption = 'Transaction Types';
    DataClassification = CustomerContent;
    LookupPageId = "Transaction Type";
    DrillDownPageId = "Transaction Type";
    fields
    {
        field(1; "Code"; Code[50])
        {
        }
        field(2; "Transaction Name"; Text[70])
        {
        }
        field(3; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(4; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST ("G/L Account")) "G/L Account"
            ELSE
            IF ("Account Type" = CONST (Customer)) Customer
            ELSE
            IF ("Account Type" = CONST (Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST ("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST ("Bank Account")) "Bank Account";
        }
        field(5; "Transaction Ref"; Option)
        {
            OptionMembers = " ",imprest,"Petty Cash",Both,Service,Vendor,Customer;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

