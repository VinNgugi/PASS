table 51513026 "SRC Cluster Places"
{
    // version FINANCE

    //DrillDownPageID = "SRC Salary-Scales Places";
    //LookupPageID = "SRC Salary-Scales Places";

    fields
    {
        field(1; "Cluster Code"; Code[50])
        {
            //TableRelation = "Leave Allowance Table"."Cluster Code";
        }
        field(2; "Cluster Place"; Code[250])
        {
        }
    }

    keys
    {
        key(Key1; "Cluster Code", "Cluster Place")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Cluster Place")
        {
        }
    }
}

