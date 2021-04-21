table 51513181 "Casuals Payment Lines"
{
    Caption = 'Casuals Payment Lines';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "Employee No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                if Emp.GET("Employee No") then begin
                    Name := Emp."Last Name" + ', ' + Emp."First Name" + ' ' + Emp."Middle Name";
                end;
            end;
        }
        field(4; Name; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Calculated Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Actual Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Overtime Hours"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(8; Arrears; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Code", "Line No")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Emp: Record Employee;
}

