table 51513808 "Services Types"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Service No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Service Name"; Text[100])
        {

        }
    }

    keys
    {
        key(PK; "Service No")
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