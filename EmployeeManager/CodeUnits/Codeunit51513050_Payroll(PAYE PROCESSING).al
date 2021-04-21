codeunit 51513050 "Payroll(PAYE PROCESSING)"
{
    // version PAYROLL


    trigger OnRun();
    begin
    end;

    var
        AmountRemaining: Decimal;
        TaxableAmount: Decimal;
        TaxCode: Code[20];
        IncomeTax: Decimal;
        GrossTaxCharged: Decimal;
        relief: Decimal;
        PayPeriod: Record "Payroll Period";
        BeginDate: Date;
        BasicSalary: Decimal;
        CompRec: Record "Human Resources Setup";
        HseLimit: Decimal;
        Emp: Record Employee;
        retirecontribution: Decimal;
        ExcessRetirement: Decimal;
        PAYE: Decimal;
        TaxablePay: Decimal;
        EmpRec: Record Employee;
        BfMpr: Decimal;
        CfMpr: Decimal;
        GrossPay: Decimal;
        TotalBenefits: Decimal;
        RetireCont: Decimal;
        TotalQuarters: Decimal;
        LowInterestBenefits: Decimal;
        Netpay: Decimal;
        [SecurityFiltering(SecurityFilter::Filtered)]
        Earnings: Record Earnings;
        TerminalDues: Decimal;
        [SecurityFiltering(SecurityFilter::Filtered)]
        Earn: Record Earnings;
        TaxTable: Record "Brackets Lines";
        [SecurityFiltering(SecurityFilter::Filtered)]
        Ded: Record Deductions;
        i: Integer;
        Text000: Label 'Preview is not allowed.';
        Text001: Label 'Last Check No. must be filled in.';
        Text002: Label 'Filters on %1 and %2 are not allowed.';
        Text003: Label 'XXXXXXXXXXXXXXXX';
        Text004: Label 'must be entered.';
        Text005: Label 'The Bank Account and the General Journal Line must have the same currency.';
        Text006: Label 'Salesperson';
        Text007: Label 'Purchaser';
        Text008: Label 'Both Bank Accounts must have the same currency.';
        Text009: Label 'Our Contact';
        Text010: Label 'XXXXXXXXXX';
        Text011: Label 'XXXX';
        Text012: Label 'XX.XXXXXXXXXX.XXXX';
        Text013: Label '%1 already exists.';
        Text014: Label 'Check for %1 %2';
        Text015: Label 'Payment';
        Text016: Label 'In the Check report, One Check per Vendor and Document No.\';
        Text017: Label 'must not be activated when Applies-to ID is specified in the journal lines.';
        Text018: Label 'XXX';
        Text019: Label 'Total';
        Text020: Label 'The total amount of check %1 is %2. The amount must be positive.';
        Text021: Label 'VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID VOID';
        Text022: Label 'NON-NEGOTIABLE';
        Text023: Label 'Test print';
        Text024: Label 'XXXX.XX';
        Text025: Label 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX';
        Text026: Label 'ZERO';
        Text027: Label 'HUNDRED';
        Text028: Label 'AND';
        Text029: Label '%1 results in a written number that is too long.';
        Text030: Label '" is already applied to %1 %2 for customer %3."';
        Text031: Label '" is already applied to %1 %2 for vendor %3."';
        Text032: Label 'ONE';
        Text033: Label 'TWO';
        Text034: Label 'THREE';
        Text035: Label 'FOUR';
        Text036: Label 'FIVE';
        Text037: Label 'SIX';
        Text038: Label 'SEVEN';
        Text039: Label 'EIGHT';
        Text040: Label 'NINE';
        Text041: Label 'TEN';
        Text042: Label 'ELEVEN';
        Text043: Label 'TWELVE';
        Text044: Label 'THIRTEEN';
        Text045: Label 'FOURTEEN';
        Text046: Label 'FIFTEEN';
        Text047: Label 'SIXTEEN';
        Text048: Label 'SEVENTEEN';
        Text049: Label 'EIGHTEEN';
        Text050: Label 'NINETEEN';
        Text051: Label 'TWENTY';
        Text052: Label 'THIRTY';
        Text053: Label 'FORTY';
        Text054: Label 'FIFTY';
        Text055: Label 'SIXTY';
        Text056: Label 'SEVENTY';
        Text057: Label 'EIGHTY';
        Text058: Label 'NINETY';
        Text059: Label 'THOUSAND';
        Text060: Label 'MILLION';
        Text061: Label 'BILLION';
        Text062: Label 'G/L Account,Customer,Vendor,Bank Account';
        Text063: Label 'Net Amount %1';
        Text064: Label '%1 must not be %2 for %3 %4.';
        Text065: Label 'AND // text0028 removed the AND';
        OnesText: array[20] of Text[30];
        TensText: array[10] of Text[30];
        ExponentText: array[5] of Text[30];
        mine: Text[30];
        DisabilityRelief: Decimal;
        AssignmentMatrixRec: Record "Assignment Matrix";
        DepRelief: Decimal;
        ReliefSetup: Record "Tax Relief Table";
        EmpPost: Record "Staff Posting Group";
        Employ: Record Employee;
        CurrExchRate: Record "Currency Exchange Rate";
        CurrencyFactor: Decimal;
        ArreasAmt: Decimal;
        ArrearTxbl: Decimal;
        NoOfMonths: Integer;
        ArrearsRel: Decimal;
    //ObjDepExt : Record "Depenfdants Extended Table";

    procedure GetTaxBracket(TaxableAmount: Decimal; TaxCodeNew: Code[10]): Decimal;
    var
        TaxTable: Record "Brackets Lines";
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
        BracketTables: Record "Bracket Tables";
    begin
        CompRec.GET;
        TaxCode := TaxCodeNew;
        AmountRemaining := TaxableAmount;

        //MESSAGE('Taxcode %1', TaxCodeNew);
        //Message('Taxable amount %1', AmountRemaining);
        EndTax := false;

        TaxTable.RESET;
        TaxTable.SETRANGE("Table Code", TaxCode);
        if TaxTable.FIND('-') then begin
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    BracketTables.RESET;
                    BracketTables.SETRANGE("Bracket Code", TaxTable."Table Code");
                    if BracketTables.FIND('-') then begin
                        if BracketTables."Tax Computation Method" = BracketTables."Tax Computation Method"::Progressive then begin
                            if (AmountRemaining) >= TaxTable."Upper Limit" then begin
                                Tax := (TaxTable."Taxable Amount" * TaxTable.Percentage / 100);
                                Tax := Tax;
                                TotalTax := TotalTax + Tax;
                            end else begin
                                AmountRemaining := AmountRemaining - TaxTable."Lower Limit" + 0.01;
                                Tax := AmountRemaining * (TaxTable.Percentage / 100);
                                TotalTax := TotalTax + Tax;
                                EndTax := true;
                            end;
                        end else begin
                            if (AmountRemaining <= TaxTable."Upper Limit") and (AmountRemaining >= TaxTable."Lower Limit") then begin
                                Tax := (((AmountRemaining - TaxTable."Relief 1(Burundi)") * (TaxTable.Percentage / 100)) + TaxTable."Relief 2(Burundi)");
                                //Tax:=((AmountRemaining-TaxTable."Relief 1(Burundi)")*TaxTable.Percentage/100),0.01);
                                //Tax:=ROUND((AmountRemaining*TaxTable.Percentage/100),0.01);
                                //MESSAGE('Tax %1',Tax);
                                EndTax := true;
                                TotalTax := TotalTax + Tax;
                            end;
                        end;
                    end;

                end;
            until (TaxTable.NEXT = 0) or EndTax = true;
        end;
        TotalTax := TotalTax;
        //
        TotalTax := TotalTax;//,'<'
                             //MESSAGE('TotalTax=%1',TotalTax);
        IncomeTax := TotalTax;
        //MESSAGE('IncomeTax=%1', IncomeTax);
        exit(IncomeTax);
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
                //PayPeriodtext:=PayPeriod.Name;
                BeginDate := PayPeriod."Starting Date";
            end;
        end;
    end;

    procedure CalculateTaxableAmount(var EmployeeNo: Code[20]; var DateSpecified: Date; var TaxableAmountNew: Decimal; var RetirementCont: Decimal; EarningCode: Code[30]; AmountDeductible: Decimal): Decimal;
    var
        Assignmatrix: Record "Assignment Matrix";
        EmpRec: Record Employee;
        [SecurityFiltering(SecurityFilter::Filtered)]
        EarnRec: Record Earnings;
        InsuranceRelief: Decimal;
        PersonalRelief: Decimal;
        HRSetup: Record "Human Resources Setup";
        Assignmatrix7: Record "Assignment Matrix";
        Bracketrec: Record "Brackets Lines";
        BracketTables: Record "Bracket Tables";
        FinalTax: Decimal;
        ObjDed: Record Deductions;
    begin
        CfMpr := 0;
        FinalTax := 0;
        i := 0;
        TaxableAmount := 0;
        RetirementCont := 0;
        InsuranceRelief := 0;
        PersonalRelief := 0;
        ArreasAmt := 0;
        //Get payroll period
        GetPayPeriod(EmployeeNo);
        if DateSpecified = 0D then
            ERROR('Pay period must be specified for this report');


        // Taxable Amount
        EmpRec.RESET;
        EmpRec.SETRANGE(EmpRec."No.", EmployeeNo);
        EmpRec.SETRANGE("Pay Period Filter", DateSpecified);
        if EmpRec.FIND('-') then begin
            if EmpRec."Pays tax" = true then begin
                /*
              //Get Taxable amount from assigment matrix
              AssignmentMatrixRec.RESET;
              AssignmentMatrixRec.SETRANGE(AssignmentMatrixRec."Employee No",EmployeeNo);
              AssignmentMatrixRec.SETRANGE(AssignmentMatrixRec."Payroll Period",DateSpecified);
              AssignmentMatrixRec.SETRANGE(AssignmentMatrixRec.Taxable,TRUE);
              IF AssignmentMatrixRec.FINDFIRST THEN
                REPEAT
                  TaxableAmount:=TaxableAmount+AssignmentMatrixRec.Amount;
                  UNTIL AssignmentMatrixRec.NEXT=0;
                */
                EmpRec.CALCFIELDS(EmpRec."Taxable Allowance", "Tax Deductible Amount", "Relief Amount");
                TaxableAmount := EmpRec."Taxable Allowance"; //-ABS(EmpRec."Relief Amount");

                if EarningCode <> '' then begin
                    TaxableAmount := TaxableAmount - AmountDeductible;
                end;
                //ERROR('Taxable Amt %1',TaxableAmount);
                //********************************************Get Tax Table for respective Country**************************//
                /*BracketTables.RESET;
                BracketTables.SETRANGE(BracketTables."Country/Region Code",EmpRec."Country/Region Code");
                if BracketTables.FIND('-') then
                    TaxCode := BracketTables."Bracket Code";
                //MESSAGE('Tax code %1', TaxCode);*/
                ObjDed.Reset();
                ObjDed.SetRange("PAYE Code", true);
                if ObjDed.Find('-') then
                    TaxCode := ObjDed."Deduction Table";
                //********************************************Get Tax Table for respective Country**************************//
                Ded.RESET;
                Ded.SETRANGE(Ded."Tax deductible", true);
                if Ded.FIND('-') then begin
                    repeat
                        Assignmatrix.RESET;
                        Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Deduction);
                        Assignmatrix.SETRANGE(Assignmatrix.Code, Ded.Code);
                        Assignmatrix.SETRANGE(Assignmatrix."Employee No", EmployeeNo);
                        Assignmatrix.SETRANGE(Closed, false);
                        if Assignmatrix.FIND('-') then begin
                            /*IF Ded."Pension Limit Amount">0 THEN BEGIN
                                  IF ABS(Assignmatrix.Amount)>Ded."Pension Limit Amount" THEN
                                      RetirementCont:=ABS(RetirementCont)+Ded."Pension Limit Amount"
                                  ELSE
                                      RetirementCont:=ABS(RetirementCont)+ABS(Assignmatrix.Amount);
                            END;*/
                            /*IF Ded."Pension Limit Amount"<=0 THEN BEGIN
                                 RetirementCont:=ABS(RetirementCont)+ABS(Assignmatrix.Amount);
                            END;*/
                            RetirementCont := RetirementCont + ABS(Assignmatrix.Amount);
                            RetireCont := RetirementCont;
                        end;
                    until Ded.NEXT = 0;
                end;

                /*HRSetup.GET;
                IF RetirementCont>HRSetup."Pension Limit Amount" THEN
                RetirementCont:=HRSetup."Pension Limit Amount";*/

                TaxableAmount := TaxableAmount - RetirementCont;
                //ERROR('Taxable Amt %1',TaxableAmount);
                if EmpRec."Home Ownership Status" = EmpRec."Home Ownership Status"::"Owner Occupier" then begin
                    //****************************************Get owner Occuper From Earning Table************************************//
                    EarnRec.RESET;
                    EarnRec.SETCURRENTKEY(EarnRec."Earning Type");
                    EarnRec.SETRANGE(EarnRec."Earning Type", EarnRec."Earning Type"::"Owner Occupier");
                    if EarnRec.FIND('-') then begin
                        repeat
                            Assignmatrix.RESET;
                            Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", DateSpecified);
                            Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                            Assignmatrix.SETRANGE(Assignmatrix.Code, EarnRec.Code);
                            Assignmatrix.SETRANGE(Assignmatrix."Employee No", EmployeeNo);
                            Assignmatrix.SETRANGE(Closed, false);
                            if Assignmatrix.FIND('-') then
                                TaxableAmount := TaxableAmount - Assignmatrix.Amount;
                        until EarnRec.NEXT = 0;
                    end;
                end;
                //****************************************Get owner Occuper From Earning Table************************************//

                // *********************************************Low Interest Benefits*********************************************//
                EarnRec.RESET;
                EarnRec.SETCURRENTKEY(EarnRec."Earning Type");
                EarnRec.SETRANGE(EarnRec."Earning Type", EarnRec."Earning Type"::"Low Interest");
                if EarnRec.FIND('-') then begin
                    repeat
                        Assignmatrix.RESET;
                        Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                        Assignmatrix.SETRANGE(Assignmatrix.Code, EarnRec.Code);
                        Assignmatrix.SETRANGE(Assignmatrix."Employee No", EmployeeNo);
                        Assignmatrix.SETRANGE(Closed, false);
                        if Assignmatrix.FIND('-') then
                            TaxableAmount := TaxableAmount + Assignmatrix.Amount;
                    until EarnRec.NEXT = 0;
                end;
                // *********************************************Low Interest Benefits*********************************************//

                //**********************************************Disability Relief JK**********************************************//
                DisabilityRelief := 0;
                EarnRec.RESET;
                EarnRec.SETCURRENTKEY(EarnRec."Earning Type");
                EarnRec.SETRANGE(EarnRec."Earning Type", EarnRec."Earning Type"::"Disability Relief");
                if EarnRec.FIND('-') then begin
                    repeat
                        Assignmatrix.RESET;
                        Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                        Assignmatrix.SETRANGE(Assignmatrix.Code, EarnRec.Code);
                        Assignmatrix.SETRANGE(Assignmatrix."Employee No", EmployeeNo);
                        Assignmatrix.SETRANGE(Closed, false);
                        if Assignmatrix.FIND('-') then begin
                            DisabilityRelief := Assignmatrix.Amount;
                            TaxableAmount := TaxableAmount - EarnRec."Maximum Limit";
                        end;
                    until EarnRec.NEXT = 0;
                end;
                //**********************************************Disability Relief JK**********************************************//

                //**********************************************Dependants Relief**********************************************//

                /*
                   DepRelief:=0;
                   Emp.RESET;
                   Emp.SETRANGE("No.",EmployeeNo);
                   IF Emp.FIND('-') THEN
                    BEGIN
                      //Emp.CALCFIELDS("No of Dependants");
                      DepRelief:=GetDependantsReleif(Emp."No of Dependants",TaxableAmount,Emp."Country/Region Code");
                      TaxableAmount:=TaxableAmount-DepRelief;
                      END;
                  */
                //**********************************************Dependants Relief**********************************************//

                //*********************************Tax relief that reduces taxable amount***********************************//
                EarnRec.RESET;
                EarnRec.SETCURRENTKEY(EarnRec."Earning Type");
                EarnRec.SETRANGE(EarnRec."Earning Type", EarnRec."Earning Type"::"Tax Relief");
                EarnRec.SETRANGE("Reduces Taxable Amount", true);
                if EarnRec.FIND('-') then begin
                    repeat
                        Assignmatrix.RESET;
                        Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                        Assignmatrix.SETRANGE(Assignmatrix.Code, EarnRec.Code);
                        Assignmatrix.SETRANGE(Assignmatrix."Employee No", EmployeeNo);
                        Assignmatrix.SETRANGE(Closed, false);
                        if Assignmatrix.FIND('-') then
                            TaxableAmount := TaxableAmount - Assignmatrix.Amount;
                    until EarnRec.NEXT = 0;
                end;
                //*********************************Tax relief that reduces taxable amount***********************************//

                // Arrears taxed as a full-month pay
                EarnRec.RESET;
                EarnRec.SETCURRENTKEY(EarnRec."Earning Type");
                EarnRec.SETRANGE(EarnRec."Earning Type", EarnRec."Earning Type"::"Normal Earning");
                EarnRec.SETRANGE("Full Month Tax", true);
                if EarnRec.FIND('-') then begin
                    repeat
                        Assignmatrix.RESET;
                        Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                        Assignmatrix.SETRANGE(Assignmatrix.Code, EarnRec.Code);
                        Assignmatrix.SETRANGE(Assignmatrix."Employee No", EmployeeNo);
                        Assignmatrix.SETRANGE(Closed, false);
                        if Assignmatrix.FIND('-') then begin
                            ArreasAmt := ArreasAmt + Assignmatrix.Amount;
                            NoOfMonths := Assignmatrix."No of Months";
                            Assignmatrix7.RESET;
                            Assignmatrix7.SETRANGE("Employee No", EmployeeNo);
                            Assignmatrix7.SETRANGE(Type, Assignmatrix7.Type::Deduction);
                            Assignmatrix7.SETRANGE(Retirement, true);
                            Assignmatrix7.SETRANGE("Payroll Period", DateSpecified);
                            if Assignmatrix7.FIND('-') then begin
                                Ded.RESET;
                                Ded.SETRANGE("Pension Scheme", true);
                                Ded.SETRANGE(Code, Assignmatrix7.Code);
                                if Ded.FIND('-') then begin
                                    if Ded.Percentage <> 0 then begin
                                        ArreasAmt := ArreasAmt - (((ArreasAmt * EarnRec."Percentage to Pension" / 100) * (Ded.Percentage / 100)));

                                    end;
                                end;
                            end;
                        end;
                    until EarnRec.NEXT = 0;
                end;

                if ArreasAmt > 0 then
                    TaxableAmount := TaxableAmount - ArreasAmt;

                TaxableAmountNew := TaxableAmount;

                // ******************************Get PAYE*************************************//
                //Normal Tax
                Employ.RESET;
                Employ.SETRANGE("No.", EmployeeNo);
                if Employ.FIND('-') then begin
                    if EmpPost.GET(Employ."Posting Group") then begin

                        if EmpPost."Round Down (1000)" then begin
                            if EmpPost."Tax Percentage" = 0 then
                                FinalTax := GetTaxBracket(ROUND(TaxableAmount, 1000, '<'), TaxCode)
                            else
                                FinalTax := ROUND(TaxableAmount, 1000, '<') * (EmpPost."Tax Percentage" / 100);
                        end else begin
                            if EmpPost."Tax Percentage" = 0 then
                                FinalTax := GetTaxBracket(TaxableAmount, TaxCode)
                            else
                                FinalTax := TaxableAmount * (EmpPost."Tax Percentage" / 100);
                        end;
                        if Employ."Tax Rate Percentage" <> 0 then begin
                            FinalTax := ((TaxableAmount + RetirementCont) * (Employ."Tax Rate Percentage" / 100));

                        end;

                        //********************Added For Mozambique****************//
                        /*if EmpPost."Dependants based Tax" then

                         begin
                           if Employ."No of Dependants"<=EmpPost."Max No of Dependants" then
                             begin
                               ObjDepExt.RESET;
                               ObjDepExt.SETRANGE("Table Code",Employ."Posting Group");
                               ObjDepExt.SETRANGE("No Of Dependants",Employ."No of Dependants");
                               if ObjDepExt.FINDSET then
                                 repeat
                                   if (TaxableAmount<=ObjDepExt."Upper Limit") and (TaxableAmount >=ObjDepExt."Lower Limit") then
                                     begin
                                     //MESSAGE('Taxable %1, Lower Limit %2,  Percentage %3,  Tax Amount %4',TaxableAmount,ObjDepExt."Lower Limit",ObjDepExt.Percentage,ObjDepExt."Tax Amount");
                                       FinalTax:=(((TaxableAmount-ObjDepExt."Lower Limit")*(ObjDepExt.Percentage/100))+ObjDepExt."Tax Amount");
                                       end;
                                   until ObjDepExt.NEXT=0;
                               end else
                               begin
                                 ObjDepExt.RESET;
                                 ObjDepExt.SETRANGE("Table Code",Employ."Posting Group");
                                 ObjDepExt.SETRANGE("No Of Dependants",EmpPost."Max No of Dependants");
                                 if ObjDepExt.FINDSET then
                                   repeat
                                     if (TaxableAmount<=ObjDepExt."Upper Limit") and (TaxableAmount >=ObjDepExt."Lower Limit") then
                                       begin
                                       //MESSAGE('Taxable %1, Lower Limit %2,  Percentage %3,  Tax Amount %4',TaxableAmount,ObjDepExt."Lower Limit",ObjDepExt.Percentage,ObjDepExt."Tax Amount");
                                         FinalTax:=(((TaxableAmount-ObjDepExt."Lower Limit")*(ObjDepExt.Percentage/100))+ObjDepExt."Tax Amount");
                                         end;
                                     until ObjDepExt.NEXT=0;
                                 end;

                           end;
                        //********************Added For Mozambique****************
                        end;*/

                        //Get Arrears tax
                        if ArreasAmt > 0 then begin
                            ArrearTxbl := GetReliefArr(ArreasAmt, EmployeeNo, DateSpecified, NoOfMonths, FinalTax);
                            FinalTax := FinalTax + ArrearTxbl;
                            //FinalTax:=FinalTax+GetTaxBracket(ArrearTxbl,TaxCode);
                        end;
                        /*
                         IF Employ."Payroll Currency"<>'' THEN BEGIN
                        //Get exchange rates
                        {
                           CurrencyFactor:=CurrExchRate.ExchangeRate(DateSpecified,Employ."Payroll Currency");
                               TaxableAmount:= ROUND(
                              CurrExchRate.ExchangeAmtFCYToLCY(
                              DateSpecified,Employ."Payroll Currency",
                               TaxableAmount,CurrencyFactor));
                            }

                        IF EmpPost.GET(Employ."Posting Group") THEN BEGIN
                        IF EmpPost."Tax Percentage"=0 THEN
                        FinalTax:=GetTaxBracket(TaxableAmount,TaxCode)
                        ELSE
                        FinalTax:=TaxableAmount*(EmpPost."Tax Percentage"/100);
                        END ELSE BEGIN
                        IF EmpPost.GET(Employ."Posting Group") THEN BEGIN
                        IF EmpPost."Tax Percentage"=0 THEN
                        FinalTax:=GetTaxBracket(TaxableAmount,TaxCode)
                        ELSE
                        FinalTax:=TaxableAmount*(EmpPost."Tax Percentage"/100);
                        END;

                        END;

                        END;
                        */

                    end;

                    // ******************************Get PAYE*************************************//

                    //Get Dependant Relief
                    Employ.GET(EmployeeNo);
                    if EmpPost.GET(Employ."Posting Group") then begin
                        if EmpPost."Dependant Tax relief Perc" <> 0 then begin
                            DepRelief := 0;
                            Emp.RESET;
                            Emp.SETRANGE("No.", EmployeeNo);
                            if Emp.FIND('-') then begin
                                if Emp."Tax Rate Percentage" = 0 then begin
                                    DepRelief := FinalTax * (Emp."No of Dependants" * (EmpPost."Dependant Tax relief Perc" / 100));
                                    FinalTax := FinalTax - DepRelief;
                                end;
                            end;
                        end;

                        if EmpPost."Dep. Tax relief creteria" = EmpPost."Dep. Tax relief creteria"::"Based on Table" then begin
                            DepRelief := 0;
                            Emp.RESET;
                            Emp.SETRANGE("No.", EmployeeNo);
                            if Emp.FIND('-') then begin
                                //DepRelief:=FinalTax*(Emp."No of Dependants"*(EmpPost."Dependant Tax relief Perc"/100));
                                DepRelief := GetDependantsReleif(Emp."No of Dependants", FinalTax, Emp."Country/Region Code");
                                FinalTax := FinalTax - DepRelief;
                            end;
                        end;
                    end;
                    InsuranceRelief := 0;
                    // ***************************************Calculate insurance relief************************************//
                    EarnRec.RESET;
                    EarnRec.SETCURRENTKEY(EarnRec."Earning Type");
                    EarnRec.SETRANGE(EarnRec."Earning Type", EarnRec."Earning Type"::"Insurance Relief");
                    if EarnRec.FIND('-') then begin
                        repeat
                            Assignmatrix.RESET;
                            Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", DateSpecified);
                            Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                            Assignmatrix.SETRANGE(Assignmatrix.Code, EarnRec.Code);
                            Assignmatrix.SETRANGE(Assignmatrix."Employee No", EmployeeNo);
                            if Assignmatrix.FIND('-') then
                                InsuranceRelief := InsuranceRelief + Assignmatrix.Amount
                            else
                                InsuranceRelief := 0;
                        until EarnRec.NEXT = 0;
                    end;
                    // ***************************************Calculate insurance relief************************************//

                    //********************************************* Personal Relief*****************************************//
                    PersonalRelief := 0;
                    EarnRec.RESET;
                    EarnRec.SETCURRENTKEY(EarnRec."Earning Type");
                    EarnRec.SETRANGE(EarnRec."Earning Type", EarnRec."Earning Type"::"Tax Relief");
                    EarnRec.SETRANGE("Reduces Taxable Amount", false);
                    if EarnRec.FIND('-') then begin
                        repeat
                            if EarnRec."Flat Amount" > 0 then begin
                                PersonalRelief := PersonalRelief + EarnRec."Flat Amount";
                            end
                            else begin
                                ReliefSetup.RESET;
                                ReliefSetup.SETRANGE("Country/Region Code", EmpRec."Country/Region Code");
                                if ReliefSetup.FIND('-') then begin
                                    PersonalRelief := PersonalRelief + ReliefSetup.Amount;
                                end;
                            end;
                        /*Assignmatrix.RESET;
                        Assignmatrix.SETRANGE(Assignmatrix."Payroll Period",DateSpecified);
                        Assignmatrix.SETRANGE(Type,Assignmatrix.Type::Payment);
                        Assignmatrix.SETRANGE(Assignmatrix.Code,EarnRec.Code);
                        Assignmatrix.SETRANGE(Assignmatrix."Employee No",EmployeeNo);
                        IF Assignmatrix.FIND('-') THEN
                         PersonalRelief:=PersonalRelief+Assignmatrix.Amount;*/
                        until EarnRec.NEXT = 0;
                    end;

                    //********************************************* Personal Relief*****************************************//


                    FinalTax := FinalTax + (PersonalRelief + InsuranceRelief);

                    if FinalTax < 0 then
                        FinalTax := 0;
                end else begin
                    TaxableAmountNew := FinalTax;

                    //FinalTax:=0;
                end;

            end;
            //MESSAGE('Taxable Amt %1 Tax %2', TaxableAmount, FinalTax);

            EmpRec.RESET;
            EmpRec.SETRANGE(EmpRec."No.", EmployeeNo);
            EmpRec.SETRANGE("Pay Period Filter", DateSpecified);
            EmpRec.SETRANGE(EmpRec."Posting Group", 'BOARD');
            if EmpRec.FIND('-') then begin
                if EmpRec."Pays tax" = true then begin

                    EmpRec.CALCFIELDS(EmpRec."Taxable Allowance", "Tax Deductible Amount", "Relief Amount");
                    TaxableAmount := EmpRec."Taxable Allowance" - ABS(EmpRec."Relief Amount");
                    FinalTax := 0.3 * TaxableAmount;
                end;
            end;
            //============================================================================================================================
            //Message('Final tax %1', FinalTax);
            exit(FinalTax);

        end;
    end;

    procedure GetUserGroup(var UserIDs: Code[10]; var PGroup: Code[20]);
    var
        UserSetup: Record "User Setup";
    begin
        if UserSetup.GET(UserIDs) then begin
            // PGroup:=UserSetup."Payroll Group";
            //IF PGroup='' THEN
            // ERROR('Dont have payroll permission');
        end;
    end;

    procedure FormatNoText(var NoText: array[2] of Text[80]; No: Decimal; CurrencyCode: Code[10]);
    var
        PrintExponent: Boolean;
        Ones: Integer;
        Tens: Integer;
        Hundreds: Integer;
        Exponent: Integer;
        NoTextIndex: Integer;
    begin
        CLEAR(NoText);
        NoTextIndex := 1;
        NoText[1] := '****';

        if No < 1 then
            AddToNoText(NoText, NoTextIndex, PrintExponent, Text026)
        else begin
            for Exponent := 4 downto 1 do begin
                PrintExponent := false;
                Ones := No div POWER(1000, Exponent - 1);
                Hundreds := Ones div 100;
                Tens := (Ones mod 100) div 10;
                Ones := Ones mod 10;
                if Hundreds > 0 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Hundreds]);
                    AddToNoText(NoText, NoTextIndex, PrintExponent, Text027);
                end;
                if Tens >= 2 then begin
                    AddToNoText(NoText, NoTextIndex, PrintExponent, TensText[Tens]);
                    if Ones > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Ones]);
                end else
                    if (Tens * 10 + Ones) > 0 then
                        AddToNoText(NoText, NoTextIndex, PrintExponent, OnesText[Tens * 10 + Ones]);
                if PrintExponent and (Exponent > 1) then
                    AddToNoText(NoText, NoTextIndex, PrintExponent, ExponentText[Exponent]);
                No := No - (Hundreds * 100 + Tens * 10 + Ones) * POWER(1000, Exponent - 1);
            end;
        end;

        AddToNoText(NoText, NoTextIndex, PrintExponent, Text028);
        AddToNoText(NoText, NoTextIndex, PrintExponent, '');
        //FORMAT(No * 100) + '/100');

        if CurrencyCode <> '' then
            AddToNoText(NoText, NoTextIndex, PrintExponent, CurrencyCode);
    end;

    local procedure AddToNoText(var NoText: array[2] of Text[80]; var NoTextIndex: Integer; var PrintExponent: Boolean; AddText: Text[30]);
    begin
        PrintExponent := true;

        while STRLEN(NoText[NoTextIndex] + ' ' + AddText) > MAXSTRLEN(NoText[1]) do begin
            NoTextIndex := NoTextIndex + 1;
            if NoTextIndex > ARRAYLEN(NoText) then
                ERROR(Text029, AddText);
        end;

        NoText[NoTextIndex] := DELCHR(NoText[NoTextIndex] + ' ' + AddText, '<');
    end;

    procedure InitTextVariable();
    begin
        OnesText[1] := Text032;
        OnesText[2] := Text033;
        OnesText[3] := Text034;
        OnesText[4] := Text035;
        OnesText[5] := Text036;
        OnesText[6] := Text037;
        OnesText[7] := Text038;
        OnesText[8] := Text039;
        OnesText[9] := Text040;
        OnesText[10] := Text041;
        OnesText[11] := Text042;
        OnesText[12] := Text043;
        OnesText[13] := Text044;
        OnesText[14] := Text045;
        OnesText[15] := Text046;
        OnesText[16] := Text047;
        OnesText[17] := Text048;
        OnesText[18] := Text049;
        OnesText[19] := Text050;

        TensText[1] := '';
        TensText[2] := Text051;
        TensText[3] := Text052;
        TensText[4] := Text053;
        TensText[5] := Text054;
        TensText[6] := Text055;
        TensText[7] := Text056;
        TensText[8] := Text057;
        TensText[9] := Text058;

        ExponentText[1] := '';
        ExponentText[2] := Text059;
        ExponentText[3] := Text060;
        ExponentText[4] := Text061;
    end;

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal;
    var
        HRsetup: Record "Human Resources Setup";
        amt: Decimal;
        DecPosistion: Integer;
        Decvalue: Text[30];
        amttext: Text[30];
        Wholeamt: Text[30];
        Stringlen: Integer;
        Decplace: Integer;
        holdamt: Text[30];
        FirstNoText: Text[30];
        SecNoText: Text[30];
        FirstNo: Integer;
        SecNo: Integer;
        Amttoround: Decimal;
    begin
        EVALUATE(amttext, FORMAT(Amount));
        DecPosistion := STRPOS(amttext, '.');
        Stringlen := STRLEN(amttext);

        if DecPosistion > 0 then begin
            Wholeamt := COPYSTR(amttext, 1, DecPosistion - 1);

            Decplace := Stringlen - DecPosistion;
            Decvalue := COPYSTR(amttext, DecPosistion + 1, 2);
            if STRLEN(Decvalue) = 1 then
                holdamt := Decvalue + '0';
            if STRLEN(Decvalue) > 1 then begin
                FirstNoText := COPYSTR(Decvalue, 1, 1);
                SecNoText := COPYSTR(Decvalue, 2, 1);
                EVALUATE(SecNo, FORMAT(SecNoText));
                if SecNo >= 5 then
                    holdamt := FirstNoText + '5'
                else
                    holdamt := FirstNoText + '0'

            end;
            amttext := Wholeamt + '.' + holdamt;
            EVALUATE(Amttoround, FORMAT(amttext));
        end else begin
            EVALUATE(amttext, FORMAT(Amount));
            EVALUATE(Amttoround, FORMAT(amttext));
        end;


        Amount := Amttoround;
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

    procedure GetDependantsReleif(Dependants: Integer; Allowances: Decimal; CountryCode: Code[10]) Releif: Decimal;
    var
        BandTable: Record "Dependants Band Table";
    begin
        BandTable.RESET;
        BandTable.SETRANGE(BandTable.Dependants, Dependants);
        BandTable.SETRANGE("Country/Region Code", CountryCode);
        if BandTable.FIND('-') then begin
            if BandTable.Amount = 0 then
                Releif := (Allowances * (BandTable.Percentage / 100))
            else
                Releif := BandTable.Amount;
            //MESSAGE(FORMAT(Releif));
        end;

    end;

    procedure GetReliefArr(ArrValue: Decimal; EmpNo: Code[10]; PayPerio: Date; Revs: Integer; CurrTax: Decimal) ArrTaxable: Decimal;
    var
        HrPost: Record "Staff Posting Group";
        [SecurityFiltering(SecurityFilter::Filtered)]
        Earning: Record Earnings;
        RelfVal: Decimal;

        AddConsRelief: Decimal;
        [SecurityFiltering(SecurityFilter::Filtered)]
        Emple: Record Employee;
        [SecurityFiltering(SecurityFilter::Filtered)]
        Deds: Record Deductions;
        Matricx: Record "Assignment Matrix";
        Pension: Decimal;
        Loops: Integer;
        TaxForMonth: Decimal;
        CurrMonth: Date;
        TaxDiff: Decimal;
    begin
        Loops := Revs;
        ArrTaxable := 0;
        TaxDiff := 0;
        CurrMonth := PayPerio;
        if Revs > 0 then begin
            while Loops > 0 do begin
                if Emple.GET(EmpNo) then begin
                    CurrMonth := CALCDATE('<-1M>', CurrMonth);
                    Matricx.RESET;
                    Matricx.SETRANGE("Employee No", EmpNo);
                    Matricx.SETRANGE("Payroll Period", CurrMonth);
                    Matricx.SETRANGE(Type, Matricx.Type::Deduction);
                    Matricx.SETRANGE(Paye, true);
                    if Matricx.FINDFIRST then begin
                        TaxDiff := TaxDiff + (CurrTax - ABS(Matricx.Amount));

                    end;
                    //ArrTaxable:=ArrValue-(RelfVal+AddConsRelief);


                    Loops := Loops - 1;
                end;
            end;
        end;
        ArrTaxable := TaxDiff;

        /*
        //Determine Tax relief
          {
        EmpPost.GET(Emple."Posting Group");
        Earning.RESET;
        Earning.SETRANGE(Code,EmpPost."Tax Relief Code");
        Earning.SETRANGE("Earning Type",Earning."Earning Type"::"Tax Relief");
        IF Earning.FIND('-') THEN BEGIN
        RelfVal:=ArrValue*(Earning.Percentage/100);
               IF Earning."Max Cons. Relief(Monthly)"<>0 THEN BEGIN
                  AddConsRelief:=((Earning."Cons Relief %"/100)*(ArrValue));
                 IF AddConsRelief<Earning."Max Cons. Relief(Monthly)" THEN
                  AddConsRelief:=Earning."Max Cons. Relief(Monthly)";
                END;
                }
        //Get pension relief
        
        {
        Matricx.RESET;
        Matricx.SETRANGE("Employee No",Emple."No.");
        Matricx.SETRANGE(Closed,FALSE);
        Matricx.SETRANGE(Type,Matricx.Type::Deduction);
        Matricx.SETRANGE(Retirement,TRUE);
        IF Matricx.FINDFIRST THEN BEGIN
        Deds.RESET;
        Deds.SETRANGE("Pension Scheme",TRUE);
        Deds.SETRANGE(Code,Matricx.Code);
        IF Deds.FIND('-') THEN BEGIN
          Pension:=((ArrValue*0.65)*(Deds.Percentage/100));
          END;
          END;
          }
          ArrTaxable:=ArrTaxable-Pension;
          //MESSAGE(FORMAT(ArrTaxable));
        END;
        END;
        */

    end;
}

