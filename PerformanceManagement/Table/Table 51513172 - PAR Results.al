table 51513172 "PAR Results"
{
    Caption = 'PAR Results';
    fields
    {
        field(1; "Appraisal Period"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Rating; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Dimension; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Appeal Status"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Salary Updated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Appraisal Period", "Employee No")
        {
        }
    }

    fieldgroups
    {
    }
}

