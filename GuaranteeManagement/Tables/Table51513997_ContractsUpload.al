table 51513997 "Contracts Upload"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "COntract No"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Loan No"; Code[20])
        {

        }
        field(3; "Bank No"; Code[20])
        {

        }
    }

    keys
    {
        key(PK; "COntract No")
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