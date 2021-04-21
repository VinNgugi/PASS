table 51513030 "Pay Modes"
{
    // version FINANCE

    Caption = 'Pay Modes';
    DataClassification = CustomerContent;
    DrillDownPageId = "Pay Modes";
    LookupPageId = "Pay Modes";
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Account Affected"; Option)
        {
            Caption = 'Account Affected';
            OptionMembers = Cashier,Predefined,Postdefined;
            DataClassification = CustomerContent;
        }
        field(4; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
            DataClassification = CustomerContent;
        }
        field(5; "Account No."; Code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
            TableRelation = IF ("Account Type" = CONST ("G/L Account")) "G/L Account"

            ELSE
            IF ("Account Type" = CONST (Customer)) Customer
            ELSE
            IF ("Account Type" = CONST (Vendor)) Vendor
            ELSE
            IF ("Account Type" = CONST ("Bank Account")) "Bank Account"
            ELSE
            IF ("Account Type" = CONST ("Fixed Asset")) "Fixed Asset"
            ELSE
            IF ("Account Type" = CONST ("IC Partner")) "IC Partner";

            trigger OnValidate();
            begin
                if "Account Type" in ["Account Type"::Customer, "Account Type"::Vendor, "Account Type"::"IC Partner"] then
                    case "Account Type" of
                        "Account Type"::"G/L Account":
                            begin
                                GLAcc.GET("Account No.");
                                //"Account Name":=GLAcc.Name;
                            end;
                        "Account Type"::Customer:
                            begin
                                Cust.GET("Account No.");
                                //"Account Name":=Cust.Name;
                            end;
                        "Account Type"::Vendor:
                            begin
                                Vend.GET("Account No.");
                                //"Account Name":=Vend.Name;
                            end;
                        "Account Type"::"Bank Account":
                            begin
                                BankAcc.GET("Account No.");
                                //"Account Name":=BankAcc.Name;
                            end;
                        "Account Type"::"Fixed Asset":
                            begin
                                FA.GET("Account No.");
                                //"Account Name":=FA.Description;
                            end;
                    end;
            end;
        }
        field(6; Electronic; Boolean)
        {
            Caption = 'Electronic';
            DataClassification = CustomerContent;
        }
        field(7; "Print Receipt"; Boolean)
        {
            Caption = 'Print Receipt';
            DataClassification = CustomerContent;
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

    var
        GLAcc: Record "G/L Account";
        Cust: Record Customer;
        Vend: Record Vendor;
        FA: Record "Fixed Asset";
        BankAcc: Record "Bank Account";
}

