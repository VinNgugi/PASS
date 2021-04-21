table 51513251 "Job Responsibilities Lines"
{
    // version HR
    Caption = 'Job Responsibilities Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[50])
        {
            NotBlank = true;
        }
        field(2; Responsibility; Text[250])
        {
            NotBlank = true;
        }
        field(3; Date; Date)
        {
        }
        field(4; Remarks; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", Responsibility, Date)
        {
        }
    }

    fieldgroups
    {
    }
}

