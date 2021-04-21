report 51513124 "Net Pay Report"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Net Pay Report.rdl';
    Caption = 'Net Pay Report';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING ("No.") WHERE (Status = CONST (Active));
            RequestFilterFields = "No.", Status;
            column(CompInfo_Picture; CompInfo.Picture)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; UPPERCASE(COMPANYNAME))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(EarnDesc_1_; EarnDesc[1])
            {
            }
            column(EarnDesc_2_; EarnDesc[2])
            {
            }
            column(EarnDesc_3_; EarnDesc[3])
            {
            }
            column(DedDesc_1_; DedDesc[1])
            {
            }
            column(DedDesc_2_; DedDesc[2])
            {
            }
            column(DedDesc_3_; DedDesc[3])
            {
            }
            column(DedDesc_4_; DedDesc[4])
            {
            }
            column(Other_Deductions_; 'Other Deductions')
            {
            }
            column(Net_Pay_; 'Net Pay')
            {
            }
            column(PF_No__; 'PF No.')
            {
            }
            column(Name_; 'Name')
            {
            }
            column(First_Name_________Middle_Name_______Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(Allowances_1_; Allowances[1])
            {
            }
            column(Allowances_2_; Allowances[2])
            {
            }
            column(Allowances_3_; Allowances[3])
            {
            }
            column(Net_Pay; NetPay)
            {
            }
            column(Total_Allowances; GrossPay)
            {
            }
            column(Total_Deductions; TotalDeduction)
            {
            }
            column(OtherEarn; OtherEarn)
            {
            }
            column(Deductions_1_; Deductions[1])
            {
            }
            column(Deductions_2_; Deductions[2])
            {
            }
            column(Deductions_3_; Deductions[3])
            {
            }
            column(Deductions_4_; Deductions[4])
            {
            }
            column(OtherDeduct; OtherDeduct)
            {
            }
            column(Employee__Total_Deductions___Total_Allowances_; Employee."Total Deductions" + "Total Allowances")
            {
            }
            column(Allowances_1__Control1000000009; Allowances[1])
            {
            }
            column(Allowances_2__Control1000000018; Allowances[2])
            {
            }
            column(Allowances_3__Control1000000032; Allowances[3])
            {
            }
            column(OtherEarn_Control1000000033; OtherEarn)
            {
            }
            column(Deductions_1__Control1000000034; Deductions[1])
            {
            }
            column(Deductions_2__Control1000000035; Deductions[2])
            {
            }
            column(Deductions_3__Control1000000036; Deductions[3])
            {
            }
            column(Deductions_4__Control1000000037; Deductions[4])
            {
            }
            column(OtherDeduct_Control1000000038; OtherDeduct)
            {
            }
            column(Employee__Total_Deductions___Total_Allowances__Control1000000039; Employee."Total Deductions" + "Total Allowances")
            {
            }
            column(STRSUBSTNO__Employees__1__counter_; STRSUBSTNO('Employees=%1', counter))
            {
            }
            column(Prepared_By______________________________________________________; 'Prepared By.....................................................')
            {
            }
            column(Approved_By_____________________________________________________; 'Approved By....................................................')
            {
            }
            column(Passed_for_Payment_By____________________________________________________; 'Passed for Payment By...................................................')
            {
            }
            column(MASTER_ROLLCaption; MASTER_ROLLCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Other_AllowancesCaption; Other_AllowancesCaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                CompInfo.GET;
                CompInfo.CALCFIELDS(Picture);

                Employee.CALCFIELDS(Employee."Total Allowances", Employee."Total Deductions");
                OtherEarn := 0;
                OtherDeduct := 0;
                Totallowances := 0;
                OtherDeduct := 0;
                TotalDeductions := 0;
                TotalDeduction := 0;
                GrossPay := 0;
                Earn.RESET;
                Earn.SETRANGE(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SETRANGE(Earn."Non-Cash Benefit", false);
                Earn.SETRANGE(Earn.Board, false);
                if Earn.FIND('-') then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        // AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",FALSE);
                        AssignMatrix.SETRANGE(Code, Earn.Code);
                        if AssignMatrix.FIND('-') then begin
                            //REPEAT
                            AssignMatrix.CALCSUMS(Amount);
                            // GrossPay:=GrossPay+PayrollRounding(AssignMatrix.Amount);
                            GrossPay := GrossPay + AssignMatrix.Amount;
                            //UNTIL AssignMatrix.NEXT=0;
                        end;
                    until Earn.NEXT = 0;
                end;

                //Total Deductions
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                AssignMatrix.SETRANGE(AssignMatrix.Paye, true);
                //--AssignMatrix.SETRANGE(AssignMatrix.Code,'895');
                if AssignMatrix.FIND('-') then begin
                    AssignMatrix.CALCSUMS(Amount);

                    TotalDeduction := TotalDeduction + ABS(AssignMatrix.Amount);
                end;

                //PAYE2
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SETRANGE(AssignMatrix.Paye, true);
                AssignMatrix.SETRANGE(AssignMatrix.Code, '898');
                AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                if AssignMatrix.FIND('-') then begin
                    AssignMatrix.CALCSUMS(Amount);

                    TotalDeduction := TotalDeduction + ABS(AssignMatrix.Amount);
                end;
                //For PAYE Manual

                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Calculation Method", Deduct."Calculation Method"::"% of Salary Recovery");
                if Deduct.FIND('-') then begin
                    repeat

                        //LoanBalance:=0;

                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        // AssignMatrix.SETRANGE(AssignMatrix.Shares,FALSE);
                        // AssignMatrix.SETRANGE(AssignMatrix."Insurance Code",FALSE);
                        if AssignMatrix.FIND('-') then begin
                            //  REPEAT
                            AssignMatrix.CALCSUMS(Amount);
                            PositivePAYEManual := 0;

                            Earn.RESET;
                            Earn.SETRANGE(Earn."Calculation Method", Earn."Calculation Method"::"% of Salary Recovery");
                            if Earn.FIND('-') then begin
                                // REPEAT
                                PayDeduct.RESET;
                                PayDeduct.SETRANGE(PayDeduct."Payroll Period", DateSpecified);
                                PayDeduct.SETFILTER(Type, '%1', PayDeduct.Type::Payment);
                                PayDeduct.SETRANGE(Code, Earn.Code);
                                PayDeduct.SETRANGE(PayDeduct."Manual Entry", true);
                                PayDeduct.SETRANGE(PayDeduct."Employee No", Employee."No.");
                                // AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                                if PayDeduct.FIND('-') then begin
                                    repeat
                                        PositivePAYEManual := PositivePAYEManual + PayDeduct.Amount;

                                    until PayDeduct.NEXT = 0;
                                end;
                            end;
                            //  TotalDeduction:=TotalDeduction+PayrollRounding(AssignMatrix.Amount)-PayrollRounding(PositivePAYEManual);
                            TotalDeduction := TotalDeduction + AssignMatrix.Amount - PositivePAYEManual;
                        end;
                    until Deduct.NEXT = 0;
                end;

                Deduct.RESET;
                Deduct.SETFILTER(Deduct."Calculation Method", '<>%1', Deduct."Calculation Method"::"% of Salary Recovery");
                Deduct.SETRANGE(Informational, false);
                if Deduct.FIND('-') then begin
                    repeat

                        // LoanBalance:=0;

                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);

                        if AssignMatrix.FIND('-') then begin
                            //  REPEAT
                            AssignMatrix.CALCSUMS(Amount);
                            TotalDeduction := TotalDeduction + ABS(AssignMatrix.Amount);


                        end;
                    until Deduct.NEXT = 0;
                end;

                //Net Pay
                NetPay := GrossPay - TotalDeduction;
            end;

            trigger OnPreDataItem();
            begin
                //CurrReport.CREATETOTALS(Allowances, Deductions, OtherEarn, OtherDeduct);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Month Begin Date"; MonthStartDate)
                {
                    Caption = 'Month Begin Date';
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
        Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);
        DateSpecified := Employee.GETRANGEMIN(Employee."Pay Period Filter");
        //MESSAGE('GOOD');
        TotalDeductions1 := 0;
        Totallowances1 := 0;
    end;

    var
        Allowances: array[20] of Decimal;
        Deductions: array[20] of Decimal;
        EarnRec: Record Earnings;
        DedRec: Record Deductions;
        Earncode: array[20] of Code[10];
        deductcode: array[20] of Code[10];
        EarnDesc: array[20] of Text[30];
        DedDesc: array[20] of Text[30];
        i: Integer;
        j: Integer;
        Assignmat: Record "Assignment Matrix";
        DateSpecified: Date;
        Totallowances: Decimal;
        TotalDeductions: Decimal;
        OtherEarn: Decimal;
        OtherDeduct: Decimal;
        counter: Integer;
        MASTER_ROLLCaptionLbl: Label 'NET PAY REPORT';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Other_AllowancesCaptionLbl: Label 'Other Allowances';
        NetPay: Decimal;
        PayPeriodRec: Record "Payroll Period";
        Deduct: Record Deductions;
        Earn: Record Earnings;
        GrossPay: Decimal;
        AccPeriod: Record "Accounting Period";
        AssignMatrix: Record "Assignment Matrix";
        PositivePAYEManual: Decimal;
        PayDeduct: Record "Assignment Matrix";
        TotalDeduction: Decimal;
        CompInfo: Record "Company Information";
        MonthStartDate: Date;
        MYVALUES: Decimal;
        Totallowances1: Decimal;
        TotalDeductions1: Decimal;

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

