table 51513140 "Workdone Lines"
{
    // version PAYROLL
    Caption = 'Workdone Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
        }
        field(2; "Payroll Period"; Date)
        {
        }
        field(3; "Employee No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                if Emp.GET("Employee No") then
                    "Employee Name" := Emp."Last Name" + ', ' + Emp."First Name" + ' ' + Emp."Middle Name";
            end;
        }
        field(4; "Employee Name"; Text[130])
        {
        }
        field(5; Amount; Decimal)
        {
        }
        field(6; Paid; Boolean)
        {
        }
        field(7; Arrears; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Payroll Period", "Employee No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Emp: Record Employee;
}

