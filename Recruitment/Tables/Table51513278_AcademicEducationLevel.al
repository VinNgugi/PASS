table 51513278 "Academic Education Level"
{
    DataClassification = CustomerContent;
    Caption = 'Academic Education Level';

    fields
    {
        field(1; "Level Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Level Code';

        }
        field(2; "Level Name"; Text[250])
        {
            Caption = 'Leval Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Level Code")
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