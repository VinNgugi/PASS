table 51513209 "Employee Leave Application"
{
    // version HR
    Caption = 'Employee Leave Application';
    DataClassification = CustomerContent;
    DrillDownPageID = "Emplo Leave Application List";
    LookupPageID = "Emplo Leave Application List";

    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                if emp.GET("Employee No") then begin
                    CLEAR("Leave Code");
                    CLEAR("Days Applied");
                    CLEAR("Leave balance");
                    "Employee Name" := FORMAT(emp.Title) + ' ' + emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
                    "Date of Joining Company" := emp."Date Of Join";
                    "Balance brought forward" := EmpLeave."Balance Brought Forward";
                    "Global Dimension 1 Code" := emp."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := emp."Global Dimension 2 Code";
                    "Country/Region Code" := emp."Country/Region Code";
                    "Mobile No" := emp."Mobile Phone No.";
                    "Date of Joining Company" := emp."Date Of Join";
                    "Contract No." := emp."Contract Number";
                    "Country/Region Code" := emp."Country/Region Code";
                    if emp."Contract Number" <> '' then
                        "Contract No." := emp."Contract Number";
                    if emp.Gender = emp.Gender::Male then
                        Gender := Gender::Male;
                    if emp.Gender = emp.Gender::Female then
                        Gender := Gender::Female;

                    //***************get directorate Name*****************//
                    DimVal.RESET;
                    DimVal.SETRANGE("Global Dimension No.", 1);
                    DimVal.SETRANGE(Code, "Global Dimension 1 Code");
                    if DimVal.FIND('-') then
                        "Department Name" := DimVal.Name;

                    //***************get directorate Name*****************//
                    //**********************Department Name*******************//
                    DimVal.RESET;
                    DimVal.SETRANGE("Global Dimension No.", 2);
                    DimVal.SETRANGE(Code, "Global Dimension 2 Code");
                    if DimVal.FIND('-') then
                        "Directorate name" := DimVal.Name;
                    //**********************Department Name*******************//

                    //TO GET ENTITLEMENT AND BALANCES-B/F FOR EMPLOYEES ON PROBATION -
                    /*
                        ContractPostingGroupCode:='';
                        StaffPostingGroupRec.RESET;
                        StaffPostingGroupRec.SETRANGE("Is Contract",TRUE);
                        IF StaffPostingGroupRec.FINDLAST THEN
                          ContractPostingGroupCode:=StaffPostingGroupRec.Code;

                        InternPostingGroup:='';
                        StaffPostingGroupRec.RESET;
                        StaffPostingGroupRec.SETRANGE("Is Intern",TRUE);
                        IF StaffPostingGroupRec.FINDLAST THEN
                          InternPostingGroup:=StaffPostingGroupRec.Code;
                    */
                    //      IF (emp."Posting Group"=ContractPostingGroupCode) OR (emp."Posting Group"=InternPostingGroup) THEN
                    //        BEGIN


                    //*******************************Get Details for Employees on Contracts*******************************//
                    EmpContracts.RESET;
                    EmpContracts.SETRANGE(EmpContracts."Employee No", emp."No.");
                    EmpContracts.SETRANGE(EmpContracts."Contract No", FORMAT(emp."Contract Number"));
                    EmpContracts.SETRANGE(EmpContracts.Expired, false);
                    if EmpContracts.FINDLAST then begin
                        "Leave Entitlment" := EmpContracts."Contract Leave Entitlement";
                        "Balance brought forward" := EmpContracts."Balance Brought Forward";
                    end;

                    //*******************************Get Details for Employees on Contracts*******************************//
                    //      END;
                    // End of the employee on probation
                end;

            end;
        }
        field(2; "Application No"; Code[20])
        {
            NotBlank = false;

            trigger OnValidate();
            begin
                "Application Date" := TODAY;
                if "Application No" <> xRec."Application No" then begin
                    HumanResSetup.GET;
                    NoSeriesMgt.TestManual(HumanResSetup."Leave Application Nos.");
                    "No. series" := '';
                end;
            end;
        }
        field(3; "Leave Code"; Code[20])
        {
            TableRelation = IF (Gender = CONST(Female)) "Leave Types" WHERE(Gender = FILTER(Both | Female))
            ELSE
            IF (Gender = CONST(Male)) "Leave Types" WHERE(Gender = FILTER(Both | Male));

            trigger OnValidate()

            begin



                IF xRec.Status <> Status::Open THEN
                    ERROR('You cannot change an already approved documents or documents pending approval');

                IF LeaveTypes.GET("Leave Code") THEN BEGIN
                    /*IF LeaveTypes."Requires Attachment" THEN
                        "Requires Attachment" := TRUE
                    ELSE
                        "Requires Attachment" := FALSE;
                    */
                    IF emp.GET("Employee No") THEN BEGIN
                        //********************************VALIDATE Gender*****************************************//
                        CASE LeaveTypes.Gender OF
                            LeaveTypes.Gender::Female:
                                BEGIN
                                    IF emp.Gender = emp.Gender::Male THEN
                                        ERROR('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);
                                END;
                            LeaveTypes.Gender::Male:
                                BEGIN
                                    IF emp.Gender = emp.Gender::Female THEN
                                        ERROR('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);
                                END;
                        END;
                        //********************************VALIDATE Gender*****************************************//
                        //*************************************Validate Employee Status******************************//
                        //        IF LeaveTypes."Annual Leave" THEN
                        //          BEGIN
                        FnGetLeaveStatistics("Leave Code");
                        //            END;
                        //*************************************Validate Employee Status******************************//

                    END;//Close IF emp.GET("Employee No") THEN
                END;//IF LeaveTypes.GET("Leave Code") THEN




                /*
                IF emp.GET("Employee No") THEN BEGIN
                                    IF LeaveTypes.GET("Leave Code") THEN BEGIN
                                        IF LeaveTypes."Requires Attachment" = TRUE THEN
                                            "Requires Attachment" := TRUE;
                                        IF LeaveTypes."Annual Leave" = FALSE THEN BEGIN
                                            IF LeaveTypes.Gender = LeaveTypes.Gender::Female THEN
                                                IF emp.Gender = emp.Gender::Male THEN
                                                    ERROR('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);

                                            IF LeaveTypes.Gender = LeaveTypes.Gender::Male THEN
                                                IF emp.Gender = emp.Gender::Female THEN
                                                    ERROR('%1 can only be assigned to %2 employees', LeaveTypes.Description, LeaveTypes.Gender);

                                            IF emp."Employment Status" = emp."Employment Status"::Probation THEN BEGIN
                                                "Leave Entitlment" := LeaveTypes."Probation Days";
                                                "Days Applied" := LeaveTypes."Probation Days";
                                            END;
                                            IF emp."Employment Status" <> emp."Employment Status"::Probation THEN BEGIN
                                                "Leave Entitlment" := LeaveTypes.Days;
                                                "Days Applied" := LeaveTypes.Days;
                                            END;

                                        END ELSE
                                            IF LeaveTypes."Annual Leave" = TRUE THEN BEGIN
                                                emp.RESET;
                                                IF emp.GET("Employee No") THEN BEGIN
                                                    IF LeaveTypes."Eligible Staff" = LeaveTypes."Eligible Staff"::Confirmed THEN
                                                        //            IF emp."Employment Status"<>emp."Employment Status"::Confirmed THEN
                                                        //              ERROR('%1 can only be assigned to %2 members of staff',LeaveTypes.Description,LeaveTypes."Eligible Staff");
                                                        //            IF (emp."Posting Group"<>'PERMANENT') AND (emp."Posting Group"<>'CMFIU/2NDM') THEN
                                                        //              ERROR('%1 can only be assigned to Permanent members of staff',LeaveTypes.Description);


                                                        NoofMonthsWorked := 0;
                                                    Nextmonth := "Fiscal Start Date";
                                                    IF DATE2DMY("Application Date", 3) = DATE2DMY("Fiscal Start Date", 3) THEN BEGIN
                                                        NoofMonthsWorked := DATE2DMY("Application Date", 2) - DATE2DMY("Fiscal Start Date", 2);
                                                    END;
                                                    IF DATE2DMY("Application Date", 3) <> DATE2DMY("Fiscal Start Date", 3) THEN BEGIN
                                                        NoofMonthsWorked := (DATE2DMY("Application Date", 2) + 12) - DATE2DMY("Fiscal Start Date", 2);
                                                    END;

                                                    NoofMonthsWorked := NoofMonthsWorked + 1;
                                                    "No. of Months Worked" := NoofMonthsWorked;

                                                    IF LeaveTypes.GET("Leave Code") THEN
                                                        "Leave Earned to Date" := ROUND((LeaveTypes.Days / 12 * NoofMonthsWorked), 0.5);
                                                    IF emp."Employment Status" = emp."Employment Status"::Probation THEN BEGIN
                                                        //******************Get Probation Days depending on the employee type***********
                                                        IF AddSetup.GET(emp."Posting Group", LeaveTypes.Code) THEN BEGIN
                                                            "Leave Entitlment" := AddSetup."Probation Leave days";
                                                        END
                                                        ELSE
                                                            "Leave Entitlment" := LeaveTypes."Probation Days";

                                                    END
                                                    ELSE BEGIN
                                                        IF AddSetup.GET(emp."Posting Group", LeaveTypes.Code) THEN BEGIN
                                                            "Leave Entitlment" := AddSetup."Total Days Entitled";
                                                        END;
                                                    END;
                                                    //"Leave Entitlment":=LeaveTypes.Days;//("Maturity Date"-"Date of Joining Company")/30*2.5;


                                                    EmpLeave.INIT;
                                                    EmpLeave."Leave Code" := "Leave Code";
                                                    EmpLeave."Maturity Date" := "Maturity Date";
                                                    EmpLeave."Employee No" := "Employee No";
                                                    EmpLeave.Entitlement := "Leave Entitlment";
                                                    IF NOT EmpLeave.GET("Employee No", "Leave Code", "Maturity Date") THEN
                                                        EmpLeave.INSERT;
                                                END;

                                            END;

                                    END;

                                    "Date of Joining Company" := emp."Date Of Join";
                                    // IF EmpLeave.GET("Employee No","Leave Code","Maturity Date") THEN
                                    // BEGIN
                                    //"Leave Entitlment":=EmpLeave.Entitlement;
                                    "Balance brought forward" := EmpLeave."Balance Brought Forward";
                                    CALCFIELDS("Total Leave Days Taken", "Recalled Days", "Off Days");
                                    "Leave balance" := ("Leave Entitlment" + "Balance brought forward" + "Recalled Days" + "Off Days") - ("Total Leave Days Taken" + "Days Absent");
                                    // END;
                                END;*/
            end;

        }
        field(4; "Days Applied"; Decimal)
        {

            trigger OnValidate();
            begin
                if xRec.Status <> Status::Open then
                    ERROR('You cannot change an already approved document');

                if "Days Applied" < 0 then
                    ERROR('Days applied must be greater than 0');

                VALIDATE("Start Date");

                //*********************************************Check For Document Requirement************************//
                if emp.GET("Employee No") then begin
                    if AddSetup.GET(emp."Posting Group", "Leave Code") then begin
                        if AddSetup."Max Days without Document" > 0 then begin
                            if "Days Applied" <= AddSetup."Max Days without Document" then begin
                                "Requires Attachment" := false;
                                MODIFY;
                            end else begin
                                "Requires Attachment" := true;
                                MODIFY;
                            end;
                        end;
                    end;
                end;
                //*********************************************Check For Document Requirement************************//

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

                // IF "Days Applied">"Leave balance" THEN
                // ERROR('The days applied for are more than your leave balance');

                "Annual Leave Entitlement Bal" := "Leave balance" - "Days Applied";

            end;
        }
        field(5; "Start Date"; Date)
        {

            trigger OnValidate();
            begin
                /*IF xRec.Status<>Status::Open THEN
                ERROR('You cannot change an already approved document');*/

                FullDays := ROUND("Days Applied", 1, '<');
                HalfDays := "Days Applied" - FullDays;

                "Resumption Date" := "Start Date";
                GeneralOptions.GET;
                NoOfWorkingDays := 0;

                //****************************************Get Base Calendar*************************************//
                if HumanResSetup.GET() then begin
                    if HumanResSetup."Base Calender Code" <> '' then
                        CalendarCode := HumanResSetup."Base Calender Code"
                    else
                        ERROR('Please Assign a base calendar code in HR Setup for easier dates calculation');
                end;
                /*
                IF "Start Date"<>0D THEN
                  BEGIN
                    IF "Start Date"<= "Application Date" THEN
                      ERROR('The date is not valid. Start date should be from %1',CALCDATE('1D',TODAY));
                    END;
                */
                //****************************************Get Base Calendar*************************************//

                if ("Days Applied" <> 0) and ("Days Applied" >= 1) then begin
                    if "Start Date" <> 0D then begin
                        NextWorkingDate := "Start Date";
                        repeat
                            if not CalendarMgmt.CheckDateStatus(CalendarCode, NextWorkingDate, Description) then
                                NoOfWorkingDays := NoOfWorkingDays + 1;

                            if LeaveTypes.GET("Leave Code") then begin
                                if LeaveTypes."Inclusive of Holidays" then begin
                                    BaseCalendar.RESET;
                                    BaseCalendar.SETRANGE(BaseCalendar."Base Calendar Code", CalendarCode);
                                    BaseCalendar.SETRANGE(BaseCalendar.Date, NextWorkingDate);
                                    BaseCalendar.SETRANGE(BaseCalendar.Nonworking, true);
                                    BaseCalendar.SETRANGE(BaseCalendar."Recurring System", BaseCalendar."Recurring System"::"Annual Recurring");
                                    if BaseCalendar.FIND('-') then begin
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                    end;

                                end;

                                if LeaveTypes."Inclusive of Saturday" then begin
                                    BaseCalender.RESET;
                                    BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SETRANGE(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SETRANGE(BaseCalender."Period No.", 6);

                                    if BaseCalender.FIND('-') then begin
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                    end;
                                end;


                                if LeaveTypes."Inclusive of Sunday" then begin
                                    BaseCalender.RESET;
                                    BaseCalender.SETRANGE(BaseCalender."Period Type", BaseCalender."Period Type"::Date);
                                    BaseCalender.SETRANGE(BaseCalender."Period Start", NextWorkingDate);
                                    BaseCalender.SETRANGE(BaseCalender."Period No.", 7);
                                    if BaseCalender.FIND('-') then begin
                                        NoOfWorkingDays := NoOfWorkingDays + 1;
                                    end;
                                end;
                                if LeaveTypes."Off/Holidays Days Leave" then
                                    ;

                            end;
                            NextWorkingDate := CALCDATE('1D', NextWorkingDate);
                        until NoOfWorkingDays = FullDays;

                        "End Date" := NextWorkingDate - 1;

                        "Resumption Date" := NextWorkingDate;
                    end;
                end else
                    if ("Days Applied" <> 0) and ("Days Applied" < 1) then begin
                        "End Date" := "Start Date";
                        "Resumption Date" := "Start Date";

                    end;
                HumanResSetup.RESET();
                HumanResSetup.GET();
                HumanResSetup.TESTFIELD(HumanResSetup."Base Calender Code");
                NonWorkingDay := false;
                if "Start Date" <> 0D then begin
                    while NonWorkingDay = false
                      do begin
                        NonWorkingDay := CalendarMgmt.CheckDateStatus(HumanResSetup."Base Calender Code", "Resumption Date", Dsptn);
                        if NonWorkingDay then begin
                            NonWorkingDay := false;
                            "Resumption Date" := CALCDATE('1D', "Resumption Date");
                        end
                        else begin
                            NonWorkingDay := true;
                        end;
                    end;
                end;


                LeaveTypes.GET("Leave Code");

                if LeaveTypes."Annual Leave" = true then begin
                    //New Joining Employees
                    if emp.GET("Employee No") then begin
                        if ("Date of Joining Company" > "Fiscal Start Date") then begin

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
                                VALIDATE("Leave Code");
                            end;
                        end;
                    end;
                end;

                //*****************************Validate for overlapping leave days**************************//
                if ("Start Date" <> 0D) then begin
                    //  CodeFactory.CheckForOverLappingDays("Employee No", "Start Date", "End Date", "Application No");
                end;
                //*******************************Validate for overlapping leave days***************************//

            end;
        }
        field(6; "End Date"; Date)
        {

            trigger OnValidate();
            begin
                //"Approved To Date":="To Date";
                if xRec.Status <> Status::Open then
                    ERROR('You cannot change an approved document');
                if "Start Date" <> 0D then
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

                if ("Leave Status" = "Leave Status"::Approved) and (xRec."Leave Status" <> "Leave Status"::Approved) then begin
                    ;
                    "Approval Date" := TODAY;
                    "Approved Days" := xRec."Days Applied";
                    //MODIFY;

                    LeaveTypes.GET("Leave Code");

                    if LeaveTypes."Annual Leave" = true then begin


                        /*
                        emp.RESET;
                        IF emp.GET("Employee No") THEN BEGIN

                          //For employees on contract by Jacob
                          IF (emp."Posting Group"='TEMP') OR (emp."Posting Group"='INTERN') THEN BEGIN
                             EmployeeContracts.RESET;
                             EmployeeContracts.SETRANGE(EmployeeContracts."Employee No","Employee No");
                             EmployeeContracts.SETRANGE(EmployeeContracts.Expired,FALSE);
                             IF EmployeeContracts.FIND('-') THEN BEGIN
                              IF (EmployeeContracts."Contract Start Date"<"Start Date") AND (EmployeeContracts."Contract End Date">"Start Date") THEN
                                EmployeeContracts."Contract Leave Balance":=EmployeeContracts."Contract Leave Balance"-"Approved Days";
                                // "Leave balance":=EmployeeContracts."Contract Leave Balance";
                                EmployeeContracts.VALIDATE(EmployeeContracts."Contract Leave Balance");
                                EmployeeContracts.MODIFY;

                               "Employee Leaves".RESET;
                               "Employee Leaves".SETRANGE("Employee Leaves"."Employee No","Employee No");
                               "Employee Leaves".SETRANGE("Employee Leaves"."Leave Code","Leave Code");
                               "Employee Leaves".SETRANGE("Employee Leaves"."Temp. Emp. Contract",EmployeeContracts."Contract No");
                               IF "Employee Leaves".FIND('-') THEN;
                                "Employee Leaves".Balance:="Employee Leaves".Balance - "Approved Days";
                                "Employee Leaves".VALIDATE("Employee Leaves".Balance);
                                 "Employee Leaves".MODIFY;
                             END;
                           END
                           ELSE
                           */

                        "Employee Leaves".RESET;
                        "Employee Leaves".SETRANGE("Employee Leaves"."Employee No", "Employee No");
                        "Employee Leaves".SETRANGE("Employee Leaves"."Leave Code", "Leave Code");
                        if "Employee Leaves".FIND('-') then begin

                            "Employee Leaves".Balance := "Employee Leaves".Balance - "Approved Days";
                            // "Employee Leaves".VALIDATE("Employee Leaves".Balance);

                            // "Leave balance":="Employee Leaves".Balance;
                            //"Balance brought forward":=EmpLeave."Balance Brought Forward";
                            "Employee Leaves".MODIFY;

                        end;
                    end
                    else
                        if ("Leave Status" <> "Leave Status"::Approved) and (xRec."Leave Status" = "Leave Status"::Approved) then begin
                            "Approval Date" := TODAY;
                            //"Approved Days" := 0;
                            "Employee Leaves".RESET;
                            "Employee Leaves".SETRANGE("Employee Leaves"."Employee No", "Employee No");
                            "Employee Leaves".SETRANGE("Employee Leaves"."Leave Code", "Leave Code");
                            if "Employee Leaves".FIND('-') then;
                            "Employee Leaves".Balance := "Employee Leaves".Balance + "Approved Days";
                            "Employee Leaves".VALIDATE("Employee Leaves".Balance);

                            "Employee Leaves".MODIFY;
                        end;

                end;

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
        field(19; "Leave Allowance Payable"; Boolean)
        {

            trigger OnValidate();
            begin
                HumanResSetup.GET;
                if LeaveTypes.Get("Leave Code") then begin
                    if not LeaveTypes."Annual Leave" then
                        Error('Leave Allowance only payable to annual Leaves.');
                    if EmpRec.Get("Employee No") then begin
                        if (emp."Posting Group" = 'TEMP') or (emp."Posting Group" = 'INTERN') then
                            ERROR('Temporary Employees are not paid leave allowance');

                        if EmpRec."Date Of Join" = 0D then
                            Error('Please contact Your HR to assign you a date of Joining the organisation');

                        if EmpRec."Contract Start Date" = 0D then
                            Error('Please contact Your HR to assign you a contract start date');

                        if CalcDate('6M', EmpRec."Date Of Join") > Today then
                            Error('You must be omre than 6M in the organisation to request for Leave pay');

                    end;

                    if "Leave Allowance Payable" = true then begin

                        if emp.GET("Employee No") then
                            // BEGIN
                            if (emp."Posting Group" = 'TEMP') or (emp."Posting Group" = 'INTERN') then
                                ERROR('Temporary Employees are not paid leave allowance');


                        leaveapp.RESET;
                        leaveapp.SETRANGE(leaveapp."Employee No", "Employee No");
                        leaveapp.SETRANGE(leaveapp."Maturity Date", "Maturity Date");
                        leaveapp.SETRANGE(leaveapp.Status, leaveapp.Status::Approved);
                        leaveapp.SETRANGE(leaveapp."Leave Allowance Payable", true);
                        if leaveapp.FIND('-') then
                            ERROR('Leave allowance has already been paid in leave application %1', leaveapp."Application No");

                        AccPeriod.RESET;
                        AccPeriod.SETRANGE(AccPeriod."Starting Date", 0D, TODAY);
                        AccPeriod.SETRANGE(AccPeriod."New Fiscal Year", TRUE);
                        IF AccPeriod.FIND('+') THEN
                            FiscalStart := AccPeriod."Starting Date";

                        FiscalEnd := CALCDATE('1Y', FiscalStart) - 1;

                        assmatrix.RESET;
                        assmatrix.SETRANGE(assmatrix."Payroll Period", "Fiscal Start Date", "Maturity Date");
                        assmatrix.SETRANGE(assmatrix."Employee No", leaveapp."Employee No");
                        assmatrix.SETRANGE(assmatrix.Type, assmatrix.Type::Payment);
                        assmatrix.SETRANGE(assmatrix.Code, HumanResSetup."Leave Allowance Code");
                        if assmatrix.FIND('-') then begin
                            LeaveAllowancePaid := true;
                            ERROR('Leave allowance has already been paid in %1', assmatrix."Payroll Period");
                        end;

                        if "Days Applied" < HumanResSetup."Qualification Days (Leave)" then
                            ERROR('You can only be paid leave allowance if you take %1 or more Days', HumanResSetup."Qualification Days (Leave)");

                    end;
                end;


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
            OptionMembers = Open,Approved,"Pending Approval","Pending Prepayment",Rejected;
            /*
                        trigger OnValidate();
                        begin
                            /*
                            IF emp.GET("Employee No") THEN
                              BEGIN
                                IF emp."Posting Group"='NRS' THEN
                                  BEGIN
                                    //CCMails:='stephenngugi8@gmail.com; snprffle@gmail.com; a.gachihi@cgiar.org';
                                    CCMails:='O.Amusa@cgiar.org; W.Oladokun@cgiar.org';
                                    END
                                    ELSE IF emp."Posting Group"='IRS' THEN
                                      BEGIN
                                        //CCMails:='stephenngugi8@gmail.com; snprffle@gmail.com; a.gachihi@cgiar.org';
                                        CCMails:='L.Mendoza@cgiar.org; A.Akinsoji@cgiar.org; O.Babatunde-Lawal@cgiar.org';
                                        END;
                                END;



                            case Status of
                                Status::"Pending Approval":
                                    begin
                                        //***********************************************************************
                                        //***************************Send Application Email Notification*******************************
                                        SMTPSetup.GET();
                                        //*****************************Applicant Mail**************************
                                        if EmpRec.GET("Employee No") then begin
                                            /*CodeFactory.GlobalSendEmailNotification("Application No", 'IITA HR OFFICE', '', "Employee Name", EmpRec."E-Mail", 'LEAVE APPLICATION',
                                                        STRSUBSTNO(LeaveMessage, "Employee Name", "Application No", 'IITA Human Resources', ''), '');
                                        end;
                                        //*****************************End Applicant Mail*************************

                                        //*************************************Reliever Mail************************************
                                        if EmpRec.GET("Acting Person") then begin
                                           /* CodeFactory.GlobalSendEmailNotification("Application No", 'IITA HR OFFICE', '', Name, EmpRec."E-Mail", 'LEAVE RELIEVER NOTIFICATION',
                                                        STRSUBSTNO(RelieverEmail, Name, "Employee Name", FORMAT("Start Date", 0, '<Day,2>/<Month,2>/<Year4>'), FORMAT("End Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                                        'IITA Human Resources', ''), '');
                                        end;
                                        //*************************************Reliever Mail*************************************
                                        //***************************Send Application Email Notification*******************************

                                        //***********************************************************************
                                    end;
                                Status::Approved:
                                    begin
                                        //*****************************Applicant Mail**************************
                                        if EmpRec.GET("Employee No") then begin
                                            /*CodeFactory.GlobalSendEmailNotification("Application No", 'IITA HR OFFICE', '', "Employee Name", EmpRec."E-Mail", 'LEAVE APPLICATION APPROVAL',
                                                        STRSUBSTNO(LeaveMessageApproved, "Employee Name", "Leave Code", "Days Applied", FORMAT("Start Date", 0, '<Day,2>/<Month,2>/<Year4>'), FORMAT("End Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                                        FORMAT("Resumption Date", 0, '<Day,2>/<Month,2>/<Year4>'), 'IITA Human Resources', ''), CCMails);
                                        end;
                                        //*****************************End Applicant Mail**************************
                                    end;
                                Status::Rejected:
                                    begin
                                        if emp.GET("Employee No") then begin
                                            ObjCommentLine.RESET;
                                            ObjCommentLine.SETRANGE("Document No.", "Application No");
                                            if ObjCommentLine.FIND('-') then begin
                                                RejectionComment := ObjCommentLine.Comment;
                                            end;

                                            //***********************************************************************
                                            CodeFactory.GlobalSendEmailNotification("Application No", 'IITA HR OFFICE', '', "Employee Name", emp."E-Mail", 'LEAVE REJECTION',
                                                         STRSUBSTNO(LeaveRejection, "Employee Name", FORMAT("Start Date", 0, '<Day,2>/<Month,2>/<Year4>'), FORMAT("End Date", 0, '<Day,2>/<Month,2>/<Year4>'),
                                                         RejectionComment, 'IITA Human Resources', ''), CCMails);
                                            //**********************************************************************
                                        end;

                                    end;
                            end;


                        end;
                        */
        }
        field(28; "Leave Entitlment"; Decimal)
        {
        }
        field(29; "Total Leave Days Taken"; Decimal)
        {
            CalcFormula = Sum("Employee Leave Application"."Days Applied" WHERE(Status = CONST(Approved),
                                                                                 "Employee No" = FIELD("Employee No"),
                                                                                 "Leave Code" = FIELD("Leave Code"),
                                                                                 "Maturity Date" = FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(30; "Acting Person"; Code[30])
        {
            TableRelation = Employee WHERE(Status = FILTER(Active));

            trigger OnValidate();
            begin
                if xRec.Status <> Status::Open then
                    ERROR('You cannot change an already approved document');


                if "Acting Person" = "Employee No" then
                    ERROR('You cannot select your own ID in this field');

                emp.RESET;
                if emp.GET("Acting Person") then
                    Name := emp."First Name" + ' ' + emp."Middle Name" + ' ' + emp."Last Name";
            end;
        }
        field(31; Name; Text[50])
        {
            Editable = false;
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
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("Employee No"),
                                                                             "Leave Recalled No." = FIELD("Application No")));
            FieldClass = FlowField;
        }
        field(41; "Off Days"; Decimal)
        {
            CalcFormula = Sum("Holidays_Off Days"."No. of Days" WHERE("Employee No." = FIELD("Employee No"),
                                                                       "Leave Type" = FIELD("Leave Code"),
                                                                       "Maturity Date" = FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(42; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate();
            begin
                //***************get directorate Name*****************//
                DimVal.RESET;
                DimVal.SETRANGE("Global Dimension No.", 1);
                DimVal.SETRANGE(Code, "Global Dimension 1 Code");
                if DimVal.FIND('-') then
                    "Department Name" := DimVal.Name;

                //***************get directorate Name*****************//
            end;
        }
        field(43; "User ID"; Code[30])
        {
        }
        field(45; "Days Absent"; Decimal)
        {
            CalcFormula = Sum("Employee Absentism"."No. of  Days Absent" WHERE("Employee No" = FIELD("Employee No"),
                                                                                Status = CONST(Released),
                                                                                "Maturity Date" = FIELD("Maturity Date")));
            FieldClass = FlowField;
        }
        field(46; "Contract No."; Code[20])
        {
        }
        field(47; "Pending Approver"; Code[30])
        {
            CalcFormula = Lookup("Approval Entry"."Approver ID" WHERE("Document No." = FIELD("Application No"),
                                                                       Status = CONST(Open)));
            FieldClass = FlowField;
        }
        field(48; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(49; "Department Name"; Text[50])
        {
        }
        field(50; "Directorate name"; Text[50])
        {
        }
        field(51; "No. of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID" = CONST(51511209),
                                                        "Document No." = FIELD("Application No")));
            FieldClass = FlowField;
        }
        field(52; "Current Payroll Period"; Date)
        {
            TableRelation = "Payroll Period"."Starting Date";
        }
        field(53; "Country/Region Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Code;
        }
        field(54; Gender; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Both,Male,Female';
            OptionMembers = Both,Male,Female;
        }
        field(55; Attachment; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Global Dimension 3 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(3, "Global Dimension 3 Code");
            end;
        }
        field(57; "Global Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Global Dimension 4 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            end;
        }
        field(58; "Global Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Global Dimension 5 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(5, "Global Dimension 5 Code");
            end;
        }
        field(59; "Global Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Global Dimension 6 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(6, "Global Dimension 6 Code");
            end;
        }
        field(60; "Global Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Global Dimension 7 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(7, "Global Dimension 7 Code");
            end;
        }
        field(61; "Global Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Global Dimension 8 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8));

            trigger OnValidate();
            begin
                ValidateShortcutDimCode(8, "Global Dimension 8 Code");
            end;
        }
        field(62; "Requires Attachment"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Leave Days Credited Back"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Hide Application"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(65; "On Leave"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Attachnemt Uploaded"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(67; Extension; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "PV No."; Code[20])
        {

        }

    }

    keys
    {
        key(Key1; "Application No")
        {
            SumIndexFields = days;
        }
        key(Key2; "Employee No", Status, "Leave Code", "Maturity Date")
        {
            SumIndexFields = "Days Applied", "Approved Days";
        }
        key(Key3; "Employee No", Status, "Leave Code", "Contract No.")
        {
            SumIndexFields = "Days Applied", "Approved Days";
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Application No", "Leave Code", "Employee No", "Employee Name", "Start Date", "End Date", "Days Applied")
        {
        }
    }

    trigger OnDelete();
    begin
        //ERROR('You are not allowed to delete leave entry');
        /*
         IF Post=TRUE THEN
         ERROR('You cannot Delete the Record');
        
        IF Status<>Status::Open THEN
        ERROR('You cannot delete a document that is already approved or pending approval');
        */

    end;

    trigger OnInsert();
    begin
        if "Application No" = '' then begin
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Leave Application Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Leave Application Nos.", xRec."No. series", 0D, "Application No", "No. series");
        end;

        "Application Date" := TODAY;
        "User ID" := USERID;

        //**************************Get Fiscal Start Date******************************//
        ObjLeavePeriod.RESET;
        ObjLeavePeriod.SETRANGE(Closed, false);
        ObjLeavePeriod.SETRANGE("Period Code", '=%1', FORMAT(DATE2DMY(TODAY, 3)));
        if ObjLeavePeriod.FINDFIRST then begin
            "Fiscal Start Date" := ObjLeavePeriod."Starting Date";
            "Maturity Date" := ObjLeavePeriod."Ending Date";
        end else
            ERROR('Update Leave Periods');

        //**************************Get Fiscal Start Date******************************//

        if UserSertup.GET(USERID) then begin
            "Employee No" := UserSertup."Employee No.";

            if EmpRec.GET("Employee No") then begin
                "Country/Region Code" := EmpRec."Country/Region Code";
                "Global Dimension 1 Code" := EmpRec."Global Dimension 1 Code";
                "Global Dimension 2 Code" := EmpRec."Global Dimension 2 Code";
                "Mobile No" := EmpRec."Mobile Phone No.";
                "Date of Joining Company" := EmpRec."Date Of Join";
                "Contract No." := emp."Contract Number";


                if EmpRec.Gender = EmpRec.Gender::Male then
                    Gender := Gender::Male;
                if EmpRec.Gender = EmpRec.Gender::Female then
                    Gender := Gender::Female;

                //***************get directorate Name*****************//
                DimVal.RESET;
                DimVal.SETRANGE("Global Dimension No.", 1);
                DimVal.SETRANGE(Code, "Global Dimension 1 Code");
                if DimVal.FINDLAST then
                    "Department Name" := DimVal.Name;

                //***************get directorate Name*****************//
                //**********************Department Name*******************//
                DimVal.RESET;
                DimVal.SETRANGE("Global Dimension No.", 2);
                DimVal.SETRANGE(Code, "Global Dimension 2 Code");
                if DimVal.FINDLAST then
                    "Directorate name" := DimVal.Name;
                //**********************Department Name*******************//
            end;
        end;

        VALIDATE("Employee No");


        ////***********************Find Maturity date
        //FindMaturityDate;


        PayrollPeriod.RESET;
        PayrollPeriod.SETFILTER(Closed, '%1', true);
        if PayrollPeriod.FINDLAST then begin
            "Current Payroll Period" := CALCDATE('1M', PayrollPeriod."Starting Date");
        end;


        EmployeeAbsentism.RESET;
        EmployeeAbsentism.SETFILTER("Employee No", "Employee No");
        EmployeeAbsentism.SETFILTER(Approved, '%1', true);
        EmployeeAbsentism.SETFILTER(Status, '%1', EmployeeAbsentism.Status::Released);
        EmployeeAbsentism.SETFILTER("Maturity Date", '%1', "Maturity Date");
        if EmployeeAbsentism.FINDSET then
            repeat
                "Days Absent" := "Days Absent" + EmployeeAbsentism."No. of  Days Absent";
            until EmployeeAbsentism.NEXT = 0;


        //*********************Prevent Creation of leave if another is open*******************//
        leaveapp.RESET;
        leaveapp.SETRANGE(leaveapp."Employee No", "Employee No");
        leaveapp.SETFILTER(leaveapp.Status, '=%1', leaveapp.Status::Open);
        if leaveapp.FINDFIRST then
            ERROR('Please submit the leave application %1  for approval before creating another one', leaveapp."Application No");

        /*
        //*********************Prevent Creation of leave application pending an earlier approval request*******************/
        leaveapp.RESET;
        leaveapp.SETRANGE(leaveapp."Employee No", "Employee No");
        leaveapp.SETFILTER(leaveapp.Status, '=%1', leaveapp.Status::"Pending Approval");
        IF leaveapp.FINDFIRST THEN
            ERROR('Please ensure the pending leave application %1 is approved before submitting another one', leaveapp."Application No");


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
        "Employee Leaves": Record "Employee Leave Entitlement";
        BaseCalender: Record Date;
        CurDate: Date;
        LeaveTypes: Record "Leave Types";
        DayApp: Decimal;
        Dayofweek: Integer;
        i: Integer;
        textholder: Text[30];
        emp: Record Employee;
        leaveapp: Record "Employee Leave Application";
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
        EmpLeave: Record "Employee Leave Entitlement";
        NoofMonthsWorked: Integer;
        FiscalStart: Date;
        Nextmonth: Date;
        DimVal: Record "Dimension Value";
        NonWorkingDay: Boolean;
        Dsptn: Text[30];
        AccPeriod: Record "Payroll Period";
        FiscalEnd: Date;
        EmpContracts: Record "Employee Contracts";
        EmployeeContracts: Record "Employee Contracts";
        LeavePlan: Record "Employee Leave Plan";
        FullDays: Decimal;
        HalfDays: Decimal;
        GLSetup: Record "General Ledger Setup";
        GLBudgets: Record "G/L Budget Name";
        empabsences: Record "Employee Absence";
        EmployeeAbsentism: Record "Employee Absentism";
        StaffPostingGroupRec: Record "Staff Posting Group";
        ContractPostingGroupCode: Code[10];
        InternPostingGroup: Code[10];
        CalendarCode: Code[10];
        CodeFactory: Codeunit "Code Factory";
        LeaveMessageApproved: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:10pt">Your <b>%2</b> Leave Application has been approved. </p> <p style="font-family:Verdana,Arial;font-size:10pt">Your approved days are <b>%3</b>, Starting from <b>%4</b>, through to <b>%5</b>.</p> <p style="font-family:Verdana,Arial;font-size:10pt">You will be expected to resume normal duties as on <b>%6</b>.</p> <p style="font-family:Verdana,Arial;font-size:10pt">Regards,</p> <p style="font-family:Verdana,Arial;font-size:10pt">%7</p> <p style="font-family:Verdana,Arial;font-size:10pt">%8</p>';
        AddSetup: Record "Additional Leave Set-Up";
        SMTPSetup: Record "SMTP Mail Setup";
        UserSetup: Record "User Setup";
        LeaveMessage: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt">This is to notify you that your leave application has been received and undergoing approval. Your supervisor will be notified of this for approval.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%3</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%4</b></p>';
        SupervisorAppMail: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt"> This is to notify you that a staff, employee Number <b>%2</b> ,Name <b>%3</b> who is under your supervision has applied for a <b>%4</b> days leave starting from <b>%5</b> through to date <b>%6</b>. </p> <p style="font-family:Verdana,Arial;font-size:9pt">The reliever selected is <b>%7</b>.</p> <p style="font-family:Verdana,Arial;font-size:9pt">Should this affect your planned work schedule, or in the case that you don''t approve this, Kindly notify the HR department for further Actions.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%8,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%9,</b></p>';
        LeaveMessageCancel: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt"> This is to notify you that your leave application serial No <b>%2</b> has been cancelled. Your supervisor will be notified of this for better work planning.</p> <p style="font-family:Verdana,Arial;font-size:9pt">Kindly do not proceed for any leave before you get an approval notification.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%3</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%4</b></p>';
        SupervisorAppMailCancel: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt"> This is to notify you that a staff, employee Number <b>%2</b> ,Name <b>%3</b> who is under your supervision has applied for a <b>%4</b> days leave starting from <b>%5</b> through to date <b>%6</b>. </p> <p style="font-family:Verdana,Arial;font-size:9pt">The reliever selected is <b>%7</b>.</p> <p style="font-family:Verdana,Arial;font-size:9pt">Should this affect your planned work schedule, or in the case that you don''t approve this, Kindly notify the HR department for further Actions.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%8,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%9,</b></p>';
        ObjLeavePeriod: Record "HR Leave Periods";
        RelieverEmail: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1,</b></p> <p style="font-family:Verdana,Arial;font-size:10pt">This is to notify you that <b>%2</b> has applied for leave and appointed you as the acting person while he/she is away. You are therefore expected to take over his/her duties as from <b>%3</b> to <b>%4</b>.</p> <p style="font-family:Verdana,Arial;font-size:10pt"><b> Regards</b></p> <p style="font-family:Verdana,Arial;font-size:10pt"><b> %5</b></p> <p style="font-family:Verdana,Arial;font-size:10pt"><b> %6</b></p>';
        CCMails: Text;
        Result: Boolean;
        LeaveRejection: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:10pt">This is to notify you that your leave application for the dates <b>%2</b> to <b>%3</b> has been rejected.</p> <p style="font-family:Verdana,Arial;font-size:10pt">Reason for rejection is :- <b>%4</b>.</p> <p style="font-family:Verdana,Arial;font-size:10pt">Regards,</p> <p style="font-family:Verdana,Arial;font-size:10pt"> <b>%5</b></p> <p style="font-family:Verdana,Arial;font-size:10pt"> <b>%6</b></p>';
        ObjCommentLine: Record "Approval Comment Line";
        RejectionComment: Text;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20]);
    var
        DimMgt: Codeunit DimensionManagement;
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Employee Leave Application", "Application No", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;

    procedure CreateLeaveAllowance(var LeaveApp: Record "Employee Contracts");
    var
        HRSetup: Record "Human Resources Setup";
        AccPeriod: Record "Accounting Period";
        FiscalStart: Date;
        FiscalEnd: Date;
        ScaleBenefits: Record "Scale Benefits";
        RefDate: Date;
    begin
        /*
        IF LeaveApp."Leave Allowance Payable"=LeaveApp."Leave Allowance Payable"::"1" THEN
        BEGIN
        AccPeriod.RESET;
        AccPeriod.SETRANGE(AccPeriod."Starting Date",0D,TODAY);
        AccPeriod.SETRANGE(AccPeriod."New Fiscal Year",TRUE);
        IF AccPeriod.FIND('+') THEN
        FiscalStart:=AccPeriod."Starting Date";
        //MESSAGE('%1',FiscalStart);
        
        
        FiscalEnd:=CALCDATE('1Y',FiscalStart)-1;
        //MESSAGE('%1',FiscalEnd);
        
        LeaveApp.RESET;
        LeaveApp.SETRANGE(LeaveApp."Employee No","Employee No");
        LeaveApp.SETRANGE(LeaveApp."Maturity Date","Maturity Date");
        LeaveApp.SETRANGE(LeaveApp.Status,LeaveApp.Status::Released);
        LeaveApp.SETRANGE(LeaveApp."Leave Allowance Payable",LeaveApp."Leave Allowance Payable"::"1");
        IF LeaveApp.FIND('-') THEN
          ERROR('Leave allowance has already been paid in leave application %1',LeaveApp."Application No");
        
        {
        assmatrix.RESET;
        assmatrix.SETRANGE(assmatrix."Payroll Period",FiscalStart,FiscalEnd);
        assmatrix.SETRANGE(assmatrix."Employee No",LeaveApp."Employee No");
        assmatrix.SETRANGE(assmatrix.Type,assmatrix.Type::Payment);
        assmatrix.SETRANGE(assmatrix.Code,HRSetup."Leave Allowance Code");
        IF assmatrix.FIND('-') THEN
        BEGIN
        LeaveAllowancePaid:=TRUE;
        ERROR('Leave allowance has already been paid in %1',assmatrix."Payroll Period");
        END;
        
        
        IF NOT LeaveAllowancePaid THEN
        BEGIN
        
        
        
        IF HRSetup.GET THEN
        BEGIN
        IF "Days Applied">=HRSetup."Qualification Days (Leave)" THEN
        BEGIN
          IF emp.GET("Employee No") THEN
          BEGIN
          {
            ScaleBenefits.RESET;
            ScaleBenefits.SETRANGE(ScaleBenefits."Salary Scale",emp."Salary Scale");
            ScaleBenefits.SETRANGE(ScaleBenefits."Salary Pointer",emp.Present);
            ScaleBenefits.SETRANGE(ScaleBenefits."ED Code",HRSetup."Leave Allowance Code");
            IF ScaleBenefits.FIND('-') THEN
            BEGIN
          }
               PayrollPeriod.RESET;
               PayrollPeriod.SETRANGE(PayrollPeriod."Close Pay",FALSE);
               IF PayrollPeriod.FIND('-') THEN
               PayPeriodStart:=PayrollPeriod."Starting Date";
        
              HRSetup.GET;
              RefDate:=CALCDATE(HRSetup."Monthly PayDate",PayPeriodStart);
              IF LeaveApp."Application Date">RefDate THEN
               PayPeriodStart:=CALCDATE('1M',PayPeriodStart);
        
        
              assmatrix.INIT;
              assmatrix."Employee No":="Employee No";
              assmatrix.Type:=assmatrix.Type::Payment;
              assmatrix.Code:=HRSetup."Leave Allowance Code";
              assmatrix.VALIDATE(assmatrix.Code);
              assmatrix."Payroll Period":=PayPeriodStart;
              assmatrix.VALIDATE("Payroll Period");
              assmatrix.Amount:=ScaleBenefits.Amount;
              IF NOT assmatrix.GET(assmatrix."Employee No",assmatrix.Type,assmatrix.Code,assmatrix."Payroll Period") THEN
              assmatrix.INSERT;
         // END;
          END;
        
        END;
        
        
        
        
        END;
        //MESSAGE('Your leave allowance for this year has already been paid');
        END;
        }
        END;
        */

    end;

    procedure FindMaturityDate();
    var
        AccPeriod: Record "Payroll Period";
    begin
        GLSetup.RESET;
        GLSetup.GET;
        /*GLSetup.TESTFIELD("Current Budget");
        GLBudgets.RESET;
        GLBudgets.GET(GLSetup."Current Budget");
        GLBudgets.TESTFIELD("Start Date");
        GLBudgets.TESTFIELD("End Date");
        "Fiscal Start Date" := GLBudgets."Start Date";
        "Maturity Date" := GLBudgets."End Date";
        
        AccPeriod.RESET;
        AccPeriod.SETRANGE(AccPeriod."Starting Date",0D,TODAY);
        AccPeriod.SETRANGE(AccPeriod."New Fiscal Year",TRUE);
        IF AccPeriod.FIND('+') THEN
        BEGIN
        FiscalStart:=AccPeriod."Starting Date";
        MaturityDate:=CALCDATE('1Y',AccPeriod."Starting Date")-1;
        END;
        */

    end;

    procedure CreateLeaveAllowancePayroll(leaverec: Record "Employee Leave Application");
    var
        assignMatrix1: Record "Assignment Matrix";
        scalebenefits: Record "Scale Benefits";
        emprec: Record Employee;
        Mailheader: Text;
        MailBody: Text;
        SMTPRec: Record "SMTP Mail Setup";
        SMTPCu: Codeunit "SMTP Mail";
        usersetup: Record "User Setup";
        ObjLeaveRec: Record "Employee Leave Application";
        ObjPayrollPeriod: Record "Payroll Period";

    begin
        HumanResSetup.GET;
        HumanResSetup.TESTFIELD("Leave Allowance Code");
        HumanResSetup.TestField("Leave Deduction Code");

        GLSetup.GET;
        ObjLeaveRec.Reset();
        ObjLeaveRec.SetRange("Application No", leaverec."Application No");
        if ObjLeaveRec.Find('-') then begin
            if ObjLeaveRec."Leave Allowance Payable" = true then begin
                //******************Check if Allowance close date reached*****************//
                ObjPayrollPeriod.Reset();
                ObjPayrollPeriod.SetRange("Starting Date", ObjLeaveRec."Current Payroll Period");
                if ObjPayrollPeriod.Find('-') then begin
                    ObjPayrollPeriod.TestField("L.Allowance Cutoff Date");
                    if Today > ObjPayrollPeriod."L.Allowance Cutoff Date" then begin
                        ObjLeaveRec."Current Payroll Period" := CalcDate('1M', ObjPayrollPeriod."Starting Date");
                        ObjLeaveRec.Modify();
                    end
                end;
                //******************Check if Allowance close date reached*****************//
                //********************Delete Both earning and ded if exists any
                assignMatrix1.Reset();
                assignMatrix1.SetRange("Payroll Period", ObjLeaveRec."Current Payroll Period");
                assignMatrix1.SetRange("Employee No", ObjLeaveRec."Employee No");
                assignMatrix1.SetFilter(Code, '%1|%2', HumanResSetup."Leave Allowance Code", HumanResSetup."Leave Deduction Code");
                if assignMatrix1.FindSet() then
                    assignMatrix1.DeleteAll();

                //*************Earning PASS*******************//
                assignMatrix1.Init();
                assignMatrix1."Employee No" := ObjLeaveRec."Employee No";
                assignMatrix1.Type := assignMatrix1.Type::Payment;
                assignMatrix1.Code := HumanResSetup."Leave Allowance Code";
                assignMatrix1."Payroll Period" := ObjLeaveRec."Current Payroll Period";
                assignMatrix1.VALIDATE("Employee No");
                assignMatrix1.VALIDATE(Code);
                assignMatrix1.VALIDATE(Amount);
                assignMatrix1.Insert(true);
                //*************Earning PASS*******************//

                //*************Deduction PASS*******************//
                assignMatrix1.Init();
                assignMatrix1."Employee No" := ObjLeaveRec."Employee No";
                assignMatrix1.Type := assignMatrix1.Type::Deduction;
                assignMatrix1.Code := HumanResSetup."Leave Deduction Code";
                assignMatrix1."Payroll Period" := ObjLeaveRec."Current Payroll Period";
                assignMatrix1.VALIDATE("Employee No");
                assignMatrix1.VALIDATE(Code);
                assignMatrix1.VALIDATE(Amount);
                assignMatrix1.Insert(true);
                //*************Deduction PASS*******************//

            end;
        end;


        //*****************************Create Payment Document For the leave allowance***************************//

        //*****************************Create Payment Document For the leave allowance***************************//


        //Send E-mail to the Leave Creator
        /*SMTPRec.RESET;
        SMTPRec.GET;
        usersetup.RESET;
        usersetup.GET(leaverec."User ID");
        usersetup.TESTFIELD("E-Mail");
        Mailheader := 'Leave Application :' + leaverec."Application No" + ' Approved';
        MailBody := 'Dear ' + usersetup."User ID" + ',<br><br>';
        MailBody := MailBody + 'Leave Application No: <b>' + leaverec."Application No" + '</b> has been Approved.<br><br>';
        MailBody := MailBody + 'Kind Regards<br><br>';
        SMTPCu.CreateMessage('Leave Info', SMTPRec."User ID", usersetup."E-Mail", Mailheader, MailBody, TRUE);
        SMTPCu.AddBCC('kibetbriann@gmail.com');
        SMTPCu.Send;*/


    end;

    local procedure FnGetLeaveStatistics(LeaveType: Code[20]);
    var
        ObjEmpRec: Record Employee;
    begin
        if ObjEmpRec.GET("Employee No") then begin
            if LeaveTypes.GET(LeaveType) then begin
                //**************************Get Employee Leave earned to date********************************//
                if ObjEmpRec."Employment Status" = ObjEmpRec."Employment Status"::Confirmed then begin
                    "Leave Earned to Date" := ROUND(((AddSetup."Total Days Entitled" / (CALCDATE('1Y-1D', "Fiscal Start Date") - "Fiscal Start Date")) * ("Application Date" - "Fiscal Start Date")), 0.5, '<');
                    "Leave Entitlment" := LeaveTypes.Days;
                end;

                //**************************Get Employee Leave earned to date********************************//
            end;
            //**************************Get Leave Balance********************************************//
            if LeaveTypes."Annual Leave" then begin
                ObjEmpRec.SETFILTER("Leave Type Filter", LeaveType);
                ObjEmpRec.SETFILTER("Date Filter", '%1..%2', CALCDATE('-CY', "Application Date"), CALCDATE('CY', "Application Date"));
                ObjEmpRec.CALCFIELDS("Total Leavedays Allocated", "Total Leavedays Taken", "Total Recalled Days", "Total Credited Back", "Balance Carried Forward");
                "Balance brought forward" := ObjEmpRec."Balance Carried Forward";
                "Leave balance" := (ObjEmpRec."Total Leavedays Allocated" + ObjEmpRec."Balance Carried Forward") - (ObjEmpRec."Total Leavedays Taken" - ObjEmpRec."Total Recalled Days" - ObjEmpRec."Total Credited Back");
            end else begin
                ObjEmpRec.SETFILTER("Leave Type Filter", LeaveType);
                ObjEmpRec.SETFILTER("Date Filter", '%1..%2', CALCDATE('-CY', "Application Date"), CALCDATE('CY', "Application Date"));
                ObjEmpRec.CALCFIELDS("Total Leavedays Allocated", "Total Leavedays Taken", "Total Recalled Days", "Total Credited Back", "Balance Carried Forward");
                "Balance brought forward" := ObjEmpRec."Balance Carried Forward";
                "Leave balance" := "Leave Entitlment" - (ObjEmpRec."Total Leavedays Taken" - ObjEmpRec."Total Recalled Days" - ObjEmpRec."Total Credited Back");
            end;
            //**************************Get Leave Balance********************************************//

        end;
    end;


    procedure FnPostLeaveApplication();
    var
        LeaveGjline: Record "HR Journal Line";
        LineNumber: Integer;
    begin
        HumanResSetup.RESET;
        if HumanResSetup.FIND('-') then begin
            HumanResSetup.TESTFIELD(HumanResSetup."Leave Template");
            HumanResSetup.TESTFIELD(HumanResSetup."Leave Batch");

            //**************************Clear Journal***********************//
            LeaveGjline.RESET;
            LeaveGjline.SETRANGE("Journal Template Name", HumanResSetup."Leave Template");
            LeaveGjline.SETRANGE("Journal Batch Name", HumanResSetup."Leave Batch");
            LeaveGjline.DELETEALL;
            //**************************Clear Journal***********************//

            //**************************Create Jn Entry*********************//
            LineNumber := LineNumber + 1000;
            CodeFactory.FnCreateLeaveLedgerEntries(LineNumber, HumanResSetup."Leave Template", HumanResSetup."Leave Batch", "Application No", "Employee No",
                                  FORMAT(DATE2DMY("Fiscal Start Date", 3)), TODAY, LeaveGjline."Leave Entry Type"::Negative, 0D, FORMAT("Leave Code") + ' ' + 'Leave Applied',
                                  "Leave Code", "Days Applied", "Global Dimension 1 Code", "Global Dimension 2 Code", '', false, LeaveGjline."Transaction Type"::"Leave Applied");
            //**************************Create Jn Entry*********************//

            //**************************Post Jn Entry*********************//
            LeaveGjline.RESET;
            LeaveGjline.SETRANGE("Journal Template Name", HumanResSetup."Leave Template");
            LeaveGjline.SETRANGE("Journal Batch Name", HumanResSetup."Leave Batch");
            if LeaveGjline.FIND('-') then begin
                CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post Line", LeaveGjline);
            end;
            //**************************Post Jn Entry*********************//
        end;

        Post := true;
        MODIFY;
    end;

    procedure FnPostLeaveReversal();
    var
        LeaveGjline: Record "HR Journal Line";
        LineNumber: Integer;
    begin
        if Post then begin
            HumanResSetup.RESET;
            if HumanResSetup.FIND('-') then begin
                HumanResSetup.TESTFIELD(HumanResSetup."Leave Template");
                HumanResSetup.TESTFIELD(HumanResSetup."Leave Batch");

                //**************************Clear Journal***********************//
                LeaveGjline.RESET;
                LeaveGjline.SETRANGE("Journal Template Name", HumanResSetup."Leave Template");
                LeaveGjline.SETRANGE("Journal Batch Name", HumanResSetup."Leave Batch");
                LeaveGjline.DELETEALL;
                //**************************Clear Journal***********************//

                //**************************Create Jn Entry*********************//
                LineNumber := LineNumber + 1000;
                CodeFactory.FnCreateLeaveLedgerEntries(LineNumber, HumanResSetup."Leave Template", HumanResSetup."Leave Batch", "Application No", "Employee No",
                                      FORMAT(DATE2DMY("Fiscal Start Date", 3)), TODAY, LeaveGjline."Leave Entry Type"::Positive, 0D, FORMAT("Leave Code") + ' ' + 'Leave Reversed',
                                      "Leave Code", "Days Applied", "Global Dimension 1 Code", "Global Dimension 2 Code", '', false, LeaveGjline."Transaction Type"::Reversal);
                //**************************Create Jn Entry*********************//

                //**************************Post Jn Entry*********************//
                LeaveGjline.RESET;
                LeaveGjline.SETRANGE("Journal Template Name", HumanResSetup."Leave Template");
                LeaveGjline.SETRANGE("Journal Batch Name", HumanResSetup."Leave Batch");
                if LeaveGjline.FIND('-') then begin
                    CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post Line", LeaveGjline);
                end;
                //**************************Post Jn Entry*********************//
            end;

            Post := false;
            MODIFY;
        end;
    end;

    procedure FnGetEMployeePostingGroup(EmployeeNo: Code[20]): Boolean;
    var
        ObjEmp: Record Employee;
        VarCheck: Boolean;
    begin
        if ObjEmp.GET(EmployeeNo) then begin

        end;

        exit(VarCheck);
    end;


}

