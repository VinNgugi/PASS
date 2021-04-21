table 51513956 "Payments Received Buffer"
{
    Caption = 'Payments Received Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Bank Ref"; Code[20])
        {
            Caption = 'Bank Ref';
            DataClassification = ToBeClassified;
        }
        field(2; "Payment Ref"; Code[20])
        {
            Caption = 'Payment Ref';
            DataClassification = ToBeClassified;
        }
        field(3; "Biller Ref"; Code[20])
        {
            Caption = 'Biller Ref';
            DataClassification = ToBeClassified;
        }
        field(4; "Transaction Date"; Date)
        {
            Caption = 'Transaction Date';
            DataClassification = ToBeClassified;
        }
        field(5; "Transaction Description"; Text[200])
        {
            Caption = 'Transaction Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Transacted Amount"; Decimal)
        {
            Caption = 'Transacted Amount';
            DataClassification = ToBeClassified;
        }
        field(7; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            DataClassification = ToBeClassified;
        }
        field(8; "Payment Channel"; Code[20])
        {
            Caption = 'Payment Channel';
            DataClassification = ToBeClassified;
        }
        field(9; "Transaction Status"; Code[20])
        {
            Caption = 'Transaction Status';
            DataClassification = ToBeClassified;
        }
        field(10; Posted; Boolean)
        {
            Caption = 'Posted';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Bank Ref")
        {
            Clustered = true;
        }
    }

}
