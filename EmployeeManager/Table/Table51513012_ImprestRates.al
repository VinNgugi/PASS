table 51513012 "Imprest Rates"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Imprest Rates";
    LookupPageId = "Imprest Rates";

    fields
    {
        field(1; "Imprest Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Description"; Text[50])
        {

        }
        field(3; Amount; Decimal)
        {

        }
    }

    keys
    {
        key(PK; "Imprest Code")
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