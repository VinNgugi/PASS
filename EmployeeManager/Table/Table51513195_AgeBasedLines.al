table 51513195 "Age Based Lines"
{
    Caption = 'Age Based Lines';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(2; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Age Based Calculations".No;
        }
        field(3; "Lower Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Max Limit"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Line No", "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

