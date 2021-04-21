table 51513134 "Effected Basic Salary Incre"
{
    // version PAYROLL

    Caption = 'Effected Basic Salary Incre';
    DataClassification = CustomerContent;
    fields
    {
        field(1; Period; Date)
        {
        }
        field(2; "Initial Basic Salary"; Decimal)
        {
        }
        field(3; "Increased by Amount"; Decimal)
        {
        }
        field(4; "New Basic Salary"; Decimal)
        {
        }
        field(5; Date; Date)
        {
        }
        field(6; Time; Time)
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

