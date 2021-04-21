table 51513154 "Tax Relief Table"
{
    Caption = 'Tax Relief Table';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Relif Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Relief Description"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Country/Region Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(Key1; "Relif Code")
        {
        }
    }

    fieldgroups
    {
    }
}

