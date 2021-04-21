table 51513107 "Brackets Lines"
{
    // version PAYROLL

    //DrillDownPageID = "Casual Payment Lines";
    //LookupPageID = "Casual Payment Lines";
    Caption = 'Brackets Lines';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Tax Band"; Code[10])
        {
            Caption = 'Tax Band';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; "Table Code"; Code[10])
        {
            Caption = 'Table Code';
            DataClassification = CustomerContent;
            TableRelation = "Bracket Tables";
        }
        field(4; "Lower Limit"; Decimal)
        {
            Caption = 'Lower Limit';
            DataClassification = CustomerContent;
        }
        field(5; "Upper Limit"; Decimal)
        {
            Caption = 'Upper Limit';
            DataClassification = CustomerContent;
        }
        field(6; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = CustomerContent;
        }
        field(7; Percentage; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = CustomerContent;
        }
        field(8; "From Date"; Date)
        {
            Caption = 'From Date';
            DataClassification = CustomerContent;
        }
        field(9; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(10; "Pay period"; Date)
        {
            Caption = 'Pay period';
            DataClassification = CustomerContent;
        }
        field(11; "Taxable Amount"; Decimal)
        {
            Caption = 'Taxable Amount';
            DataClassification = CustomerContent;
        }
        field(12; "Total taxable"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total taxable';

        }
        field(13; "Factor Without Housing"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Factor Without Housing';
            DecimalPlaces = 2 :;
        }
        field(14; "Factor With Housing"; Decimal)
        {
            Caption = 'Factor With Housing';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 :;
        }
        field(15; Institution; Code[20])
        {
            Caption = 'Institution';
            DataClassification = CustomerContent;
            TableRelation = Institutions;
        }
        field(16; "Contribution Rates Inclusive"; Boolean)
        {
            Caption = 'Contribution Rates Inclusive';
            DataClassification = CustomerContent;
        }
        field(17; "Is Nhif"; Boolean)
        {
            Caption = 'Is Nhif';
            DataClassification = CustomerContent;
        }
        field(18; Deduction; Decimal)
        {
            Caption = 'Deduction';
            DataClassification = CustomerContent;
        }
        field(19; "Relief 1(Burundi)"; Decimal)
        {
            Caption = 'Relief 1(Burundi)';
            DataClassification = CustomerContent;
        }
        field(20; "Relief 2(Burundi)"; Decimal)
        {
            Caption = 'Relief 2(Burundi)';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Tax Band", "Table Code")
        {
        }
    }

    fieldgroups
    {
    }
}

