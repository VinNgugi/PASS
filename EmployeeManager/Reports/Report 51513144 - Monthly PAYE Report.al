report 51513144 "Monthly PAYE Report"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Monthly PAYE Report.rdl';
    Caption = 'Monthly PAYE Report';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "Pay Period Filter", "No.", "Global Dimension 1 Code", "Global Dimension 2 Code", "Section/Location";
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text____year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<month text>  <year4>')))
            {
            }
            column(CoName; CoName)
            {
            }
            column(SortBy; SortBy)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text____year4_____Control5; UPPERCASE(FORMAT(DateSpecified, 0, '<month text>  <year4>')))
            {
            }
            column(CoName_Control9; CoName)
            {
            }
            column(SortBy_Control29; SortBy)
            {
            }
            column(FORMAT_TODAY_0_4__Control22; FORMAT(TODAY, 0, 4))
            {
            }
            column(USERID_Control24; USERID)
            {
            }
            column(CurrReport_PAGENO_Control23; CurrReport.PAGENO)
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(First_Name_________Middle_Name________Last_Name_; "First Name" + '  ' + "Middle Name" + '  ' + "Last Name")
            {
            }
            column(Employee__PIN_Number_; "PIN Number")
            {
            }
            /*column(Employee_Employee__Taxable_Income_;Employee."Taxable Income")
            {
            }*/
            column(ABS_Employee__Cumm__PAYE__; ABS(Employee."Cumm. PAYE"))
            {
            }
            column(TotalTaxable; TotalTaxable)
            {
            }
            column(ABS_TotalPaye_; ABS(TotalPaye))
            {
            }
            column(RecordNo; RecordNo)
            {
            }
            column(Employee_NamesCaption; Employee_NamesCaptionLbl)
            {
            }
            column(FilterCaption; FilterCaptionLbl)
            {
            }
            column(PIN_NumberCaption; PIN_NumberCaptionLbl)
            {
            }
            column(USERCaption; USERCaptionLbl)
            {
            }
            column(PAYE_KshsCaption; PAYE_KshsCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(MONTHLY_PAYE_REPORT_Caption; MONTHLY_PAYE_REPORT_CaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(Pay_NumberCaption; Pay_NumberCaptionLbl)
            {
            }
            column(TAXABLE_PAYCaption; TAXABLE_PAYCaptionLbl)
            {
            }
            column(PERIODCaption_Control27; PERIODCaption_Control27Lbl)
            {
            }
            column(Employee_NamesCaption_Control12; Employee_NamesCaption_Control12Lbl)
            {
            }
            column(Pay_NumberCaption_Control7; Pay_NumberCaption_Control7Lbl)
            {
            }
            column(PIN_NumberCaption_Control13; PIN_NumberCaption_Control13Lbl)
            {
            }
            column(PAYE_KshsCaption_Control15; PAYE_KshsCaption_Control15Lbl)
            {
            }
            column(USERCaption_Control26; USERCaption_Control26Lbl)
            {
            }
            column(CurrReport_PAGENO_Control23Caption; CurrReport_PAGENO_Control23CaptionLbl)
            {
            }
            column(FilterCaption_Control30; FilterCaption_Control30Lbl)
            {
            }
            column(MONTHLY_PAYE_REPORT_Caption_Control47; MONTHLY_PAYE_REPORT_Caption_Control47Lbl)
            {
            }
            column(TAXABLE_PAYCaption_Control1000000001; TAXABLE_PAYCaption_Control1000000001Lbl)
            {
            }
            column(TOTALSCaption; TOTALSCaptionLbl)
            {
            }
            column(PIC; Compinfo.Picture)
            {
            }

            trigger OnAfterGetRecord();
            begin
                CfMpr := 0;


                /*IF EmpBank.GET("Employee's Bank","Bank Branch") THEN
                    BankName:=EmpBank.Name; */

                Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);
                Employee.CALCFIELDS("Taxable Allowance", "Tax Deductible Amount", Employee."Cumm. PAYE");
                //Employee.CALCFIELDS(Employee."Total Allowances", Employee."Total Deductions", Employee."Taxable Income");
                //Employee.CALCFIELDS("Benefits-Non Cash", "Total Savings", "Retirement Contribution");

                if Employee."Cumm. PAYE" = 0 then begin

                    CurrReport.SKIP
                end;
                TotalPaye := TotalPaye + Employee."Cumm. PAYE";
                //TotalTaxable := TotalTaxable + Employee."Taxable Income";
                RecordNo := RecordNo + 1;

            end;

            trigger OnPreDataItem();
            begin
                Company.GET;
                CoName := Company.Name;
                if BeginDate = DateSpecified then
                    //Employee.SETRANGE(Status,Employee.Status::Active);
                    NoOfRecords := COUNT;
                DeptFilter := '';
                ProjFilter := '';
                SecLocFilter := '';
                NoFilter := '';
                if Employee.GETFILTER("Global Dimension 1 Code") <> '' then
                    DeptFilter := 'Dept ' + Employee.GETFILTER("Global Dimension 1 Code");
                if Employee.GETFILTER("No.") <> '' then
                    NoFilter := 'No ' + Employee.GETFILTER("No.");
                if Employee.GETFILTER("Global Dimension 2 Code") <> '' then
                    ProjFilter := 'Proj ' + Employee.GETFILTER("Global Dimension 2 Code");
                if Employee.GETFILTER("Section/Location") <> '' then
                    SecLocFilter := 'Sec/Loc ' + Employee.GETFILTER("Section/Location");

                SortBy := NoFilter + DeptFilter + ProjFilter + SecLocFilter;

                /*CUser:=USERID;
                GetGroup.GetUserGroup(CUser,GroupCode);
                SETRANGE(Employee."Posting Group",GroupCode);*/

                Compinfo.CALCFIELDS(Compinfo.Picture);

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
                    Caption = 'MonthStartDate';
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
        GetPayPeriod;

        Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);
        PayPeriodtext := Employee.GETFILTER("Pay Period Filter");

        //PayPeriodtext:=Employee.GETFILTER("Date Filter");
        if PayPeriodtext = '' then
            ERROR('Pay period must be specified for this report');
        //MonthStartDate:= DateSpecified;
        DateSpecified := MonthStartDate;

        //Employee.GETRANGEMIN("Date Filter");
        HoldDate := Employee.GETRANGEMIN("Pay Period Filter");//Employee.GETRANGEMIN("Date Filter");

        if PayPeriod.GET(DateSpecified) then
            PayPeriodtext := PayPeriod.Name;
        Year := DATE2DMY(HoldDate, 3);
        PayPeriodtext := PayPeriodtext + '-' + FORMAT(Year);
        EndDate := CALCDATE('1M', DateSpecified - 1);
    end;

    var
        Addr: array[10, 30] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;
        Transactions: Record "Assignment Matrix";
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        PayPeriod: Record "Payroll Period";
        PayPeriodtext: Text[30];
        BeginDate: Date;
        DateSpecified: Date;
        EndDate: Date;
        EmpBank: Record "Staff  Bank Account";
        BankName: Text[30];
        BasicSalary: Decimal;
        TaxableAmt: Decimal;
        RightBracket: Boolean;
        NetPay: Decimal;
        PayPeriodRec: Record "Staff  Bank Account";
        PayDeduct: Record "Assignment Matrix";
        EmpRec: Record Employee;
        EmpNo: Code[10];
        TaxableAmount: Decimal;
        PAYE: Decimal;
        ArrEarnings: array[10, 50] of Text[250];
        ArrDeductions: array[10, 50] of Text[250];
        Index: Integer;
        Index1: Integer;
        j: Integer;
        ArrEarningsAmt: array[10, 50] of Text[250];
        ArrDeductionsAmt: array[10, 50] of Text[250];
        Year: Integer;
        EmpArray: array[10, 15] of Decimal;
        HoldDate: Date;
        DenomArray: array[3, 11] of Text[50];
        NoOfUnitsArray: array[3, 11] of Integer;
        AmountArray: array[3, 11] of Decimal;
        PayModeArray: array[3] of Text[30];
        HoursArray: array[10, 50] of Decimal;
        CompRec: Record "Human Resources Setup";
        HseLimit: Decimal;
        ExcessRetirement: Decimal;
        CfMpr: Decimal;
        relief: Decimal;
        Company: Record "Company Information";
        CoName: Text[80];
        TotalTaxable: Decimal;
        TotalPaye: Decimal;
        TaxCode: Code[10];
        SortBy: Text[30];
        NoFilter: Text[40];
        DeptFilter: Text[30];
        ProjFilter: Text[30];
        SecLocFilter: Text[30];
        GrossPay: Decimal;
        RetireCont: Decimal;
        retirecontribution: Decimal;
        TotalBenefits: Decimal;
        TaxablePay: Decimal;
        TotalQuarters: Decimal;
        GroupCode: Code[20];
        CUser: Code[20];
        Employee_NamesCaptionLbl: Label 'Employee Names';
        FilterCaptionLbl: Label 'Filter';
        PIN_NumberCaptionLbl: Label 'TAX Code';
        USERCaptionLbl: Label 'USER';
        PAYE_KshsCaptionLbl: Label 'PAYE Kshs';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MONTHLY_PAYE_REPORT_CaptionLbl: Label '"MONTHLY PAYE REPORT "';
        PERIODCaptionLbl: Label 'PERIOD';
        Pay_NumberCaptionLbl: Label 'Pay Number';
        TAXABLE_PAYCaptionLbl: Label 'TAXABLE PAY';
        PERIODCaption_Control27Lbl: Label 'PERIOD';
        Employee_NamesCaption_Control12Lbl: Label 'Employee Names';
        Pay_NumberCaption_Control7Lbl: Label 'Pay Number';
        PIN_NumberCaption_Control13Lbl: Label 'PIN Number';
        PAYE_KshsCaption_Control15Lbl: Label 'PAYE Kshs';
        USERCaption_Control26Lbl: Label 'USER';
        CurrReport_PAGENO_Control23CaptionLbl: Label 'Page';
        FilterCaption_Control30Lbl: Label 'Filter';
        MONTHLY_PAYE_REPORT_Caption_Control47Lbl: Label '"MONTHLY PAYE REPORT "';
        TAXABLE_PAYCaption_Control1000000001Lbl: Label 'TAXABLE PAY';
        TOTALSCaptionLbl: Label 'TOTALS';
        MonthStartDate: Date;
        Compinfo: Record "Company Information";

    procedure GetTaxBracket(var TaxableAmount: Decimal);
    var
        TaxTable: Record Brackets;
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

    procedure GetPayPeriod();
    begin
        PayPeriod.SETRANGE(PayPeriod."Close Pay", false);
        if PayPeriod.FIND('-') then begin
            PayPeriodtext := PayPeriod.Name;
            BeginDate := PayPeriod."Starting Date";
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

    procedure getdate99(bddate: Date);
    begin
        MonthStartDate := bddate;
    end;
}

