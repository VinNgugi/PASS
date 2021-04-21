report 51513141 "Salaries Summary"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Salaries Summary.rdl';
    Caption = 'Salaries Summary';

    dataset
    {
        dataitem(Earnings; Earnings)
        {
            DataItemTableView = WHERE ("Reduces Tax" = CONST (false), "Account No." = FILTER (<> ''), "Non-Cash Benefit" = CONST (false));
            column(TheCodeCaption; TheCode)
            {
            }
            column(AccountNoText; AccountNoText)
            {
            }
            column(TitleCaption; Title)
            {
            }
            column(Company_Name; Company.Name)
            {
            }
            column(Company_Picture; Company.Picture)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(CodeText; CodeText)
            {
            }
            column(DrText; DrText)
            {
            }
            column(CrText; CrText)
            {
            }
            column(AccountNoCaption; AccountNo)
            {
            }
            column(Description; LineDescription)
            {
            }
            column(Debit; TotalAmount)
            {
            }
            column(Credit; -TotalAmount)
            {
            }

            trigger OnAfterGetRecord();
            begin
                Company.CALCFIELDS(Picture);
                PeriodText := FORMAT(Datefilter, 0, '<month text> <year4>');

                TheCode := '';
                AccountNo := '';
                LineDescription := '';
                TotalAmount := 0;

                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(Code, Earnings.Code);
                //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                AssignMatrix.CALCSUMS(Amount);

                if AssignMatrix.Amount = 0 then
                    CurrReport.SKIP;


                TheCode := Earnings.Code;
                AccountNo := Earnings."Account No.";
                LineDescription := Earnings.Description + ' ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                TotalAmount := AssignMatrix.Amount;
                TotalDebits := TotalDebits + AssignMatrix.Amount;
                TotalNetPay := -(TotalDebits + TotalCredits);
            end;
        }
        dataitem(Deductions; Deductions)
        {
            DataItemTableView = WHERE ("Account No." = FILTER (<> ''), "Pension Scheme" = CONST (false), Gratuity = CONST (false), "Gratuity Arrears" = CONST (false));
            column(TheCodeDedCaption; TheCode)
            {
            }
            column(AccountNoDedCaption; AccountNo)
            {
            }
            column(DescriptionDed; LineDescription)
            {
            }
            column(DebitDed; TotalAmount)
            {
            }
            column(CreditDed; -TotalAmount)
            {
            }

            trigger OnAfterGetRecord();
            begin

                TheCode := '';
                AccountNo := '';
                LineDescription := '';
                TotalAmount := 0;

                if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Salary Recovery" then begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, Deductions.Code);
                    //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS(Amount);

                    if AssignMatrix.Amount = 0 then
                        CurrReport.SKIP;


                    TheCode := Deductions.Code;
                    AccountNo := Deductions."Account No.";
                    LineDescription := Deductions.Description + ' ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                    TotalAmount := ABS(AssignMatrix.Amount);
                    TotalDebits := TotalDebits + ABS(AssignMatrix.Amount);
                    TotalNetPay := -(TotalDebits + TotalCredits);


                end else begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, Deductions.Code);
                    //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS(Amount);

                    if AssignMatrix.Amount = 0 then
                        CurrReport.SKIP;


                    TheCode := Deductions.Code;
                    AccountNo := Deductions."Account No.";
                    LineDescription := Deductions.Description + ' ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                    TotalAmount := AssignMatrix.Amount;

                    TotalCredits := TotalCredits + AssignMatrix.Amount;
                    TotalNetPay := -(TotalDebits + TotalCredits);
                end;
            end;
        }
        dataitem(PensionScheme; Deductions)
        {
            DataItemTableView = WHERE ("Pension Scheme" = CONST (true));
            column(TheCodePenCaption; TheCode)
            {
            }
            column(AccountNoPenCaption; AccountNo)
            {
            }
            column(DescriptionPen; LineDescription)
            {
            }
            column(DebitPen; TotalAmount)
            {
            }
            column(CreditPen; -TotalAmount)
            {
            }

            trigger OnAfterGetRecord();
            begin
                TheCode := '';
                AccountNo := '';
                LineDescription := '';
                TotalAmount := 0;

                PGMapping.SETRANGE(Type, PGMapping.Type::Deduction);
                PGMapping.SETRANGE(Code, PensionScheme.Code);
                if PGMapping.FIND('-') then begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, PensionScheme.Code);
                    //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS(Amount);

                    if AssignMatrix.Amount = 0 then
                        CurrReport.SKIP;


                    TheCode := PensionScheme.Code;
                    AccountNo := PGMapping."G/L Account";
                    LineDescription := PensionScheme.Description + ' ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                    TotalAmount := AssignMatrix.Amount;

                    TotalCredits := TotalCredits + AssignMatrix.Amount;
                end;
                TotalNetPay := -(TotalDebits + TotalCredits);
            end;
        }
        dataitem(GratuityScheme; Deductions)
        {
            DataItemTableView = WHERE (Gratuity = CONST (true));
            column(TheCodeGratCaption; TheCode)
            {
            }
            column(AccountNoGratCaption; AccountNo)
            {
            }
            column(DescriptionGrat; LineDescription)
            {
            }
            column(DebitGrat; TotalAmount)
            {
            }
            column(CreditGrat; -TotalAmount)
            {
            }

            trigger OnAfterGetRecord();
            begin
                TotalAmount := 0;
                PGMapping.SETRANGE(Type, PGMapping.Type::Deduction);
                PGMapping.SETRANGE(PGMapping.Code, GratuityScheme.Code);
                if PGMapping.FIND('-') then begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, GratuityScheme.Code);
                    //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS(Amount);

                    if AssignMatrix.Amount = 0 then
                        CurrReport.SKIP;


                    TheCode := GratuityScheme.Code;
                    AccountNo := PGMapping."G/L Account";
                    LineDescription := GratuityScheme.Description + ' ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                    TotalAmount := AssignMatrix.Amount;

                    TotalCredits := TotalCredits + AssignMatrix.Amount;
                end;
                TotalNetPay := -(TotalDebits + TotalCredits);
            end;
        }
        dataitem(GratuityArrears; Deductions)
        {
            DataItemTableView = WHERE ("Gratuity Arrears" = CONST (true));
            column(TheCodeGratArrCaption; TheCode)
            {
            }
            column(AccountNoGratArrCaption; AccountNo)
            {
            }
            column(DescriptionGratArr; LineDescription)
            {
            }
            column(DebitGratArr; TotalAmount)
            {
            }
            column(CreditGratArr; -TotalAmount)
            {
            }

            trigger OnAfterGetRecord();
            begin
                TotalAmount := 0;
                PGMapping.SETRANGE(Type, PGMapping.Type::Deduction);
                PGMapping.SETRANGE(Code, GratuityArrears.Code);
                if PGMapping.FIND('-') then begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, GratuityArrears.Code);
                    //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS(Amount);

                    if AssignMatrix.Amount = 0 then
                        CurrReport.SKIP;


                    TheCode := GratuityArrears.Code;
                    AccountNo := PGMapping."G/L Account";
                    LineDescription := GratuityArrears.Description + ' ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                    TotalAmount := AssignMatrix.Amount;

                    TotalCredits := TotalCredits + AssignMatrix.Amount;
                end;
                // TotalNetPay:=-(TotalDebits+TotalCredits);
            end;
        }
        dataitem(PensionSchemeEmployer; Deductions)
        {
            DataItemTableView = WHERE ("Pension Scheme" = CONST (true));
            column(TheCodePenEmpCaption; TheCode)
            {
            }
            column(AccountNoPenEmpCaption; AccountNo)
            {
            }
            column(DescriptionPenEmp; LineDescription)
            {
            }
            column(DebitPenEmp; TotalAmount)
            {
            }
            column(CreditPenEmp; -TotalAmount)
            {
            }

            trigger OnAfterGetRecord();
            begin
                TotalAmount := 0;
                PGMapping.SETRANGE(Type, PGMapping.Type::Deduction);
                PGMapping.SETRANGE(Code, PensionSchemeEmployer.Code);
                if PGMapping.FIND('-') then begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, PensionSchemeEmployer.Code);
                    //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS("Employer Amount");



                    if AssignMatrix."Employer Amount" = 0 then
                        CurrReport.SKIP;


                    TheCode := PensionSchemeEmployer.Code;
                    AccountNo := PGMapping."GL Account Employer";
                    LineDescription := PensionSchemeEmployer.Description + ' Employer ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                    TotalAmount := ABS(AssignMatrix."Employer Amount");
                    // MESSAGE('PensionEmployer=%1',TotalAmount);
                    TotalDebits := TotalDebits + ABS(AssignMatrix."Employer Amount");
                end;
                // TotalNetPay:=-(TotalDebits+TotalCredits);
            end;
        }
        dataitem(GratuityEmployer; Deductions)
        {
            DataItemTableView = WHERE (Gratuity = CONST (true));
            column(TheCodeGratEmpCaption; TheCode)
            {
            }
            column(AccountNoGratEmpCaption; AccountNo)
            {
            }
            column(DescriptionGratEmp; LineDescription)
            {
            }
            column(DebitGratEmp; TotalAmount)
            {
            }
            column(CreditGratEmp; -TotalAmount)
            {
            }

            trigger OnAfterGetRecord();
            begin
                TotalAmount := 0;
                PGMapping.SETRANGE(Type, PGMapping.Type::Deduction);
                PGMapping.SETRANGE(Code, GratuityEmployer.Code);
                if PGMapping.FIND('-') then begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, GratuityEmployer.Code);
                    //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS("Employer Amount");

                    if AssignMatrix."Employer Amount" = 0 then
                        CurrReport.SKIP;

                    TheCode := GratuityEmployer.Code;
                    AccountNo := PGMapping."GL Account Employer";
                    LineDescription := GratuityEmployer.Description + ' Employer ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                    TotalAmount := ABS(AssignMatrix."Employer Amount");

                    TotalDebits := TotalDebits + ABS(AssignMatrix."Employer Amount");
                end;
                //TotalNetPay:=-(TotalDebits+TotalCredits);
            end;
        }
        dataitem(GratuityArrearsEmployer; Deductions)
        {
            DataItemTableView = WHERE ("Gratuity Arrears" = CONST (true));
            column(TheCodeGratArrEmpCaption; TheCode)
            {
            }
            column(AccountNoGratArrEmpCaption; AccountNo)
            {
            }
            column(DescriptionGratArrEmp; LineDescription)
            {
            }
            column(DebitGratArrEmp; TotalAmount)
            {
            }
            column(CreditGratArrEmp; -TotalAmount)
            {
            }

            trigger OnAfterGetRecord();
            begin
                TotalAmount := 0;
                PGMapping.SETRANGE(Type, PGMapping.Type::Deduction);
                PGMapping.SETRANGE(Code, GratuityArrearsEmployer.Code);
                if PGMapping.FIND('-') then begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, GratuityArrearsEmployer.Code);
                    //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS("Employer Amount");

                    if AssignMatrix."Employer Amount" = 0 then
                        CurrReport.SKIP;

                    TheCode := GratuityArrearsEmployer.Code;
                    AccountNo := PGMapping."GL Account Employer";
                    LineDescription := GratuityArrearsEmployer.Description + ' Employer ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                    TotalAmount := ABS(AssignMatrix."Employer Amount");

                    TotalDebits := TotalDebits + ABS(AssignMatrix."Employer Amount");
                end;
                // TotalNetPay:=-(TotalDebits+TotalCredits);

                // NetPayAccountNo:='702200';
                // NetDescription:= 'NET PAY' +' '+FORMAT(Datefilter,0,'<month text> <year4>');
            end;
        }
        dataitem(PensionSchemeEmployerCr; Deductions)
        {
            DataItemTableView = WHERE ("Pension Scheme" = CONST (true));
            column(TheCodePenEmpCrCaption; TheCode)
            {
            }
            column(AccountNoPenEmpCrCaption; AccountNo)
            {
            }
            column(DescriptionPenCrEmp; LineDescription)
            {
            }
            column(DebitPenEmpCr; TotalAmount)
            {
            }
            column(CreditPenEmpCr; -TotalAmount)
            {
            }

            trigger OnAfterGetRecord();
            begin
                TotalAmount := 0;
                PGMapping.SETRANGE(Type, PGMapping.Type::Deduction);
                PGMapping.SETRANGE(Code, PensionSchemeEmployerCr.Code);
                if PGMapping.FIND('-') then begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, PensionSchemeEmployerCr.Code);
                    //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS("Employer Amount");

                    if AssignMatrix."Employer Amount" = 0 then
                        CurrReport.SKIP;


                    TheCode := PensionSchemeEmployerCr.Code;
                    AccountNo := PGMapping."G/L Account";
                    LineDescription := PensionSchemeEmployerCr.Description + ' Employer ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                    TotalAmount := -AssignMatrix."Employer Amount";
                    // MESSAGE('PensionEmployerCr=%1',TotalAmount);
                    TotalCredits := TotalCredits - AssignMatrix."Employer Amount";
                end;
                // TotalNetPay:=-(TotalDebits+TotalCredits);
            end;
        }
        dataitem(GratuityEmployerCr; Deductions)
        {
            DataItemTableView = WHERE (Gratuity = CONST (true));
            column(TheCodeGratEmpCrCaption; TheCode)
            {
            }
            column(AccountNoGratEmpCrCaption; AccountNo)
            {
            }
            column(DescriptionGratEmpCr; LineDescription)
            {
            }
            column(DebitGratEmpCr; TotalAmount)
            {
            }
            column(CreditGratEmpCr; -TotalAmount)
            {
            }

            trigger OnAfterGetRecord();
            begin
                TotalAmount := 0;
                PGMapping.SETRANGE(Type, PGMapping.Type::Deduction);
                PGMapping.SETRANGE(Code, GratuityEmployerCr.Code);
                if PGMapping.FIND('-') then begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, GratuityEmployerCr.Code);
                    //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS("Employer Amount");

                    if AssignMatrix."Employer Amount" = 0 then
                        CurrReport.SKIP;

                    TheCode := GratuityEmployerCr.Code;
                    AccountNo := PGMapping."G/L Account";
                    LineDescription := GratuityEmployerCr.Description + ' Employer ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                    TotalAmount := -AssignMatrix."Employer Amount";

                    TotalCredits := TotalCredits - AssignMatrix."Employer Amount";
                end;
                //TotalNetPay:=-(TotalDebits+TotalCredits);
            end;
        }
        dataitem(GratuityArrearsEmployerCr; Deductions)
        {
            DataItemTableView = WHERE ("Gratuity Arrears" = CONST (true));
            column(TheCodeGratArrEmpCrCaption; TheCode)
            {
            }
            column(AccountNoGratArrEmpCrCaption; AccountNo)
            {
            }
            column(DescriptionGratArrEmpCr; LineDescription)
            {
            }
            column(DebitGratArrEmpCr; TotalAmount)
            {
            }
            column(CreditGratArrEmpCr; -TotalAmount)
            {
            }
            column(GrandTotalCaption; GrandTotal)
            {
            }
            column(TotalDebits; TotalDebits)
            {
            }
            column(TotalCredits; ABS(TotalCredits + TotalNetPay))
            {
            }
            column(TotalNetPay; ABS(TotalNetPay))
            {
            }
            column(NetPayAccountNo; NetPayAccountNo)
            {
            }
            column(NetDescription; NetDescription)
            {
            }

            trigger OnAfterGetRecord();
            begin
                TotalAmount := 0;
                PGMapping.SETRANGE(Type, PGMapping.Type::Deduction);
                PGMapping.SETRANGE(Code, GratuityArrearsEmployerCr.Code);
                if PGMapping.FIND('-') then begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, GratuityArrearsEmployerCr.Code);
                    //AssignMatrix.SETRANGE("Global Dimension 2 Code","Dimension Value".Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS("Employer Amount");

                    // IF AssignMatrix."Employer Amount"=0 THEN
                    //  CurrReport.SKIP;


                    TheCode := GratuityArrearsEmployerCr.Code;
                    AccountNo := PGMapping."G/L Account";
                    LineDescription := GratuityArrearsEmployerCr.Description + ' Employer ' + FORMAT(Datefilter, 0, '<month text> <year4>');
                    TotalAmount := -AssignMatrix."Employer Amount";

                    TotalCredits := TotalCredits - AssignMatrix."Employer Amount";
                end;
                // TotalNetPay:=-(TotalDebits+TotalCredits);

                NetPayAccountNo := '702200';
                NetDescription := 'NET PAY' + ' ' + FORMAT(Datefilter, 0, '<month text> <year4>');
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(MonthStartDate; MonthStartDate)
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

    trigger OnInitReport();
    begin
        //EVALUATE(Datefilter,'10012013');
    end;

    trigger OnPreReport();
    begin
        // Employee.SETFILTER("Pay Period Filter",'%1',MonthStartDate);
        AssignMatrix.SETFILTER("Payroll Period", '%1', MonthStartDate);
        Datefilter := MonthStartDate;



        GenJnline.RESET;
        GenJnline.SETRANGE("Journal Template Name", 'GENERAL');
        GenJnline.SETRANGE("Journal Batch Name", 'SALARIES');
        GenJnline.DELETEALL;
        //TotalDebits:=0;
        Company.CALCFIELDS(Picture);
        PeriodText := FORMAT(Datefilter, 0, '<month text> <year4>');
        TotalDebits := 0;
        TotalCredits := 0;
        TotalNetPay := 0;
        //TotalAmount:=
    end;

    var
        Earn: Record Earnings;
        Datefilter: Date;
        GenJnline: Record "Gen. Journal Line";
        LineNumber: Integer;
        AmountRemaining: Decimal;
        Company: Record "Company Information";
        IncomeTax: Decimal;
        NetPay: Decimal;
        RightBracket: Boolean;
        Companyz: Code[10];
        "Posting Date": Date;
        BatchName: Text[30];
        DocumentNo: Code[10];
        Description: Text[30];
        Amount: Decimal;
        "G/LAccount": Code[10];
        TotalncomeTax: Decimal;
        GrossPay: Decimal;
        Totalgross: Decimal;
        TotalNetPay: Decimal;
        Payday: Date;
        TotalBasic: Decimal;
        PayrollPeriod: Record "Payroll Period";
        PostingGroup: Record "Employee Posting Group";
        TaxAccount: Code[10];
        SalariesAcc: Code[10];
        PayablesAcc: Code[10];
        First: Code[10];
        Last: Code[10];
        EmployeeTemp: Record Employee temporary;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        AssignMatrix: Record "Assignment Matrix";
        JnlTemp: Record "Gen. Journal Batch";
        Found: Boolean;
        TotalSSF: Decimal;
        PeriodStartDate: Date;
        EmpRec: Record Employee;
        DateSpecified: Date;
        Payperiodtext: Text[30];
        TransferLoans: Boolean;
        TaxCode: Code[10];
        BasicSalary: Decimal;
        PAYE: Decimal;
        CompRec: Record "Human Resources Setup";
        HseLimit: Decimal;
        ExcessRetirement: Decimal;
        CfMpr: Decimal;
        relief: Decimal;
        GetPeriodFilter: Date;
        ActivityRec: Record "Dimension Value";
        EarningsCopy: Record Earnings;
        LoanApp: Record "Loan Application";
        EmpAccMap: Record "Employee Account Mapping";
        PGMapping: Record "Staff PGroups";
        Deduction: Record Deductions;
        AccountNo: Code[30];
        TotalAmount: Decimal;
        LineDescription: Text[250];
        TheCode: Code[10];
        Title: Label 'Salaries Journal';
        DrText: Label 'Dr Amount';
        CrText: Label 'Cr Amount';
        GrandTotal: Label 'Grand Total';
        CodeText: Label 'Code';
        AccountNoText: Label 'Account No.';
        PeriodText: Text[50];
        NetPayAccountNo: Code[30];
        NetDescription: Text[250];
        MonthStartDate: Date;

    procedure GetTaxBracket(var TaxableAmount: Decimal);
    var
        TaxTable: Record Brackets;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
        Employee: Record Employee;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := AmountRemaining;
        AmountRemaining := PayrollRounding(AmountRemaining);
        EndTax := false;

        TaxTable.SETRANGE("Table Code", TaxCode);

        if TaxTable.FIND('-') then begin
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if (TaxableAmount) > TaxTable."Upper Limit" then
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

    procedure GetPayPeriod(var PayPeriods: Record "Payroll Period");
    begin
        PayrollPeriod := PayPeriods;
    end;

    procedure GetCurrentPeriod();
    var
        PayPeriodRec: Record "Payroll Period";
    begin
        PayPeriodRec.SETRANGE(PayPeriodRec.Closed, false);
        if PayPeriodRec.FIND('-') then
            PeriodStartDate := PayPeriodRec."Starting Date";
    end;

    procedure AdjustPostingGr();
    begin
        if AssignMatrix.FIND('-') then begin
            repeat
                if EmpRec.GET(AssignMatrix."Employee No") then
                    AssignMatrix."Posting Group Filter" := EmpRec."Posting Group";
                AssignMatrix.MODIFY;
            until AssignMatrix.NEXT = 0;
        end;
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

