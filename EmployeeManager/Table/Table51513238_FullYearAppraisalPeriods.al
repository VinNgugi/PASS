table 51513238 "Full Year Appraisal Periods"
{
    // version HR

    //DrillDownPageID = "GS Transport Request List";
    //LookupPageID = "GS Transport Request List";
    Caption = 'Full Year Appraisal Periods';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Period; Code[30])
        {
            NotBlank = true;
        }
        field(2; Comments; Text[250])
        {
        }
        field(3; "Start Date"; Date)
        {
        }
        field(4; "End Date"; Date)
        {
        }
    }

    keys
    {
        key(Key1; Period)
        {
        }
    }

    fieldgroups
    {
    }
}

