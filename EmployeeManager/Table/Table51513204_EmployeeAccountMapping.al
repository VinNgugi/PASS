table 51513204 "Employee Account Mapping"
{
    // version HR

    Caption = 'Employee Account Mapping';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No."; Code[20])
        {
            TableRelation = Employee;
        }
        field(2; "Loan Type"; Code[10])
        {
            TableRelation = "Loan Product Type".Code;
        }
        field(3; "Customer A/c"; Code[20])
        {
            TableRelation = Customer;
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Loan Type")
        {
        }
    }

    fieldgroups
    {
    }
}

