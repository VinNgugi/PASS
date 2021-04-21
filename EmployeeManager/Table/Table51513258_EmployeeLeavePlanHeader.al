table 51513258 "Employee Leave Plan Header"
{
    // version HR

    //DrillDownPageID = "Recruitment Needs";
    //LookupPageID = "Recruitment Needs";
    Caption = 'Employee Leave Plan Header';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No"; Code[30])
        {
            TableRelation = Employee;
        }
        field(2; "Employee Name"; Text[40])
        {
            Editable = false;
        }
        field(3; "Leave Code"; Code[20])
        {
            TableRelation = "Leave Types" WHERE ("Annual Leave" = CONST (true));

            trigger OnValidate();
            begin
                LeaveTypes.RESET;
                if LeaveTypes.GET("Leave Code") then begin
                    if LeaveTypes.Gender = LeaveTypes.Gender::Female then
                        if emp.Gender = emp.Gender::Male then
                            ERROR('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);

                    if LeaveTypes.Gender = LeaveTypes.Gender::Male then
                        if emp.Gender = emp.Gender::Female then
                            ERROR('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);
                    /*
                    CALCFIELDS("Total Leave Days Taken","Recalled Days","Off Days");
                    "Leave balance":="Leave Entitlment"+"Recalled Days"+"Off Days"-"Total Leave Days Taken";
                    IF "Days Applied">"Leave balance" THEN
                    ERROR('The days applied for are more than your leave balance');

                   END;

                   IF EmpLeave.GET("Employee No","Leave Code","Maturity Date") THEN
                   BEGIN
                   IF "Leave Earned to Date"=0 THEN
                   "Leave Entitlment":=EmpLeave.Entitlement+EmpLeave."Balance Brought Forward"
                   ELSE
                   "Leave Entitlment":="Leave Earned to Date";

                    CALCFIELDS("Total Leave Days Taken","Recalled Days","Off Days");
                    "Leave balance":="Leave Entitlment"+"Recalled Days"+"Off Days"-"Total Leave Days Taken";
                    IF "Days Applied">"Leave balance" THEN
                    ERROR('The days applied for are more than your leave balance');

                   END;
                    */

                    if "Date Of Joining Company" < "Fiscal Start Date" then begin

                        "Leave Entitlement" := LeaveTypes.Days;
                        // MESSAGE('Yearly ent. %1',LeaveTypes.Days);

                    end
                    else

                        if "Date Of Joining Company" > "Fiscal Start Date" then begin

                            if "Date Of Joining Company" <> 0D then begin
                                NoofMonthsWorked := 0;
                                Nextmonth := "Date Of Joining Company";
                                repeat
                                    Nextmonth := CALCDATE('1M', Nextmonth);
                                    NoofMonthsWorked := NoofMonthsWorked + 1;
                                until Nextmonth >= TODAY;
                                NoofMonthsWorked := NoofMonthsWorked - 1;
                                //"No. of Months Worked":=NoofMonthsWorked;

                                if LeaveTypes.GET("Leave Code") then
                                    "Leave Earned to Date" := ROUND(((LeaveTypes.Days / 12) * NoofMonthsWorked), 1);
                                "Leave Entitlement" := "Leave Earned to Date";
                                //MESSAGE('Leave earned ent. %1',"Leave Earned to Date");

                                //VALIDATE("Leave Code");
                            end;
                        end;

                end;


                /*
                IF EmpLeave.GET("Employee No","Leave Code","Maturity Date") THEN
                BEGIN
                EmpLeave.CALCFIELDS(EmpLeave."Total Days Taken","Recalled Days","Days Absent","Days Absent");
                "Leave Entitlement":=EmpLeave.Entitlement;
                "Leave Balance":=(EmpLeave."Balance Brought Forward"+"Leave Entitlement"+EmpLeave."Recalled Days")-(EmpLeave."Total Days Taken"+EmpLeave."Days Absent");
                END;
                */

            end;
        }
        field(4; "Leave Balance"; Decimal)
        {
        }
        field(7; "Fiscal Start Date"; Date)
        {
        }
        field(8; "Maturity Date"; Date)
        {
        }
        field(10; "User ID"; Code[80])
        {
        }
        field(11; "Department Code"; Code[50])
        {
            Editable = false;
        }
        field(12; "Leave Entitlement"; Decimal)
        {
        }
        field(13; "Date Of Joining Company"; Date)
        {
            Editable = false;
        }
        field(14; "Application Date"; Date)
        {
        }
        field(15; "Application No"; Code[30])
        {
            Editable = false;
        }
        field(16; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected;
        }
        field(17; "No. series"; Code[20])
        {
        }
        field(18; "Days in Plan"; Decimal)
        {
            CalcFormula = Sum ("Employee Leave Plan"."Days Applied" WHERE ("Application No" = FIELD ("Application No"),
                                                                          "Employee No" = FIELD ("Employee No")));
            FieldClass = FlowField;
        }
        field(19; "Leave Earned to Date"; Decimal)
        {
        }
        field(20; "Contract Type"; Code[20])
        {
        }
        field(21; Designation; Code[50])
        {
        }
        field(22; "Recalled Days"; Decimal)
        {
        }
        field(23; "Off Days"; Decimal)
        {
        }
        field(24; "Total Leave Days"; Decimal)
        {
        }
        field(25; "Directorate Code"; Code[30])
        {
        }
        field(26; "Department Name"; Text[50])
        {
        }
        field(27; "Directorate Name"; Text[50])
        {
        }
        field(28; "No. of Approvals"; Integer)
        {
            CalcFormula = Count ("Approval Entry" WHERE ("Table ID" = CONST (51511194),
                                                        "Document No." = FIELD ("Application No")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Application No", "Maturity Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        if Status <> Status::Open then
            ERROR('You cannot delete a document that is already approved or pending approval');
    end;

    trigger OnInsert();
    begin

        if "Application No" = '' then begin
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Leave Plan Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Leave Plan Nos", xRec."No. series", 0D, "Application No", "No. series");
        end;


        "Application Date" := TODAY;
        FindMaturityDate;
        "Maturity Date" := MaturityDate;
        "Fiscal Start Date" := FiscalStart;

        if UserSetup.GET(USERID) then begin
            "Employee No" := UserSetup."Employee No.";
            VALIDATE("Employee No");
            "User ID" := USERID;
        end;


        if emp.GET("Employee No") then begin
            "Employee Name" := FORMAT(emp.Title) + ' ' + emp."First Name" + ' ' + emp."Middle Name" + '' + emp."Last Name";
            "Date Of Joining Company" := emp."Date Of Join";
            "Department Code" := emp."Global Dimension 2 Code";

            DimVal.RESET;
            DimVal.SETRANGE("Global Dimension No.", 2);
            DimVal.SETRANGE(Code, "Department Code");
            if DimVal.FINDLAST then
                "Department Name" := DimVal.Name;

            "Directorate Code" := emp."Global Dimension 1 Code";

            DimVal.RESET;
            DimVal.SETRANGE("Global Dimension No.", 2);
            DimVal.SETRANGE(Code, "Department Code");
            if DimVal.FINDLAST then
                "Directorate Name" := DimVal.Name;

            Designation := emp."Job Title";
            "Department Code" := emp."Global Dimension 1 Code";
            "Contract Type" := emp."Posting Group";
            ;

            LeaveTypes.RESET;
            LeaveTypes.SETRANGE(LeaveTypes."Annual Leave", true);
            if LeaveTypes.FIND('-') then
                "Leave Code" := LeaveTypes.Code;

        end;



        PlanHeader.RESET;
        PlanHeader.SETRANGE(PlanHeader."Employee No", "Employee No");
        PlanHeader.SETRANGE(PlanHeader."Fiscal Start Date", "Fiscal Start Date");
        PlanHeader.SETRANGE(PlanHeader."Maturity Date", "Maturity Date");
        if PlanHeader.FIND('+') then
            ERROR('You have already forwarded your leave plan for the current year');
    end;

    var
        MaturityDate: Date;
        FiscalStart: Date;
        UserSetup: Record "User Setup";
        emp: Record Employee;
        LeaveTypes: Record "Leave Types";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PlanHeader: Record "Employee Leave Plan Header";
        EmpLeave: Record "HR Type Of Intervention";
        NoofMonthsWorked: Integer;
        Nextmonth: Date;
        DimVal: Record "Dimension Value";

    procedure FindMaturityDate();
    var
        PayrollPeriodRec: Record "Payroll Period";
    begin

        PayrollPeriodRec.RESET;
        PayrollPeriodRec.SETRANGE(PayrollPeriodRec."Starting Date", 0D, TODAY);
        PayrollPeriodRec.SETRANGE(PayrollPeriodRec."New Fiscal Year", true);
        if PayrollPeriodRec.FIND('+') then begin
            FiscalStart := PayrollPeriodRec."Starting Date";
            MaturityDate := CALCDATE('1Y', PayrollPeriodRec."Starting Date") - 1;
        end;
    end;
}

