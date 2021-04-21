table 51513235 "Employee Leave Plan"
{
    // version HR

    //DrillDownPageID = "Telephone Request HR";
    //LookupPageID = "Telephone Request HR";
    Caption = 'Employee Leave Plan';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                /*  IF emp.GET("Employee No") THEN
                  BEGIN
                  "Employee Name":=FORMAT(emp.Title)+' '+emp."First Name"+' '+emp."Middle Name"+''+emp."Last Name";
                  "Date of Joining Company":=EmpRec."Date Of Join";
                  "Department Code":=emp."Global Dimension 1 Code";
                    LeaveTypes.RESET;
                    LeaveTypes.SETRANGE(LeaveTypes."Annual Leave",TRUE);
                    IF LeaveTypes.FIND('-') THEN
                    "Leave Code":=LeaveTypes.Code;
                
                  END;
                  */

            end;
        }
        field(2; "Application No"; Code[20])
        {
            NotBlank = false;
            TableRelation = "Employee Leave Plan Header";

            trigger OnValidate();
            begin
                "Application Date" := TODAY;
                if UserSertup.GET(USERID) then begin
                    "Employee No" := UserSertup."Employee No.";
                    VALIDATE("Employee No");
                    "User ID" := USERID;
                    if EmpRec.GET("Employee No") then
                        "Department Code" := EmpRec."Global Dimension 1 Code";
                end;
            end;
        }
        field(3; "Leave Code"; Code[20])
        {
            TableRelation = "Leave Types";

            trigger OnValidate();
            begin
                /*IF xRec.Status<>Status::Open THEN
                ERROR('You cannot change a document an approved document');
                
                
                emp.GET("Employee No");
                IF LeaveTypes.GET("Leave Code") THEN
                BEGIN
                IF LeaveTypes.Gender=LeaveTypes.Gender::Female THEN
                IF emp.Gender=emp.Gender::Male THEN
                ERROR('%1 can only be assigned to %2 employees',LeaveTypes.Description,LeaveTypes.Gender);
                
                IF LeaveTypes.Gender=LeaveTypes.Gender::Male THEN
                IF emp.Gender=emp.Gender::Female THEN
                ERROR('%1 can only be assigned to %2 employees',LeaveTypes.Description,LeaveTypes.Gender);
                "Leave Entitlment":=LeaveTypes.Days;
                
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
                
                
                
                
                "Date of Joining Company":=emp."Date Of Join";
                "Annual Leave Entitlement Bal":="Leave balance"-"Days Applied";
                */

            end;
        }
        field(4; "Days Applied"; Decimal)
        {

            trigger OnValidate();
            begin
                if xRec.Status <> Status::Open then
                    ERROR('You cannot change a document an approved document');

                VALIDATE("Start Date");
                VALIDATE("Leave Code");



                /*
                "Approved Days":="Days Applied";
                
                IF "Start Date" <> 0D THEN BEGIN;
                "Approved Start Date":="Start Date";
                
                IF "Days Applied" > 0 THEN BEGIN
                LeaveTypes.RESET;
                LeaveTypes.SETFILTER(LeaveTypes.Code,"Leave Code");
                CurDate:="Start Date";
                DayApp:="Days Applied";
                REPEAT
                DayApp := DayApp - 1;
                {
                IF LeaveTypes."Inclusive of Holidays" = FALSE THEN BEGIN
                GeneralOptions.FIND('-');
                BaseCalender.RESET;
                BaseCalender.SETFILTER(BaseCalender."Base Calendar Code",GeneralOptions."Base Calender");
                BaseCalender.SETRANGE(BaseCalender.Date,CurDate);
                IF BaseCalender.FIND('-') THEN BEGIN
                  IF BaseCalender.Nonworking = FALSE THEN BEGIN
                     CurDate := CALCDATE('1D',CurDate);
                  END
                  ELSE BEGIN
                     CurDate := CurDate;
                  END;
                
                
                END
                ELSE BEGIN
                  CurDate := CALCDATE('1D',CurDate);
                END;
                
                END;
                }
                 CurDate := CALCDATE('1D',CurDate);
                UNTIL DayApp = 0;
                
                END;
                
                "End Date":=CurDate;
                
                END;
                         */

            end;
        }
        field(5; "Start Date"; Date)
        {

            trigger OnValidate();
            begin
                if xRec.Status <> Status::Open then
                    ERROR('You cannot change a document an approved document');
                /*
                IF ("Start Date"<"Fiscal Start Date") OR ("Start Date">"Maturity Date") THEN
                 ERROR('You can only enter dates that are within the current fiscal year!!');
                */
                GeneralOptions.GET;
                NoOfWorkingDays := 0;
                if "Days Applied" <> 0 then begin
                    if "Start Date" <> 0D then begin
                        NextWorkingDate := "Start Date";

                        repeat
                            if not CalendarMgmt.CheckDateStatus(GeneralOptions."Base Calendar Code", NextWorkingDate, Description) then
                                NoOfWorkingDays := NoOfWorkingDays + 1;

                            if LeaveTypes.GET("Leave Code") then begin
                                if LeaveTypes."Inclusive of Holidays" then begin
                                    BaseCalendar.RESET;
                                    BaseCalendar.SETRANGE(BaseCalendar."Base Calendar Code", GeneralOptions."Base Calendar Code");
                                    BaseCalendar.SETRANGE(BaseCalendar.Date, NextWorkingDate);
                                    BaseCalendar.SETRANGE(BaseCalendar.Nonworking, true);
                                    BaseCalendar.SETRANGE(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                    if BaseCalendar.FIND('-') then begin
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                        // MESSAGE('Holiday =%1 Day of week %2',BaseCalendar.Date,BaseCalendar.Description);
                                    end;

                                end;

                                if LeaveTypes."Inclusive of Saturday" then begin
                                    BaseCalender.RESET;
                                    BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SETRANGE(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SETRANGE(BaseCalender."Period No.", 6);

                                    if BaseCalender.FIND('-') then begin
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                        // MESSAGE('SATURDAY =%1 Day of week %2',BaseCalender."Period Start",BaseCalender."Period Name");
                                    end;
                                end;


                                if LeaveTypes."Inclusive of Sunday" then begin
                                    BaseCalender.RESET;
                                    BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SETRANGE(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SETRANGE(BaseCalender."Period No.", 7);
                                    if BaseCalender.FIND('-') then begin
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                        //  MESSAGE('Sunday =%1 Day of week %2',BaseCalender."Period Start",BaseCalender."Period Name");
                                    end;
                                end;


                                if LeaveTypes."Off/Holidays Days Leave" then
                                    ;

                            end;

                            NextWorkingDate := CALCDATE('1D', NextWorkingDate);
                        until NoOfWorkingDays = "Days Applied";
                        "End Date" := NextWorkingDate - 1;
                        "Resumption Date" := NextWorkingDate;
                    end;
                end;
                /*
                IF ("End Date" > "Maturity Date") THEN
                 ERROR('You can only enter dates that are within the current fiscal year!!');
                */



                //New Joining Employees

                if "Date of Joining Company" > "Fiscal Start Date" then begin

                    if "Date of Joining Company" <> 0D then begin
                        NoofMonthsWorked := 0;
                        Nextmonth := "Date of Joining Company";
                        repeat

                            Nextmonth := CALCDATE('1M', Nextmonth);
                            NoofMonthsWorked := NoofMonthsWorked + 1;
                        until Nextmonth >= "Start Date";
                        NoofMonthsWorked := NoofMonthsWorked - 1;
                        "No. of Months Worked" := NoofMonthsWorked;

                        if LeaveTypes.GET("Leave Code") then
                            "Leave Earned to Date" := ROUND(((LeaveTypes.Days / 12) * NoofMonthsWorked), 1);
                        "Leave Entitlment" := "Leave Earned to Date";
                        VALIDATE("Leave Code");
                    end;
                end;

            end;
        }
        field(6; "End Date"; Date)
        {

            trigger OnValidate();
            begin
                //"Approved To Date":="To Date";
                if xRec.Status <> Status::Open then
                    ERROR('You cannot change a document an approved document');

                VALIDATE("Start Date");
                VALIDATE("Leave Code");
            end;
        }
        field(7; "Application Date"; Date)
        {
        }
        field(8; "Approved Days"; Decimal)
        {

            trigger OnValidate();
            begin
                days := "Approved Days";
            end;
        }
        field(9; "Approved Start Date"; Date)
        {
        }
        field(10; "Verified By Manager"; Boolean)
        {

            trigger OnValidate();
            begin
                "Verification Date" := TODAY;
            end;
        }
        field(11; "Verification Date"; Date)
        {
        }
        field(12; "Leave Status"; Option)
        {
            OptionCaption = 'Being Processed,Approved,Rejected,Canceled';
            OptionMembers = "Being Processed",Approved,Rejected,Canceled;

            trigger OnValidate();
            begin
                /*
                IF ("Leave Status" = "Leave Status"::Approved) AND (xRec."Leave Status" <> "Leave Status"::Approved) THEN BEGIN;
                "Approval Date" := TODAY;
                "Employee Leaves".RESET;
                "Employee Leaves".SETRANGE("Employee Leaves"."Employee No","Employee No");
                "Employee Leaves".SETRANGE("Employee Leaves"."Leave Code","Leave Code");
                IF "Employee Leaves".FIND('-') THEN;
                "Employee Leaves".Balance:="Employee Leaves".Balance - "Approved Days";
                "Leave balance":="Employee Leaves".Balance;
                //MESSAGE('%1 %2',"Employee Leaves".Balance,"Approved Days");
                 "Employee Leaves".VALIDATE("Employee Leaves".Balance);
                "Employee Leaves".MODIFY;
                {
                SETRANGE("Leave Allowance Payable",TRUE);
                IF FIND('-') THEN  BEGIN
                emp.SETRANGE(emp."No.","Employee No");
                IF emp.FIND('-') THEN
                BEGIN
                earn.SETRANGE(earn."Leave Allowance",TRUE);
                  IF earn.FIND('-') THEN
                    BEGIN
                    ecode:=earn.Code;
                    assmatrix.RESET;
                    assmatrix.SETRANGE(assmatrix."Employee No","Employee No");
                    assmatrix.SETRANGE(assmatrix.Closed,FALSE);
                      IF assmatrix.FIND('-') THEN
                        BEGIN
                        assmatrix."Employee No":="Employee No";
                        assmatrix.VALIDATE("Employee No");
                        assmatrix.Code:=ecode;
                        assmatrix.VALIDATE(Code);
                        assmatrix.INSERT;
                      END;
                   END;
                END;
                END;
                }
                END
                ELSE IF ("Leave Status" <> "Leave Status"::Approved) AND (xRec."Leave Status" = "Leave Status"::Approved) THEN BEGIN
                "Approval Date" := TODAY;
                "Employee Leaves".RESET;
                "Employee Leaves".SETRANGE("Employee Leaves"."Employee No","Employee No");
                "Employee Leaves".SETRANGE("Employee Leaves"."Leave Code","Leave Code");
                IF "Employee Leaves".FIND('-') THEN;
                "Employee Leaves".Balance:="Employee Leaves".Balance + "Approved Days";
                 "Employee Leaves".VALIDATE("Employee Leaves".Balance);
                
                "Employee Leaves".MODIFY;
                {
                SETRANGE("Leave Allowance Payable",TRUE);
                IF FIND('-') THEN  BEGIN
                
                emp.SETRANGE(emp."No.","Employee No");
                IF emp.FIND('-') THEN
                BEGIN
                earn.SETRANGE(earn."Leave Allowance",TRUE);
                  IF earn.FIND('-') THEN
                    BEGIN
                    ecode:=earn.Code;
                    assmatrix.RESET;
                    assmatrix.SETRANGE(assmatrix."Employee No","Employee No");
                    assmatrix.SETRANGE(assmatrix.Closed,FALSE);
                      IF assmatrix.FIND('-') THEN
                        BEGIN
                        assmatrix."Employee No":="Employee No";
                        assmatrix.VALIDATE("Employee No");
                        assmatrix.Code:=ecode;
                        assmatrix.VALIDATE(Code);
                        assmatrix.INSERT;
                      END;
                   END;
                   }
                END;
                //END;
                
                
                
                
                
                //END;
                */

            end;
        }
        field(13; "Approved End Date"; Date)
        {
        }
        field(14; "Approval Date"; Date)
        {
        }
        field(15; Comments; Text[250])
        {
        }
        field(16; Taken; Boolean)
        {
        }
        field(17; "Acrued Days"; Decimal)
        {
        }
        field(18; "Over used Days"; Decimal)
        {
        }
        field(19; "Leave Allowance Payable"; Option)
        {
            OptionMembers = " ",Yes,No;

            trigger OnValidate();
            begin
                /*HumanResSetup.GET;
                IF "Leave Allowance Payable"="Leave Allowance Payable"::Yes THEN
                IF "Days Applied"<HumanResSetup."Qualification Days (Leave)" THEN
                ERROR('You can only be paid leave allowance if you take more or %1 Days',HumanResSetup."Qualification Days (Leave)" );
                */

            end;
        }
        field(20; Post; Boolean)
        {
        }
        field(21; days; Decimal)
        {
        }
        field(23; "No. series"; Code[10])
        {
        }
        field(24; "Leave balance"; Decimal)
        {
        }
        field(25; "Resumption Date"; Date)
        {
        }
        field(26; "Employee Name"; Text[50])
        {
        }
        field(27; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(28; "Leave Entitlment"; Decimal)
        {
        }
        field(29; "Total Leave Days Taken"; Decimal)
        {
            CalcFormula = Sum ("Employee Leave Application"."Days Applied" WHERE (Status = CONST (Approved),
                                                                                 "Employee No" = FIELD ("Employee No"),
                                                                                 "Leave Code" = FIELD ("Leave Code"),
                                                                                 "Maturity Date" = FIELD ("Maturity Date")));
            FieldClass = FlowField;
        }
        field(30; "Duties Taken Over By"; Code[80])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                if xRec.Status <> Status::Open then
                    ERROR('You cannot change a document an approved document');

                if emp.GET("Duties Taken Over By") then
                    Name := emp."First Name" + '' + emp."Middle Name" + '' + emp."Last Name";
            end;
        }
        field(31; Name; Text[50])
        {
        }
        field(32; "Mobile No"; Code[20])
        {
        }
        field(33; "Balance brought forward"; Decimal)
        {
        }
        field(34; "Leave Earned to Date"; Decimal)
        {
        }
        field(35; "Maturity Date"; Date)
        {
        }
        field(36; "Date of Joining Company"; Date)
        {
        }
        field(37; "Fiscal Start Date"; Date)
        {
        }
        field(38; "No. of Months Worked"; Decimal)
        {
        }
        field(39; "Annual Leave Entitlement Bal"; Decimal)
        {
        }
        field(40; "Recalled Days"; Decimal)
        {
            CalcFormula = Sum ("Leave Recall"."No. of Off Days" WHERE ("Employee No" = FIELD ("Employee No"),
                                                                      "Maturity Date" = FIELD ("Maturity Date")));
            FieldClass = FlowField;
        }
        field(41; "Off Days"; Decimal)
        {
            CalcFormula = Sum ("Holidays_Off Days"."No. of Days" WHERE ("Employee No." = FIELD ("Employee No"),
                                                                       "Leave Type" = FIELD ("Leave Code"),
                                                                       "Maturity Date" = FIELD ("Maturity Date")));
            FieldClass = FlowField;
        }
        field(42; "Department Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(43; "User ID"; Code[80])
        {
        }
        field(44; "Line No"; Integer)
        {
        }
        field(45; "Directorate Code"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(46; "Leave bf"; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; "Application No", "Employee No", "Line No")
        {
            SumIndexFields = days;
        }
        key(Key2; "Employee No", Status, "Leave Code", "Maturity Date")
        {
            SumIndexFields = "Days Applied", "Approved Days";
        }
        key(Key3; "Employee No", "Application No", "Maturity Date")
        {
        }
        key(Key4; "Department Code", "Application No", "Employee No", "Line No")
        {
            SumIndexFields = "Days Applied";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin

        //IF Post=TRUE THEN
        // ERROR('You cannot Delete the Record');
    end;

    trigger OnInsert();
    begin



        /*IF "Application No" = '' THEN BEGIN
          HumanResSetup.GET;
          HumanResSetup.TESTFIELD("Leave Plan Nos");
          NoSeriesMgt.InitSeries(HumanResSetup."Leave Plan Nos",xRec."No. series",0D,"Application No","No. series");
        END;*/

        "Application Date" := TODAY;
        FindMaturityDate;
        "Maturity Date" := MaturityDate;
        "Fiscal Start Date" := FiscalStart;

    end;

    trigger OnModify();
    begin
        //IF Post=TRUE THEN
        // ERROR('You cannot Modify the Record');
    end;

    trigger OnRename();
    begin
        if Post = true then
            ERROR('You cannot Rename the Record');
    end;

    var
        "Employee Leaves": Record "HR Type Of Intervention";
        BaseCalender: Record Date;
        CurDate: Date;
        LeaveTypes: Record "Leave Types";
        DayApp: Decimal;
        Dayofweek: Integer;
        i: Integer;
        textholder: Text[30];
        emp: Record Employee;
        leaveapp: Record "Employee Leave Plan";
        GeneralOptions: Record "Company Information";
        NoOfDays: Integer;
        BaseCalendar: Record "Base Calendar Change";
        yearend: Date;
        d: Date;
        d2: Integer;
        d3: Integer;
        d4: Integer;
        d1: Integer;
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        earn: Record Earnings;
        assmatrix: Record "Assignment Matrix";
        ecode: Code[10];
        ldated: Date;
        UserSertup: Record "User Setup";
        CalendarMgmt: Codeunit "Calendar Management";
        NextWorkingDate: Date;
        Description: Text[30];
        NoOfWorkingDays: Integer;
        LeaveAllowancePaid: Boolean;
        PayrollPeriod: Record "Payroll Period";
        PayPeriodStart: Date;
        EmpRec: Record Employee;
        MaturityDate: Date;
        EmpLeave: Record "HR Type Of Intervention";
        NoofMonthsWorked: Integer;
        FiscalStart: Date;
        Nextmonth: Date;
        DimVal: Record "Dimension Value";

    procedure CreateLeaveAllowance(var LeaveApp: Record "Employee Contracts");
    var
        HRSetup: Record "Human Resources Setup";
        AccPeriod: Record "Payroll Period";
        FiscalStart: Date;
        FiscalEnd: Date;
        ScaleBenefits: Record "Scale Benefits";
    begin
        /*IF LeaveApp."Leave Allowance Payable"=LeaveApp."Leave Allowance Payable"::"1" THEN
        BEGIN
        AccPeriod.RESET;
        AccPeriod.SETRANGE(AccPeriod."Starting Date",0D,TODAY);
        AccPeriod.SETRANGE(AccPeriod."New Fiscal Year",TRUE);
        IF AccPeriod.FIND('+') THEN
        FiscalStart:=AccPeriod."Starting Date";
        //MESSAGE('%1',FiscalStart);
        
        FiscalEnd:=CALCDATE('1Y',FiscalStart)-1;
        //MESSAGE('%1',FiscalEnd);
        
        
        assmatrix.RESET;
        assmatrix.SETRANGE(assmatrix."Payroll Period",FiscalStart,FiscalEnd);
        assmatrix.SETRANGE(assmatrix.Type,assmatrix.Type::Payment);
        assmatrix.SETRANGE(assmatrix.Code,HRSetup."Leave Allowance Code");
        IF assmatrix.FIND('-') THEN
        BEGIN
        LeaveAllowancePaid:=TRUE;
        MESSAGE('Leave allowance paid on %1',assmatrix."Payroll Period");
        END;
        
        
        IF NOT LeaveAllowancePaid THEN
        BEGIN
        
        
        
        IF HRSetup.GET THEN
        BEGIN
        IF "Days Applied">=HRSetup."Qualification Days (Leave)" THEN
        BEGIN
          IF emp.GET("Employee No") THEN
          BEGIN
            ScaleBenefits.RESET;
            ScaleBenefits.SETRANGE(ScaleBenefits."Salary Scale",emp."Salary Scale");
            ScaleBenefits.SETRANGE(ScaleBenefits."Salary Pointer",emp.Present);
            ScaleBenefits.SETRANGE(ScaleBenefits."ED Code",HRSetup."Leave Allowance Code");
            IF ScaleBenefits.FIND('-') THEN
            BEGIN
               PayrollPeriod.RESET;
               PayrollPeriod.SETRANGE(PayrollPeriod."Close Pay",FALSE);
               IF PayrollPeriod.FIND('-') THEN
               PayPeriodStart:=PayrollPeriod."Starting Date";
        
              assmatrix.INIT;
              assmatrix."Employee No":="Employee No";
              assmatrix.Type:=assmatrix.Type::Payment;
              assmatrix.Code:=HRSetup."Leave Allowance Code";
              assmatrix.VALIDATE(assmatrix.Code);
              assmatrix."Payroll Period":=PayPeriodStart;
              assmatrix.Amount:=ScaleBenefits.Amount;
        
              IF NOT assmatrix.GET(assmatrix."Employee No",assmatrix.Type,assmatrix.Code,assmatrix."Payroll Period") THEN
               assmatrix.INSERT;
          END;
          END;
        
        END;
        
        
        
        
        END;
        END;
        END;
        */

    end;

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

