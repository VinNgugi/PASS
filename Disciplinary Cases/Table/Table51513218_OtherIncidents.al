table 51513218 "Other Incidents"
{
    // version HR

    Caption = 'Other Incidents';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = true;
            TableRelation = Employee."No.";
        }
        field(2; "Incident Date"; Date)
        {
            NotBlank = true;
        }
        field(3; Incident; Text[200])
        {
            NotBlank = true;
        }
        field(4; Comments; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No", "Incident Date", Incident)
        {
        }
    }

    fieldgroups
    {
    }
}

