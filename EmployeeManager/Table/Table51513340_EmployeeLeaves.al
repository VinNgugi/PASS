table 51513340 "Employee Leaves"
{
    // version HR

    //LookupPageID = "Appraiser and Appraisee Narrat";
    Caption = 'Employee Leaves';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Employee."No.";
        }
        field(2; "Leave Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Leave Types".Code;

            trigger OnValidate();
            begin
                //Brian Kibet-Tying Start Date & End Date to Fiscal Year instead of Actual Year
                GLSETUP.RESET;
                GLSETUP.GET;
                GLSETUP.TESTFIELD("Current Budget");
                GLBudgets.RESET;
                GLBudgets.GET(GLSETUP."Current Budget");
                GLBudgets.TESTFIELD("Start Date");
                GLBudgets.TESTFIELD("End Date");
                StartDate := GLBudgets."Start Date";
                "Maturity Date" := GLBudgets."End Date";
                //===================================================
                /*
                Period.RESET;
                Period.SETRANGE(Period."New Fiscal Year",TRUE);
                Period.SETRANGE(Period.Closed,FALSE);
                IF Period.FIND('-') THEN
                   StartDate:=CALCDATE('1Y',Period."Starting Date")-1 ; //ERROR('%1',StartDate);
                */
                "Leave Types".RESET;
                "Leave Types".SETRANGE("Leave Types".Code, "Leave Code");
                if "Leave Types".FIND('-') then begin
                    //ERROR('%1',"Leave Types".Days);
                    if "Leave Types".Gender <> "Leave Types".Gender::Both then begin
                        EmployeeRec.RESET;
                        EmployeeRec.SETRANGE(EmployeeRec."No.", "Employee No");
                        if "Leave Types".Gender = "Leave Types".Gender::Female then begin
                            if EmployeeRec.Gender <> EmployeeRec.Gender::Female then begin
                                "Leave Code" := '';
                                Balance := 0;
                                ERROR('%1', 'You cannot assign this employee this leave.');
                            end;
                        end
                        else
                            Balance := "Leave Types".Days;
                    end
                    else
                        Balance := "Leave Types".Days;
                    Entitlement := "Leave Types".Days;
                end;

                Balance := "Leave Types".Days;

                Balance := Entitlement + "Balance Brought Forward" + "Recalled Days" - "Total Days Taken";

                if EmployeeRec.GET("Employee No") then begin
                    // Entitlement:=(StartDate-EmployeeRec."Date Of Join")/30*2.5;
                end;

            end;
        }
        field(3; "Maturity Date"; Date)
        {
        }
        field(4; Balance; Decimal)
        {
        }
        field(5; "Acrued Days"; Decimal)
        {
        }
        field(6; "Total Days Taken"; Decimal)
        {
            CalcFormula = Sum ("Employee Leave Application"."Days Applied" WHERE ("Employee No" = FIELD ("Employee No"),
                                                                                 "Leave Code" = FIELD ("Leave Code"),
                                                                                 "Maturity Date" = FIELD ("Maturity Date"),
                                                                                 Status = CONST (Approved)));
            FieldClass = FlowField;
        }
        field(7; Entitlement; Decimal)
        {
        }
        field(8; "Balance Brought Forward"; Decimal)
        {
        }
        field(9; "Recalled Days"; Decimal)
        {
            CalcFormula = Sum ("Leave Recall"."No. of Off Days" WHERE ("Employee No" = FIELD ("Employee No"),
                                                                      "Maturity Date" = FIELD ("Maturity Date")));
            FieldClass = FlowField;
        }
        field(10; "Days Absent"; Decimal)
        {
            CalcFormula = Sum ("Employee Absentism"."No. of  Days Absent" WHERE ("Employee No" = FIELD ("Employee No"),
                                                                                "Maturity Date" = FIELD ("Maturity Date")));
            FieldClass = FlowField;
        }
        field(11; "Leaves Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(12; "Temp. Emp. Contract"; Integer)
        {
        }
        field(13; "Contract No."; Integer)
        {
        }
        field(14; "Leave  Allowance Paid"; Boolean)
        {
        }
        field(15; Department; Code[20])
        {
            CalcFormula = Lookup (Employee."Global Dimension 1 Code" WHERE ("No." = FIELD ("Employee No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Employee No", "Leave Code", "Maturity Date")
        {
        }
    }

    fieldgroups
    {
    }

    var
        "Leave Types": Record "Leave Types";
        EmployeeRec: Record Employee;
        Period: Record "Payroll Period";
        StartDate: Date;
        GLSETUP: Record "General Ledger Setup";
        GLBudgets: Record "G/L Budget Name";
}

