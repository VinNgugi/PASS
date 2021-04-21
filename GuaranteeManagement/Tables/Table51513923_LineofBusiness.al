table 51513923 "Line Of Business"
{
    DataClassification = CustomerContent;
    Caption = 'Line of Business';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';

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