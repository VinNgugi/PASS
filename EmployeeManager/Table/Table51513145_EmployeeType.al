table 51513145 "Employee Type"
{
    Caption = 'Employee Type';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Salary Scale Filter"; Text[30])
        {
            Caption = 'Salary Scale Filter';
            DataClassification = CustomerContent;
        }
        field(4; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group';
            DataClassification = CustomerContent;
            TableRelation = "Staff Posting Group".Code;
        }
        field(5; "Lower Grade"; Code[10])
        {
            Caption = 'Lower Grade';
            DataClassification = CustomerContent;
        }
        field(6; "Upper Grade"; Code[10])
        {
            Caption = 'Upper Grade';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Code", "Posting Group")
        {
        }
    }

    fieldgroups
    {
    }
}

