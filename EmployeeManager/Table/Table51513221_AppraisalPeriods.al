table 51513221 "Appraisal Periods"
{
    // version HR

    //DrillDownPageID = "GS Transport Request List";
    //LookupPageID = "GS Transport Request List";
    Caption = 'Appraisal Periods';
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
        field(5; "Payroll Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Posting Group".Code;
        }
    }

    keys
    {
        key(Key1; Period, "Payroll Group")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Period, "Start Date", "End Date")
        {
        }
    }
}

