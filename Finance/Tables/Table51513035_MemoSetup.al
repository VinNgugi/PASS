table 51513035 "Memo Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(2; "Memo Request Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(3; "Hotel Req Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(4; "Surrender Grace Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Unsurrendered Period"; DateFormula)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Send Trip  Email Notifocation"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Primary Key")
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