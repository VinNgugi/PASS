table 51513804 "Enterprenuership Test"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Test Code"; code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Test Question"; Text[1000])
        {

        }
        field(3; "Answer Prefix"; Text[1000])
        {

        }

    }

    keys
    {
        key(PK; "Test Code")
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