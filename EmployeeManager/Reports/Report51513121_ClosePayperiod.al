report 51513121 "Close Pay period"
{
    // version PAYROLL

    //       // Used for previous loan handling
    //         //  IF Loan.GET(PaymentDed.Code,PaymentDed."Employee No") THEN
    //         //    BEGIN

    ProcessingOnly = true;
    UseRequestPage = false;
    Caption = 'Close Pay period';
    dataset
    {
        dataitem("Assignment Matrix"; "Assignment Matrix")
        {

            trigger OnPostDataItem();
            var
                SalaryIncrement: Codeunit "Effect Annual Basic Incre";
            begin
                //ERROR('PayperiodStart..%1StartingDate..%2',PayperiodStart,StartingDate);
                if PayperiodStart <> StartingDate then
                    ERROR('Cannot Close this Pay period Without Closing the preceding ones')
                else begin
                    if PayPeriod.GET(StartingDate) then begin
                        PayPeriod."Close Pay" := true;
                        PayPeriod.Closed := true;
                        PayPeriod."Closed By" := USERID;
                        PayPeriod."Closed on Date" := CURRENTDATETIME;
                        PayPeriod.CreateLeaveEntitlment(PayPeriod);
                        PayPeriod.MODIFY;
                        MESSAGE('The period has been closed');
                    end;
                end;

                // Go thru assignment matrix for loans and validate code
                NewPeriod := CALCDATE('1M', PayperiodStart);
                Loan.RESET;
                if Loan.FIND('-') then begin
                    repeat
                        AssMatrix.RESET;
                        AssMatrix.SETRANGE(AssMatrix."Payroll Period", NewPeriod);
                        AssMatrix.SETRANGE(Code, Loan.Code);
                        if AssMatrix.FIND('-') then begin
                            repeat
                                if EmpRec.GET("Assignment Matrix"."Employee No") then begin
                                    if (EmpRec.Status = EmpRec.Status::Active) then
                                        AssMatrix.VALIDATE(Code);
                                    AssMatrix.MODIFY
                                end;
                            until AssMatrix.NEXT = 0;
                        end;
                    until Loan.NEXT = 0;
                end;

                //Run Salary Increment
                SalaryIncrement.RUN;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    var
        payrollperiod: Record "Payroll Period";
    begin

        if not CONFIRM('Please backup up before closing current period! OK to Proceed?') then
            ERROR('The period has not been closed');

        //PayrollRun.RUN;
        //  Error('%1..', PayperiodStart);
        DeducePayPeriod;
        ClosePeriodTrans;
        FnCloseGratuityTransactions();
        CreateNewEntries(PayperiodStart);
        UpdateSalaryPointers(PayperiodStart);
        //  Error('%1..', PayperiodStart);
    end;

    var
        Proceed: Boolean;
        CurrentPeriodEnd: Date;
        DaysAdded: Code[10];
        PayPeriod: Record "Payroll Period";
        StartingDate: Date;
        PayperiodStart: Date;
        LoansUpdate: Boolean;
        PayHistory: Record "Employee Ledger Entry";
        EmpRec: Record Employee;
        TaxableAmount: Decimal;
        RightBracket: Boolean;
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        NetPay: Decimal;
        Loan: Record "Loans transactions";
        ReducedBal: Decimal;
        InterestAmt: Decimal;
        CompRec: Record "Human Resources Setup";
        HseLimit: Decimal;
        ExcessRetirement: Decimal;
        relief: Decimal;
        Outstanding: Decimal;
        CreateRec: Boolean;
        benefits: Record Earnings;
        deductions: Record Deductions;
        InterestDiff: Decimal;
        Rounding: Boolean;
        PD: Record "Assignment Matrix";
        Pay: Record Earnings;
        Ded: Record Deductions;
        TaxCode: Code[10];
        CfAmount: Decimal;
        TempAmount: Decimal;
        EmpRec1: Record Employee;
        Emprec2: Record Employee;
        NewPeriod: Date;
        AssMatrix: Record "Assignment Matrix";
        PayrollRun: Report "Payroll Run";
        Schedule: Record "Repayment Schedule";
        Window: Dialog;
        EmployeeName: Text[200];
        GetGroup: Codeunit PayrollRounding;
        GroupCode: Code[20];
        CUser: Code[20];
        LoanApplicationForm: Record "Loan Application";
        Discontinue: Boolean;

    procedure GetCurrentPeriod(var Payperiod: Record "Payroll Period");
    begin

        CurrentPeriodEnd := Payperiod."Starting Date";
        StartingDate := CurrentPeriodEnd;
        CurrentPeriodEnd := CALCDATE('CM', CurrentPeriodEnd);

        //Error('1..%1..%2',CurrentPeriodEnd,StartingDate);
    end;

    procedure DeducePayPeriod();
    var
        PayPeriodRec: Record "Payroll Period";
    begin
        PayPeriodRec.RESET;
        PayPeriodRec.SETRANGE(PayPeriodRec."Close Pay", false);
        PayPeriodRec.SETFILTER(PayPeriodRec."Starting Date", '<>%1', 0D);
        if PayPeriodRec.FIND('-') then begin
            PayperiodStart := PayPeriodRec."Starting Date";
            GetCurrentPeriod(PayPeriodRec);
        end;
        //ERROR('1...%1',PayperiodStart);
    end;

    procedure ClosePeriodTrans();
    var
        EarnDeduct: Record "Assignment Matrix";
    begin
        // Error('%1',PayperiodStart);
        EarnDeduct.RESET;
        EarnDeduct.SETRANGE(EarnDeduct."Payroll Period", PayperiodStart);
        if EarnDeduct.FIND('-') then
            repeat
                EarnDeduct.Closed := true;
                EarnDeduct."Payroll Period" := PayperiodStart;
                EarnDeduct.MODIFY;
            until EarnDeduct.NEXT = 0;
        //----------------------------------------------------
        PayPeriod.RESET;
        PayPeriod.SETFILTER(PayPeriod."Starting Date", '%1', PayperiodStart);
        if PayPeriod.FINDSET then begin
            PayPeriod.Closed := true;
            PayPeriod."Closed By" := USERID;
            PayPeriod."Closed on Date" := CURRENTDATETIME;
            //:=TODAY;
            PayPeriod.MODIFY;
        end;
        //----------------------------------------------------
    end;

    procedure CreateNewEntries(var CurrPeriodStat: Date);
    var
        PaymentDed: Record "Assignment Matrix";
        AssignMatrix: Record "Assignment Matrix";
    begin
        /*This function creates new entries for the next Payroll period which are accessible and editable
        by the user of the Payroll. It should ideally create new entries if the EmpRec is ACTIVE*/

        //MESSAGE('%1',CurrPeriodStat);
        NewPeriod := CALCDATE('1M', PayperiodStart);
        Window.OPEN('Creating Next period entries ##############################1', EmployeeName);
        PaymentDed.RESET;
        PaymentDed.SETRANGE(PaymentDed."Payroll Period", PayperiodStart);
        PaymentDed.SETRANGE(PaymentDed."Next Period Entry", true);
        //PaymentDed.SETFILTER(PaymentDed.Amount, '<>%1',0);
        if PaymentDed.FIND('-') then begin
            repeat
                CreateRec := true;
                AssignMatrix.INIT;
                AssignMatrix."Employee No" := PaymentDed."Employee No";
                AssignMatrix.Type := PaymentDed.Type;
                AssignMatrix.Code := PaymentDed.Code;
                AssignMatrix."Global Dimension 1 code" := PaymentDed."Global Dimension 1 code";
                AssignMatrix."Global Dimension 2 Code" := PaymentDed."Global Dimension 2 Code";
                AssignMatrix."Reference No" := PaymentDed."Reference No";
                AssignMatrix.Retirement := PaymentDed.Retirement;
                AssignMatrix."Payroll Period" := CALCDATE('1M', PayperiodStart);
                AssignMatrix.Amount := PaymentDed.Amount;
                AssignMatrix.Description := PaymentDed.Description;
                AssignMatrix.Taxable := PaymentDed.Taxable;
                AssignMatrix."Tax Deductible" := PaymentDed."Tax Deductible";
                AssignMatrix.Frequency := PaymentDed.Frequency;
                AssignMatrix."Pay Period" := PaymentDed."Pay Period";
                AssignMatrix."Non-Cash Benefit" := PaymentDed."Non-Cash Benefit";
                AssignMatrix.Quarters := PaymentDed.Quarters;
                AssignMatrix."No. of Units" := PaymentDed."No. of Units";
                AssignMatrix.Section := PaymentDed.Section;
                AssignMatrix."Basic Pay" := PaymentDed."Basic Pay";
                AssignMatrix."Salary Grade" := PaymentDed."Salary Grade";
                AssignMatrix."Employer Amount" := PaymentDed."Employer Amount";
                AssignMatrix."Global Dimension 1 code" := PaymentDed."Global Dimension 1 code";
                AssignMatrix."Next Period Entry" := PaymentDed."Next Period Entry";
                AssignMatrix."Posting Group Filter" := PaymentDed."Posting Group Filter";
                AssignMatrix."Loan Repay" := PaymentDed."Loan Repay";
                AssignMatrix.DebitAcct := PaymentDed.DebitAcct;
                AssignMatrix.CreditAcct := PaymentDed.CreditAcct;
                AssignMatrix."Basic Salary Code" := PaymentDed."Basic Salary Code";
                AssignMatrix."Normal Earnings" := PaymentDed."Normal Earnings";

                AssignMatrix."Tax Relief" := PaymentDed."Tax Relief";

                if PaymentDed."Global Dimension 1 code" = '' then begin
                    Emprec2.RESET;
                    if Emprec2.GET(PaymentDed."Employee No") then
                        AssignMatrix."Global Dimension 1 code" := Emprec2."Global Dimension 1 Code";
                end;
                //END EMM
                EmpRec.RESET;
                if EmpRec.GET(PaymentDed."Employee No") then begin
                    AssignMatrix."Payroll Group" := EmpRec."Posting Group";
                    Window.UPDATE(1, EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name");

                    if (EmpRec.Status = EmpRec.Status::Active) and (CreateRec = true) then
                        if not AssignMatrix.GET(AssignMatrix."Employee No", AssignMatrix.Type, AssignMatrix.Code, AssignMatrix."Payroll Period", AssignMatrix."Reference No") then
                            AssignMatrix.INSERT;
                end;
            until PaymentDed.NEXT = 0;
        end;

        //Manage loans

        PaymentDed.RESET;
        PaymentDed.SETRANGE(PaymentDed."Payroll Period", NewPeriod);
        PaymentDed.SETRANGE(Type, PaymentDed.Type::Deduction);
        if PaymentDed.FIND('-') then begin
            repeat
                LoanApplicationForm.RESET;
                LoanApplicationForm.SETRANGE(LoanApplicationForm."Deduction Code", PaymentDed.Code);
                LoanApplicationForm.SETRANGE(LoanApplicationForm."Loan No", PaymentDed."Reference No");
                if LoanApplicationForm.FIND('-') then begin
                    LoanApplicationForm.SETRANGE(LoanApplicationForm."Date filter", 0D, PayperiodStart);
                    LoanApplicationForm.CALCFIELDS(LoanApplicationForm."Total Repayment", LoanApplicationForm."Total Loan");

                    if LoanApplicationForm."Total Loan" <> 0 then begin
                        if (LoanApplicationForm."Total Loan" + LoanApplicationForm."Total Repayment") <= 0 then begin
                            MESSAGE('Loan %1 has expired', PaymentDed."Reference No");
                            PaymentDed.DELETE;
                        end
                        else begin
                            if (LoanApplicationForm."Total Loan" + LoanApplicationForm."Total Repayment") < LoanApplicationForm.Repayment then begin

                                LoanApplicationForm.CALCFIELDS(LoanApplicationForm."Total Repayment");

                                PaymentDed.Amount := -(LoanApplicationForm."Total Loan" + LoanApplicationForm."Total Repayment");
                                // PaymentDed."Next Period Entry":=FALSE;
                                PaymentDed.MODIFY;
                            end;

                        end;

                    end else begin
                        if (LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment") <= 0 then begin
                            MESSAGE('Loan %1 has expired', PaymentDed."Reference No");
                            PaymentDed.DELETE;
                        end
                        else begin
                            if (LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment") < LoanApplicationForm.Repayment then begin

                                LoanApplicationForm.CALCFIELDS(LoanApplicationForm."Total Repayment");

                                PaymentDed.Amount := -(LoanApplicationForm."Approved Amount" + LoanApplicationForm."Total Repayment");
                                // PaymentDed."Next Period Entry":=FALSE;
                                PaymentDed.MODIFY;
                            end;

                        end;
                    end;
                end;

            until PaymentDed.NEXT = 0;
        end;

    end;

    procedure Initialize();
    var
        InitEarnDeduct: Record "Assignment Matrix";
    begin

        InitEarnDeduct.SETRANGE(InitEarnDeduct.Closed, false);

        repeat
            InitEarnDeduct."Payroll Period" := PayperiodStart;
            InitEarnDeduct.MODIFY;
        until InitEarnDeduct.NEXT = 0;
    end;

    procedure GetTaxBracket(var TaxableAmount: Decimal);
    var
        TaxTable: Record Brackets;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := AmountRemaining;
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
        IncomeTax := -TotalTax;
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
        PaymentDeduction."Payroll Period" := CALCDATE('1M', PayperiodStart);
        PaymentDeduction.Amount := ReducedBalance * InterestDiff;
        PaymentDeduction."Non-Cash Benefit" := true;
        PaymentDeduction.Taxable := true;
        //PaymentDeduction."Next Period Entry":=TRUE;
        if allowances.GET(BenefitCode) then
            PaymentDeduction.Description := allowances.Description;
        PaymentDeduction.INSERT;
    end;

    procedure CoinageAnalysis(var NetPay: Decimal) NetPay1: Decimal;
    var
        Index: Integer;
        Intex: Integer;
        AmountArray: array[15] of Decimal;
        NoOfUnitsArray: array[15] of Integer;
        MinAmount: Decimal;
    begin
    end;

    procedure UpdateSalaryPointers(var PayrollPeriod: Date);
    var
        Emp: Record Employee;
        RollingMonth: Integer;
    begin
        Emp.RESET;
        Emp.SETRANGE(Emp.Status, Emp.Status::Active);
        if Emp.FIND('-') then begin
            repeat

                if FORMAT(DATE2DMY(NewPeriod, 2)) = Emp."Incremental Month" then begin

                    if INCSTR(Emp.Present) < Emp.Halt then begin
                        //MESSAGE('%1 %2',INCSTR(Emp.Present),Emp.Halt);
                        Emp.Previous := Emp.Present;
                        Emp.Present := INCSTR(Emp.Present);
                        Emp.MODIFY;
                    end;
                end;

            until Emp.NEXT = 0;
        end;
    end;

    procedure CalculateRepaymentAmount(var EmpNo: Code[20]; var LoanNo: Code[20]; var LoanInterest: Decimal; LastPayment: Date) Repayment: Decimal;
    var
        LoanApplication: Record "Loan Application";
        RepaymentSchedule: Record "Repayment Schedule";
        RepaymentAmnt: Decimal;
        Balance: Decimal;
        ReceiptsRec: Record "Non Payroll Receipts";
        NonPayrollReceipts: Decimal;
    begin


        Repayment := 0;
        LoanInterest := 0;
        //Get the loan being repaid
        LoanApplication.RESET;
        LoanApplication.SETRANGE(LoanApplication."Loan No", LoanNo);
        LoanApplication.SETRANGE(LoanApplication."Employee No", EmpNo);
        LoanApplication.SETRANGE("Date filter", 0D, LastPayment);
        if LoanApplication.FINDFIRST then begin
            if LoanApplication."Interest Calculation Method" <> LoanApplication."Interest Calculation Method"::"Reducing Balance" then begin

                LoanApplication.CALCFIELDS("Total Repayment", Receipts);
                // MESSAGE('HAPA');

                Balance := LoanApplication."Approved Amount" - ABS(LoanApplication."Total Repayment") - ABS(LoanApplication.Receipts);

                Repayment := LoanApplication.Repayment;
                if Balance <= 0 then
                    Repayment := 0;
                exit(Repayment);
            end
            else begin
                //MESSAGE('KULE');
                /*
                RepaymentSchedule.RESET;
                RepaymentSchedule.SETRANGE(RepaymentSchedule."Loan No",LoanNo);
                RepaymentSchedule.SETRANGE(RepaymentSchedule."Employee No",EmpNo);
                RepaymentSchedule.SETRANGE("Repayment Date",CALCDATE('1M',PayperiodStart));
                 IF RepaymentSchedule.FINDFIRST THEN BEGIN
                    Repayment:=-RepaymentSchedule."Monthly Repayment";
                    Repayment:=PayrollRounding(Repayment);
                    EXIT(Repayment);
                 END;
                 */
                //Get Principal Repayment and subtract the interest on the balance
                LoanApplication.CALCFIELDS("Total Repayment", Receipts);
                Balance := LoanApplication."Approved Amount" - ABS(LoanApplication."Total Repayment") - ABS(LoanApplication.Receipts);
                LoanInterest := (LoanApplication."Interest Rate" / 100 * Balance) / 12;
                LoanInterest := PayrollRounding(LoanInterest);
                Repayment := LoanApplication.Repayment;
                if Balance <= 0 then
                    Repayment := 0;
                exit(Repayment);
            end;
        end;

    end;

    local procedure FnCloseGratuityTransactions()
    var
        Employee: Record Employee;
        Payments: Record Earnings;
        AssignmentMat: Record "Assignment Matrix";

    begin
        Payments.Reset();
        Payments.SetRange("Gratuity Pay", true);
        if Payments.FindSet() then
            repeat
                Employee.Reset();
                if Employee.FindSet() then
                    repeat
                        AssMatrix.Reset();
                        AssMatrix.SetRange(Code, Payments.Code);
                        AssMatrix.SetRange("Employee No", Employee."No.");
                        AssMatrix.SetRange("Payroll Period", PayperiodStart);
                        if AssMatrix.Find('-') then begin
                            AssignmentMat.Reset();
                            AssignmentMat.SetRange("Employee No", Employee."No.");
                            AssignmentMat.SetRange(Code, Payments.Code);
                            AssignmentMat.SetRange("Gratuity Paid", false);
                            if AssignmentMat.FindSet() then
                                repeat
                                    AssignmentMat."Gratuity Paid" := true;
                                    AssignmentMat.Modify();
                                until AssignmentMat.Next() = 0;
                        end;
                    until Employee.Next() = 0;
            until Payments.Next() = 0;
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
}

