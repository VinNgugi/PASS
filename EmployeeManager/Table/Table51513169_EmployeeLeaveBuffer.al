table 51513169 "Leave Balance Buffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Leave Code"; Code[20])
        {

        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
        }
        field(4; Balance; Decimal)
        {

        }
        field(5; "Days taken"; Decimal)
        {

        }
        field(6; Entitlement; Decimal)
        {

        }
        field(7; "Recalled Days"; Decimal)
        {

        }
        field(8; "Days Credited Back"; Decimal)
        {

        }
        field(9; "Balance Brought Forward"; Decimal)
        {

        }
    }

    keys
    {
        key(PK; "Employee No.", "Leave Code")
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