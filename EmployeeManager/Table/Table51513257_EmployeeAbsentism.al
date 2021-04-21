table 51513257 "Employee Absentism"
{
    // version HR

    DrillDownPageID = "Employee Absence List";
    LookupPageID = "Employee Absence List";
    Caption = 'Employee Absentism';
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                if Emp.GET("Employee No") then begin
                    "Employee Name" := Emp."First Name" + '   ' + Emp."Middle Name" + '   ' + Emp."Last Name";
                end;
                if "Employee No" = '' then
                    DELETE;
            end;
        }
        field(3; "Absent From"; Date)
        {
        }
        field(4; Approved; Boolean)
        {

            trigger OnValidate();
            begin

                "Leave Types".RESET;
                "Leave Types".SETRANGE("Leave Types"."Off/Holidays Days Leave", true);
                if "Leave Types".FIND('-') then;
                "Employee Leave".RESET;
                "Employee Leave".SETRANGE("Employee Leave"."Employee No", "Employee No");
                "Employee Leave".SETRANGE("Employee Leave"."Leave Code", "Leave Types".Code);
                if "Employee Leave".FIND('-') then;
                if Approved = true then begin
                    ;
                    "Employee Leave".Balance := "Employee Leave".Balance + 1;
                    "Employee Leave".MODIFY;
                end
                else begin
                    "Employee Leave".Balance := "Employee Leave".Balance - 1;
                    "Employee Leave".MODIFY;
                end;
            end;
        }
        field(5; "Absentism code"; Code[20])
        {
            TableRelation = "Employee Leave Application" WHERE (Status = CONST (Approved));

            trigger OnValidate();
            begin
                GeneralOptions.GET;
                /* IF LeaveApplication.GET("Leave Application") THEN
                 BEGIN
                   NoOfDaysOff:=0;
                     "Leave Ending Date":=LeaveApplication."End Date";
                   IF LeaveApplication."End Date"<>0D THEN
                   BEGIN
                   NextDate:="Recall Date";
                   REPEAT
                   IF NOT CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code",NextDate,Description) THEN
                   NoOfDaysOff:=NoOfDaysOff+1;
                
                   NextDate:=CALCDATE('1D',NextDate);
                   UNTIL NextDate=LeaveApplication."End Date";
                   END;
                
                 END;
                 */
                "No. of  Days Absent" := NoOfDaysOff;

            end;
        }
        field(6; "Absent To"; Date)
        {

            trigger OnValidate();
            begin
                Days := 1;
                AbsentFrom := "Absent From";
                HumanResSetup.RESET();
                HumanResSetup.GET();
                HumanResSetup.TESTFIELD(HumanResSetup."Base Calender Code");
                NonWorkingDay := false;
                if "Absent From" <> 0D then begin
                    if AbsentFrom < "Absent To" then begin
                        while AbsentFrom <> "Absent To"
                              do begin
                            NonWorkingDay := CalendarMgmt.CheckDateStatus(HumanResSetup."Base Calender Code", AbsentFrom, Dsptn);
                            if NonWorkingDay then begin
                                NonWorkingDay := false;
                                AbsentFrom := CALCDATE('1D', AbsentFrom);
                            end
                            else begin
                                AbsentFrom := CALCDATE('1D', AbsentFrom);
                                Days := Days + 1;
                            end;
                        end;
                    end;
                end;
                "No. of  Days Absent" := Days;
            end;
        }
        field(7; "No. of  Days Absent"; Decimal)
        {
        }
        field(9; "Maturity Date"; Date)
        {
        }
        field(10; "No. Series"; Code[10])
        {
        }
        field(11; "Employee Name"; Text[30])
        {
        }
        field(12; "Absent No."; Code[20])
        {
        }
        field(13; Status; Option)
        {
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(14; "Fiscal Start Date"; Date)
        {
        }
        field(15; "Reported  By"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                if Emp.GET("Reported  By") then
                    Name := Emp."First Name" + '' + Emp."Middle Name" + '' + Emp."Last Name";
            end;
        }
        field(16; Name; Text[50])
        {
            Editable = false;
        }
        field(17; "Reason for Absentism"; Text[130])
        {
        }
        field(18; Penalty; Option)
        {
            OptionCaption = '" ,Leave,Salary"';
            OptionMembers = " ",Leave,Salary;

            trigger OnValidate();
            begin
                if Penalty = Penalty::Leave then begin
                    if "No. of  Days Absent" = 0 then
                        DELETE;
                    MESSAGE(' %1 Will be deducted from the leave days', "No. of  Days Absent");
                    LeaveApplication.SETRANGE("Employee No", xRec."Employee No");

                end
                else
                    if Penalty = Penalty::Salary then begin

                        if Emp.GET("Employee No") then begin
                            ScaleBenefits.RESET;
                            ScaleBenefits.SETRANGE(ScaleBenefits."Salary Scale", Emp."Salary Scale");
                            ScaleBenefits.SETRANGE(ScaleBenefits."Salary Pointer", Emp.Present);
                            // ScaleBenefits.SETRANGE(ScaleBenefits."ED Code",);
                            if ScaleBenefits.FIND('-') then begin
                                PayrollPeriod.RESET;
                                PayrollPeriod.SETRANGE(PayrollPeriod."Close Pay", false);
                                if PayrollPeriod.FIND('-') then
                                    PayPeriodStart := PayrollPeriod."Starting Date";


                                assmatrix.INIT;
                                assmatrix."Employee No" := "Employee No";
                                assmatrix.Type := assmatrix.Type::Deduction;

                                assmatrix.VALIDATE(assmatrix.Code);
                                assmatrix."Payroll Period" := PayPeriodStart;
                                assmatrix.VALIDATE("Payroll Period");
                                assmatrix.Amount := ScaleBenefits.Amount; //Deduction
                                if not assmatrix.GET(assmatrix."Employee No", assmatrix.Type, assmatrix.Code, assmatrix."Payroll Period") then
                                    assmatrix.INSERT;
                            end;
                        end;


                        MESSAGE(' %1 Will be deducted from the salary', Deduction);
                    end;
            end;
        }
        field(19; "Contract No."; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Absent No.")
        {
        }
        key(Key2; "Employee No", "Maturity Date")
        {
            SumIndexFields = "No. of  Days Absent";
        }
        key(Key3; "Employee No", "Contract No.")
        {
            SumIndexFields = "No. of  Days Absent";
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "Absent No." = '' then begin
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD(HumanResSetup."Employee Absentism");
            NoSeriesMgt.InitSeries(HumanResSetup."Employee Absentism", xRec."No. Series", 0D, "Absent No.", "No. Series");
        end;

        FindMaturityDate;
        "Maturity Date" := MaturityDate;
        "Fiscal Start Date" := FiscalStart;
    end;

    var
        Holidays: Record "Holidays_Off Days";
        "Employee Leave": Record "Employee Leave Entitlement";
        "Leave Types": Record "Leave Types";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        FiscalStart: Date;
        MaturityDate: Date;
        Emp: Record Employee;
        LeaveApplication: Record "Employee Leave Application";
        NextDate: Date;
        NoOfDaysOff: Decimal;
        CalendarMgmt: Codeunit "Calendar Management";
        GeneralOptions: Record "Company Information";
        Description: Text[30];
        NonWorkingDay: Boolean;
        Dsptn: Text[30];
        Days: Integer;
        AbsentFrom: Date;
        Deduction: Decimal;
        ScaleBenefits: Record "Scale Benefits";
        PayrollPeriod: Record "Payroll Period";
        PayPeriodStart: Date;
        assmatrix: Record "Assignment Matrix";

    procedure FindMaturityDate();
    var
        AccPeriod: Record "Payroll Period";
    begin
        AccPeriod.RESET;
        AccPeriod.SETRANGE(AccPeriod."Starting Date", 0D, TODAY);
        AccPeriod.SETRANGE(AccPeriod."New Fiscal Year", true);
        if AccPeriod.FIND('+') then begin
            FiscalStart := AccPeriod."Starting Date";
            MaturityDate := CALCDATE('1Y', AccPeriod."Starting Date") - 1;
        end;
    end;
}

