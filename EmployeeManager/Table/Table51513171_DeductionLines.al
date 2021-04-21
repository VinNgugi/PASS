table 51513171 "Deduction Lines"
{
    Caption = 'Deduction Lines';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Deduction; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Deductions.Code;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Transfered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

