table 51513276 "Score Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Score Setup';
    LookupPageId = "Score Setup List";
    DrillDownPageId = "Score Setup List";

    fields
    {
        field(1; "Score ID"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score Id';

        }
        field(2; Score; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }
        field(3; "Qualification Category"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Qualification Category';
        }
    }

    keys
    {
        key(PK; "Score ID")
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