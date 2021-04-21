table 51513216 "Disciplinary Offenses"
{
    // version HR
    Caption = 'Disciplinary Offenses';
    DataClassification = CustomerContent;
    LookupPageID = "Disciplinary Offenses";

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Rating; Code[50])
        {
            TableRelation = "Disciplinary Case Ratings".Code;
        }
        field(4; Comments; Text[200])
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

