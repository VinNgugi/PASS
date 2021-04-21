table 51513007 "Mobile Devices"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Name; Text[50])
        {

        }
        field(3; IMEI; Code[50])
        {

        }
        field(4; Comments; Text[50])
        {

        }
        field(5; "Date Entered"; date)
        {

        }
        field(6; "Time Entered"; Time)
        {

        }
        field(7; "User ID"; Code[20])
        {

        }
        field(8; Blocked; Boolean)
        {

        }
        field(9; "Date Blocked"; Date)
        {

        }
        field(10; "Blocked By"; Code[20])
        {

        }
    }

    keys
    {
        key(PK; "No.")
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