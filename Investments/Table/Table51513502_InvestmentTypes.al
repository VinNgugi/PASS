table 51513502 "Investment Types"
{
    DataClassification = CustomerContent;
    DrillDownPageId = "Investment Types";
    LookupPageId = "Investment Types";
    Caption = 'Investment Types';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';

        }
        field(2; Name; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
        }
        field(3; "Interest Receivable Account"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Account" where ("Account Category" = filter (Assets));
        }
        field(4; "Interest Income Account"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "G/L Account" where ("Account Category" = filter (Income));
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