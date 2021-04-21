table 51513295 "HR Relative"
{
    DataClassification = CustomerContent;
    Caption = 'HR Relative';
    LookupPageId = "HR Relative";

    fields
    {
        field(1; Code; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            NotBlank = true;

        }
        field(2; Relationship; Text[50])
        {
            DataClassification = CustomerContent;
            caption = 'Relationship';
        }
    }

    keys
    {
        key(pk; code)
        {
            Clustered = true;
        }
    }



}