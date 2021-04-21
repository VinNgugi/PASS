table 51513700 "Employment Experience Rating"
{
    // version HR
    Caption = 'Employment Experience Rating';
    DataClassification = CustomerContent;

    fields
    {
        field(1; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Supervisor Rating"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Work Experienc Rating"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Description)
        {
        }
    }

    fieldgroups
    {
    }
}

