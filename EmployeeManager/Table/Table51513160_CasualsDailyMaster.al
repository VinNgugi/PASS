table 51513160 "Casuals Daily Master"
{
    Caption = 'Casuals Daily Master';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Department; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Date Time In"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Date Time out"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Hours worked"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Working Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
        }
    }

    fieldgroups
    {
    }
}

