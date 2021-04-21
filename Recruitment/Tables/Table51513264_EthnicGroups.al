table 51513264 "Ethnic Groups"
{
    Caption = 'Ethnic Groups';
    DataClassification = CustomerContent;
    LookupPageId = "Ethnic Groups List";
    DrillDownPageId = "Ethnic Groups List";

    fields
    {
        field(1; Code; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';

        }
        field(2; Description; text[50])
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

    var
        myInt: Integer;

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