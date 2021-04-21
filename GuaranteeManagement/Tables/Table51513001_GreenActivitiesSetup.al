table 51513001 "Green Activities Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Description; Text[50])
        {

        }
    }

    keys
    {
        key(PK; "Entry Code")
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