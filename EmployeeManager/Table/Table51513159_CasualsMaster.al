table 51513159 "Casuals Master"
{
    Caption = 'Casuals Master';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Expected Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "ID Num"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; Department; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Company; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }
}

