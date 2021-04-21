table 51513926 Types
{
    DataClassification = ToBeClassified;
    DrillDownPageId = Types;
    LookupPageId = Types;

    fields
    {
        field(1; Code; Code[50])
        {
            DataClassification = ToBeClassified;

        }

        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; Subsector; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Subsector';
            TableRelation = Subsector;
        }
        field(4; "Business Type"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Business Type';
            TableRelation = "Line Of Business";
        }


    }

    keys
    {
        key(PK; Code, Subsector)
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