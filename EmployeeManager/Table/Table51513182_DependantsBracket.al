table 51513182 "Dependants Bracket"
{
    Caption = 'Dependants Bracket';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Tax Band"; Code[10])
        {
            Caption = 'Tax Band';
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(2; Description; Text[30])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(3; "Table Code"; Code[10])
        {
            Caption = 'Table Code';
            DataClassification = ToBeClassified;
            TableRelation = "Bracket Tables";
        }
        field(4; "Lower Limit"; Decimal)
        {
            Caption = 'Lower Limit';
            DataClassification = ToBeClassified;
        }
        field(5; "Upper Limit"; Decimal)
        {
            Caption = 'Upper Limit';
            DataClassification = ToBeClassified;
        }
        field(6; "No of Dependants"; Integer)
        {
            Caption = 'No of Dependants';
            DataClassification = ToBeClassified;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Tax Band", "No of Dependants", "Table Code")
        {
        }
    }

    fieldgroups
    {
    }
}

