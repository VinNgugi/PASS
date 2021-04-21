table 51513215 "Disciplinary Remarks"
{
    // version HR
    Caption = 'Disciplinary Remarks';
    DataClassification = CustomerContent;
    //LookupPageID = "GS Leave Applications List";

    fields
    {
        field(1; Remark; Code[50])
        {
            NotBlank = true;
        }
        field(2; Description; Text[200])
        {
        }
        field(3; Comments; Text[200])
        {
        }
    }

    keys
    {
        key(Key1; Remark)
        {
        }
    }

    fieldgroups
    {
    }
}

