table 51513214 "Disciplinary Case Ratings"
{
    // version HR
    Caption = 'Disciplinary Case Ratings';
    DataClassification = CustomerContent;
    LookupPageID = "Committee Board Of Directors";

    fields
    {
        field(1; "Code"; Code[50])
        {
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
        }
        field(3; Comments; Text[200])
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

