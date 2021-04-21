table 51513230 "Key Performance Areas"
{
    // version HR

    //LookupPageID = "Applicants List";

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = true;
        }
        field(2; Period; Code[20])
        {
            NotBlank = true;
        }
        field(3; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(4; Description; Text[200])
        {
        }
        field(5; Self; Code[20])
        {
            TableRelation = "Appraisal Grades";
        }
        field(6; Reviewer; Code[20])
        {
            TableRelation = "Appraisal Grades";
        }
        field(7; Comments; Text[250])
        {
        }
        field(8; "KPA Entry No"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Employee No", Period, "Code")
        {
        }
    }

    fieldgroups
    {
    }

    procedure GetKPACode() GetKPACode: Code[20];
    begin
        GetKPACode := Code;
    end;
}

