report 51513136 "Fringe Benefit Report"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Fringe Benefit Report.rdl';
    Caption = 'Fringe Benefit Report';

    dataset
    {
        dataitem("Loan Application"; "Loan Application")
        {
            DataItemTableView = SORTING ("Loan No", "Loan Product Type") ORDER(Ascending) WHERE ("Loan Status" = CONST (Issued), "Stop Loan" = CONST (false));
            column(Loan_No; "Loan Application"."Loan No")
            {
            }
            column(Issued_Date; "Loan Application"."Issued Date")
            {
            }
            column(Employee_No; "Loan Application"."Employee No")
            {
            }
            column(Employee_Name; "Loan Application"."Employee Name")
            {
            }
            column(Approved_Amount; "Loan Application"."Approved Amount")
            {
            }
            column(Instalment; ("Loan Application".Instalment / 12))
            {
            }
            column(KRAPIN; KRAPIN)
            {
            }
            column(Principalamount; Principalamount)
            {
            }
            column(InterestRate_5; "InterestRate5%")
            {
            }
            column(InterestRate_8; "InterestRate8%")
            {
            }
            column(FringeAmount; FringeAmount)
            {
            }
            column(FringeAmountT_30; FringeAmountT)
            {
            }

            trigger OnAfterGetRecord();
            begin
                //IF "Loan Application1"."Employee No"<>'022' THEN
                //  CurrReport.SKIP;
                if "Loan Application"."Approved Amount" = 0 then
                    CurrReport.SKIP;
                if LoanProductType1.GET("Loan Application"."Loan Product Type") then
                    if LoanProductType1."Fringe Benefit Code" = '' then
                        CurrReport.SKIP;
                //IF "Loan Application1".
                InterestRate1 := "Loan Application"."Interest Rate";
                AssignmentMatrixX1.RESET;
                AssignmentMatrixX1.SETRANGE(Type, AssignmentMatrixX1.Type::Payment);
                AssignmentMatrixX1.SETRANGE(Code, frinngecode);
                AssignmentMatrixX1.SETRANGE("Payroll Period", "Payroll Period");
                AssignmentMatrixX1.SETRANGE("Employee No", "Loan Application"."Employee No");
                if not AssignmentMatrixX1.FINDFIRST then
                    CurrReport.SKIP;
                if Employee.GET("Loan Application"."Employee No") then
                    KRAPIN := Employee."PIN Number";
                //============================fringe calculations
                Principalamount := 0;
                fringestart := 0D;
                Installments := 0;
                InterestAmount := 0;
                Principamount := 0;
                Principal2 := 0;
                Repayment := 0;
                Numerator := 0;
                Denominator := 0;
                Principalamount := "Loan Application"."Approved Amount";
                fringestart := "Loan Application"."Issued Date";
                Installments := "Loan Application".Instalment;
                Numerator := ("Loan Application"."Interest Rate" / 12 / 100);
                Denominator := (1 - POWER((1 + ("Loan Application"."Interest Rate" / 12 / 100)), -Installments));
                Repayment := ROUND((Numerator / Denominator) * Principalamount, 0.05, '>');

                months := 0;
                // MESSAGE('am a hero! %1',InterestRate1);
                while fringestart <= "Payroll Period" do begin
                    //MESSAGE('am a hero!');

                    Principamount := ROUND((Principalamount / 100 / 12 * InterestRate1), 0.05, '>');
                    Principal2 := (Repayment - Principamount);
                    Principalamount := Principalamount - Principal2;
                    fringestart := CALCDATE('1M', fringestart);
                    months := months + 1;
                    // Principamount:=0;
                    // MESSAGE('Emp name %1 Principamount %2',"Loan Application1"."Employee Name",Principamount);
                end;
                // MESSAGE('Emp name %1 numbers %2 Repayment %3' ,"Loan Application1"."Employee Name",months,Repayment);
                MarketIntRateRec.RESET;
                MarketIntRateRec.SETFILTER("Start Date", '<=%1', "Payroll Period");
                MarketIntRateRec.SETFILTER("End Date", '>=%1', "Payroll Period");
                if MarketIntRateRec.FIND('-') then begin
                    MarketIntRate := MarketIntRateRec.Intrest;
                    InterestRate := "Loan Application"."Interest Rate";
                    // InterestRate:=ROUND(InterestRate,0.01);
                    Taxpercentage := MarketIntRateRec."Tax Percentage";
                end else
                    ERROR('Market Interest Rates have not been setup for the period including %1', "Payroll Period");
                //calculating the fringe benefit
                //Installments:=240;

                Fringebal := 0;
                FringeAmount := 0;
                FringeAmountT := 0;
                Fringebal := (Principalamount);
                /*
                //FringeAmount:=ROUND((((InterestRate)/100)/12)*Fringebal,0.05);//MarketIntRate-
                NumeratorF:=((MarketIntRate)/12/100);
                DenominatorF:=(1-POWER((1+((MarketIntRate-InterestRate)/12/100)),-Installments));
                RepaymentF:=ROUND((NumeratorF/DenominatorF)*Fringebal,0.01,'>');
                FringeAmountT:=ROUND((Taxpercentage/100)*FringeAmount,0.01);
                */
                "InterestRate5%" := ROUND((Fringebal / 100 / 12 * InterestRate1), 0.05, '>');
                "InterestRate8%" := ROUND((Fringebal / 100 / 12 * MarketIntRate), 0.05, '>');
                // MESSAGE('RepaymentF %1',RepaymentF);

                FringeAmount := ("InterestRate8%" - "InterestRate5%");
                FringeAmountT := ROUND((Taxpercentage / 100) * FringeAmount, 0.01);

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Payroll Period"; "Payroll Period")
                {
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
        if "Payroll Period" = 0D then
            ERROR('Input Payroll Period!');
        EarningsX1.RESET;
        EarningsX1.SETRANGE(Fringe, true);
        if EarningsX1.FINDFIRST then
            frinngecode := EarningsX1.Code;
    end;

    var
        LoanProductType1: Record "Loan Product Type";
        EarningsX1: Record Earnings;
        frinngecode: Code[10];
        "Payroll Period": Date;
        AssignmentMatrixX1: Record "Assignment Matrix";
        Employee: Record Employee;
        KRAPIN: Code[30];
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
        LoanApplication: Record "Loan Application";
        InterestRate1: Decimal;
        "InterestRate5%": Decimal;
        "InterestRate8%": Decimal;
        "30%Tax": Integer;
}

