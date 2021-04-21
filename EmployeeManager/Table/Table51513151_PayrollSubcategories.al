table 51513151 "Payroll Subcategories"
{
    Caption = 'Payroll Subcategories';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Payroll Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Posting Group".Code;
        }
        field(2; "Payroll Subcategory"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Allow Batches"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Payroll Group", "Payroll Subcategory")
        {
        }
    }

    fieldgroups
    {
    }
}

