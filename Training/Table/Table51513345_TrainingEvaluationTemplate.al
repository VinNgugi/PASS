table 51513345 "Training Evaluation Template"
{
    // version HR


    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Evaluation Area"; Code[50])
        {

        }
        field(3; Question; Text[250])
        {
        }
        field(4; Bold; Boolean)
        {
        }
        field(5; "Answer Type"; Option)
        {
            OptionMembers = " ",Selection,Narrative;
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

