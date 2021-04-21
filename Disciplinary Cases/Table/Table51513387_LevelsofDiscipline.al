table 51513387 "Levels of Discipline"
{
    // version HR

    Caption = 'Levels of Discipline';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Level; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Level)
        {
        }
    }

    fieldgroups
    {
    }
}

