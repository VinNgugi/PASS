table 51513336 "Board Of Directors"
{
    // version HR
    Caption = 'Board Of Directors';
    DataClassification = CustomerContent;
    //LookupPageID = 51511142;

    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; SurName; Text[100])
        {
        }
        field(3; "Other Names"; Text[150])
        {
        }
        field(4; Remarks; Text[200])
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

