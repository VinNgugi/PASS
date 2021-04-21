table 51515453 "Training Classification"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Type"; Option)
        {
            OptionMembers = local,International;
        }
        field(3; "Account No"; Code[20])
        {
            TableRelation = "G/L Account"."No." where ("Account Category" = filter (Expense));
        }
    }

    keys
    {
        key(PK; "Code.")
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