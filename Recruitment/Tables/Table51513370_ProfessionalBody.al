table 51513370 "Professional Body"
{
    DataClassification = CustomerContent;
    Caption = 'Professional Body';
    DrillDownPageId = "Professional Bodies";
    LookupPageId = "Professional Bodies";

    fields
    {
        field(1; Code; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Professional Body';

        }
        field(2; Description; text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "No Of Members"; Integer)
        {
            DataClassification = customercontent;
            Caption = 'No Of Members';
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