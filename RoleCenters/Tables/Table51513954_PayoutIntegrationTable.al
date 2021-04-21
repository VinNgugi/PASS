table 51513954 "Bank Payout Integration"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Payment No."; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Payment Date"; date)
        {

        }
        field(3; Name; text[100])
        {

        }
        field(4; "Bank Account No"; code[20])
        {

        }
        field(5; "Bank"; text[20])
        {

        }
        field(6; Branch; text[20])
        {

        }
        field(7; Description; Text[100])
        {

        }
        field(8; "Currency Code"; Code[20])
        {

        }
        field(9; Amount; Decimal)
        {

        }
    }

    keys
    {
        key(PK; "Payment No.")
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