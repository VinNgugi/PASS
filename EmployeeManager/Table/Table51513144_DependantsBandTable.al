table 51513144 "Dependants Band Table"
{
    Caption = 'Dependants Band Table';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Bands; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Country/Region Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(3; Dependants; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Percentage; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Bands)
        {
        }
    }

    fieldgroups
    {
    }
}

