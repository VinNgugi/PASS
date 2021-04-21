table 51513293 "Appointment Checklist"
{
    // version HR
    Caption = 'Appointment Checklist';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No."; Code[20])
        {
            NotBlank = true;

            trigger OnValidate();
            begin
                OK := Employee.GET("Employee No.");
                if OK then begin
                    "Employee First Name" := Employee."First Name";
                    "Employee Last Name" := Employee."Last Name";
                end;
            end;
        }
        field(3; Item; Text[100])
        {
        }
        field(4; Date; Date)
        {
        }
        field(5; Signed; Boolean)
        {
        }
        field(6; "Employee First Name"; Text[30])
        {
        }
        field(7; "Employee Last Name"; Text[30])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", Item)
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        OK := Employee.GET("Employee No.");
        if OK then begin
            "Employee First Name" := Employee."First Name";
            "Employee Last Name" := Employee."Last Name";
        end;
    end;

    var
        Employee: Record Employee;
        OK: Boolean;
}

