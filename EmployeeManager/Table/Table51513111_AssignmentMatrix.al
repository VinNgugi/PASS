table 51513111 "Assignment Matrix"
{
    // version PAYROLL

    DataCaptionFields = "Employee No", Description;
    DataClassification = CustomerContent;
    DrillDownPageID = "Payment & Deductions";
    LookupPageID = "Payment & Deductions";

    fields
    {
        field(1; "Employee No"; Code[30])
        {

            trigger OnValidate();
            begin
                if Empl.GET("Employee No") then begin
                    GLSetup.Get();
                    DefDim.Reset();
                    DefDim.SetFilter("Table ID", '5200');
                    DefDim.SetRange("No.", "Employee No");
                    if DefDim.FindSet() then
                        repeat
                            if DefDim."Dimension Code" = GLSetup."Global Dimension 1 Code" then begin
                                "Global Dimension 1 code" := DefDim."Dimension Value Code";
                                Validate("Global Dimension 1 code");
                            end else
                                if DefDim."Dimension Code" = GLSetup."Global Dimension 2 Code" then begin
                                    "Global Dimension 2 code" := DefDim."Dimension Value Code";
                                    Validate("Global Dimension 2 code");
                                end else
                                    if DefDim."Dimension Code" = GLSetup."Shortcut Dimension 3 Code" then begin
                                        "Global Dimension 3 code" := DefDim."Dimension Value Code";
                                        Validate("Global Dimension 3 code");
                                    end;


                        until defdim.Next() = 0;



                    //Un comment this please
                    // "Posting Group Filter":=Empl."Posting Group";
                    //"Salary Pointer":=Empl.Present;
                    //"Basic Pay":=Empl."Basic Pay";
                    // if Empl."Posting Group"='' then
                    //  ERROR('Assign  %1  %2 a posting group before assigning any earning or deduction',Empl."First Name",Empl."Last Name");
                end;
            end;
        }
        field(2; Type; Option)
        {
            NotBlank = false;
            OptionMembers = Payment,Deduction,"Saving Scheme",Loan,Informational;
        }
        field(3; "Code"; Code[20])
        {
            TableRelation = IF (Type = CONST(Payment)) Earnings.Code ELSE
            IF (Type = CONST(Deduction)) Deductions.Code;

            trigger OnValidate();
            begin

                TESTFIELD("Employee No");
                if Empl.GET("Employee No") then begin
                    if Empl.Status <> Empl.Status::Active then
                        ERROR('Can only assign Earnings and deductions to Active Employees. %1 is inactive ', "Employee No");
                end;

                GetPayPeriod;
                "Payroll Period" := PayStartDate;
                "Pay Period" := PayPeriodText;
                Batch := BatchNo;
                //********************************Gratuity And leave Pay checks*******************************************//
                HRSetup.Get();
                Payments.Reset();
                Payments.SetRange(Code, Code);
                if Payments.Find('-') then begin
                    if Payments."Gratuity Pay" then begin
                        Assignmatrix.Reset();
                        Assignmatrix.SetCurrentKey("Payroll Period");
                        Assignmatrix.SetRange("Employee No", "Employee No");
                        Assignmatrix.SetRange(Code, Payments.Code);
                        Assignmatrix.SetRange(Type, Type::Payment);
                        if not Assignmatrix.FindLast() then begin
                            if Empl.Get("Employee No") then begin
                                Empl.TestField("Date Of Join");
                            end;
                            if (CalcDate(HRSetup."Gratuity Validity Period", Empl."Date Of Join") >= "Payroll Period") then
                                Error('You are not entitled to any gratuity pay till date %2', Assignmatrix."Payroll Period", (CalcDate(HRSetup."Gratuity Validity Period", Empl."Date Of Join")));
                        end else begin
                            if (CalcDate(HRSetup."Gratuity Validity Period", Assignmatrix."Payroll Period") >= "Payroll Period") then
                                Error('Your last Gratuity amount was paid on %1. You are not entitled to any gratuity pay till date %2', Assignmatrix."Payroll Period", (CalcDate(HRSetup."Gratuity Validity Period", Assignmatrix."Payroll Period")));
                        end;
                    end;

                end;

                Payments.Reset();
                Payments.SetRange(Code, Code);
                if Payments.Find('-') then begin
                    if Payments."Leave Allowance Code" then begin
                        if Empl.Get("Employee No") then begin
                            Empl.TestField("Date Of Join");

                            if (CalcDate('1Y', Empl."Date Of Join") < "Payroll Period") then
                                Error('Employee is less than a year old in the organisation');
                        end;

                        Assignmatrix.Reset();
                        Assignmatrix.SetCurrentKey("Payroll Period");
                        Assignmatrix.SetRange("Employee No", "Employee No");
                        Assignmatrix.SetRange(Code, Payments.Code);
                        Assignmatrix.SetRange(Type, Type::Payment);
                        if Assignmatrix.FindLast() then begin
                            if (CalcDate('1Y', Assignmatrix."Payroll Period") >= "Payroll Period") then
                                Error('Your last Leave Allowance was paid on paid on %1. You are not entitled to any Leave Allowance till date %2', Assignmatrix."Payroll Period", CalcDate('1Y', Assignmatrix."Payroll Period"));
                        end;
                    end;

                end;

                //********************************Gratuity And leave Pay checks*******************************************//
                //*********************Allowances Calculation rules etc***************
                case Type of
                    Type::Payment:
                        begin

                            Payments.RESET;
                            Payments.SETRANGE(Code, Code);
                            //Payments.SETFILTER("Country/Region Code", '%1|%2', Empl."Country/Region Code", '');
                            //if Payments.COUNT > 1 then
                            //    Payments.SETRANGE("Country/Region Code", Empl."Country/Region Code");
                            if Payments.FIND('-') then

                              // IF Payments.GET(Code) THEN
                              begin
                                // check if blocked
                                if Payments.Block = true then
                                    ERROR(' Earning Blocked');
                                "Time Sheet" := Payments."Time Sheet";
                                Description := Payments.Description;
                                "Gratuity Pay" := Payments."Gratuity Pay";

                                if Payments."Earning Type" = Payments."Earning Type"::"Tax Relief" then
                                    "Tax Relief" := true;
                                "Non-Cash Benefit" := Payments."Non-Cash Benefit";
                                Quarters := Payments.Quarters;
                                //Paydeduct:=Payments."End Date";
                                Taxable := Payments.Taxable;
                                // MESSAGE('Taxable=%1',Taxable);
                                "Tax Deductible" := Payments."Reduces Tax";
                                if Payments."Pay Type" = Payments."Pay Type"::Recurring then
                                    "Next Period Entry" := true;

                                "Basic Salary Code" := Payments."Basic Salary Code";
                                "Basic Pay Arrears" := Payments."Basic Pay Arrears";
                                if Payments."Earning Type" = Payments."Earning Type"::"Normal Earning" then
                                    "Normal Earnings" := true
                                else
                                    "Normal Earnings" := false;

                                if Payments."Calculation Method" = Payments."Calculation Method"::"Flat amount" then begin

                                    if Payments."Flat Amount" <> 0 then
                                        Amount := Payments."Flat Amount"
                                    else
                                        Amount := Amount;

                                    //**********************************************Sum Gratuity Contribution From Inception************************************//
                                    if "Gratuity Pay" then begin
                                        GratuityAmount := 0;
                                        Assignmatrix.Reset();
                                        Assignmatrix.SetRange("Gratuity Pay", true);
                                        Assignmatrix.SetRange("Gratuity Paid", false);
                                        if Assignmatrix.FindSet() then
                                            repeat
                                                GratuityAmount := GratuityAmount + Assignmatrix."Employer Amount";
                                            until Assignmatrix.Next() = 0;

                                        Amount := GratuityAmount;
                                        Validate(Amount);
                                    end;
                                    //**********************************************Sum Gratuity Contribution From Inception************************************//
                                end;




                                if Payments."Calculation Method" = Payments."Calculation Method"::"% of Basic pay" then begin
                                    if Empl.GET("Employee No") then begin
                                        Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                                        Empl.CALCFIELDS(Basic, Empl."Basic Arrears");

                                        if Payments."Accrue Net" then begin
                                            if Amount > (Payments.Percentage / 100 * (Empl.Basic)) then
                                                Amount := Amount
                                            else
                                                Amount := Payments.Percentage / 100 * (Empl.Basic);
                                        end else begin
                                            Amount := Payments.Percentage / 100 * (Empl.Basic);
                                        end;
                                        // Amount:=Payments.Percentage/100*(Empl.Basic);

                                        //Amount:=Payments.Percentage/100*(Empl.Basic-Empl."Basic Arrears");

                                        //Check For Limits
                                        if Payments."Minimum Limit" <> 0 then
                                            if Amount < Payments."Minimum Limit" then
                                                Amount := Payments."Minimum Limit";
                                        if Payments."Maximum Limit" <> 0 then
                                            if Amount > Payments."Maximum Limit" then
                                                Amount := Payments."Maximum Limit";

                                        Amount := PayrollRounding(Amount);//round
                                                                          //MESSAGE('amount %1 Basic %2 OPercentage %3 basic arrears %4',Amount,Empl.Basic,Payments.Percentage,Empl."Basic Arrears");
                                    end;
                                end;
                                // Responsibility Allowance
                                if Payments."Responsibility Allowance Code" = true then begin
                                    if Assignmatrix."Voluntary Percentage" <> 0 then begin

                                    end;
                                end;


                                if Payments."Calculation Method" = Payments."Calculation Method"::"% of Basic after tax" then begin
                                    if Empl.GET("Employee No") then begin
                                        HRSetup.GET;
                                        //if HRSetup."Company overtime hours" <> 0 then
                                        //  Amount := ("No. of Units" * Empl."Hourly Rate" * Payments."Overtime Factor");//HRSetup."Company overtime hours";

                                        //Check For Limits
                                        if Payments."Minimum Limit" <> 0 then
                                            if Amount < Payments."Minimum Limit" then
                                                Amount := Payments."Minimum Limit";
                                        if Payments."Maximum Limit" <> 0 then
                                            if Amount > Payments."Maximum Limit" then
                                                Amount := Payments."Maximum Limit";

                                        Amount := PayrollRounding(Amount);//round
                                    end;
                                end;

                                //Age-based calculations
                                if Payments."Calculation Method" = Payments."Calculation Method"::"Based on Age" then begin
                                    if Empl.GET("Employee No") then begin
                                        Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                                        Empl.CALCFIELDS(Basic, Empl."Basic Arrears");

                                        if Empl."Date Of Birth" <> 0D then begin
                                            EmpAge := (TODAY - Empl."Date Of Birth") / 365;
                                            CalcTbl.RESET;
                                            CalcTbl.SETRANGE(Type, CalcTbl.Type::Earning);
                                            CalcTbl.SETRANGE(Code, Payments.Code);
                                            if CalcTbl.FIND('-') then begin
                                                CalcLines.RESET;
                                                CalcLines.SETRANGE(Code, CalcTbl.No);
                                                if CalcLines.FIND('-') then begin
                                                    repeat
                                                        if ((EmpAge >= CalcLines."Lower Limit") and (EmpAge <= CalcLines."Max Limit")) then
                                                            CalcPerc := CalcLines.Percentage;
                                                    until CalcLines.NEXT = 0;
                                                end;
                                                Amount := (Empl.Basic + Empl."Basic Arrears") * (CalcPerc / 100);

                                            end;
                                        end;
                                    end;
                                end;

                                if Payments."Calculation Method" = Payments."Calculation Method"::"Based on Hourly Rate" then begin
                                    if Empl.GET("Employee No") then begin
                                        Amount := "No. of Units" * Empl."Daily Rate";//*Payments."Overtime Factor";
                                        if Payments."Overtime Factor" <> 0 then
                                            Amount := "No. of Units" * Empl."Daily Rate" * Payments."Overtime Factor";

                                        //Check For Limits
                                        if Payments."Minimum Limit" <> 0 then
                                            if Amount < Payments."Minimum Limit" then
                                                Amount := Payments."Minimum Limit";
                                        if Payments."Maximum Limit" <> 0 then
                                            if Amount > Payments."Maximum Limit" then
                                                Amount := Payments."Maximum Limit";


                                        Amount := PayrollRounding(Amount);//round
                                    end;
                                end;
                                //Family Allowance
                                if Payments."Calculation Method" = Payments."Calculation Method"::"No of Dependants" then begin
                                    if Empl.GET("Employee No") then begin
                                        Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                                        Empl.CALCFIELDS(Basic);
                                        if Empl."No of Dependants" <> 0 then begin
                                            Amount := Payments."Amount Per Dependant" * Empl."No of Dependants";
                                            if Payments."Minimum Limit" <> 0 then
                                                if Amount < Payments."Minimum Limit" then
                                                    Amount := Payments."Minimum Limit";
                                            if Payments."Maximum Limit" <> 0 then
                                                if Amount > Payments."Maximum Limit" then
                                                    Amount := Payments."Maximum Limit";
                                        end;
                                    end;

                                end;

                                //insurance relief

                                if Payments."Calculation Method" = Payments."Calculation Method"::"% of Insurance Amount" then begin
                                    if Empl.GET("Employee No") then begin
                                        Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                                        Empl.CALCFIELDS(Empl.Insurance);
                                        Amount := ABS((Payments.Percentage / 100) * (Empl.Insurance));

                                        //Check For Limits
                                        if Payments."Minimum Limit" <> 0 then
                                            if Amount < Payments."Minimum Limit" then
                                                Amount := Payments."Minimum Limit";
                                        if Payments."Maximum Limit" <> 0 then
                                            if Amount > Payments."Maximum Limit" then
                                                Amount := Payments."Maximum Limit";

                                        Amount := PayrollRounding(Amount);//round
                                    end;
                                end;

                                if Payments."Calculation Method" = Payments."Calculation Method"::"% of Gross pay" then begin
                                    if Empl.GET("Employee No") then begin
                                        Amount := 0;
                                        ArrearVal := 0;
                                        Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                                        Empl.CALCFIELDS(Basic, Empl."Total Allowances");
                                        EarnRec.RESET;
                                        EarnRec.SETRANGE("Full Month Tax", true);
                                        if EarnRec.FIND('-') then begin
                                            repeat
                                                Assignmatrix.RESET;
                                                Assignmatrix.SETRANGE("Employee No", "Employee No");
                                                Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                                Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                                Assignmatrix.SETRANGE(Code, EarnRec.Code);
                                                if Assignmatrix.FIND('-') then
                                                    ArrearVal := ArrearVal + Assignmatrix.Amount;
                                            until EarnRec.NEXT = 0;
                                        end;
                                        Amount := ((Payments.Percentage / 100) * (Empl."Total Allowances" - ArrearVal));

                                        //Check For Limits
                                        if Payments."Minimum Limit" <> 0 then
                                            if Amount < Payments."Minimum Limit" then
                                                Amount := Payments."Minimum Limit";
                                        if Payments."Maximum Limit" <> 0 then
                                            if Amount > Payments."Maximum Limit" then
                                                Amount := Payments."Maximum Limit";

                                        //*************************************Additional Cons relief*************************//
                                        if Payments."Max Cons. Relief(Monthly)" <> 0 then begin
                                            AddConsRelief := ((Payments."Cons Relief %" / 100) * (Empl."Total Allowances"));
                                            if AddConsRelief < Payments."Max Cons. Relief(Monthly)" then
                                                AddConsRelief := Payments."Max Cons. Relief(Monthly)";
                                        end;
                                        Amount := Amount + AddConsRelief;
                                        //*************************************Additional Cons relief*************************//

                                        Amount := PayrollRounding(Amount);//round
                                    end;

                                end;


                                /*  //***********************************************Added To cater for relief************************/
                                IF Payments."Calculation Method" = Payments."Calculation Method"::"% of Gross pay" THEN BEGIN
                                    IF Payments."Earning Type" = Payments."Earning Type"::"Tax Relief" THEN BEGIN
                                        IF Empl.GET("Employee No") THEN BEGIN

                                            //*********************************Get Gross Pay
                                            TotalGross := 0;
                                            Amount := 0;
                                            EarnRec.RESET;
                                            EarnRec.SETRANGE("Gross Pay Entry", TRUE);
                                            IF EarnRec.FIND('-') THEN BEGIN
                                                REPEAT
                                                    Assignmatrix.RESET;
                                                    Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                                    Assignmatrix.SETRANGE("Employee No", Empl."No.");
                                                    Assignmatrix.SETRANGE("Payroll Period", PayStartDate);
                                                    Assignmatrix.SETRANGE(Code, EarnRec.Code);
                                                    IF Assignmatrix.FIND('-') THEN BEGIN
                                                        TotalGross := TotalGross + Assignmatrix.Amount;
                                                    END;
                                                UNTIL EarnRec.NEXT = 0;
                                            END;
                                            //***************************End Get Gross

                                            //Empl.SETRANGE(Empl."Pay Period Filter","Payroll Period");
                                            //Empl.CALCFIELDS(Basic,Empl."Total Allowances");
                                            Amount := ((Payments.Percentage / 100) * (TotalGross));

                                            //Check For Limits
                                            IF Payments."Minimum Limit" <> 0 THEN
                                                IF Amount < Payments."Minimum Limit" THEN
                                                    Amount := Payments."Minimum Limit";
                                            IF Payments."Maximum Limit" <> 0 THEN
                                                IF Amount > Payments."Maximum Limit" THEN
                                                    Amount := Payments."Maximum Limit";

                                            //*************************************Additional Cons relief*************************//
                                            IF Payments."Max Cons. Relief(Monthly)" <> 0 THEN BEGIN
                                                AddConsRelief := ((Payments."Cons Relief %" / 100) * (TotalGross));
                                                IF AddConsRelief < Payments."Max Cons. Relief(Monthly)" THEN
                                                    AddConsRelief := Payments."Max Cons. Relief(Monthly)";
                                            END;
                                            Amount := Amount + AddConsRelief;
                                            //*************************************Additional Cons relief*************************//

                                            Amount := PayrollRounding(Amount);//round
                                        END;
                                    END;

                                END;
                                //*************************************************************************************************//


                                if Payments."Calculation Method" = Payments."Calculation Method"::"% of Taxable income" then begin
                                    if Empl.GET("Employee No") then begin
                                        Empl.SETRANGE("Pay Period Filter", PayStartDate);
                                        Empl.CALCFIELDS(Empl."Taxable Allowance");
                                        Amount := ((Payments.Percentage / 100) * (Empl."Basic Pay" + Empl."Taxable Allowance"));

                                        //Check For Limits
                                        if Payments."Minimum Limit" <> 0 then
                                            if Amount < Payments."Minimum Limit" then
                                                Amount := Payments."Minimum Limit";
                                        if Payments."Maximum Limit" <> 0 then
                                            if Amount > Payments."Maximum Limit" then
                                                Amount := Payments."Maximum Limit";

                                        Amount := PayrollRounding(Amount);//round
                                    end;
                                end;

                                if Payments."Reduces Tax" then
                                    Amount := PayrollRounding(Amount);//round

                            end;

                            if Payments."Calculation Method" = Payments."Calculation Method"::"% of Cost" then begin
                                if Empl.GET("Employee No") then begin
                                    Amount := ABS((Payments.Percentage / 100) * (Cost));
                                    Amount := PayrollRounding(Amount);//round
                                end;
                            end;

                        end;

                    //*********Deductions****************************************
                    Type::Deduction:
                        begin
                            Empl.GET("Employee No");
                            Deductions.RESET;
                            Deductions.SETCURRENTKEY(Code, "Country/Region Code");
                            Deductions.SETRANGE(Code, Code);
                            //DedsCounter := Deductions.COUNT;
                            //if DedsCounter > 1 then
                            //    Deductions.SETRANGE("Country/Region Code", Empl."Country/Region Code");

                            /*
                            Deductions.SETFILTER("Country/Region Code",'%1|%2',Empl."Country/Region Code",'');
                            IF Deductions.COUNT>1 THEN
                            Deductions.SETRANGE("Country/Region Code",Empl."Country/Region Code");
                            MESSAGE(Code);
                            */
                            if Deductions.FIND('-') then

                              // IF Deductions.GET(Code) THEN

                              begin
                                if Deductions.Block = true then
                                    ERROR('Deduction Blocked');

                                Description := Deductions.Description;
                                "G/L Account" := Deductions."Account No.";
                                "Tax Deductible" := Deductions."Tax deductible";
                                Retirement := Deductions."Pension Scheme";
                                Shares := Deductions.Shares;
                                Paye := Deductions."PAYE Code";
                                "Insurance Code" := Deductions."Insurance Code";
                                "Main Deduction Code" := Deductions."Main Deduction Code";



                                if Deductions.Type = Deductions.Type::Recurring then
                                    "Next Period Entry" := true;
                                if Deductions."Calculation Method" = Deductions."Calculation Method"::"Flat Amount" then begin
                                    if Deductions."Flat Amount" <> 0 then
                                        Amount := Deductions."Flat Amount"
                                    else
                                        Amount := Amount;

                                    if Deductions."Flat Amount Employer" <> 0 then
                                        "Employer Amount" := Deductions."Flat Amount Employer"
                                    else
                                        "Employer Amount" := "Employer Amount";
                                    //Check for substitute payments
                                    Assignmatrix.RESET;
                                    Assignmatrix.SETRANGE("Employee No", "Employee No");
                                    Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                    Assignmatrix.SETRANGE(Code, Deductions."Substitute Earning");
                                    Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                    if Assignmatrix.FIND('-') then
                                        "Employer Amount" := 0;
                                end;


                                if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay" then begin
                                    if Empl.GET("Employee No") then begin
                                        Empl.SETRANGE(Empl."Pay Period Filter", PayStartDate);
                                        Empl.CALCFIELDS(Empl.Basic);
                                        Amount := Deductions.Percentage / 100 * Empl.Basic;
                                        if (Deductions."PAYE Code" = true) then
                                            "Taxable amount" := Empl.Basic;
                                        //MESSAGE('NO ROUNDING AMOUNT=%1',Amount);
                                        Amount := PayrollRounding(Amount);//round
                                        "Employer Amount" := Deductions."Percentage Employer" / 100 * Empl.Basic;
                                        "Employer Amount" := PayrollRounding("Employer Amount");//round
                                        CheckIfRatesInclusive("Employee No", "Payroll Period", Code, Amount);
                                        //pension amount may exceed the maximum limit but the additional amount is tax
                                        /*
                                        IF Deductions."Maximum Amount"<> 0 THEN BEGIN
                                        IF ABS(Amount) > Deductions."Maximum Amount" THEN
                                         Amount:=Deductions."Maximum Amount";
                                         "Employer Amount":=Deductions."Percentage Employer"/100*Empl.Basic;
                                         //Employer amount should not have maximum pension deduction
                                         {
                                           IF "Employer Amount">Deductions."Maximum Amount" THEN
                                      "Employer Amount":=Deductions."Maximum Amount";
                                         }
                                         */
                                        //end of Employer pension
                                        "Employer Amount" := PayrollRounding("Employer Amount");//round
                                        CheckIfRatesInclusive("Employee No", "Payroll Period", Code, "Employer Amount");

                                    end;
                                end;


                                //Calculate deductions on Gross Pay
                                if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay" then begin
                                    if Empl.GET("Employee No") then begin
                                        if Deductions."Severance Pay" = false then begin

                                            Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                                            Empl.CALCFIELDS(Basic, Empl."Total Allowances");

                                            GratPay := 0;
                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE(Type, Type::Payment);
                                            Assignmatrix.SETRANGE("Employee No", Empl."No.");
                                            Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                            Assignmatrix.SETRANGE("Gratuity Pay", true);
                                            if Assignmatrix.FIND('-') then begin
                                                GratPay := Assignmatrix.Amount;
                                            end;

                                            Amount := ((Deductions.Percentage / 100) * (Empl."Total Allowances" - GratPay));//
                                            Amount := PayrollRounding(Amount);//round
                                            if Deductions."Maximum Amount" <> 0 then begin
                                                if Amount > Deductions."Maximum Amount" then
                                                    Amount := Deductions."Maximum Amount"
                                                else
                                                    Amount := Amount;
                                            end;

                                            "Taxable amount" := Empl."Total Allowances";
                                            if Deductions."Percentage Employer" <> 0 then
                                                "Employer Amount" := ((Deductions."Percentage Employer" / 100) * (Empl."Total Allowances" - GratPay));//round
                                            if Deductions."Maximun Amount Employer" <> 0 then begin
                                                if "Employer Amount" > Deductions."Maximun Amount Employer" then
                                                    "Employer Amount" := Deductions."Maximun Amount Employer"
                                                else
                                                    "Employer Amount" := "Employer Amount";
                                            end;

                                        end;

                                        if Deductions."Severance Pay" = true then begin
                                            ErPension := 0;
                                            Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                                            Empl.CALCFIELDS(Basic, Empl."Total Allowances");
                                            Deds.RESET;
                                            Deds.SETRANGE("Pension Scheme", true);
                                            if Deds.FIND('-') then begin
                                                repeat
                                                    Assignmatrix.RESET;
                                                    Assignmatrix.SETRANGE(Type, Type::Deduction);
                                                    Assignmatrix.SETRANGE("Employee No", Empl."No.");
                                                    Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                                    Assignmatrix.SETRANGE(Code, Deds.Code);
                                                    if Assignmatrix.FIND('-') then
                                                        ErPension := ErPension + Assignmatrix."Employer Amount";
                                                until Deds.NEXT = 0;
                                            end;
                                            //**********************Calculate Amount for Severance******************************//
                                            GPayAmount := 0;
                                            EarnRec.RESET;
                                            EarnRec.SETRANGE("Gross Pay Entry", true);
                                            if EarnRec.FINDSET then
                                                repeat
                                                    Assignmatrix.RESET;
                                                    Assignmatrix.SETRANGE(Type, Type::Payment);
                                                    Assignmatrix.SETRANGE("Employee No", Empl."No.");
                                                    Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                                    Assignmatrix.SETRANGE(Code, EarnRec.Code);
                                                    if Assignmatrix.FIND('-') then
                                                        GPayAmount := GPayAmount + Assignmatrix.Amount;
                                                until EarnRec.NEXT = 0;

                                            //**********************Calculate Amount for Severance******************************//
                                            "Taxable amount" := Empl."Total Allowances";
                                            "Employer Amount" := (((Deductions.Percentage / 100) * (GPayAmount)) - ErPension);
                                            MESSAGE('Employer amount %1  gross pay %2  pension Amt %3', "Employer Amount", GPayAmount, ErPension);
                                            "Employer Amount" := PayrollRounding("Employer Amount");//round
                                        end;
                                    end;
                                end;

                                //% of Gross pay entries
                                if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Gross Pay Entries" then begin
                                    TotalGross := 0;
                                    Amount := 0;
                                    EarnRec.RESET;
                                    EarnRec.SETRANGE("Gross Pay Entry", true);
                                    if EarnRec.FIND('-') then begin
                                        repeat
                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                                            Assignmatrix.SETRANGE("Employee No", Empl."No.");
                                            Assignmatrix.SETRANGE("Payroll Period", PayStartDate);
                                            Assignmatrix.SETRANGE(Code, EarnRec.Code);
                                            if Assignmatrix.FIND('-') then begin
                                                TotalGross := TotalGross + Assignmatrix.Amount;
                                            end;
                                        until EarnRec.NEXT = 0;
                                    end;
                                    Amount := TotalGross * (Deductions.Percentage / 100);
                                    "Employer Amount" := TotalGross * (Deductions."Percentage Employer" / 100);
                                end;

                                //***************************************************************% Basic + Housing*****************************************************//

                                if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance" then begin

                                    BasicHSFactor := 0;
                                    Payments.RESET;
                                    Payments.SETRANGE("Basic Salary Code", true);
                                    if Payments.FIND('-') then begin
                                        repeat

                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE(Type, Type::Payment);
                                            Assignmatrix.SETRANGE("Employee No", "Employee No");
                                            Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                            Assignmatrix.SETRANGE(Code, Payments.Code);
                                            if Assignmatrix.FIND('-') then begin

                                                BasicHSFactor := BasicHSFactor + Assignmatrix.Amount;
                                            end;
                                        until Payments.NEXT = 0;
                                    end;

                                    //Housing
                                    Payments.RESET;
                                    Payments.SETRANGE("House Allowance Code", true);
                                    if Payments.FIND('-') then begin
                                        repeat
                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE(Type, Type::Payment);
                                            Assignmatrix.SETRANGE("Employee No", "Employee No");
                                            Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                            Assignmatrix.SETRANGE(Code, Payments.Code);
                                            if Assignmatrix.FIND('-') then begin

                                                BasicHSFactor := BasicHSFactor + Assignmatrix.Amount;
                                            end;
                                        until Payments.NEXT = 0;
                                    end;
                                end;

                                if BasicHSFactor <> 0 then begin
                                    if Deductions.Percentage <> 0 then begin
                                        if "Employee Voluntary" <> 0 then
                                            Amount := ("Employee Voluntary" + ((Deductions.Percentage / 100) * (BasicHSFactor)))
                                        else
                                            Amount := ((Deductions.Percentage / 100) * (BasicHSFactor));
                                        Amount := PayrollRounding(Amount);
                                    end;
                                    "Taxable amount" := Empl."Total Allowances";
                                    if Deductions."Percentage Employer" <> 0 then begin
                                        "Employer Amount" := (Deductions."Percentage Employer" / 100) * BasicHSFactor;
                                    end;
                                end;
                                //***************************************************************% Basic + Housing*****************************************************//

                                // Percentage of basic + House + Transport
                                if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic+House+Transport" then begin

                                    PensionFactor := 0;
                                    Payments.RESET;
                                    Payments.SETRANGE("Commuter Allowance Code", true);
                                    if Payments.FIND('-') then begin
                                        repeat

                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE(Type, Type::Payment);
                                            Assignmatrix.SETRANGE("Employee No", "Employee No");
                                            Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                            Assignmatrix.SETRANGE(Code, Payments.Code);
                                            if Assignmatrix.FIND('-') then begin

                                                PensionFactor := PensionFactor + Assignmatrix.Amount;
                                            end;
                                        until Payments.NEXT = 0;
                                    end;
                                    //Arrears
                                    Payments.RESET;
                                    Payments.SETRANGE("Basic Pay Arrears", true);
                                    if Payments.FIND('-') then begin
                                        repeat
                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE(Type, Type::Payment);
                                            Assignmatrix.SETRANGE("Employee No", "Employee No");
                                            Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                            Assignmatrix.SETRANGE(Code, Payments.Code);
                                            if Assignmatrix.FIND('-') then begin
                                                PensionFactor := PensionFactor + (Assignmatrix.Amount * (Payments."Percentage to Pension" / 100));

                                            end;
                                        until Payments.NEXT = 0;
                                    end;
                                    Payments.RESET;
                                    Payments.SETRANGE("House Allowance Code", true);
                                    if Payments.FIND('-') then begin
                                        repeat
                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE(Type, Type::Payment);
                                            Assignmatrix.SETRANGE("Employee No", "Employee No");
                                            Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                            Assignmatrix.SETRANGE(Code, Payments.Code);
                                            if Assignmatrix.FIND('-') then begin

                                                PensionFactor := PensionFactor + Assignmatrix.Amount;
                                            end;
                                        until Payments.NEXT = 0;
                                    end;
                                    Payments.RESET;
                                    Payments.SETRANGE("Basic Salary Code", true);
                                    if Payments.FIND('-') then begin
                                        repeat
                                            Assignmatrix.RESET;
                                            Assignmatrix.SETRANGE(Type, Type::Payment);
                                            Assignmatrix.SETRANGE("Employee No", "Employee No");
                                            Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                                            Assignmatrix.SETRANGE(Code, Payments.Code);
                                            if Assignmatrix.FIND('-') then begin
                                                PensionFactor := PensionFactor + Assignmatrix.Amount;
                                            end;
                                        until Payments.NEXT = 0;
                                    end;
                                    if PensionFactor <> 0 then begin
                                        if Deductions.Percentage <> 0 then begin
                                            if "Employee Voluntary" <> 0 then
                                                Amount := ("Employee Voluntary" + ((Deductions.Percentage / 100) * (PensionFactor)))
                                            else
                                                Amount := ((Deductions.Percentage / 100) * (PensionFactor));
                                            Amount := PayrollRounding(Amount);
                                        end;
                                        "Taxable amount" := Empl."Total Allowances";
                                        if Deductions."Percentage Employer" <> 0 then begin
                                            "Employer Amount" := (Deductions."Percentage Employer" / 100) * PensionFactor;
                                        end;
                                    end;
                                end;
                                // Employer Medical Scheme
                                if Deductions."Medical Scheme" = true then begin
                                    if Empl.GET("Employee No") then begin
                                        Dims.RESET;
                                        Dims.SETRANGE(Code, Empl."Global Dimension 2 Code");
                                        Dims.SETRANGE("Global Dimension No.", 2);
                                        if Dims.FIND('-') then begin
                                            /*if Dims.Type = Dims.Type::Core then
                                                "Employer Amount(LCY)" := Deductions."Flat Amount Core";
                                            if Dims.Type = Dims.Type::"Non-Core" then
                                                "Employer Amount(LCY)" := Deductions."Flat Amount Projects";*/
                                            VALIDATE("Employer Amount(LCY)");

                                        end;
                                    end;
                                end;
                                //Vehicle Grant Provision
                                /*
                                if Deductions."Vehicle Grant" = true then begin
                                    if Empl.GET("Employee No") then begin
                                        if Scalex.GET(Empl."Salary Scale") then begin
                                            if Scalex."Vehicle Grant" <> 0 then
                                                "Employer Amount" := (Scalex."Vehicle Grant" / 12);
                                        end;
                                    end;
                                end;
*/

                                //Salary Recovery
                                SalaryRecoveryAmt := 0;
                                if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Salary Recovery" then begin
                                    if Empl.GET("Employee No") then begin
                                        Deductions.RESET;
                                        Deductions.SETRANGE(Deductions."Salary Recovery", true);
                                        if Deductions.FIND('-') then begin
                                            SalarySteps.RESET;
                                            SalarySteps.SETRANGE(SalarySteps.Code, Deductions.Code);
                                            SalarySteps.SETRANGE(SalarySteps."Employee No", "Employee No");
                                            SalarySteps.SETRANGE(SalarySteps."Payroll Period", "Payroll Period");
                                            // SalarySteps.SETRANGE(SalarySteps."Employee No",LoanApp."Employee No");
                                            if SalarySteps.FIND('-') then
                                                SalaryRecoveryAmt := SalarySteps.Amount;
                                            Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                                            // Empl.CALCFIELDS();
                                            Amount := ((Deductions.Percentage / 100) * SalaryRecoveryAmt);
                                            Amount := PayrollRounding(Amount);//round
                                        end;
                                    end;
                                end;
                                //end of salary recovery

                                if Deductions.CoinageRounding = true then begin
                                    //     HRSetup.GET();
                                    //     Maxlimit:=HRSetup."Pension Limit Amount";
                                    Retirement := Deductions.CoinageRounding;
                                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay" then
                                        "Employer Amount" := Deductions.Percentage / 100 * Empl."Basic Pay"
                                    else
                                        "Employer Amount" := Deductions."Flat Amount";
                                    "Employer Amount" := PayrollRounding("Employer Amount");//round
                                end;

                                //  IF "Employer Amount" > Deductions."Maximum Amount" THEN
                                //     "Employer Amount":=Deductions."Maximum Amount";
                                Amount := PayrollRounding(Amount);//round
                                "Employer Amount" := PayrollRounding("Employer Amount");//round
                            end;

                            //added for Uganda requirements
                            // added by Lob vega
                            if Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table" then begin
                                if Empl.GET("Employee No") then begin
                                    Empl.CALCFIELDS(Empl."Total Allowances");
                                    Amount := ((Deductions.Percentage / 100) * (Empl."Basic Pay" + Empl."Total Allowances"));
                                    "Employer Amount" := ((Deductions.Percentage / 100) * (Empl."Basic Pay" + Empl."Total Allowances"));
                                    Amount := PayrollRounding(Amount);
                                    "Employer Amount" := PayrollRounding("Employer Amount");
                                end;
                            end;
                            //added for BM requirements
                            if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay+Hse Allowance" then begin
                                if Empl.GET("Employee No") then begin
                                    //SalarySteps.GET(Empl."Salary Steps",SalarySteps.Level::"Level 1",Empl."Salary Scheme Category");
                                    //Amount:=((Deductions.Percentage/100)* (Empl."Basic Pay"+SalarySteps."House allowance"));
                                    //"Employer Amount":=((Deductions.Percentage/100)*(Empl."Working Days Per Year"+SalarySteps."House allowance"));
                                    Amount := PayrollRounding(Amount);
                                    "Employer Amount" := PayrollRounding("Employer Amount");
                                end;
                            end;
                            //
                            if Type = Type::Deduction then
                                Amount := -Amount;

                            //*******New Addition*******************
                            if Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Table" then begin
                                Empl.RESET;
                                Empl.SETRANGE(Empl."No.", "Employee No");
                                Empl.SETRANGE(Empl."Pay Period Filter", PayStartDate);
                                Empl.CALCFIELDS(Empl."Total Allowances", Empl.Basic);
                                // used gross pay new requirement for NHIF changed by Linus
                                // MESSAGE('Deduction Table');
                                Amount := -(GetBracket(Deductions, Empl."Total Allowances", "Employee Tier I", "Employee Tier II"));
                                if Deductions."Pension Scheme" then
                                    "Employer Amount" := (GetBracket(Deductions, Empl."Total Allowances", "Employer Tier I", "Employer Tier II"));

                            end;

                        end;

                //IF (Type=Type::Loan) THEN BEGIN
                /*Type::Loan:
                    begin
                        ERROR('...9');
                        LoanApp.RESET;
                        LoanApp.SETRANGE(LoanApp."Loan No", Code);
                        LoanApp.SETRANGE(LoanApp."Employee No", "Employee No");
                        if LoanApp.FIND('-') then begin
                            if LoanProductType.GET(LoanApp."Loan Product Type") then
                                Description := LoanProductType.Description;
                            Amount := -LoanApp.Repayment;
                            VALIDATE(Amount);
                        end;

                    end;*/
                end;
                //**********END**************************************************************************
                /*
                CASE Type OF
                Type::Payment:
                  BEGIN
                    IF Payments.GET(Code) THEN
                      BEGIN
                        Description:=Payments.Description;
                        MODIFY;
                        END;
                      END;
                Type::Deduction:
                  BEGIN
                    IF Deductions.GET(Code) THEN
                      BEGIN
                        Description:=Deductions.Description;
                        MODIFY;
                        END;
                    END;
                  END;
                  */

            end;
        }
        field(5; "Effective Start Date"; Date)
        {
        }
        field(6; "Effective End Date"; Date)
        {
        }
        field(7; "Payroll Period"; Date)
        {
            NotBlank = false;
            //This property is currently not supported
            //TestTableRelation = true;
            //ValidateTableRelation = true;

            trigger OnValidate();
            begin

                if PayPeriod.GET("Payroll Period") then
                    "Pay Period" := PayPeriod.Name;
            end;
        }
        field(8; Amount; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate();
            begin
                if (Type = Type::Payment) then
                    if Payments.GET(Code) then
                        if Payments."Reduces Tax" then begin
                            //Amount:=-Amount;
                        end;
                if (Type = Type::Payment) then
                    if Amount < 0 then
                        ERROR('Earning must not be negative');

                if (Type = Type::Deduction) then
                    if (Amount > 0) then
                        Amount := -Amount;

                if (Type = Type::Deduction) then begin
                    if Deductions.GET(Code) then begin
                        //IF Deductions.GET(Code) THEN BEGIN
                        if Deductions."Pension Arrears" = true then begin
                            //IF Empl.GET("Employee No") THEN BEGIN
                            // Empl.SETRANGE(Empl."Pay Period Filter",PayStartDate);

                            "Employer Amount" := 2 * Amount;
                            "Employer Amount" := PayrollRounding("Employer Amount");//round
                                                                                    //pension amount may exceed the maximum limit but the additional amount is tax
                                                                                    // END;
                        end;
                    end;
                end;
                // TESTFIELD(Closed,FALSE);
                //Added
                /*if "Loan Repay" = true then begin
                    if Loan.GET(Rec.Code, Rec."Employee No") then begin
                        Loan.CALCFIELDS(Loan."Cumm. Period Repayments");
                        "Period Repayment" := ABS(Amount) + "Interest Amount";
                        "Initial Amount" := Loan."Loan Amount";
                        // MESSAGE('amount %1  Cul repayment %2',Amount,Loan."Cumm. Period Repayments1");
                        "Outstanding Amount" := Loan."Loan Amount" - Loan."Cumm. Period Repayments";
                    end;
                end;*/
                Amount := PayrollRounding(Amount);
                if "Manual Entry" then begin
                    if Empl.GET("Employee No") then begin
                        Empl.SETRANGE(Empl."Pay Period Filter", "Payroll Period");
                        Empl.CALCFIELDS(Empl."Total Allowances", Empl."Total Deductions");

                    end;
                end;
                /*
                IF NOT "Manual Entry" THEN
                BEGIN
                IF Empl.GET("Employee No") THEN
                BEGIN
                Empl.SETRANGE(Empl."Pay Period Filter","Payroll Period");
                Empl.CALCFIELDS(Empl."Total Allowances",Empl."Total Deductions");
                IF ((Empl."Total Allowances"+Empl."Total Deductions"))<ROUND((Empl."Total Allowances")*1/3,0.02) THEN
                MESSAGE('Assigning this deduction for Employee %1 will result in a less 1/3 Rule, A Third Gross Pay=%2 Total deductions=%3'
                ,"Employee No",ROUND((Empl."Total Allowances")*1/3,0.02),Empl."Total Deductions");
                
                END;
                END;
                */

            end;
        }
        field(9; Description; Text[80])
        {

            trigger OnValidate();
            begin
                //TESTFIELD(Closed,FALSE);
            end;
        }
        field(10; Taxable; Boolean)
        {

            trigger OnValidate();
            begin
                // TESTFIELD(Closed,FALSE);
            end;
        }
        field(11; "Tax Deductible"; Boolean)
        {

            trigger OnValidate();
            begin
                //TESTFIELD(Closed,FALSE);
            end;
        }
        field(12; Frequency; Option)
        {
            OptionMembers = Recurring,"Non-recurring";
        }
        field(13; "Pay Period"; Text[30])
        {
        }
        field(14; "G/L Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(15; "Basic Pay"; Decimal)
        {
        }
        field(16; "Employer Amount"; Decimal)
        {
            DecimalPlaces = 2 : 2;

            trigger OnValidate();
            begin
                //TESTFIELD(Closed,FALSE);
            end;
        }
        field(17; "Global Dimension 1 code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(18; "Next Period Entry"; Boolean)
        {
        }
        field(19; "Posting Group Filter"; Code[20])
        {

            trigger OnValidate();
            begin
                //TESTFIELD(Closed,FALSE);
            end;
        }
        field(20; "Initial Amount"; Decimal)
        {
        }
        field(21; "Outstanding Amount"; Decimal)
        {
        }
        field(22; "Loan Repay"; Boolean)
        {

            trigger OnValidate();
            begin
                // TESTFIELD(Closed,FALSE);
            end;
        }
        field(23; Closed; Boolean)
        {
            Editable = true;
        }
        field(24; "Salary Grade"; Code[20])
        {
        }
        field(25; "Tax Relief"; Boolean)
        {
        }
        field(26; "Interest Amount"; Decimal)
        {

            trigger OnValidate();
            begin
                // TESTFIELD(Closed,FALSE);
            end;
        }
        field(27; "Period Repayment"; Decimal)
        {

            trigger OnValidate();
            begin
                // TESTFIELD(Closed,FALSE);
            end;
        }
        field(28; "Non-Cash Benefit"; Boolean)
        {

            trigger OnValidate();
            begin
                // TESTFIELD(Closed,FALSE);
            end;
        }
        field(29; Quarters; Boolean)
        {
        }
        field(30; "No. of Units"; Decimal)
        {

            trigger OnValidate();
            begin
                HRSetup.GET;
                if Type = Type::Payment then begin
                    if Payments.GET(Code) then begin
                        if Payments."Calculation Method" = Payments."Calculation Method"::"% of Basic after tax" then begin
                            if Empl.GET("Employee No") then;
                            //if HRSetup."Company overtime hours" <> 0 then
                            //Amount := (Empl."Hourly Rate" * "No. of Units" * Payments."Overtime Factor");///HRSetup."Company overtime hours"
                        end;

                        if Payments."Calculation Method" = Payments."Calculation Method"::"Based on Hourly Rate" then begin
                            if Empl.GET("Employee No") then
                                Amount := "No. of Units" * Empl."Daily Rate";
                            if Payments."Overtime Factor" <> 0 then
                                Amount := "No. of Units" * Empl."Daily Rate" * Payments."Overtime Factor"

                        end;

                        if Payments."Calculation Method" = Payments."Calculation Method"::"Flat amount" then begin
                            if Empl.GET("Employee No") then
                                Amount := "No. of Units" * Payments."Total Amount";
                        end;


                    end;
                end;

                //*****Deductions
                if Type = Type::Deduction then begin
                    if Deductions.GET(Code) then begin
                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Hourly Rate" then begin
                            if Empl.GET("Employee No") then
                                Amount := -"No. of Units" * Empl."Hourly Rate"
                        end;

                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"Based on Daily Rate " then begin
                            if Empl.GET("Employee No") then
                                Amount := -"No. of Units" * Empl."Daily Rate"
                        end;

                        if Deductions."Calculation Method" = Deductions."Calculation Method"::"Flat Amount" then begin
                            if Empl.GET("Employee No") then
                                Amount := -"No. of Units" * Deductions."Flat Amount";
                        end;

                    end;
                end;
                //TESTFIELD(Closed,FALSE);
            end;
        }
        field(31; Section; Code[20])
        {
        }
        field(33; Retirement; Boolean)
        {

            trigger OnValidate();
            begin
                // TESTFIELD(Closed,FALSE);
            end;
        }
        field(34; CFPay; Boolean)
        {

            trigger OnValidate();
            begin
                // TESTFIELD(Closed,FALSE);
            end;
        }
        field(35; BFPay; Boolean)
        {

            trigger OnValidate();
            begin
                // TESTFIELD(Closed,FALSE);
            end;
        }
        field(36; "Opening Balance"; Decimal)
        {
        }
        field(37; DebitAcct; Code[20])
        {
        }
        field(38; CreditAcct; Code[20])
        {
        }
        field(39; Shares; Boolean)
        {
        }
        field(40; "Show on Report"; Boolean)
        {
        }
        field(41; "Earning/Deduction Type"; Option)
        {
            OptionMembers = Recurring,"Non-recurring";
        }
        field(42; "Time Sheet"; Boolean)
        {
        }
        field(43; "Basic Salary Code"; Boolean)
        {
        }
        field(44; "Payroll Group"; Code[20])
        {
            TableRelation = "Employee Posting Group".Code;
        }
        field(45; Paye; Boolean)
        {
        }
        field(46; "Taxable amount"; Decimal)
        {
        }
        field(47; "Less Pension Contribution"; Decimal)
        {
        }
        field(48; "Monthly Personal Relief"; Decimal)
        {
        }
        field(49; "Normal Earnings"; Boolean)
        {
            Editable = false;
        }
        field(50; "Monthly Self Contribution"; Decimal)
        {
        }
        field(51; "Monthly Self Cummulative"; Decimal)
        {
        }
        field(52; "Company Monthly Contribution"; Decimal)
        {
        }
        field(53; "Company Cummulative"; Decimal)
        {
        }
        field(54; "Main Deduction Code"; Code[20])
        {
        }
        field(55; "Opening Balance Company"; Decimal)
        {
        }
        field(56; "Insurance Code"; Boolean)
        {
        }
        field(57; "Reference No"; Code[50])
        {
        }
        field(58; "Manual Entry"; Boolean)
        {
        }
        field(59; "Salary Pointer"; Code[20])
        {
        }
        field(60; "Employee Voluntary"; Decimal)
        {

            trigger OnValidate();
            begin
                Amount := -(ABS(Amount) + "Employee Voluntary");
            end;
        }
        field(61; "Employer Voluntary"; Decimal)
        {
        }
        field(62; "Loan Product Type"; Code[20])
        {
            // TableRelation = "Loan Product Type".Code;
        }
        field(63; "June Paye"; Decimal)
        {
        }
        field(64; "June Taxable Amount"; Decimal)
        {
        }
        field(65; "June Paye Diff"; Decimal)
        {
        }
        field(66; "Gratuity PAYE"; Decimal)
        {

            trigger OnValidate();
            begin
                if Paye = true then
                    MODIFY;
            end;
        }
        field(67; "Basic Pay Arrears"; Boolean)
        {
        }
        field(68; "Policy No./Loan No."; Code[20])
        {
        }
        field(69; "Loan Balance"; Decimal)
        {
        }
        field(70; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(71; "Global Dimension 3 Code"; Code[20])
        {
        }
        field(72; Information; Boolean)
        {
        }
        field(73; Cost; Decimal)
        {

            trigger OnValidate();
            begin
                VALIDATE(Code);
            end;
        }
        field(74; "Employee Tier I"; Decimal)
        {
        }
        field(75; "Employee Tier II"; Decimal)
        {
        }
        field(76; "Employer Tier I"; Decimal)
        {
        }
        field(77; "Employer Tier II"; Decimal)
        {
        }
        field(78; "Loan Interest"; Decimal)
        {
        }
        field(79; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Editable = false;
            TableRelation = "Dimension Set Entry";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;

            trigger OnLookup()
            var
                myInt: Integer;
            begin
                ShowDimensions;
            end;
        }
        field(50000; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            //ValidateTableRelation = false;
        }
        field(50001; Balance; Decimal)
        {
        }
        field(50002; "Suspend Start Date"; Date)
        {
        }
        field(50003; "Suspend End Date"; Date)
        {
        }
        field(50004; Suspended; Boolean)
        {
        }
        field(50005; "Suspended Amount"; Decimal)
        {
        }
        field(50006; "Vol. amount"; Decimal)
        {
        }
        field(50007; "Emp Oustanding Balance"; Decimal)
        {
        }
        field(50008; "Imported Record"; Boolean)
        {
        }
        field(50009; "Amount  less interest"; Decimal)
        {
            //CalcFormula = Sum ("Loans transactions"."Period Repayments" WHERE (Employee = FIELD ("Employee No"),
            //                                                                  Code = FIELD (Code)));
            FieldClass = FlowField;
        }
        field(50010; "Top Up Share"; Decimal)
        {
        }
        field(60000; "Pension Updated?"; Boolean)
        {
        }
        field(60001; "Amount(LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                //Convert to FCY
                if Empl.GET("Employee No") then begin
                    if Empl."Payroll Currency" <> '' then
                        CurrencyFactor :=
                          CurrExchRate.ExchangeRate(TODAY, Empl."Payroll Currency");
                    if Empl."Payroll Currency" = '' then
                        Amount := "Amount(LCY)"
                    else
                        Amount := ROUND(
                       CurrExchRate.ExchangeAmtLCYToFCY(
                       TODAY, Empl."Payroll Currency",
                        "Amount(LCY)", CurrencyFactor));


                end;
            end;
        }
        field(60002; "Employer Amount(LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                //Convert to FCY
                if Empl.GET("Employee No") then begin
                    if Empl."Payroll Currency" <> '' then
                        CurrencyFactor :=
                          CurrExchRate.ExchangeRate(TODAY, Empl."Payroll Currency");
                    if Empl."Payroll Currency" = '' then
                        "Employer Amount" := "Employer Amount(LCY)"
                    else
                        "Employer Amount" := ROUND(
                       CurrExchRate.ExchangeAmtLCYToFCY(
                       TODAY, Empl."Payroll Currency", "Employer Amount(LCY)", CurrencyFactor));
                end;
            end;
        }
        field(60003; Batch; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60004; "Voluntary Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                if "Voluntary Percentage" <> 0 then begin
                    Assignmatrix.RESET;
                    Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                    Assignmatrix.SETRANGE("Basic Salary Code", true);
                    Assignmatrix.SETRANGE("Employee No", "Employee No");
                    Assignmatrix.SETRANGE("Payroll Period", "Payroll Period");
                    if Assignmatrix.FINDFIRST then
                        Amount := Assignmatrix.Amount * ("Voluntary Percentage" / 100);
                end;
            end;
        }
        field(60005; "Full month tax"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60006; "Gratuity Pay"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60007; "No of Months"; Integer)
        {
            DataClassification = ToBeClassified;
            Description = 'For Arrears';
        }
        field(60008; "Gratuity Paid"; Boolean)
        {

        }
        field(60009; gratuity; Boolean)
        {

        }
    }

    keys
    {
        key(Key1; "Employee No", Type, "Code", "Payroll Period", "Reference No", Batch)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key2; "Employee No", Taxable, "Tax Deductible", Retirement, "Non-Cash Benefit", "Tax Relief")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key3; Type, "Code", "Posting Group Filter")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key4; "Non-Cash Benefit")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key5; Quarters)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key6; "Non-Cash Benefit", Taxable)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key7; Type, Retirement)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key8; "Global Dimension 1 code", "Payroll Period", "Code")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key9; "Employee No", Shares)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key10; Closed, "Code", Type, "Employee No")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key11; "Show on Report")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key12; "Employee No", "Code", "Payroll Period", "Next Period Entry")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key13; "Opening Balance")
        {
        }
        key(Key14; "Global Dimension 1 code", "Payroll Period", Type, "Code")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key15; "Basic Salary Code", "Basic Pay Arrears")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount;
        }
        key(Key16; Paye)
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount, "Taxable amount", "Less Pension Contribution";
        }
        key(Key17; "Employee No", "Payroll Period", Type, "Non-Cash Benefit", "Normal Earnings")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount, "Taxable amount";
        }
        key(Key18; "Posting Group Filter")
        {
            SumIndexFields = "Employer Amount", "Interest Amount", "Period Repayment", "No. of Units", "Opening Balance", Amount, "Taxable amount";
        }
        key(Key19; "Payroll Period", Type, "Code")
        {
            SumIndexFields = Amount;
        }
        key(Key20; Type, "Employee No", "Payroll Period", "Insurance Code")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        PensionFactor: Decimal;
        Payments: Record Earnings;
        Deductions: Record Deductions;
        Paydeduct: Decimal;
        Empl: Record Employee;
        PayPeriod: Record "Payroll Period";
        //Loan: Record "Loans transactions";
        PayStartDate: Date;
        PayPeriodText: Text[30];
        TableAmount: Decimal;
        Basic: Decimal;
        ReducedBal: Decimal;
        InterestAmt: Decimal;
        HRSetup: Record "Human Resources Setup";
        Maxlimit: Decimal;
        Benefits: Record "Brackets Lines";
        InterestDiff: Decimal;
        SalarySteps: Record "Assignment Matrix";
        //LoanProductType: Record "Loan Product Type";
        //LoanApp: Record "Loan Application";
        "reference no": Record "Assignment Matrix";
        LoanBalance: Decimal;
        TotalRepayment: Decimal;
        SalaryRecoveryAmt: Decimal;
        //LoanTopUps: Record "Loan Top-up";
        TotalTopups: Decimal;
        BasicSalary: Decimal;
        Month: Date;
        Assignmatrix: Record "Assignment Matrix";
        BasicSalaryCode: Code[30];
        CurrExchRate: Record "Currency Exchange Rate";
        AddConsRelief: Decimal;
        [SecurityFiltering(SecurityFilter::Filtered)]
        EarnRec: Record Earnings;
        TotalGross: Decimal;
        BatchNo: Code[10];
        StaffP: Record "Salary Scales";
        [SecurityFiltering(SecurityFilter::Filtered)]
        Deds: Record Deductions;
        ErPension: Decimal;
        Dims: Record "Dimension Value";
        BasicHSFactor: Decimal;
        DedsCounter: Integer;
        GPayAmount: Decimal;
        CalcTbl: Record "Age Based Calculations";
        CalcLines: Record "Age Based Lines";
        EmpAge: Decimal;
        CalcPerc: Decimal;
        GratPay: Decimal;
        ArrearVal: Decimal;
        CurrencyFactor: Decimal;
        Scalex: Record "Salary Scales";
        GratuityAmount: Decimal;
        DimMgt: Codeunit DimensionManagement;
        DefDim: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";

    procedure GetPayPeriod();
    var
        Per: Record "Payroll period";
        Posting: Record "Staff Posting Group";
        Employ: Record Employee;
        ScaleFilter: Code[20];
    begin
        Employ.RESET;
        Employ.SETRANGE("No.", "Employee No");
        if Employ.FIND('-') then begin
            /*
            StaffP.RESET;
            StaffP.SETRANGE(Scale,Employ."Salary Scale");
            IF StaffP.FIND('-') THEN
              ScaleFilter:=StaffP."Payroll Category";
              ScaleFilter:='';
            Per.RESET;
            Per.SETRANGE("Payroll Group",Employ."Posting Group");
            IF ScaleFilter<>'' THEN
            Per.SETRANGE("Payroll Category",ScaleFilter);
            */

            Per.RESET;
            //Per.SETRANGE("Payroll Group", Employ."Posting Group");
            Per.SETRANGE(Closed, false);
            if Per.FINDFIRST then begin
                PayStartDate := Per."Starting Date";
                PayPeriodText := FORMAT(Per."Starting Date", 0, '<Month Text> <Year4>');
                //BatchNo := Per."Batch No";
            end;
        end;
        //Old code
        /*
      PayPeriod.SETRANGE(PayPeriod."Close Pay",FALSE);
      IF PayPeriod.FINDFIRST THEN
      PayStartDate:=PayPeriod."Starting Date";
      PayPeriodText:=PayPeriod.Name;
      */

    end;

    procedure GetBracket(DeductionsRec: Record Deductions; BasicPay: Decimal; var TierI: Decimal; var TierII: Decimal) TotalAmt: Decimal;
    var
        BracketTable: Record "Brackets Lines";
        BracketSource: Record "Bracket Tables";
        Loop: Boolean;
        PensionableAmt: Decimal;
        TableAmount: Decimal;
        i: Integer;
    begin
        TotalAmt := 0;
        TableAmount := 0;
        i := 0;
        if BracketSource.GET(DeductionsRec."Deduction Table") then;
        BracketTable.SETRANGE(BracketTable."Table Code", DeductionsRec."Deduction Table");
        BracketTable.SETRANGE(Institution, DeductionsRec."Institution Code");
        if BracketTable.FIND('-') then begin
            case BracketSource.Type of
                BracketSource.Type::Fixed:
                    begin
                        repeat
                            if ((BasicPay >= BracketTable."Lower Limit") and (BasicPay <= BracketTable."Upper Limit")) then
                                TotalAmt := BracketTable.Amount;
                        until BracketTable.NEXT = 0;
                    end;

                BracketSource.Type::"Graduating Scale":
                    begin
                        PensionableAmt := BasicPay;
                        repeat
                            i := i + 1;
                            if BasicPay <= 0 then
                                Loop := true
                            else begin
                                if BasicPay >= BracketTable."Upper Limit" then begin
                                    TableAmount := (BracketTable."Taxable Amount" * BracketTable.Percentage / 100);
                                    if Deductions."Pension Scheme" then begin
                                        if i = 1 then
                                            TierI := TableAmount
                                        else
                                            TierII := TableAmount;
                                    end;
                                    TotalAmt := TotalAmt + TableAmount;
                                end
                                else begin
                                    PensionableAmt := PensionableAmt - BracketTable."Lower Limit";
                                    TableAmount := PensionableAmt * (BracketTable.Percentage / 100);
                                    Loop := true;
                                    if Deductions."Pension Scheme" then begin
                                        if i = 1 then
                                            TierI := TableAmount
                                        else
                                            TierII := TableAmount;
                                    end;
                                    TotalAmt := TotalAmt + TableAmount;
                                end;
                            end;
                        until (BracketTable.NEXT = 0) or Loop = true;
                    end;
            end;
        end;

        exit(TotalAmt);
        //ELSE
        //MESSAGE('The Brackets have not been defined');
    end;

    procedure CreateLIBenefit(var Employee: Code[10]; var BenefitCode: Code[10]; var ReducedBalance: Decimal);
    var
        PaymentDeduction: Record "Assignment Matrix";
        Payrollmonths: Record "Payroll Period";
        allowances: Record Earnings;
    begin
        PaymentDeduction.INIT;
        PaymentDeduction."Employee No" := Employee;
        PaymentDeduction.Code := BenefitCode;
        PaymentDeduction.Type := PaymentDeduction.Type::Payment;
        PaymentDeduction."Payroll Period" := PayStartDate;
        PaymentDeduction.Amount := ReducedBalance * InterestDiff;
        PaymentDeduction."Non-Cash Benefit" := true;
        PaymentDeduction.Taxable := true;
        //PaymentDeduction."Next Period Entry":=TRUE;
        if allowances.GET(BenefitCode) then
            PaymentDeduction.Description := allowances.Description;
        PaymentDeduction.INSERT;
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

    procedure CheckIfRatesInclusive(EmpNo: Code[20]; PayPeriod: Date; DeductionCode: Code[20]; var DeductibleAmt: Decimal);
    var
        DeductionsRec: Record Deductions;
        BracketTable: Record "Brackets Lines";
        BracketSource: Record "Bracket Tables";
        AssMatrix: Record "Assignment Matrix";
        i: Integer;
    begin
        if DeductionsRec.GET(DeductionCode) then begin
            if DeductionsRec."Pension Scheme" then begin
                i := 0;
                DeductionsRec.RESET;
                DeductionsRec.SETRANGE("Calculation Method", DeductionsRec."Calculation Method"::"Based on Table");
                DeductionsRec.SETRANGE("Pension Scheme", true);
                if DeductionsRec.FIND('-') then begin
                    if BracketSource.GET(DeductionsRec."Deduction Table") then;
                    BracketTable.SETRANGE(BracketTable."Table Code", DeductionsRec."Deduction Table");
                    if BracketTable.FIND('-') then
                        repeat
                            i := i + 1;
                            if BracketTable."Contribution Rates Inclusive" then begin
                                AssMatrix.RESET;
                                AssMatrix.SETRANGE("Employee No", EmpNo);
                                AssMatrix.SETRANGE("Payroll Period", PayPeriod);
                                AssMatrix.SETRANGE(Type, AssMatrix.Type::Deduction);
                                AssMatrix.SETRANGE(Code, DeductionsRec.Code);
                                if AssMatrix.FIND('-') then begin
                                    if i = 1 then
                                        DeductibleAmt := DeductibleAmt - AssMatrix."Employee Tier I"
                                    else
                                        DeductibleAmt := DeductibleAmt - AssMatrix."Employee Tier II";
                                end;
                            end;
                        until
                         BracketTable.NEXT = 0;
                end;
            end;
        end;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])
    var
        myInt: Integer;
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowDimensions()
    var
        myInt: Integer;
    begin

        "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID", STRSUBSTNO('%1 %2 %3', "Employee No", "Code", Type),
            "Global Dimension 1 Code", "Global Dimension 2 Code");
    end;
}

