table 51513127 "House Allowance Matrix"
{
    // version PAYROLL

    Caption = 'House Allowance Matrix';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Salary Scale"; Code[10])
        {
            TableRelation = "Salary Scales".Scale;
        }
        field(2; Station; Code[30])
        {
            TableRelation = "Dimension Value".Code;
        }
        field(3; "House Allowance"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Salary Scale", Station)
        {
        }
    }

    fieldgroups
    {
    }
}

