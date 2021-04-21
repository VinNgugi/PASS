table 51513540 "Foreign Destination"
{
    DrillDownPageID = "Foreign Destination";
    LookupPageID = "Foreign Destination";

    fields
    {
        field(1; "Destination Code"; Code[30])
        {
        }
        field(2; "Destination Name"; Text[30])
        {
        }
        field(3; "Job Grade"; Code[10])
        {
        }
        field(4; Amount; Decimal)
        {
        }
        field(5; Country; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Destination Code", "Job Grade")
        {
        }
    }

    fieldgroups
    {
    }
}

