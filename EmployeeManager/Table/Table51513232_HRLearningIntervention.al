table 51513232 "HR Learning Intervention"
{
    // version HR

    //LookupPageID = 52091;
    Caption = 'HR Learning Intervention';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No."; Code[20])
        {

            trigger OnValidate();
            begin
                /*    OK:= Employee.GET("Employee No.");
                    IF OK THEN BEGIN
                     "Employee First Name":= Employee."Known As";
                     "Employee Last Name":= Employee."Last Name";
                    END;
                    */

            end;
        }
        field(2; EduTC; Decimal)
        {

            trigger OnValidate();
            begin
                TotalTC := EduTC + TrainTC;
                //CALCSUMS(EduAC);
                EduVar := EduTC - EduAC;
                //CALCSUMS(TrainAC);
                TrainVar := TrainTC - TrainAC;
                TotalVar := TotalTC - TotalAC;
            end;
        }
        field(3; EduAC; Decimal)
        {
            FieldClass = Normal;
        }
        field(4; EduVar; Decimal)
        {
        }
        field(5; TrainTC; Decimal)
        {

            trigger OnValidate();
            begin
                //CALCSUMS(EduAC);
                //CALCSUMS(TrainAC);
                TotalTC := EduTC + TrainTC;
                EduVar := EduTC - EduAC;
                TrainVar := TrainTC - TrainAC;
                TotalVar := TotalTC - TotalAC;
            end;
        }
        field(6; TrainAC; Decimal)
        {
            FieldClass = Normal;
        }
        field(7; TrainVar; Decimal)
        {
        }
        field(8; TotalTC; Decimal)
        {

            trigger OnValidate();
            begin
                TotalTC := EduTC + TrainTC;
            end;
        }
        field(9; TotalAC; Decimal)
        {
        }
        field(10; TotalVar; Decimal)
        {
        }
        field(11; Budget; Decimal)
        {

            trigger OnValidate();
            begin
                Remaining := Budget - Used;
                //CALCSUMS(EduAC);
                EduVar := EduTC - EduAC;
                //CALCSUMS(TrainAC);
                TrainVar := TrainTC - TrainAC;
                TotalVar := TotalTC - TotalAC;
            end;
        }
        field(12; Used; Decimal)
        {
            FieldClass = Normal;

            trigger OnValidate();
            begin
                Remaining := Budget - Used;
                TrainVar := TrainTC - TrainAC;
                TotalVar := TotalTC - TotalAC;
            end;
        }
        field(13; Remaining; Decimal)
        {

            trigger OnValidate();
            begin
                Remaining := Budget - Used;
                TrainVar := TrainTC - TrainAC;
                TotalVar := TotalTC - TotalAC;
            end;
        }
        field(14; "Calendar Year"; Integer)
        {
            FieldClass = Normal;
        }
        field(15; "Employee First Name"; Text[30])
        {
            FieldClass = Normal;
        }
        field(16; "Employee Last Name"; Text[30])
        {
        }
        field(17; "A Development Plan Costs Used"; Decimal)
        {
        }
        field(18; "Development Plan Costs Total"; Decimal)
        {
        }
        field(19; "E Development Plan Costs Used"; Decimal)
        {
            FieldClass = Normal;
        }
        field(20; "Used In Education Assistance"; Decimal)
        {
            //CalcFormula = Sum(Table69150.Field73 WHERE (Field74=FIELD("Calendar Year")));
            FieldClass = FlowField;
        }
        field(21; Comment; Boolean)
        {
            Editable = false;
        }
        field(22; "Other Training Costs"; Decimal)
        {
            //CalcFormula = Sum(Table69123.Field7 WHERE (Field25=FIELD("Calendar Year")));
            FieldClass = FlowField;
        }
        field(23; "Line No"; Integer)
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Calendar Year", "Line No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        /*   OK:= Employee.GET("Employee No.");
           IF OK THEN BEGIN
            "Employee First Name":= Employee."Known As";
            "Employee Last Name":= Employee."Last Name";
           END;
           "Calendar Year":= DATE2DMY(WORKDATE,3);
           */

    end;

    var
        OK: Boolean;
        Employee: Record Employee;
        eVal: Boolean;
        tVal: Boolean;
}

