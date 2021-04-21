table 51513903 "Shortlisting Criterion"
{
    DataClassification = CustomerContent;
    Caption = 'Shortlisting Criterion';
    LookupPageId = "Shortlisting Criterion";
    DrillDownPageId = "Shortlisting Criterion";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';

        }
        field(2; "Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }



    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}