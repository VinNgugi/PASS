table 51513166 "Sharepoint Integration"
{
    Caption = 'Sharepoint Integration';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Leave,Leave1';
            OptionMembers = Leave,Leave1;
        }
        field(2; "URL Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Document Type")
        {
        }
    }

    fieldgroups
    {
    }
}

