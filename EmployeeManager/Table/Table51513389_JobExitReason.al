table 51513389 "Job Exit Reason"
{
    // version HR

    //DrillDownPageID = "Job Exit Reason List";
    //LookupPageID = "Job Exit Reason List";
    Caption = 'Job Exit Reason';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Reason; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; Reason)
        {
        }
    }

    fieldgroups
    {
    }
}

