codeunit 51513056 "Overtime Payroll Computation"
{
    // version PAYROLL


    trigger OnRun();
    begin
    end;

    var
        OverTHeader: Record "Overtime Header";
        OverTLine: Record "Overtime Line";
        BonusLines: Record "Workdone Lines";
        Empl: Record Employee;
        OvertimeH: Record "Overtime Header";
        AssignmentMatrix: Record "Assignment Matrix";
        Earnings: Record Earnings;
        Earn: Record Earnings;
        overcode: Code[20];
        OvertimeSetUp: Record "Overtime Set Up";
        Earn2: Record Earnings;
        Basicpaycode: Code[20];
        AssignMatrix: Record "Assignment Matrix";
        BasicSalary: Decimal;
        Overtimerate: Decimal;
        OvertimehoursPM: Decimal;
        Overtimepaid: Decimal;
        Window: Dialog;
        OvertimerateDouble: Decimal;

    procedure ComputeOvertime(var OvertimeHeader: Record "Overtime Header");
    begin
        //=====overtime code
        Earn.RESET;
        Earn.SETRANGE(OverTime, true);
        if Earn.FINDFIRST then begin
            overcode := Earn.Code;
        end;
        //=======basic pay code
        Earn2.RESET;
        Earn2.SETRANGE("Basic Salary Code", true);
        if Earn2.FINDFIRST then begin
            Basicpaycode := Earn2.Code;
        end;
        OverTLine.RESET;
        OverTLine.SETRANGE(Code, OvertimeHeader.Code);
        OverTLine.SETRANGE("pay period", OvertimeHeader."Pay Period");
        if OverTLine.FINDFIRST then begin
            repeat
                OverTLine.TESTFIELD("Hours Normal");
                OverTLine.TESTFIELD("Overttime Code");
                Window.OPEN('Calculating Overtime For ##############################1', OverTLine."Employee Name");
                BasicSalary := 0;
                Overtimerate := 0;
                OvertimehoursPM := 0;
                Overtimepaid := 0;
                //=====get basic pay
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(Code, Basicpaycode);
                AssignMatrix.SETRANGE("Employee No", OverTLine."Employee No");
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                AssignMatrix.SETRANGE("Payroll Period", OvertimeHeader."Pay Period");
                if AssignMatrix.FINDFIRST then begin
                    BasicSalary := AssignMatrix.Amount;
                end;
                //======
                if OvertimeSetUp.GET(OverTLine."Overttime Code") then begin
                    Overtimerate := OvertimeSetUp."Rates Normal";
                    OvertimerateDouble := OvertimeSetUp."Rates Double";
                    OvertimehoursPM := OvertimeSetUp."Max Hours Per Month";
                end;
                Overtimepaid := ROUND((BasicSalary / OvertimehoursPM) * (OverTLine."Hours Normal" * Overtimerate), 0.01) + ROUND((BasicSalary / OvertimehoursPM) * (OverTLine."Hours Double" * OvertimerateDouble), 0.01);
                OverTLine.Amount := Overtimepaid;
                if OverTLine.Amount <> 0 then
                    OverTLine.MODIFY;
            until OverTLine.NEXT = 0;
        end;
    end;

    procedure ComputeOvertimeLine(var OvertimeLine: Record "Overtime Line");
    begin

        //=====overtime code
        Earn.RESET;
        Earn.SETRANGE(OverTime, true);
        if Earn.FINDFIRST then begin
            overcode := Earn.Code;
        end;
        //=======basic pay code
        Earn2.RESET;
        Earn2.SETRANGE("Basic Salary Code", true);
        if Earn2.FINDFIRST then begin
            Basicpaycode := Earn2.Code;
        end;
        OverTLine.RESET;
        OverTLine.SETRANGE("Line No", OvertimeLine."Line No");
        OverTLine.SETRANGE(Code, OvertimeLine.Code);
        OverTLine.SETRANGE("pay period", OvertimeLine."pay period");
        if OverTLine.FINDFIRST then begin
            BasicSalary := 0;
            Overtimerate := 0;
            OvertimehoursPM := 0;
            Overtimepaid := 0;
            //=====get basic pay
            AssignMatrix.RESET;
            AssignMatrix.SETRANGE(Code, Basicpaycode);
            AssignMatrix.SETRANGE("Employee No", OverTLine."Employee No");
            AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
            AssignMatrix.SETRANGE("Payroll Period", OvertimeLine."pay period");
            if AssignMatrix.FINDFIRST then begin
                BasicSalary := AssignMatrix.Amount;
            end;
            //======
            if OvertimeSetUp.GET(OverTLine."Overttime Code") then begin
                Overtimerate := OvertimeSetUp."Rates Normal";
                OvertimerateDouble := OvertimeSetUp."Rates Double";
                OvertimehoursPM := OvertimeSetUp."Max Hours Per Month";
            end;
            Overtimepaid := ROUND((BasicSalary / OvertimehoursPM) * (OverTLine."Hours Normal" * Overtimerate), 0.01) + ROUND((BasicSalary / OvertimehoursPM) * (OverTLine."Hours Double" * OvertimerateDouble), 0.01);
            OverTLine.Amount := Overtimepaid;
            if OverTLine.Amount <> 0 then
                OverTLine.MODIFY;
        end;
    end;

    procedure OvertimePayroll(var OvertimeHeader: Record "Overtime Header");
    begin
        Earn.RESET;
        Earn.SETRANGE(OverTime, true);
        if Earn.FINDFIRST then begin
            overcode := Earn.Code;
        end;
        //=======basic pay code
        Earn2.RESET;
        Earn2.SETRANGE("Basic Salary Code", true);
        if Earn2.FINDFIRST then begin
            Basicpaycode := Earn2.Code;
        end;
        //==============================get ovetime lines
        OverTLine.RESET;
        OverTLine.SETRANGE(Code, OvertimeHeader.Code);
        OverTLine.SETRANGE("pay period", OvertimeHeader."Pay Period");
        OverTLine.SETRANGE(Paid, false);
        if OverTLine.FINDFIRST then begin
            repeat
                Window.OPEN('Calculating Payroll For ##############################1', OverTLine."Employee Name");
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(Code, overcode);
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                AssignMatrix.SETRANGE("Employee No", OverTLine."Employee No");
                AssignMatrix.SETRANGE("Payroll Period", OverTLine."pay period");
                if AssignMatrix.FIND('-') then begin
                    AssignMatrix.Amount := OverTLine.Amount;
                    if AssignMatrix.Amount <> 0 then
                        AssignMatrix.MODIFY;
                end
                else begin
                    AssignMatrix.INIT;
                    AssignMatrix."Employee No" := OverTLine."Employee No";
                    AssignMatrix.Type := AssignMatrix.Type::Payment;
                    AssignMatrix.Code := overcode;
                    AssignMatrix.VALIDATE(AssignMatrix.Code);
                    AssignMatrix."Payroll Period" := OverTLine."pay period";
                    Empl.GET(OverTLine."Employee No");
                    AssignMatrix."Global Dimension 1 code" := Empl."Global Dimension 1 Code";
                    AssignMatrix."Global Dimension 2 Code" := Empl."Global Dimension 2 Code";
                    AssignMatrix.Amount := OverTLine.Amount;
                    AssignMatrix."Manual Entry" := false;
                    if AssignMatrix.Amount <> 0 then
                        AssignMatrix.INSERT;
                end;
                OverTLine.Paid := true;
                OverTLine.MODIFY;
            until OverTLine.NEXT = 0;
        end;
    end;

    procedure Overtimetemplate(OvertimeH: Record "Overtime Header");
    var
        Window: Dialog;
        OvertimeTemplate: Record "Overtime Template";
        OvertimeLine: Record "Overtime Line";
        LineNo: Integer;
        OvertimeL: Record "Overtime Line";
        OvertimePayrollComputation: Codeunit "Overtime Payroll Computation";
    begin
        if CONFIRM('Are You Sure You Want to Run All The Overtime For Payroll Period  ' + FORMAT(OvertimeH."Pay Period") + ' ?', false) = true then begin
            LineNo := 100;
            OvertimeL.SETCURRENTKEY("Line No");
            OvertimeL.ASCENDING(false);
            if OvertimeL.FINDFIRST then begin
                LineNo := OvertimeL."Line No" + 1;
            end;
            OvertimeTemplate.RESET;
            OvertimeTemplate.SETRANGE("Payroll period", OvertimeH."Pay Period");
            if OvertimeTemplate.FINDFIRST then begin
                repeat
                    Window.OPEN('Calculating Payroll For ##############################1', OvertimeTemplate."Employee Name");
                    OvertimeLine.INIT;
                    OvertimeLine."Line No" := LineNo;
                    OvertimeLine.Code := OvertimeH.Code;
                    OvertimeLine."Employee No" := OvertimeTemplate."Employee No";
                    OvertimeLine."Employee Name" := OvertimeTemplate."Employee Name";
                    OvertimeLine."pay period" := OvertimeH."Pay Period";
                    OvertimeLine."Hours Normal" := OvertimeTemplate.Hours;
                    OvertimeLine."Hours Double" := OvertimeTemplate.Double;
                    OvertimeLine."Overttime Code" := 'NORMAL OT GW';
                    OvertimeLine.INSERT;
                    LineNo := LineNo + 1;
                    OvertimePayrollComputation.ComputeOvertimeLine(OvertimeLine);
                until OvertimeTemplate.NEXT = 0;
            end;
            MESSAGE('Overtime Details Successfully Updated %1', OvertimeH.Code);
        end;
    end;

    procedure BonusPayroll(var OvertimeHeader: Record "Overtime Header");
    var
        BonusCode: Code[20];
    begin
        Earn.RESET;
        Earn.SETRANGE(Bonus, true);
        if Earn.FINDFIRST then begin
            BonusCode := Earn.Code;
        end;
        //=======basic pay code
        Earn2.RESET;
        Earn2.SETRANGE("Basic Salary Code", true);
        if Earn2.FINDFIRST then begin
            Basicpaycode := Earn2.Code;
        end;
        //==============================get ovetime lines
        BonusLines.RESET;
        BonusLines.SETRANGE(Code, OvertimeHeader.Code);
        BonusLines.SETRANGE("Payroll Period", OvertimeHeader."Pay Period");
        BonusLines.SETRANGE(Paid, false);
        if BonusLines.FINDFIRST then begin
            repeat
                Window.OPEN('Calculating Payroll For ##############################1', BonusLines."Employee Name");
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(Code, BonusCode);
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                AssignMatrix.SETRANGE("Employee No", BonusLines."Employee No");
                AssignMatrix.SETRANGE("Payroll Period", BonusLines."Payroll Period");
                if AssignMatrix.FIND('-') then begin
                    AssignMatrix.Amount := BonusLines.Amount;
                    if AssignMatrix.Amount <> 0 then
                        AssignMatrix.MODIFY;
                end
                else begin
                    AssignMatrix.INIT;
                    AssignMatrix."Employee No" := BonusLines."Employee No";
                    AssignMatrix.Type := AssignMatrix.Type::Payment;
                    AssignMatrix.Code := BonusCode;
                    AssignMatrix.VALIDATE(AssignMatrix.Code);
                    AssignMatrix."Payroll Period" := BonusLines."Payroll Period";
                    Empl.GET(BonusLines."Employee No");
                    AssignMatrix."Global Dimension 1 code" := Empl."Global Dimension 1 Code";
                    AssignMatrix."Global Dimension 2 Code" := Empl."Global Dimension 2 Code";
                    AssignMatrix.Amount := BonusLines.Amount;
                    AssignMatrix."Manual Entry" := false;
                    if AssignMatrix.Amount <> 0 then
                        AssignMatrix.INSERT;
                end;
                BonusLines.Paid := true;
                BonusLines.MODIFY;
            until OverTLine.NEXT = 0;
        end;
    end;

    procedure Bonustemplate(OvertimeH: Record "Overtime Header");
    var
        Window: Dialog;
        OvertimeTemplate: Record "Overtime Template";
        OvertimeLine: Record "Overtime Line";
        LineNo: Integer;
        OvertimeL: Record "Overtime Line";
        OvertimePayrollComputation: Codeunit "Overtime Payroll Computation";
    begin
        if CONFIRM('Are You Sure You Want to Run All The Overtime For Payroll Period  ' + FORMAT(OvertimeH."Pay Period") + ' ?', false) = true then begin
            LineNo := 100;
            OvertimeL.SETCURRENTKEY("Line No");
            OvertimeL.ASCENDING(false);
            if OvertimeL.FINDFIRST then begin
                LineNo := OvertimeL."Line No" + 1;
            end;
            OvertimeTemplate.RESET;
            OvertimeTemplate.SETRANGE("Payroll period", OvertimeH."Pay Period");
            if OvertimeTemplate.FINDFIRST then begin
                repeat
                    Window.OPEN('Calculating Payroll For ##############################1', OvertimeTemplate."Employee Name");
                    OvertimeLine.INIT;
                    OvertimeLine."Line No" := LineNo;
                    OvertimeLine.Code := OvertimeH.Code;
                    OvertimeLine."Employee No" := OvertimeTemplate."Employee No";
                    OvertimeLine."Employee Name" := OvertimeTemplate."Employee Name";
                    OvertimeLine."pay period" := OvertimeH."Pay Period";
                    OvertimeLine."Hours Normal" := OvertimeTemplate.Hours;
                    OvertimeLine."Hours Double" := OvertimeTemplate.Double;
                    OvertimeLine."Overttime Code" := 'NORMAL OT GW';
                    OvertimeLine.INSERT;
                    LineNo := LineNo + 1;
                    OvertimePayrollComputation.ComputeOvertimeLine(OvertimeLine);
                until OvertimeTemplate.NEXT = 0;
            end;
            MESSAGE('Overtime Details Successfully Updated %1', OvertimeH.Code);
        end;
    end;

    procedure InsertCasuals(Cas: Record "Casuals Payments");
    var
        Lines: Record "Casuals Payment Lines";
        DailyEntries: Record "Casuals Daily Master";
        CasualM: Record "Casuals Master";
        Emp: Record Employee;
        StartD: Date;
        EndD: Date;
    begin
        StartD := Cas."Payroll Period";
        EndD := CALCDATE('<CM>', Cas."Payroll Period");
        Emp.RESET;
        //Emp.SETRANGE("Global Dimension 7 Code", Cas.Unit);
        //Emp.SETRANGE("Posting Group", 'CASUALS');
        if Emp.FIND('-') then begin
            repeat
                //Check for active Casuals
                DailyEntries.RESET;
                DailyEntries.SETRANGE("Employee No.", Emp."No.");
                DailyEntries.SETRANGE("Date Time In", CREATEDATETIME(StartD, 000000T), CREATEDATETIME(EndD, 000000T));
                if DailyEntries.FIND('-') then begin
                    Lines.INIT;
                    Lines.Code := Cas.Code;
                    Lines.Name := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                    Lines."Calculated Hours" := GetCasualHours(Emp."No.", StartD, EndD);
                    Lines.INSERT;
                end;
            until Emp.NEXT = 0;
        end;
    end;

    local procedure GetCasualHours(EmpNo: Code[10]; StartDate: Date; EndDate: Date) HoursWorked: Decimal;
    var
        Attendance: Record "Employee Attendance";
    begin
        Attendance.RESET;
        Attendance.SETRANGE("Staff No", EmpNo);
        Attendance.SETRANGE(Date, StartDate, EndDate);
        if Attendance.FIND('-') then begin
            Attendance.CALCSUMS("Hours Worked");
            HoursWorked := Attendance."Hours Worked";
        end else
            HoursWorked := 0;
    end;
}

