table 51513217 "Disciplinary Actions"
{
    // version HR
    Caption = 'Disciplinary Actions';
    DataClassification = CustomerContent;
    LookupPageID = "Disciplinary Actions";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Terminate; Boolean)
        {
        }
        field(4; Document; Text[100])
        {
        }
        field(5; Comments; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

