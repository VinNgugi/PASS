table 51513158 "Additional Leave Set-Up"
{
    // version HR
    Caption = 'Additional Leave Set-Up';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Payroll posting Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Posting Group";
        }
        field(2; "Leave Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Multi- Comp Leave Types";
        }
        field(3; "Country Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(4; "Probation Leave days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Max Payback Days(Resignation)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Total Days Entitled"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Max Days without Document"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Payroll posting Group", "Leave Code")
        {
        }
    }

    fieldgroups
    {
    }
}

