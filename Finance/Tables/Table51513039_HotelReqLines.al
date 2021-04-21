table 51513039 "Hotel Request Lines"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "Header No.")
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