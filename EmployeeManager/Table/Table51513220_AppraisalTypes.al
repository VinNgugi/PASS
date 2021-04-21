table 51513220 "Appraisal Types"
{
    // version HR

    //DrillDownPageID = "Employee Leave Plan Details";
    //LookupPageID = "Employee Leave Plan Details";
    Caption = 'Appraisal Types';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Description; Text[150])
        {
            NotBlank = true;
        }
        field(3; "Use Template"; Boolean)
        {
        }
        field(4; "Template Link"; Text[200])
        {
        }
        field(5; Remarks; Text[250])
        {
        }
        field(6; "Max. Weighting"; Decimal)
        {
        }
        field(7; "Max. Score"; Decimal)
        {
        }
        field(8; "Minimum Job Group"; Code[10])
        {
            TableRelation = "Salary Scales";
        }
        field(9; "Maximum Job Group"; Code[10])
        {
            TableRelation = "Salary Scales";
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

