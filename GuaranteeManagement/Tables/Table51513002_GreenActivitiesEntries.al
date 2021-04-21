table 51513002 "Green Activities Entries"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Contract No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;


        }
        field(2; "Entry Code"; Code[20])
        {
            Editable = false;

        }
        field(3; Description; Text[50])
        {
            Editable = false;
        }
        field(4; Checkbox; Boolean)
        {

        }
    }

    keys
    {
        key(PK; "Contract No.", "Entry Code")
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