report 51513116 "Payroll Run"
{
    // version PAYROLL

    ProcessingOnly = true;

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "No.", "Posting Group";

            trigger OnAfterGetRecord();
            var
                LoanApp: Record "Loan Application";
                Loans: Record "Loan Product Type";
                LoanTopup: Record "Loan Top-up";
                OpenBal: Decimal;
                LoanInterest: Decimal;
                bracketrec: Record "Brackets Lines";
                assignmentmat: Record "Assignment Matrix";
            begin
                //If Date of leaving is Past & the Employee is Inactive Clear his Payroll Info======
                //GetPayPeriod(Employee."No.");
                //IF BeginDate <> DateSpecified THEN
                //  Month:=BeginDate;
                if Employee.Status = Employee.Status::Active then begin
                    if Employee."Date Of Leaving" <> 0D then begin
                        if Employee."Date Of Leaving" < Month then begin
                            conftxt := 'Please Note that Employee No: ' + Employee."No." + '- ' + Employee."First Name" + ' ' + Employee."Last Name" + ' \has a Date of Leaving that is ' + FORMAT(Employee."Date Of Leaving") + ' which is Past as Compared to this';
                            conftxt := conftxt + ' Payroll Period-' + FORMAT(Month) + '\Do you want to Clear his Payroll Information for this Month?';
                            conf := CONFIRM(conftxt);
                            if FORMAT(conftxt) = 'Yes' then begin
                                Assignmatrix.RESET;
                                Assignmatrix.SETFILTER("Payroll Period", '%1', Month);
                                Assignmatrix.SETFILTER("Employee No", Employee."No.");
                                if Assignmatrix.FINDSET then
                                    repeat
                                        Assignmatrix.DELETE;
                                    until Assignmatrix.NEXT = 0;
                            end;
                        end;
                    end;
                    //For
                    DaysInMonth := 0;
                    DaysWorked := 0;
                    // Check for working days
                    if HrPost.GET(Employee."Posting Group") then begin
                        if HrPost."Prorate Salary" = true then begin
                            //Insert Full pay if not specified
                            Earnings.RESET;
                            Earnings.SETRANGE("Gross Pay Entry", true);
                            Earnings.SETRANGE("Basic Pay Arrears", false);
                            if Earnings.FIND('-') then begin
                                repeat
                                    Assignmatrix.RESET;
                                    Assignmatrix.SETRANGE("Employee No", "No.");
                                    Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                    Assignmatrix.SETRANGE(Code, Earnings.Code);
                                    Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                                    if Assignmatrix.FIND('-') then begin
                                        /*FullPay.RESET;
                                        FullPay.SETRANGE("Employee No", Assignmatrix."Employee No");
                                        FullPay.SETRANGE(Code, Assignmatrix.Code);
                                        if not FullPay.FIND('-') then begin
                                            FullPay.INIT;
                                            FullPay."Employee No" := Assignmatrix."Employee No";
                                            FullPay.Code := Assignmatrix.Code;
                                            FullPay.VALIDATE(Code);
                                            FullPay.Amount := Assignmatrix.Amount;
                                            if FullPay.Amount <> 0 then
                                                FullPay.INSERT;
                                        end;*/
                                    end;
                                until Earnings.NEXT = 0;
                            end;
                            if ((Employee."Employment Date" = 0D) and (Employee."Date Of Join" <> 0D)) then begin
                                Employee."Employment Date" := Employee."Date Of Join";

                            end;
                            // Check for days worked
                            EndMonth := CALCDATE('CM', Month);
                            DaysInMonth := EndMonth - Month + 1;
                            if Employee."Employment Date" <> 0D then begin
                                DaysWorked := EndMonth - Employee."Employment Date" + 1;
                                //Calculate salary
                                if Employee."Termination Date" <> 0D then
                                    DaysWorked := Employee."Termination Date" - Month + 1;

                                if DaysWorked < DaysInMonth then begin
                                    Earnings.RESET;
                                    Earnings.SETRANGE("Gross Pay Entry", true);
                                    Earnings.SETRANGE("Basic Pay Arrears", false);
                                    if Earnings.FIND('-') then begin
                                        repeat
                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE("Employee No", Employee."No.");
                                            Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                            Assignmatrix.SETRANGE(Code, Earnings.Code);
                                            Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                                            if Assignmatrix.FIND('-') then begin
                                                /*FullPay.RESET;
                                                FullPay.SETRANGE("
                                                 No", Assignmatrix."Employee No");
                                                FullPay.SETRANGE(Code, Assignmatrix.Code);
                                                if FullPay.FIND('-') then begin
                                                    Assignmatrix.Amount := FullPay.Amount * (DaysWorked / DaysInMonth);

                                                    Assignmatrix.MODIFY;
                                                end;*/
                                            end;
                                        until Earnings.NEXT = 0;
                                    end;
                                end;

                                if DaysWorked >= DaysInMonth then begin

                                    Earnings.RESET;
                                    Earnings.SETRANGE("Gross Pay Entry", true);
                                    Earnings.SETRANGE("Basic Pay Arrears", false);
                                    if Earnings.FIND('-') then begin
                                        repeat
                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE("Employee No", Employee."No.");
                                            Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                            Assignmatrix.SETRANGE(Code, Earnings.Code);
                                            Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                                            if Assignmatrix.FIND('-') then begin
                                                /*FullPay.RESET;
                                                FullPay.SETRANGE("Employee No", Assignmatrix."Employee No");
                                                FullPay.SETRANGE(Code, Assignmatrix.Code);
                                                if FullPay.FIND('-') then begin
                                                    Assignmatrix.Amount := FullPay.Amount;

                                                    Assignmatrix.MODIFY;
                                                end;*/
                                            end;
                                        until Earnings.NEXT = 0;
                                    end;

                                end;
                            end;
                            //Insert Temporary Allowances
                            TempDays := 0;
                            NonWorking := 0;
                            /*FullPay.RESET;
                            FullPay.SETRANGE("Employee No", Employee."No.");
                            FullPay.SETRANGE(Type, FullPay.Type::Temprary);
                            if FullPay.FIND('-') then begin
                                repeat

                                    if ((FullPay."Effective Start Date" >= Month) and (FullPay."Effective Start Date" <= EndMonth)) then begin
                                        Assignmatrix.RESET;
                                        Assignmatrix.SETRANGE("Employee No", Employee."No.");
                                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                        Assignmatrix.SETRANGE("Payroll Period", Month);
                                        Assignmatrix.SETRANGE(Code, FullPay.Code);
                                        if Assignmatrix.FIND('-') then begin
                                            TempDays := EndMonth - FullPay."Effective Start Date" + 1;
                                            if FullPay.Weekend = true then begin
                                                NonWorking := GetNonWorkingDays(FullPay."Effective Start Date", EndMonth);
                                                Assignmatrix.Amount := FullPay.Amount * ((TempDays - NonWorking + 1) / 22);

                                            end else begin
                                                Assignmatrix.Amount := FullPay.Amount * (TempDays / DaysInMonth);
                                            end;
                                            Assignmatrix.MODIFY;
                                        end else begin
                                            Assignmatrix7.INIT;
                                            Assignmatrix7."Employee No" := Employee."No.";
                                            Assignmatrix7.VALIDATE("Employee No");
                                            Assignmatrix7.Type := Assignmatrix7.Type::Payment;
                                            Assignmatrix7.Code := FullPay.Code;
                                            Assignmatrix7.VALIDATE(Code);
                                            TempDays := EndMonth - FullPay."Effective Start Date";
                                            if FullPay.Weekend = true then begin
                                                NonWorking := GetNonWorkingDays(FullPay."Effective Start Date", EndMonth);
                                                Assignmatrix7.Amount := FullPay.Amount * ((TempDays - NonWorking) / 22);
                                            end else begin
                                                Assignmatrix7.Amount := FullPay.Amount * (TempDays / DaysInMonth);
                                            end;
                                            Assignmatrix7.VALIDATE(Amount);
                                            Assignmatrix7.INSERT;
                                        end;
                                    end;
                                    if ((FullPay."Effective Start Date" < Month) and (FullPay."Effective End Date" > EndMonth)) then begin
                                        Assignmatrix.RESET;
                                        Assignmatrix.SETRANGE("Employee No", Employee."No.");
                                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                        Assignmatrix.SETRANGE("Payroll Period", Month);
                                        Assignmatrix.SETRANGE(Code, FullPay.Code);
                                        if Assignmatrix.FIND('-') then begin
                                            TempDays := EndMonth - Month + 1;
                                            if FullPay.Weekend = true then begin
                                                NonWorking := GetNonWorkingDays(FullPay."Effective Start Date", EndMonth);
                                                Assignmatrix.Amount := FullPay.Amount;
                                            end else begin
                                                Assignmatrix.Amount := FullPay.Amount;
                                            end;
                                            Assignmatrix.MODIFY;
                                        end;
                                    end;
                                    if ((FullPay."Effective End Date" >= Month) and (FullPay."Effective End Date" <= EndMonth)) then begin
                                        Assignmatrix.RESET;
                                        Assignmatrix.SETRANGE("Employee No", Employee."No.");
                                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                        Assignmatrix.SETRANGE("Payroll Period", Month);
                                        Assignmatrix.SETRANGE(Code, FullPay.Code);
                                        if Assignmatrix.FIND('-') then begin
                                            TempDays := FullPay."Effective End Date" - Month + 1;
                                            if FullPay.Weekend = true then begin
                                                NonWorking := GetNonWorkingDays(FullPay."Effective End Date", EndMonth);
                                                Assignmatrix.Amount := FullPay.Amount * ((TempDays - NonWorking + 1) / 22);
                                            end else begin
                                                Assignmatrix.Amount := FullPay.Amount * (TempDays / DaysInMonth);
                                            end;
                                            Assignmatrix.MODIFY;
                                        end else begin
                                            Assignmatrix7.INIT;
                                            Assignmatrix7."Employee No" := Employee."No.";
                                            Assignmatrix7.VALIDATE("Employee No");
                                            Assignmatrix7.Type := Assignmatrix7.Type::Payment;
                                            Assignmatrix7.Code := FullPay.Code;
                                            Assignmatrix7.VALIDATE(Code);
                                            TempDays := FullPay."Effective End Date" - Month + 1;
                                            if FullPay.Weekend = true then begin
                                                NonWorking := GetNonWorkingDays(FullPay."Effective End Date", EndMonth);
                                                Assignmatrix7.Amount := FullPay.Amount * ((TempDays - NonWorking) / 22);
                                            end else begin
                                                Assignmatrix7.Amount := FullPay.Amount * (TempDays / DaysInMonth);
                                            end;
                                            Assignmatrix7.VALIDATE(Amount);
                                            Assignmatrix7.INSERT;
                                        end;
                                    end;
                                    if FullPay."Effective End Date" < Month then begin
                                        Assignmatrix.RESET;
                                        Assignmatrix.SETRANGE("Employee No", Employee."No.");
                                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                        Assignmatrix.SETRANGE("Payroll Period", Month);
                                        Assignmatrix.SETRANGE(Code, FullPay.Code);
                                        if Assignmatrix.FIND('-') then begin

                                            Assignmatrix.DELETE;
                                        end;
                                    end;
                                until FullPay.NEXT = 0;
                            end;*/
                        end;
                    end;

                    /*
                    //********************************Salry increament for groups
                    PARcent:=0;
                    InitialBasic:=0;
                    InitialGross:=0;
                    HrSetup.GET;
                    IF HrPost.GET(Employee."Posting Group") THEN BEGIN
                    IF HrPost."Salary Incre Month" <> 0D THEN BEGIN
                    IF (Month <> HrPost."Salary Incre Month") AND (Employee."Salary Changed"=TRUE) THEN BEGIN
                       Employee."Salary Changed":=FALSE;
                       Employee.MODIFY;
                    END;
                    IF (Month=HrPost."Salary Incre Month") AND (Employee."Salary Changed"=FALSE) THEN BEGIN


                       Earnings.RESET;
                       Earnings.SETRANGE("Gross Pay Entry",TRUE);
                       IF Earnings.FIND('-') THEN BEGIN

                        //*************Get Imported Par RAtings for increament
                        Results.RESET;
                        Results.SETRANGE("Employee No",Employee."No.");
                        Results.SETRANGE("Salary Updated",FALSE);
                        IF Results.FIND('-') THEN BEGIN
                        IF Ranking.GET(Results.Rating) THEN BEGIN
                        IF Ranking."Salary Increament Perc"<>0 THEN BEGIN
                          IF HrPost."Increase Basic Only PAR"=FALSE THEN
                            PARcent:=Ranking."Salary Increament Perc"
                          ELSE
                           PARcent:=Ranking."Salary Increament Perc" * 0.5;
                          END;
                        END;
                        END;
                         REPEAT

                          Assignmatrix7.RESET;
                          Assignmatrix7.SETRANGE("Employee No","No.");
                          Assignmatrix7.SETRANGE(Code,Earnings.Code);
                          Assignmatrix7.SETRANGE(Assignmatrix7."Payroll Period",LastMonth);
                          IF Assignmatrix7.FIND('-') THEN BEGIN

                       Assignmatrix.RESET;
                       Assignmatrix.SETRANGE("Employee No","No.");
                       Assignmatrix.SETRANGE(Code,Earnings.Code);
                       Assignmatrix.SETRANGE(Assignmatrix."Payroll Period",Month);
                       IF Assignmatrix.FIND('-') THEN BEGIN
                       Assignmatrix.Amount:=(Assignmatrix7.Amount*((100+(HrPost."Increament Percentage"+PARcent))/100));
                        // ERROR('Month %1 Perc %2',Month,Assignmatrix.Amount);
                       Assignmatrix.MODIFY;
                       END;
                       END;
                       UNTIL Earnings.NEXT=0;
                       IF PARcent<>0 THEN BEGIN
                         Results."Salary Updated":=TRUE;
                       Results.MODIFY;
                       END;
                       Employee."Salary Changed":=TRUE;
                       Employee.MODIFY;

                      END;
                    END;
                    END;
                    END;

                    //************************************************End Increase
                    */

                    //********************************Salry increament for groups
                    PARcent := 0;
                    InitialBasic := 0;
                    InitialGross := 0;
                    BasicPerc := 0;
                    HrSetup.GET;
                    if HrPost.GET(Employee."Posting Group") then begin
                        if HrPost."Salary Incre Month" <> 0D then begin

                            BasicPerc := HrPost."Basic Perc(On Gross)";

                            /*if (Month <> HrPost."Salary Incre Month") and (Employee."Salary Changed" = true) then begin
                                Employee."Salary Changed" := false;
                                Employee.MODIFY;
                            end;*/
                            /*if (Month = HrPost."Salary Incre Month") and (Employee."Salary Changed" = false) then begin


                                //*************Get Imported Par RAtings for increament
                                Results.RESET;
                                Results.SETRANGE("Employee No", Employee."No.");
                                Results.SETRANGE("Salary Updated", false);
                                if Results.FIND('-') then begin
                                    if Ranking.GET(Results.Rating) then begin
                                        if Ranking."Salary Increament Perc" <> 0 then begin
                                            if HrPost."Increase Basic Only PAR" = false then begin
                                                PARcent := Ranking."Salary Increament Perc";
                                                //**********************Get Previous Basic*
                                                Earnings.RESET;
                                                Earnings.SETRANGE("Gross Pay Entry", true);
                                                if Earnings.FINDSET then
                                                    repeat
                                                        Assignmatrix7.RESET;
                                                        Assignmatrix7.SETRANGE("Employee No", "No.");
                                                        Assignmatrix7.SETRANGE(Code, Earnings.Code);
                                                        Assignmatrix7.SETRANGE(Assignmatrix7."Payroll Period", LastMonth);
                                                        if Assignmatrix7.FIND('-') then begin
                                                            InitialGross := InitialGross + Assignmatrix7.Amount;
                                                            if Earnings."Basic Salary Code" then
                                                                InitialBasic := Assignmatrix7.Amount;
                                                        end;

                                                    until Earnings.NEXT = 0;
                                                //**********************Get Previous Basic*
                                                //MESSAGE('Basic %1  ,Gross %2',InitialBasic,InitialGross);
                                                //**********************Modify New Basic*********************
                                                Earnings.RESET;
                                                Earnings.SETRANGE("Basic Salary Code", true);
                                                if Earnings.FIND('-') then begin
                                                    Assignmatrix.RESET;
                                                    Assignmatrix.SETRANGE("Employee No", "No.");
                                                    Assignmatrix.SETRANGE(Code, Earnings.Code);
                                                    Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                                                    if Assignmatrix.FIND('-') then begin
                                                        //ERROR('Initial Basic %1, initial Gross %2 increament per %3 Basic Perc %4',InitialBasic,InitialGross,HrPost."Increament Percentage",BasicPerc);
                                                        Assignmatrix.Amount := ((InitialGross + (((HrPost."Increament Percentage" / 100) * InitialGross) + ((PARcent / 100) * InitialBasic))) * BasicPerc / 100);
                                                        Assignmatrix.MODIFY;
                                                    end;
                                                end;

                                                //**********************Modify New Basic*********************
                                            end

                                            else begin
                                                PARcent := Ranking."Salary Increament Perc" * 0.5;
                                                Earnings.RESET;
                                                Earnings.SETRANGE("Gross Pay Entry", true);
                                                if Earnings.FIND('-') then begin
                                                    repeat
                                                        Assignmatrix7.RESET;
                                                        Assignmatrix7.SETRANGE("Employee No", "No.");
                                                        Assignmatrix7.SETRANGE(Code, Earnings.Code);
                                                        Assignmatrix7.SETRANGE(Assignmatrix7."Payroll Period", LastMonth);
                                                        if Assignmatrix7.FIND('-') then begin
                                                            Assignmatrix.RESET;
                                                            Assignmatrix.SETRANGE("Employee No", "No.");
                                                            Assignmatrix.SETRANGE(Code, Earnings.Code);
                                                            Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                                                            if Assignmatrix.FIND('-') then begin
                                                                Assignmatrix.Amount := (Assignmatrix7.Amount * ((100 + (HrPost."Increament Percentage" + PARcent)) / 100));
                                                                // ERROR('Month %1 Perc %2',Month,Assignmatrix.Amount);
                                                                Assignmatrix.MODIFY;
                                                            end;
                                                        end;
                                                    until Earnings.NEXT = 0;
                                                end;

                                            end;

                                        end;
                                    end;
                                end;

                                if PARcent <> 0 then begin
                                    Results."Salary Updated" := true;
                                    Results.MODIFY;
                                end;
                                Employee."Salary Changed" := true;
                                Employee.MODIFY;


                            end;*/
                        end;
                    end;

                    //************************************************End Increase



                    //Insert Overtime Allowances
                    OvertimeVal := 0;
                    HrSetup.GET;
                    //HrSetup.TESTFIELD("Overtime Earning Code");Commented by Steve on 06252019
                    Overtimel.RESET;
                    Overtimel.SETRANGE("Employee No", Employee."No.");
                    Overtimel.SETRANGE("pay period", Month);
                    //Overtimel.SETRANGE(Added,FALSE);
                    if Overtimel.FIND('-') then begin
                        repeat
                            Overtimel.VALIDATE(Date);
                            OvertimeVal := OvertimeVal + Overtimel.Amount;
                            Overtimel.Added := true;
                            Overtimel.MODIFY;
                        until Overtimel.NEXT = 0;
                        if OvertimeVal <> 0 then begin
                            Assignmatrix.RESET;
                            Assignmatrix.SETRANGE("Employee No", "No.");
                            Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                            //Assignmatrix.SETRANGE(Code, HrSetup."Overtime Earning Code");
                            Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                            if Assignmatrix.FIND('-') then begin
                                Assignmatrix.Amount := OvertimeVal;
                                Assignmatrix.MODIFY;
                            end else begin
                                Assignmatrix7.INIT;
                                Assignmatrix7."Employee No" := Employee."No.";
                                Assignmatrix7.VALIDATE("Employee No");
                                Assignmatrix7.Type := Assignmatrix7.Type::Payment;
                                //Assignmatrix7.Code := HrSetup."Overtime Earning Code";
                                Assignmatrix7.VALIDATE(Code);
                                Assignmatrix7.Amount := OvertimeVal;
                                Assignmatrix7.INSERT;
                            end;
                        end;

                        /*
                        Overtimel.Added:=TRUE;
                        Overtimel.MODIFY;
                       */
                    end;
                    // Get Volontary Amounts from previous period
                    /*
                         Assignmatrix.RESET;
                         Assignmatrix.SETRANGE("Employee No","No.");
                         Assignmatrix.SETRANGE(Assignmatrix.Type,Assignmatrix.Type::Deduction);
                         Assignmatrix.SETRANGE(Assignmatrix."Payroll Period",Month);
                         Assignmatrix.SETRANGE(Retirement,TRUE);

                         IF Assignmatrix.FIND('-') THEN BEGIN
                           Assignmatrix7.RESET;
                           Assignmatrix7.SETRANGE("Employee No",Assignmatrix."Employee No");
                           Assignmatrix7.SETRANGE(Assignmatrix7."Payroll Period",LastMonth);
                           Assignmatrix7.SETRANGE(Code,Assignmatrix.Code);
                           Assignmatrix7.SETRANGE(Retirement,TRUE);
                           Assignmatrix7.SETFILTER("Employee Voluntary",'<>%1',0);
                          IF Assignmatrix7.FIND('-') THEN BEGIN
                          Assignmatrix."Employee Voluntary":=Assignmatrix7."Employee Voluntary";
                          Assignmatrix.VALIDATE("Employee Voluntary");
                          //MESSAGE('Code % Voluntary %2 Emp %3',Assignmatrix7.Code,Assignmatrix7."Employee Voluntary",Assignmatrix7."Employee No")
                         END;
                        END;
                        */
                    // Salary Increament PAR Results
                    /*
                    Results.RESET;
                    Results.SETRANGE("Employee No",Employee."No.");
                    Results.SETRANGE("Salary Updated",FALSE);
                    IF Results.FIND('-') THEN BEGIN
                      IF Ranking.GET(Results.Rating) THEN BEGIN
                        IF Ranking."Salary Increament Perc"<>0 THEN BEGIN
                       Earnings.RESET;
                       Earnings.SETRANGE("Basic Salary Code",TRUE);
                       IF Earnings.FIND('-') THEN BEGIN
                         REPEAT
                       Assignmatrix.RESET;
                       Assignmatrix.SETRANGE("Employee No","No.");
                       Assignmatrix.SETRANGE(Code,Earnings.Code);
                       Assignmatrix.SETRANGE(Assignmatrix."Payroll Period",LastMonth);
                       IF Assignmatrix.FIND('-') THEN BEGIN
                       Assignmatrix7.RESET;
                       Assignmatrix7.SETRANGE("Employee No","No.");
                       Assignmatrix7.SETRANGE(Code,Earnings.Code);
                       Assignmatrix7.SETRANGE(Assignmatrix7."Payroll Period",Month);
                       IF Assignmatrix7.FIND('-') THEN
                       Assignmatrix7.Amount:=(Assignmatrix7.Amount*((100+Ranking."Salary Increament Perc")/100));
                       IF Assignmatrix7.MODIFY THEN BEGIN
                         Results."Salary Updated":=TRUE;
                       Results.MODIFY;
                       END;
                       END;
                       UNTIL Earnings.NEXT=0;
                       END;
                        END;
                        END;
                    END;
                    */
                    //==================================================================================
                    //Check the Balances and stop if the Amounts are zero.

                    //Insert PA Deductions
                    /*
                    IF HrPost.GET(Employee."Posting Group") THEN BEGIN
                    IF HrPost."Personal Account Code"<>'' THEN BEGIN
                    StaffBal.RESET;
                    StaffBal.SETRANGE(STAFF_CODE,Employee."No.");
                    IF StaffBal.FIND('-') THEN BEGIN
                    IF StaffBal.PA_FCY_BAL>0 THEN BEGIN
                          Assignmatrix.RESET;
                          Assignmatrix.SETRANGE("Employee No",Employee."No.");
                          Assignmatrix.SETRANGE(Code,HrPost."Personal Account Code");
                          Assignmatrix.SETRANGE(Assignmatrix."Payroll Period",Month);
                          IF Assignmatrix.FIND('-') THEN BEGIN
                          Assignmatrix.Amount:=StaffBal.PA_FCY_BAL;
                          END ELSE BEGIN
                          Assignmatrix7.INIT;
                         Assignmatrix7."Employee No":=Employee."No.";
                         Assignmatrix7.VALIDATE("Employee No");
                         Assignmatrix7.Type:=Assignmatrix7.Type::Deduction;
                         Assignmatrix7.Code:=HrPost."Personal Account Code";
                         Assignmatrix7.VALIDATE(Code);
                         Assignmatrix7.Amount:=-StaffBal.PA_FCY_BAL;
                         Assignmatrix7.VALIDATE(Amount);
                         Assignmatrix7.INSERT;
                          END;
                    END;
                    END;
                    END;
                    END;
                    */
                    //Insert Development levy
                    /*MonthText := '';
                    DedText := '';
                    if HrPost.GET(Employee."Posting Group") then begin
                        if HrPost."Development levy Code" <> '' then begin
                            Deductions.RESET;
                            Deductions.SETRANGE(Code, HrPost."Development levy Code");
                            if Deductions.FIND('-') then begin
                                DedText := FORMAT(Deductions.Month);
                                MonthText := FORMAT(Month, 0, '<Month Text>');
                                if DedText = MonthText then begin
                                    DimValue.RESET;
                                    DimValue.SETRANGE(Code, Employee."Global Dimension 6 Code");
                                    DimValue.SETRANGE("Global Dimension No.", 6);
                                    if DimValue.FIND('-') then begin
                                        if DimValue."Development Levy" <> 0 then begin
                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE("Employee No", Employee."No.");
                                            Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Deduction);
                                            Assignmatrix.SETRANGE("Payroll Period", Month);
                                            Assignmatrix.SETRANGE(Code, Deductions.Code);
                                            if Assignmatrix.FIND('-') then begin
                                                Assignmatrix.Amount := DimValue."Development Levy";
                                                Assignmatrix.MODIFY;
                                            end else begin
                                                Assignmatrix7.INIT;
                                                Assignmatrix7."Employee No" := Employee."No.";
                                                Assignmatrix7.VALIDATE("Employee No");
                                                Assignmatrix7.Type := Assignmatrix7.Type::Deduction;
                                                Assignmatrix7.Code := Deductions.Code;
                                                Assignmatrix7.VALIDATE(Code);
                                                Assignmatrix7.Amount := DimValue."Development Levy";
                                                Assignmatrix7.VALIDATE(Amount);
                                                Assignmatrix7.INSERT;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;*/
                    ClosingBal := 0;
                    //Insert Provisions
                    if HrPost.GET(Employee."Posting Group") then begin
                        Prov.RESET;
                        Prov.SETRANGE("Staff Group", Employee."Posting Group");
                        if Prov.FIND('-') then begin
                            repeat
                                Assignmatrix.RESET;
                                Assignmatrix.SETRANGE("Employee No", Employee."No.");
                                if Prov.Type = Prov.Type::Deduction then
                                    Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Deduction) else
                                    Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                Assignmatrix.SETRANGE("Payroll Period", Month);
                                Assignmatrix.SETRANGE(Code, Prov.Provision);
                                if Assignmatrix.FIND('-') then begin
                                    Assignmatrix.VALIDATE(Code);
                                    Assignmatrix.MODIFY;
                                end else begin
                                    Assignmatrix7.INIT;
                                    Assignmatrix7."Employee No" := Employee."No.";
                                    Assignmatrix7.VALIDATE("Employee No");
                                    if Prov.Type = Prov.Type::Deduction then
                                        Assignmatrix7.Type := Assignmatrix7.Type::Deduction else
                                        Assignmatrix7.Type := Assignmatrix7.Type::Payment;
                                    Assignmatrix7.Code := Prov.Provision;
                                    Assignmatrix7.VALIDATE(Code);

                                    Assignmatrix7.INSERT;
                                end;
                            until Prov.NEXT = 0;
                        end;
                    end;
                    Deductions.RESET;
                    Deductions.SETRANGE(Deductions.Shares, true);
                    //Deductions.SETRANGE(Deductions.Code,
                    if Deductions.FIND('-') then begin
                        repeat
                            Assignmatrix.RESET;
                            Assignmatrix.SETRANGE("Employee No", "No.");
                            Assignmatrix.SETRANGE(Code, Deductions.Code);
                            Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                            if Assignmatrix.FIND('-') then begin
                                //=====================================Brian K
                                //Message('%1',Deductions.Description);
                                Assignmatrix7.RESET;
                                //Assignmatrix7.INIT;
                                Assignmatrix7.SETFILTER(Assignmatrix7."Employee No", "No.");
                                Assignmatrix7.SETFILTER(Assignmatrix7.Code, Deductions.Code);
                                Assignmatrix7.SETFILTER(Assignmatrix7."Payroll Period", '%1', CALCDATE('-1M', Month));
                                if Assignmatrix7.FINDSET then begin
                                    Assignmatrix."Outstanding Amount" := ABS(Assignmatrix7."Outstanding Amount") + ABS(Assignmatrix.Amount);
                                    Assignmatrix.MODIFY;
                                end;
                                //============================================
                            end;

                        until Deductions.NEXT = 0;
                    end;
                    //======================Loans<Pick from repayment schedule>==========================
                    Deductions.RESET;
                    Deductions.SETRANGE(Deductions.Loan, true);
                    if Deductions.FIND('-') then begin
                        repeat
                            //Remove complete loans
                            LoanApps.RESET;
                            LoanApps.SETRANGE("Employee No", Employee."No.");
                            LoanApps.SETFILTER("Stop Loan", '%1', false);
                            LoanApps.SETRANGE("Deduction Code", Deductions.Code);
                            LoanApps.SETRANGE("Loan Status", LoanApps."Loan Status"::Issued);
                            if LoanApps.FIND('-') then begin
                                REPAREC.RESET;
                                REPAREC.SETRANGE("Loan No", LoanApps."Loan No");
                                REPAREC.SETRANGE("Repayment Date", Month);
                                if not REPAREC.FIND('-') then begin
                                    Assignmatrix.RESET;
                                    Assignmatrix.SETRANGE("Employee No", "No.");
                                    Assignmatrix.SETRANGE(Assignmatrix.Type, Assignmatrix.Type::Deduction);
                                    Assignmatrix.SETRANGE(Code, Deductions.Code);
                                    Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                                    if Assignmatrix.FIND('-') then
                                        Assignmatrix.DELETE;
                                    //Interest
                                    Assignmatrix.RESET;
                                    Assignmatrix.SETRANGE("Employee No", "No.");
                                    Assignmatrix.SETRANGE(Assignmatrix.Type, Assignmatrix.Type::Deduction);
                                    Assignmatrix.SETRANGE(Code, LoanApps."Interest Deduction Code");
                                    Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                                    if Assignmatrix.FIND('-') then
                                        Assignmatrix.DELETE;
                                    LoanApps."Stop Loan" := true;
                                    LoanApps.MODIFY;
                                end;
                            end;
                            //Assign Loans and Interest
                            LoanApps.RESET;
                            LoanApps.SETRANGE("Employee No", Employee."No.");
                            LoanApps.SETFILTER("Stop Loan", '%1', false);
                            LoanApps.SETRANGE("Deduction Code", Deductions.Code);
                            LoanApps.SETRANGE("Loan Status", LoanApps."Loan Status"::Issued);
                            if LoanApps.FIND('-') then begin
                                REPAREC.RESET;
                                REPAREC.SETRANGE("Loan No", LoanApps."Loan No");
                                REPAREC.SETRANGE("Repayment Date", Month);

                                if REPAREC.FIND('-') then begin
                                    //Insert/Modify Principal Repeyment
                                    Assignmatrix.RESET;
                                    Assignmatrix.SETRANGE("Employee No", "No.");
                                    Assignmatrix.SETRANGE(Assignmatrix.Type, Assignmatrix.Type::Deduction);
                                    Assignmatrix.SETRANGE(Code, Deductions.Code);
                                    Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                                    if Assignmatrix.FIND('-') then begin
                                        if ABS(Assignmatrix.Amount) <> REPAREC."Monthly Repayment" then begin
                                            Assignmatrix.Amount := -REPAREC."Monthly Repayment";

                                            Assignmatrix.MODIFY;
                                        end;
                                    end else begin
                                        Assignmatrix7.INIT;
                                        Assignmatrix7."Employee No" := Employee."No.";
                                        Assignmatrix7.VALIDATE("Employee No");
                                        Assignmatrix7.Type := Assignmatrix7.Type::Deduction;
                                        Assignmatrix7.Code := Deductions.Code;
                                        Assignmatrix7.VALIDATE(Code);
                                        Assignmatrix7.Amount := -REPAREC."Monthly Repayment";
                                        Assignmatrix7.VALIDATE(Amount);
                                        Assignmatrix7."Reference No" := LoanApps."Loan No";
                                        Assignmatrix7.INSERT;
                                    end;
                                    //Insert Interest if available.
                                    if REPAREC."Monthly Interest" <> 0 then begin
                                        if LoanApps."Interest Deduction Code" <> '' then begin
                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE("Employee No", "No.");
                                            Assignmatrix.SETRANGE(Assignmatrix.Type, Assignmatrix.Type::Deduction);
                                            Assignmatrix.SETRANGE(Code, LoanApps."Interest Deduction Code");
                                            Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                                            if Assignmatrix.FIND('-') then begin
                                                if ABS(Assignmatrix.Amount) <> REPAREC."Monthly Interest" then begin
                                                    Assignmatrix.Amount := -REPAREC."Monthly Interest";
                                                    Assignmatrix.MODIFY;
                                                end;
                                            end else begin

                                                Assignmatrix7.INIT;
                                                Assignmatrix7."Employee No" := Employee."No.";
                                                Assignmatrix7.VALIDATE("Employee No");
                                                Assignmatrix7.Type := Assignmatrix7.Type::Deduction;
                                                Assignmatrix7.Code := LoanApps."Interest Deduction Code";
                                                Assignmatrix7."Payroll Period" := Month;
                                                Assignmatrix7.VALIDATE(Code);
                                                Assignmatrix7.Amount := -REPAREC."Monthly Interest";
                                                Assignmatrix7.VALIDATE(Amount);
                                                Assignmatrix7."Reference No" := LoanApps."Loan No";
                                                Assignmatrix7.INSERT;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        until Deductions.NEXT = 0;
                    end;

                    Earnings.RESET;
                    Earnings.SETRANGE(Earnings."Basic Salary Code", true);
                    if Earnings.FIND('-') then
                        BasicSalaryCode := Earnings.Code;

                    if ScaleBenefits.GET(Employee."Salary Scale", Employee.Present, BasicSalaryCode) then begin
                        Assignmatrix.RESET;
                        Assignmatrix.SETRANGE(Assignmatrix.Code, BasicSalaryCode);
                        Assignmatrix.SETRANGE(Assignmatrix.Type, Assignmatrix.Type::Payment);
                        Assignmatrix.SETRANGE(Assignmatrix."Employee No", Employee."No.");
                        Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);

                        if Assignmatrix.FIND('-') then begin
                            Assignmatrix.Amount := ScaleBenefits.Amount;
                            Assignmatrix.MODIFY;
                        end
                        else begin
                            Assignmatrix.INIT;
                            Assignmatrix."Employee No" := Employee."No.";
                            Assignmatrix.Type := Assignmatrix.Type::Payment;
                            Assignmatrix.Code := BasicSalaryCode;
                            Assignmatrix.VALIDATE(Assignmatrix.Code);
                            Assignmatrix."Payroll Period" := Month;
                            //Assignmatrix.Amount:=ScalePointer."Basic Pay";
                            Assignmatrix."Global Dimension 1 code" := Employee."Global Dimension 1 Code";
                            Assignmatrix."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                            //Assignmatrix."Global Dimension 3 Code":=Employee."Shortcut Dimension 3 Code";
                            Assignmatrix.Amount := ScaleBenefits.Amount;
                            Assignmatrix."Manual Entry" := false;
                            Assignmatrix.INSERT;
                        end;
                    end;

                    //****************************************Update Exchange Rates**************************************//

                    Assignmatrix.RESET;
                    Assignmatrix.SETRANGE(Assignmatrix."Employee No", Employee."No.");
                    Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                    Assignmatrix.SETRANGE(Assignmatrix.Closed, false);
                    if Assignmatrix.FIND('-') then begin
                        repeat

                            if Employee.GET(Employee."No.") then begin
                                if Employee."Payroll Currency" <> '' then
                                    CurrencyFactor :=
                                      CurrExchRate.ExchangeRate(TODAY, Employee."Payroll Currency");
                                if Employee."Payroll Currency" = '' then
                                    Assignmatrix."Amount(LCY)" := Assignmatrix.Amount
                                else
                                    Assignmatrix."Amount(LCY)" := ROUND(
                                   CurrExchRate.ExchangeAmtFCYToLCY(
                                   TODAY, Employee."Payroll Currency",
                                    Assignmatrix.Amount, CurrencyFactor));
                                /*
                                  Assignmatrix."Employer Amount" := ROUND(
                                 CurrExchRate.ExchangeAmtFCYToLCY(
                                 TODAY,Employee."Payroll Currency",Assignmatrix."Employer Amount(LCY)" ,CurrencyFactor));
                                 //MESSAGE(FORMAT(Assignmatrix."Amount(LCY)"));
                                 */
                                Assignmatrix.MODIFY;

                            end;
                        until Assignmatrix.NEXT = 0;
                    end;

                    //*******************************************End of exchange rates*****************************************//

                    // Delete all Previous PAYE
                    HrPost.GET(Employee."Posting Group");
                    Deductions.RESET;
                    Deductions.SETRANGE(Deductions."PAYE Code", true);
                    Deductions.SETRANGE(Code, HrPost."Tax Code");
                    if Deductions.FIND('-') then begin

                        Assignmatrix.RESET;
                        Assignmatrix.SETRANGE(Assignmatrix.Code, Deductions.Code);
                        Assignmatrix.SETRANGE(Assignmatrix.Type, Assignmatrix.Type::Deduction);
                        Assignmatrix.SETRANGE(Assignmatrix."Employee No", Employee."No.");
                        Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                        Assignmatrix.SETRANGE(Closed, false);
                        Assignmatrix.DELETEALL;
                    end;

                    // validate assigment matrix code incase basic salary change and update calculation based on basic salary
                    Assignmatrix.RESET;
                    Assignmatrix.SETRANGE(Assignmatrix."Employee No", Employee."No.");
                    Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                    Assignmatrix.SETRANGE(Closed, false);
                    if Assignmatrix.FIND('-') then begin
                        repeat
                            if Assignmatrix.Type = Assignmatrix.Type::Payment then begin
                                EarnCount := 0;
                                Earnings.RESET;
                                Earnings.SETRANGE(Code, Assignmatrix.Code);
                                EarnCount := Earnings.COUNT;
                                if EarnCount > 1 then
                                    Earnings.SETRANGE("Country/Region Code", Employee."Country/Region Code");
                                if Earnings.FIND('-') then

                                  // IF Earnings.GET(Assignmatrix.Code) THEN
                                  begin
                                    // MESSAGE('Validating %1',Assignmatrix.Code);
                                    if Earnings.Taxable = true then begin
                                        Assignmatrix.Taxable := true;
                                        Assignmatrix.MODIFY;
                                    end;

                                    if (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic pay") or
                                      (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Gross pay") or
                                      (Earnings."Calculation Method" = Earnings."Calculation Method"::"Flat amount") or
                                      (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Basic after tax") or
                                      (Earnings."Calculation Method" = Earnings."Calculation Method"::"Based on Age") or
                                      (Earnings."Calculation Method" = Earnings."Calculation Method"::"Based on Hourly Rate") or
                                      (Earnings."Calculation Method" = Earnings."Calculation Method"::"% of Loan Amount") then begin

                                        Assignmatrix.VALIDATE(Code);
                                        Assignmatrix.Amount := (Assignmatrix.Amount);
                                        Assignmatrix.MODIFY;
                                    end else begin
                                        //=================for other allowances from SRC====================
                                        if ScaleBenefits.GET(Employee."Salary Scale", Employee.Present, Assignmatrix.Code) then begin
                                            Assignmatrix.Amount := ScaleBenefits.Amount;
                                            Assignmatrix.MODIFY;
                                        end;
                                        //=======================end for other allowances=============
                                    end;
                                end;
                            end;
                            if Assignmatrix.Retirement = false then begin
                                if Assignmatrix.Type = Assignmatrix.Type::Deduction then begin
                                    DedCount := 0;
                                    Deductions.RESET;
                                    Deductions.SETRANGE(Code, Assignmatrix.Code);
                                    DedCount := Deductions.COUNT;
                                    if DedCount > 1 then
                                        Deductions.SETRANGE("Country/Region Code", Employee."Country/Region Code");
                                    if Deductions.FIND('-') then
                                      //IF Deductions.GET(Assignmatrix.Code) THEN
                                      begin

                                        if (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay") or
                                            (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Hourly Rate") or
                                            (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay") or
                                            (Deductions."Calculation Method" = Deductions."Calculation Method"::"Flat Amount") or
                                            (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay Entries") or
                                            (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic+House+Transport") or
                                            (Deductions.Provision = true) or
                                            (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Daily Rate ") then begin
                                            Assignmatrix.VALIDATE(Code);
                                            Assignmatrix.Amount := (Assignmatrix.Amount);
                                            Assignmatrix."Employer Amount" := (Assignmatrix."Employer Amount");
                                            Assignmatrix.MODIFY;
                                        end;

                                    end;
                                end;
                            end;
                            if Assignmatrix.Retirement = true then begin

                                if Assignmatrix.Type = Assignmatrix.Type::Deduction then begin
                                    DedCount := 0;
                                    Deductions.RESET;
                                    Deductions.SETRANGE(Code, Assignmatrix.Code);
                                    DedCount := Deductions.COUNT;
                                    if DedCount > 1 then
                                        Deductions.SETRANGE("Country/Region Code", Employee."Country/Region Code");
                                    if Deductions.FIND('-') then
                                        //IF Deductions.GET(Assignmatrix.Code) THEN
                                        begin
                                        if (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay") or
                                            (Deductions."Calculation Method" = Deductions."Calculation Method"::"Flat Amount") or
                                          (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Hourly Rate") or
                                          (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay") or
                                          (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay Entries") or
                                          (Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic+House+Transport") or
                                          (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Daily Rate ") then begin
                                            Assignmatrix.VALIDATE(Code);
                                            Assignmatrix.Amount := (Assignmatrix.Amount);
                                            Assignmatrix.MODIFY;
                                        end;
                                    end;
                                end;
                            end;

                            if (Assignmatrix.Type = Assignmatrix.Type::Deduction) and (Assignmatrix.Amount > 0) then begin
                                Assignmatrix.Amount := -Assignmatrix.Amount;
                                Assignmatrix.MODIFY;
                            end;
                            if Assignmatrix.Type = Assignmatrix.Type::Deduction then begin
                                DedCount := 0;
                                Deductions.RESET;
                                Deductions.SETRANGE(Code, Assignmatrix.Code);
                                DedCount := Deductions.COUNT;
                                if DedCount > 1 then
                                    Deductions.SETRANGE("Country/Region Code", Employee."Country/Region Code");
                                if Deductions.FIND('-') then
                                      // IF Deductions.GET(Assignmatrix.Code) THEN
                                      begin
                                    if (Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table") and
                                        (Deductions."PAYE Code" = false) then begin
                                        Assignmatrix.VALIDATE(Code);
                                        Assignmatrix.Amount := ROUND(Assignmatrix.Amount, 1);
                                        Assignmatrix.MODIFY;
                                    end;
                                end;
                            end;

                        until Assignmatrix.NEXT = 0;
                    end;
                    HrPost.GET(Employee."Posting Group");
                    Deductions.RESET;
                    Deductions.SETRANGE(Deductions."PAYE Code", true);
                    Deductions.SETRANGE(Code, HrPost."Tax Code");
                    if Deductions.FIND('-') then begin
                        IncomeTax := 0;
                        RetireCont := 0;
                        //Get Batch Number

                        BatchNo := GetBatchNo(Employee."No.", Month);
                        IncomeTax := GetPaye.CalculateTaxableAmount(Employee."No.", Month, TaxableAmount, RetireCont, '', 0);
                        // INSERT PAYE

                        Assignmatrix.INIT;
                        Assignmatrix."Employee No" := Employee."No.";
                        Assignmatrix.Type := Assignmatrix.Type::Deduction;
                        Assignmatrix.Code := Deductions.Code;
                        Assignmatrix.VALIDATE(Code);
                        Assignmatrix."Payroll Period" := Month;
                        Assignmatrix."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                        //IF IncomeTax>0 THEN
                        IncomeTax := -IncomeTax;
                        Assignmatrix.Amount := IncomeTax;
                        Assignmatrix.VALIDATE(Amount);
                        Assignmatrix.Paye := true;
                        Assignmatrix."Taxable amount" := TaxableAmount;
                        Assignmatrix.Batch := BatchNo;
                        Assignmatrix."Less Pension Contribution" := RetireCont;
                        Assignmatrix.Paye := true;
                        Assignmatrix."Global Dimension 1 code" := Employee."Global Dimension 1 Code";
                        Assignmatrix."Global Dimension 2 Code" := Employee."Global Dimension 2 Code";

                        Assignmatrix."Posting Group Filter" := Employee."Posting Group";

                        if (Assignmatrix."Taxable amount" <> 0) then
                            Assignmatrix.INSERT;
                    end
                    else
                        ERROR('Must specify Paye Code under deductions');



                    //***********************************************Get Tax relief*************************************//
                    PersonalRelief := 0;
                    Earnings.RESET;
                    Earnings.SETCURRENTKEY(Earnings."Earning Type");
                    Earnings.SETRANGE(Earnings."Earning Type", Earnings."Earning Type"::"Tax Relief");
                    //Earnings.SETRANGE(Earnings."Country/Region Code",EmpRec."Country/Region Code");
                    IF Earnings.FIND('-') THEN BEGIN
                        REPEAT
                            IF Earnings."Flat Amount" > 0 THEN BEGIN
                                PersonalRelief := PersonalRelief + Earnings."Flat Amount";
                            END
                            ELSE BEGIN
                                ReliefSetup.RESET;
                                ReliefSetup.SETRANGE("Country/Region Code", Employee."Country/Region Code");
                                IF ReliefSetup.FIND('-') THEN BEGIN
                                    PersonalRelief := PersonalRelief + ReliefSetup.Amount;

                                    //*****************Insert personal rellief as an earning******************//
                                    WITH Assignmatrix DO BEGIN
                                        MESSAGE('Niko Hapa');
                                        "Employee No" := Employee."No.";
                                        Type := Type::Payment;
                                        Code := Earnings.Code;
                                        VALIDATE(Code);
                                        Amount := PersonalRelief;
                                        "Payroll Period" := Month;
                                        "Global Dimension 1 code" := Employee."Global Dimension 1 Code";
                                        "Global Dimension 2 Code" := Employee."Global Dimension 2 Code";
                                        IF Amount <> 0 THEN
                                            INSERT;
                                    END;
                                    //*****************End Insert personal rellief as an earning******************//
                                END;
                            END;
                        UNTIL Earnings.NEXT = 0;
                    END;

                    //***********************************************Get Tax relief*************************************//




                    //==================================================================Calculate NHIF automatically
                    NHIFamount := 0;
                    //Get Allowance-taxable
                    EmpRec.RESET;
                    EmpRec.SETRANGE("No.", Employee."No.");
                    EmpRec.SETRANGE("Pay Period Filter", DateSpecified);
                    EmpRec.CALCFIELDS("Total Allowances");
                    TotalAllowance := EmpRec."Total Allowances";
                    //Get NHIF Code
                    Deductions.RESET;
                    DeductionsRec.SETRANGE(DeductionsRec."NHIF Deduction", true);
                    if DeductionsRec.FINDLAST then
                        NHIFCode := DeductionsRec.Code;

                    Assignmatrix.RESET;
                    Assignmatrix.SETRANGE(Assignmatrix.Code, NHIFCode);
                    Assignmatrix.SETRANGE(Assignmatrix.Type, Assignmatrix.Type::Deduction);
                    Assignmatrix.SETRANGE(Assignmatrix."Employee No", Employee."No.");
                    Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                    if Assignmatrix.FINDFIRST then begin
                        BracketTablesRec.RESET;
                        BracketTablesRec.SETRANGE(NHIF, true);
                        if BracketTablesRec.FINDLAST then begin
                            BracketsX1.RESET;
                            BracketsX1.SETRANGE("Table Code", BracketTablesRec."Bracket Code");
                            if BracketsX1.FINDFIRST then
                                repeat
                                    if (BracketsX1."Lower Limit" <= TotalAllowance) and (BracketsX1."Upper Limit" >= TotalAllowance) then begin
                                        Assignmatrix.Amount := -BracketsX1.Amount;
                                        Assignmatrix."Employer Amount" := BracketsX1.Amount;
                                        Assignmatrix.MODIFY;
                                    end;
                                until BracketsX1.NEXT = 0;
                        end;

                    end;

                    Principalamount := 0;
                    fringestart := 0D;
                    Installments := 0;
                    InterestAmount := 0;
                    Principamount := 0;
                    Principal2 := 0;
                    Mortgage := false;
                    Mortgageamt := 0;
                    LoanApplication.RESET;
                    LoanApplication.SETRANGE(LoanApplication."Employee No", "No.");
                    LoanApplication.SETRANGE("Stop Loan", false);
                    if LoanApplication.FIND('-') then begin
                        repeat
                            if LoanType.GET(LoanApplication."Loan Product Type") then begin
                                if LoanType."Fringe Benefit Code" <> '' then begin
                                    Principalamount := LoanApplication."Approved Amount";
                                    fringestart := LoanApplication."Issued Date";
                                    Installments := LoanApplication.Instalment;
                                    Numerator := (LoanType."Interest Rate" / 12 / 100);
                                    Denominator := (1 - POWER((1 + (LoanType."Interest Rate" / 12 / 100)), -Installments));
                                    Repayment := ROUND((Numerator / Denominator) * Principalamount, 0.05, '>');
                                    if Installments <= 0 then
                                        ERROR('Instalment Amount must be specified');
                                    months := 0;
                                    while fringestart <= Month do begin
                                        Principamount := ROUND((Principalamount / 100 / 12 * LoanType."Interest Rate"), 0.05, '>');
                                        Principal2 := Repayment - Principamount;
                                        Principalamount := Principalamount - Principal2;
                                        fringestart := CALCDATE('1M', fringestart);
                                        months := months + 1;

                                    end;
                                    //check mortgage
                                    if LoanType.Mortgage <> '' then begin
                                        Mortgageamt := Principamount;
                                    end;
                                    //=================end check mortgage

                                    MarketIntRateRec.RESET;
                                    MarketIntRateRec.SETFILTER("Start Date", '<=%1', Month);
                                    MarketIntRateRec.SETFILTER("End Date", '>=%1', Month);
                                    if MarketIntRateRec.FIND('-') then begin
                                        MarketIntRate := MarketIntRateRec.Intrest;
                                        InterestRate := LoanType."Interest Rate";
                                        // InterestRate:=ROUND(InterestRate,0.01);
                                        Taxpercentage := MarketIntRateRec."Tax Percentage";
                                    end
                                    else
                                        ERROR('Market Interest Rates have not been setup for the period including %1', Month);

                                    //calculating the fringe benefit

                                    Fringebal := 0;
                                    FringeAmount := 0;
                                    FringeAmountT := 0;
                                    Fringebal := (Principalamount);
                                    FringeAmount := ROUND((((MarketIntRate - InterestRate) / 100) / 12) * Fringebal, 0.05);
                                    NumeratorF := ((MarketIntRate) / 12 / 100);
                                    DenominatorF := (1 - POWER((1 + ((MarketIntRate - InterestRate) / 12 / 100)), -Installments));
                                    RepaymentF := ROUND((NumeratorF / DenominatorF) * Fringebal, 0.01, '>');
                                    FringeAmountT := ROUND((Taxpercentage / 100) * FringeAmount, 0.01);

                                    Assmatrix.INIT;
                                    Assmatrix."Employee No" := Employee."No.";
                                    Assmatrix.Type := Assmatrix.Type::Payment;
                                    Assmatrix."Reference No" := LoanApplication."Loan No";
                                    Assmatrix.Code := LoanType."Fringe Benefit Code";
                                    Assmatrix."Payroll Period" := Month;//LoanApplication."Issued Date";

                                    Earnings.RESET;
                                    Earnings.SETRANGE(Earnings.Code, LoanType."Fringe Benefit Code");
                                    if Earnings.FIND('-') then
                                        Assmatrix.Description := Earnings.Description;
                                    Assmatrix."Payroll Group" := Employee."Posting Group";
                                    Assmatrix.Amount := FringeAmount;
                                    Assmatrix."Employer Amount" := FringeAmountT;
                                    Assmatrix."Next Period Entry" := true;
                                    Assmatrix.VALIDATE(Assmatrix.Amount);
                                    if not Assmatrix.GET(Assmatrix."Employee No", Assmatrix.Type, Assmatrix.Code, Assmatrix."Payroll Period", Assmatrix."Reference No")
                                    then
                                        if Assignmatrix.Amount <> 0 then
                                            Assmatrix.INSERT
                                        else
                                            if Assignmatrix.Amount <> 0 then
                                                Assmatrix.MODIFY;

                                    Assignmatrix.RESET;
                                    Assignmatrix.SETRANGE(Assignmatrix.Code, LoanType."Fringe Benefit Code");
                                    Assignmatrix.SETRANGE(Assignmatrix.Type, Assignmatrix.Type::Payment);
                                    Assignmatrix.SETRANGE(Assignmatrix."Employee No", Employee."No.");
                                    Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                                    if Assignmatrix.FINDFIRST then begin
                                        Assignmatrix.Amount := FringeAmount;
                                        Assignmatrix."Employer Amount" := FringeAmountT;
                                        Assmatrix.VALIDATE(Assmatrix.Amount, Assignmatrix."Employer Amount");
                                        Assignmatrix.MODIFY;
                                    end else begin
                                        Earnings.RESET;
                                        Earnings.SETRANGE(Earnings.Code, LoanType."Fringe Benefit Code");
                                        if Earnings.FIND('-') then
                                            Assignmatrix.Description := Earnings.Description;
                                        Assignmatrix."Payroll Group" := Employee."Posting Group";
                                        Assignmatrix.Amount := FringeAmount;
                                        Assmatrix."Employer Amount" := FringeAmountT;
                                        Assignmatrix."Next Period Entry" := true;
                                        Assignmatrix.VALIDATE(Assignmatrix.Amount, Assignmatrix."Employer Amount");
                                        Assignmatrix.INSERT;
                                    end;
                                end;
                            end;
                        until LoanApplication.NEXT = 0;
                    end;
                    //=============================================================FRINGE BENEFIT CALCULATION
                    //==========================================MORTGAGE RELIEF
                    //Get mortgage code
                    MortgageCode := '';
                    EarningsRec.RESET;
                    EarningsRec.SETRANGE("Earning Type", EarningsRec."Earning Type"::"Owner Occupier");
                    if EarningsRec.FINDLAST then
                        MortgageCode := EarningsRec.Code;

                    Assignmatrix.RESET;
                    Assignmatrix.SETRANGE(Assignmatrix.Code, MortgageCode);
                    Assignmatrix.SETRANGE(Assignmatrix.Type, Assignmatrix.Type::Payment);
                    Assignmatrix.SETRANGE(Assignmatrix."Employee No", Employee."No.");
                    Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                    if Assignmatrix.FINDFIRST then begin
                        if Mortgageamt <> 0 then begin
                            if Earnings."Flat Amount" > Mortgageamt then begin
                                Assignmatrix.Amount := Mortgageamt;
                            end else begin
                                Assignmatrix.Amount := Assignmatrix.Amount;
                            end;
                        end;
                        Assignmatrix.MODIFY;
                    end;
                end else begin
                    if Employee.Status <> Employee.Status::Active then begin
                        Assignmatrix.RESET;
                        Assignmatrix.SETRANGE("Payroll Period", Month);
                        Assignmatrix.SETRANGE("Employee No", Employee."No.");
                        Assignmatrix.SETRANGE(Closed, false);
                        if Assignmatrix.FIND('-') then
                            repeat
                                Assignmatrix.DELETE;
                            until Assignmatrix.NEXT = 0;
                    end;
                end;
                //==========================================MORTGAGE RELIEF
                //*********************************Accrue Net Amt for Leave Accrual TZ*******************************************//
                Earnings.RESET;
                Earnings.SETRANGE("Accrue Net", true);
                if Earnings.FINDSET then
                    repeat
                        Assignmatrix.RESET;
                        Assignmatrix.SETRANGE("Employee No", "No.");
                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                        Assignmatrix.SETRANGE(Code, Earnings.Code);
                        Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                        if Assignmatrix.FIND('-') then begin
                            InitialTax := 0;
                            InitialTax := GetPaye.CalculateTaxableAmount(Employee."No.", Month, TaxableAmount, RetireCont, Assignmatrix.Code, Assignmatrix.Amount);
                            Assignmatrix.Amount := Assignmatrix.Amount - (ABS(IncomeTax) - InitialTax);
                            Assignmatrix."Amount(LCY)" := Assignmatrix.Amount - (ABS(IncomeTax) - InitialTax);
                            Assignmatrix.MODIFY;

                            //*********************************Tax Edit TZ*******************************************//
                            Deductions.RESET;
                            Deductions.SETRANGE("PAYE Code", true);
                            if Deductions.FINDSET then
                                repeat
                                    Assignmatrix.RESET;
                                    Assignmatrix.SETRANGE("Employee No", "No.");
                                    Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Deduction);
                                    Assignmatrix.SETRANGE(Code, Deductions.Code);
                                    Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", Month);
                                    if Assignmatrix.FIND('-') then begin
                                        //InitialTax:=0;
                                        //InitialTax:=GetPaye.CalculateTaxableAmount(Employee."No.", Month,TaxableAmount,RetireCont,Assignmatrix.Code,Assignmatrix.Amount);
                                        //Assignmatrix.Amount:=(ABS(Assignmatrix.Amount)-(ABS(IncomeTax)-InitialTax)*-1);
                                        //Assignmatrix."Amount(LCY)":=(ABS(Assignmatrix.Amount)-(ABS(IncomeTax)-InitialTax)*-1);
                                        Assignmatrix.Amount := InitialTax * -1;
                                        Assignmatrix."Amount(LCY)" := InitialTax * -1;
                                        Assignmatrix.MODIFY
                                    end;
                                until Deductions.NEXT = 0;
                            //*********************************Tax Edit TZ*******************************************//
                        end;

                    until Earnings.NEXT = 0;
                //*********************************Accrue Net Amt for Leave Accrual TZ*******************************************//

                Window.UPDATE(1, Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name");

            end;

            trigger OnPostDataItem();
            begin

                Window.CLOSE;
                MESSAGE('Processed');
            end;

            trigger OnPreDataItem();
            begin

                Window.OPEN('Calculating Payroll For ##############################1', EmployeeName);

                if UserSetup.GET(USERID) then begin
                    /*User.RESET;
                    User.SETRANGE("User Name", UserId);
                    if User.FIND('-') then begin
                        
                        PayrollPeriod.RESET;
                        PayrollPeriod.SETRANGE(Closed,FALSE);
                        PayrollPeriod.SETRANGE("Country/Region Code",User.Country);
                        IF PayrollPeriod.FIND('-') THEN
                          BEGIN
                            Month:=PayrollPeriod."Starting Date";
                            LastMonth:=CALCDATE('-1M',Month);
                            DateSpecified:=Month;
                            END;
                            
                    end;*/
                end else begin
                    ERROR('You are not set up as a valid user. Kindly contact your system administrator for assistance');
                end;

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DateSpecified; DateSpecified)
                {
                    Caption = 'Pay Period';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin

        //PayrollPeriod.SETRANGE(Closed,FALSE);
        //IF PayrollPeriod.FINDFIRST THEN
        Month := DateSpecified;
        LastMonth := CALCDATE('-1M', Month);
        //DateSpecified:=Month;

        if PayPeriod.GET(DateSpecified) then
            PayPeriodtext := PayPeriod.Name;
        EndDate := CALCDATE('1M', DateSpecified) - 1;
        CompRec.GET;
        TaxCode := CompRec."Tax Table";
    end;

    var
        Assignmatrix: Record "Assignment Matrix";
        CurrencyFactor: Decimal;
        CurrExchRate: Record "Currency Exchange Rate";
        Assignmatrix7: Record "Assignment Matrix";
        BeginDate: Date;
        DateSpecified: Date;
        BasicSalary: Decimal;
        TaxableAmount: Decimal;
        CompRec: Record "Human Resources Setup";
        HseLimit: Decimal;
        TaxCode: Code[10];
        retirecontribution: Decimal;
        ExcessRetirement: Decimal;
        GrossPay: Decimal;
        TotalBenefits: Decimal;
        TaxablePay: Decimal;
        RetireCont: Decimal;
        TotalQuarters: Decimal;
        IncomeTax: Decimal;
        relief: Decimal;
        EmpRec: Record Employee;
        NetPay: Decimal;
        NetPay1: Decimal;
        Index: Integer;
        Intex: Integer;
        AmountRemaining: Decimal;
        PayPeriod: Record "Payroll Period";
        DenomArray: array[1, 12] of Text[50];
        NoOfUnitsArray: array[1, 12] of Integer;
        AmountArray: array[1, 60] of Decimal;
        PayMode: Text[30];
        PayPeriodtext: Text[30];
        EndDate: Date;
        DaysinAmonth: Decimal;
        HoursInamonth: Decimal;
        [SecurityFiltering(SecurityFilter::Filtered)]
        Earnings: Record Earnings;
        CfMpr: Decimal;
        [SecurityFiltering(SecurityFilter::Filtered)]
        Deductions: Record Deductions;
        NormalOvertimeHours: Decimal;
        WeekendOvertime: Decimal;
        PayrollPeriod: Record "Payroll Period";
        Window: Dialog;
        EmployeeName: Text[230];
        NoOfDays: Integer;
        Month: Date;
        GetPaye: Codeunit "Payroll(PAYE PROCESSING)";
        GetGroup: Codeunit "Payroll(PAYE PROCESSING)";
        GroupCode: Code[20];
        CUser: Code[20];
        ScalePointer: Record "Salary Pointers";
        SalaryScale: Record "Salary Scales";
        CurrentMonth: Integer;
        CurrentMonthtext: Text[30];
        HseAllow: Record "House Allowance Matrix";
        [SecurityFiltering(SecurityFilter::Filtered)]
        Ded: Record Deductions;
        Assmatrix: Record "Assignment Matrix";
        LoanType: Record "Loan Product Type";
        LoanType1: Record "Loan Product Type";
        LoanApplication: Record "Loan Application";
        LoanBalance: Decimal;
        InterestAmt: Decimal;
        RefNo: Code[20];
        LastMonth: Date;
        NextPointer: Code[10];
        ScaleBenefits: Record "Scale Benefits";
        BasicSalaryCode: Code[10];
        LoanTopUp: Record "Loan Top-up";
        TotalTopUp: Decimal;
        RepSchedule: Record "Repayment Schedule";
        Informational: Boolean;
        ClosingBal: Decimal;
        RepaymentAmt: Decimal;
        REPAREC: Record "Repayment Schedule";
        conf: Boolean;
        conftxt: Text;
        BracketsX1: Record "Brackets Lines";
        NHIFamount: Decimal;
        MarketIntRateRec: Record "Market Intrest Rates";
        MarketIntRate: Decimal;
        InterestRate: Decimal;
        Taxpercentage: Decimal;
        Numerator: Decimal;
        Denominator: Decimal;
        Repayment: Decimal;
        NumeratorF: Decimal;
        DenominatorF: Decimal;
        RepaymentF: Decimal;
        Installments: Integer;
        fringestart: Date;
        months: Integer;
        LoopEndBool: Boolean;
        Principalamount: Decimal;
        Fringebal: Decimal;
        FringeAmount: Decimal;
        FringeAmountT: Decimal;
        InterestAmount: Decimal;
        Principamount: Decimal;
        Principal2: Decimal;
        Mortgage: Boolean;
        Mortgageamt: Decimal;
        LoanApps: Record "Loan Application";
        TotalAllowance: Decimal;
        BracketTablesRec: Record "Bracket Tables";
        [SecurityFiltering(SecurityFilter::Filtered)]
        EarningsRec: Record Earnings;
        MortgageCode: Code[10];
        [SecurityFiltering(SecurityFilter::Filtered)]
        DeductionsRec: Record Deductions;
        NHIFCode: Code[10];
        //CalcPAYE: Codeunit Payroll5;
        User: Record User;
        UserSetup: Record "User Setup";
        PersonalRelief: Decimal;
        ReliefSetup: Record "Tax Relief Table";
        BatchNo: Code[10];
        HrSetup: Record "Human Resources Setup";
        HrPost: Record "Staff Posting Group";
        Ranking: Record "Appraisal Grades";
        //Results: Record "PAR Results";
        PARcent: Decimal;
        Overtimel: Record "Overtime Line";
        OvertimeVal: Decimal;
        EarnCount: Integer;
        DedCount: Integer;
        InitialGross: Decimal;
        InitialBasic: Decimal;
        BasicPerc: Decimal;
        [SecurityFiltering(SecurityFilter::Filtered)]
        Emply: Record Employee;
        //FullPay: Record "Assignment Matrix-X12";
        EndMonth: Date;
        DaysInMonth: Integer;
        DaysWorked: Integer;
        InitialTax: Decimal;
        //StaffBal: Record Staff_Account_Balance;
        DimValue: Record "Dimension Value";
        MonthText: Text;
        DedText: Text;
        TempDays: Integer;
        NonWorking: Integer;
        Prov: Record "Employment Provisions";

    procedure GetTaxBracket(var TaxableAmount: Decimal);
    var
        TaxTable: Record "Brackets Lines";
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := ROUND(AmountRemaining, 0.01);
        EndTax := false;
        TaxTable.SETRANGE("Table Code", TaxCode);


        if TaxTable.FIND('-') then begin
            repeat

                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if ROUND((TaxableAmount), 0.01) > TaxTable."Upper Limit" then
                        Tax := TaxTable."Taxable Amount" * TaxTable.Percentage / 100

                    else begin
                        Tax := AmountRemaining * TaxTable.Percentage / 100;
                        TotalTax := TotalTax + Tax;
                        EndTax := true;
                    end;
                    if not EndTax then begin
                        AmountRemaining := AmountRemaining - TaxTable."Taxable Amount";
                        TotalTax := TotalTax + Tax;
                    end;
                end;
            until (TaxTable.NEXT = 0) or EndTax = true;
        end;
        TotalTax := TotalTax;
        TotalTax := PayrollRounding(TotalTax);
        IncomeTax := -TotalTax;
        if not Employee."Pays tax" then
            IncomeTax := 0;
    end;

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal;
    var
        HRsetup: Record "Human Resources Setup";
    begin

        HRsetup.GET;
        if HRsetup."Payroll Rounding Precision" = 0 then
            ERROR('You must specify the rounding precision under HR setup');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then
            PayrollRounding := ROUND(Amount, HRsetup."Payroll Rounding Precision", '=');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then
            PayrollRounding := ROUND(Amount, HRsetup."Payroll Rounding Precision", '>');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then
            PayrollRounding := ROUND(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;

    local procedure GetBatchNo(Emp: Code[10]; Period: Date) NewBatch: Code[10];
    var
        Assign: Record "Assignment Matrix";
    begin
        Assign.RESET;
        Assign.SETRANGE("Payroll Period", Period);
        Assign.SETRANGE("Employee No", Emp);
        Assign.SETFILTER(Batch, '<>%1', '');
        if Assign.FIND('-') then
            NewBatch := Assign.Batch else
            NewBatch := '';
    end;

    procedure GetPayPeriod(EmpNo: Code[10]);
    var
        Assignm: Record "Assignment Matrix";
    begin
        Assignm.RESET;
        Assignm.SETRANGE("Employee No", EmpNo);
        Assignm.SETRANGE(Closed, false);
        if Assignm.FINDFIRST then begin
            PayPeriod.SETRANGE("Starting Date", Assignm."Payroll Period");
            if PayPeriod.FIND('-') then begin
                PayPeriodtext := PayPeriod.Name;
                BeginDate := PayPeriod."Starting Date";
            end;
        end;
    end;

    procedure GetNonWorkingDays(StartDate: Date; EndDate: Date) NwDays: Integer;
    var
        CalendarMgmt: Codeunit "Calendar Management";
        NoOfDays: Integer;
        StartD: Date;
        DayDesc: Text;
    begin
        StartD := StartDate;
        while StartD <= EndDate do begin
            if CalendarMgmt.CheckDateStatus(Employee."Base Calendar Code", StartD, DayDesc) then
                NwDays := NwDays + 1;
            StartD := CALCDATE('<+1D>', StartD);
        end;
    end;
}

