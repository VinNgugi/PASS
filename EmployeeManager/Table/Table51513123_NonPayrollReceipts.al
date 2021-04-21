table 51513123 "Non Payroll Receipts"
{
    // version PAYROLL

    Caption = 'Non Payroll Receipts';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Loan No"; Code[20])
        {
            TableRelation = "Loan Application"."Loan No";
        }
        field(2; "Payroll Period"; Date)
        {
            NotBlank = true;
            TableRelation = "Payroll Period";
        }
        field(3; "Received From"; Text[40])
        {
        }
        field(4; "Cheque No"; Code[20])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; "Reference No"; Code[20])
        {
        }
        field(7; Repayment; Decimal)
        {
        }
        field(8; Installments; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Loan No", "Payroll Period")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }
}

