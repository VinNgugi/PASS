table 51513139 "Overtime Excel"
{
    // version PAYROLL
    Caption = 'Overtime Excel';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                if Empl.GET("Employee No") then
                    "Employee Name" := Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
            end;
        }
        field(2; "Employee Name"; Text[120])
        {
        }
        field(3; "Hours Normal"; Decimal)
        {
        }
        field(4; "Hours Double"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Empl: Record Employee;
}

