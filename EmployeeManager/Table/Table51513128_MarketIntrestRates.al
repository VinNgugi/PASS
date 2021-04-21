table 51513128 "Market Intrest Rates"
{
    // version PAYROLL

    Caption = 'Market Intrest Rates';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Loan Code"; Code[20])
        {
        }
        field(2; "Start Date"; Date)
        {
        }
        field(3; "End Date"; Date)
        {
        }
        field(4; Intrest; Decimal)
        {
        }
        field(5; "Tax Percentage"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Loan Code", "Start Date", "End Date")
        {
        }
    }

    fieldgroups
    {
    }
}

