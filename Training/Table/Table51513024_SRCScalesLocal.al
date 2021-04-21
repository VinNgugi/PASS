table 51513024 "SRC Scales Local"
{
    // version FINANCE

    Caption = 'SRC Scales Local';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Salary Scale"; Code[20])
        {
            TableRelation = "Salary Scales";
        }
        field(2; "SRC Cluster"; Code[50])
        {
            //TableRelation = "Leave Allowance Table";
        }
        field(3; Amount; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Salary Scale", "SRC Cluster")
        {
        }
    }

    fieldgroups
    {
    }
}

