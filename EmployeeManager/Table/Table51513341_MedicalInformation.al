table 51513341 "Medical Information"
{
    // version HR
    Caption = 'Medical Information';
    DataClassification = CustomerContent;
    DrillDownPageID = "Medical Claim Header";
    LookupPageID = "Medical Claim Header";

    fields
    {
        field(1; Description; Code[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(2; Remarks; Text[200])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
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

