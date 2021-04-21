codeunit 51513052 PayrollRounding
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
        Earnings: Record Earnings;
        TerminalDues: Decimal;
        Earn: Record Earnings;
        TaxTable: Record "Brackets Lines";
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

    procedure GetTaxBracket(var TaxableAmount: Decimal) GetTaxBracket: Decimal;
    var
        TaxTable: Record Brackets;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        CompRec.GET;
        TaxCode := CompRec."Tax Table";
        //MESSAGE('%1',TaxCode);

        AmountRemaining := TaxableAmount;
        AmountRemaining := ROUND(AmountRemaining, 0.01);
        EndTax := false;
        TaxTable.SETRANGE("Table Code", TaxCode);


        if TaxTable.FIND('-') then begin
            repeat

                if AmountRemaining <= 0 then
                    EndTax := true


                else begin

                    if ROUND((TaxableAmount), 1) >= TaxTable."Upper Limit" then begin

                        Tax := TaxTable."Taxable Amount" * TaxTable.Percentage / 100;
                        TotalTax := TotalTax + Tax;
                        //
                    end
                    else begin
                        //Deducted 1 here and got the xact figures just chek incase this may have issues
                        //Only the amount in the last Tax band had issues.
                        AmountRemaining := AmountRemaining - TaxTable."Lower Limit";
                        Tax := AmountRemaining * (TaxTable.Percentage / 100);

                        //Tax:=AmountRemaining*TaxTable.Percentage/100;

                        EndTax := true;
                        TotalTax := TotalTax + Tax;
                    end;
                end;
            until (TaxTable.NEXT = 0) or EndTax = true;
        end;
        TotalTax := TotalTax;
        //MESSAGE('%1',TotalTax);
        TotalTax := PayrollRounding(TotalTax);
        IncomeTax := -TotalTax;

        GetTaxBracket := ROUND(TotalTax, 1, '<');
    end;

    procedure GetPayPeriod();
    begin
        PayPeriod.SETRANGE(PayPeriod."Close Pay", false);
        if PayPeriod.FIND('-') then begin
            //PayPeriodtext:=PayPeriod.Name;
            BeginDate := PayPeriod."Starting Date";
        end;
    end;

    procedure CalculateTaxableAmount(var EmployeeNo: Code[20]; var DateSpecified: Date; var FinalTax: Decimal; var TaxableAmountNew: Decimal; var RetirementCont: Decimal);
    var
        Assignmatrix: Record "Assignment Matrix";
        EmpRec: Record Employee;
        EarnRec: Record Earnings;
        InsuranceRelief: Decimal;
        PersonalRelief: Decimal;
    begin
        CfMpr := 0;
        FinalTax := 0;
        i := 0;
        TaxableAmount := 0;
        RetirementCont := 0;
        InsuranceRelief := 0;
        PersonalRelief := 0;
        //Get payroll period
        GetPayPeriod;
        if DateSpecified = 0D then
            ERROR('Pay period must be specified for this report');

        // Taxable Amount
        EmpRec.RESET;
        EmpRec.SETRANGE(EmpRec."No.", EmployeeNo);
        EmpRec.SETRANGE("Pay Period Filter", DateSpecified);
        if EmpRec.FIND('-') then begin
            if EmpRec."Pays tax" = true then begin

                EmpRec.CALCFIELDS(EmpRec."Taxable Allowance", "Tax Deductible Amount");
                TaxableAmount := EmpRec."Taxable Allowance";
                // mine:=EmpRec."Taxable Allowance";
                //MESSAGE('%1',TaxableAmount);
                Ded.RESET;
                Ded.SETRANGE(Ded."Tax deductible", true);
                if Ded.FIND('-') then begin
                    repeat

                        Assignmatrix.RESET;
                        Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Deduction);
                        Assignmatrix.SETRANGE(Assignmatrix.Code, Ded.Code);
                        Assignmatrix.SETRANGE(Assignmatrix."Employee No", EmployeeNo);
                        if Assignmatrix.FIND('-') then
                            if Ded."Pension Limit Amount" > 0 then begin

                                if ABS(Assignmatrix.Amount) > Ded."Pension Limit Amount" then
                                    RetirementCont := ABS(RetirementCont) + Ded."Pension Limit Amount"
                                else
                                    RetirementCont := ABS(RetirementCont) + ABS(Assignmatrix.Amount);

                            end else
                                RetirementCont := ABS(RetirementCont) + ABS(Assignmatrix.Amount);

                    until Ded.NEXT = 0;
                end;
                TaxableAmount := TaxableAmount - RetirementCont;
                // end Taxable Amount
                // added to cater for Owner occupier Specific

                if EmpRec."Home Ownership Status" = EmpRec."Home Ownership Status"::"Owner Occupier"
                 then begin
                    // Get owner Occuper From Earning Table
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
                            if Assignmatrix.FIND('-') then
                                TaxableAmount := TaxableAmount - Assignmatrix.Amount;
                        until EarnRec.NEXT = 0;
                    end;
                end;
                // End ofOwner occupier Specific

                // Low Interest Benefits
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
                        if Assignmatrix.FIND('-') then
                            TaxableAmount := TaxableAmount + Assignmatrix.Amount;
                    until EarnRec.NEXT = 0;
                end;

                //End of Low Interest benefits

                TaxableAmount := ROUND(TaxableAmount, 0.01, '<');
                TaxableAmountNew := TaxableAmount;

                // Get PAYE
                //MESSAGE('Taxable income=%1',TaxableAmount);
                FinalTax := GetTaxBracket(TaxableAmount);
                //MESSAGE('tax=%1',FinalTax);

                // Get Reliefs
                InsuranceRelief := 0;
                // Calculate insurance relief;
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
                            InsuranceRelief := InsuranceRelief + Assignmatrix.Amount;
                    until EarnRec.NEXT = 0;
                end;


                // Personal Relief
                PersonalRelief := 0;
                EarnRec.RESET;
                EarnRec.SETCURRENTKEY(EarnRec."Earning Type");
                EarnRec.SETRANGE(EarnRec."Earning Type", EarnRec."Earning Type"::"Tax Relief");
                if EarnRec.FIND('-') then begin
                    repeat
                        Assignmatrix.RESET;
                        Assignmatrix.SETRANGE(Assignmatrix."Payroll Period", DateSpecified);
                        Assignmatrix.SETRANGE(Type, Assignmatrix.Type::Payment);
                        Assignmatrix.SETRANGE(Assignmatrix.Code, EarnRec.Code);
                        Assignmatrix.SETRANGE(Assignmatrix."Employee No", EmployeeNo);
                        if Assignmatrix.FIND('-') then
                            PersonalRelief := PersonalRelief + Assignmatrix.Amount;
                    until EarnRec.NEXT = 0;
                end;


                FinalTax := FinalTax - (PersonalRelief + InsuranceRelief);

                if FinalTax < 0 then
                    FinalTax := 0;
            end else
                FinalTax := 0;

        end;
    end;

    procedure GetUserGroup(var UserIDs: Code[10]; var PGroup: Code[20]);
    var
        UserSetup: Record "User Setup";
    begin
        /*
        IF UserSetup.GET(UserIDs) THEN BEGIN
         PGroup
         :=UserSetup.Picture;
         IF PGroup='' THEN
          ERROR('Dont have payroll permission');
        END;
          */

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
}

