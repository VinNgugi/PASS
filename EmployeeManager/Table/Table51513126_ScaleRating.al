table 51513126 "Scale Rating"
{
    // version PAYROLL
    Caption = 'Scale Rating';
    DataClassification = CustomerContent;
    //DrillDownPageID = 51511886;
    // LookupPageID = 51511886;

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; Descritption; Text[100])
        {
        }
        field(3; Rate; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

