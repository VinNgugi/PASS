table 51513542 "User Batch Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "User Name"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";

        }
        field(2; "Payment Voucher Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Template Type" = filter (Payments));
        }
        field(3; "Petty Cash Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Template Type" = filter (Payments));
        }
        field(4; "Imprest/Surrender Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Template Type" = filter (Payments));
        }
    }

    keys
    {
        key(PK; "User Name")
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