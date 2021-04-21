table 51513807 "Business Performance"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Item; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Sales,Expences,"Gross Profit";

        }
        field(2; "Application No"; Code[20])
        {

        }
        field(3; "Before Last Year"; Decimal)
        {

        }
        field(4; "Last Year"; Decimal)
        {

        }
        field(5; "This Year"; Decimal)
        {

        }
        field(6; "Next Year"; Decimal)
        {

        }
    }

    keys
    {
        key(PK; Item, "Application No")
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