table 51513147 "Employee Attendance Setup"
{
    Caption = 'Employee Attendance Setup';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee Type"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Payment Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Daily,Weekly,Monthly,Annualy,Per Work';
            OptionMembers = ,Daily,Weekly,Monthly,Annualy,"Per Work";
        }
        field(3; "Rate Per Hour"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Rate Per Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Rate Per Week"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Overtime Rate Per Hour"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Max Hours per Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Max Overtime Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Wages Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Earnings.Code;
        }
        field(10; "Overtime Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Earnings.Code;
        }
        field(11; "Arrears Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Earnings.Code;
        }
    }

    keys
    {
        key(Key1; "Employee Type")
        {
        }
    }

    fieldgroups
    {
    }
}

