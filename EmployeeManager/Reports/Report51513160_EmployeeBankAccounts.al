report 51513160 "Employee Bank Accounts"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Employee Bank Accounts.rdl';
    Caption = 'Employee Bank Accounts';
    dataset
    {
        dataitem("Staff  Bank Account"; "Staff  Bank Account")
        {
            RequestFilterFields = "Code", "Bank Branch No.";
            dataitem(Employee; Employee)
            {
                DataItemLink = "Employee's Bank" = FIELD (Code), "Bank Branch" = FIELD ("Bank Branch No.");
                DataItemTableView = SORTING ("No.") WHERE (Status = FILTER (Active));
                RequestFilterFields = "Employee's Bank";
                column(CurrReport_PAGENO; CurrReport.PAGENO)
                {
                    
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(EmpNo_; Employee."No.")
                {
                }
                column(EmpName; Employee."First Name" + Employee."Middle Name" + Employee."Last Name")
                {
                }
                column(EmpAccNo; Employee."Bank Account Number")
                {
                }
                column(EmpNetPay; NetPay)
                {
                }
                column(ReportNameCaption; ReportNameLbl)
                {
                }
                column(BankNameCaption; BankNameLbl)
                {
                }
                column(BranchCodeCaption; BranchCodeLbl)
                {
                }
                column(AddressCaption; AddressLbl)
                {
                }
                column(EmpNoCaption; EmpNoLbl)
                {
                }
                column(EmpNameCaption; EmpNameLbl)
                {
                }
                column(AccNoCaption; AccNoLbl)
                {
                }
                column(NetPayCaption; NetPayLbl)
                {
                }
                column(BranchCode_; Employee."Bank Branch")
                {
                }
                column(BankName_; BankName)
                {
                }
                column(BranchName_; BranchName)
                {
                }
                column(BankCode_; Employee."Employee's Bank")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    /*EmpBank.RESET;
                    EmpBank.SETRANGE(EmpBank.Code,Employee."Employee's Bank");
                    EmpBank.SETRANGE(EmpBank."Bank Branch No.",Employee."Bank Branch");
                    IF EmpBank.FIND('-') THEN BEGIN
                    
                    //IF EmpBank.GET(Employee."Employee's Bank",EmpBank."Bank Branch No.") THEN BEGIN
                    //IF EmpBank.GET(Employee."No.",Employee."Employee's Bank") THEN
                    
                    BankName:=EmpBank.Name;
                    BranchName:=EmpBank."Name 2";
                    BranchCode:= EmpBank."Bank Branch No.";//COPYSTR(Employee."Employee's Bank",3, 3);
                    END;*/



                    GrossPay := 0;
                    TotalDeduction := 0;


                    RefNo := MonthStartDate;

                    Earn.RESET;
                    Earn.SETRANGE(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                    Earn.SETRANGE(Earn."Non-Cash Benefit", false);
                    if Earn.FIND('-') then begin
                        repeat
                            AssignMatrix.RESET;
                            AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", RefNo);
                            AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                            AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                            // AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",FALSE);
                            AssignMatrix.SETRANGE(Code, Earn.Code);
                            if AssignMatrix.FIND('-') then begin
                                repeat

                                    GrossPay := GrossPay + AssignMatrix.Amount;

                                until AssignMatrix.NEXT = 0;
                            end;
                        until Earn.NEXT = 0;
                    end;
                    //PAYE


                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", RefNo);
                    AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                    AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                    AssignMatrix.SETRANGE(AssignMatrix.Paye, true);
                    if AssignMatrix.FIND('-') then begin

                        TotalDeduction := TotalDeduction + ABS(AssignMatrix.Amount);
                    end;

                    i := i + 1;

                    Deduct.RESET;
                    Deduct.SETFILTER(Deduct."Calculation Method", '<>%1', Deduct."Calculation Method"::"% of Salary Recovery");
                    Deduct.SETRANGE(Deduct.Informational, false);
                    if Deduct.FIND('-') then begin
                        repeat

                            AssignMatrix.RESET;
                            AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", RefNo);
                            AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                            AssignMatrix.SETRANGE(AssignMatrix.Code, Deduct.Code);
                            AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                            AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                            // AssignMatrix.SETRANGE(AssignMatrix.Shares,FALSE);
                            // AssignMatrix.SETRANGE(AssignMatrix."Insurance Code",FALSE);

                            if AssignMatrix.FIND('-') then begin
                                repeat
                                    TotalDeduction := TotalDeduction + ABS(PayrollRounding(AssignMatrix.Amount));

                                    if Deduct.GET(AssignMatrix.Code) then begin
                                        //
                                    end;

                                    i := i + 1;
                                until AssignMatrix.NEXT = 0;
                            end;

                        until Deduct.NEXT = 0;
                    end;
                    //For PAYE Manual

                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Calculation Method", Deduct."Calculation Method"::"% of Salary Recovery");
                    if Deduct.FIND('-') then begin
                        repeat

                            LoanBalance := 0;

                            AssignMatrix.RESET;
                            AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", RefNo);
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
                                    PayDeduct.SETRANGE(PayDeduct."Payroll Period", RefNo);
                                    PayDeduct.SETFILTER(Type, '%1', PayDeduct.Type::Payment);
                                    PayDeduct.SETRANGE(Code, Earn.Code);
                                    PayDeduct.SETRANGE(PayDeduct."Employee No", Employee."No.");
                                    PayDeduct.SETRANGE(PayDeduct."Manual Entry", true);
                                    // AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                                    if PayDeduct.FIND('-') then begin
                                        repeat
                                            PositivePAYEManual := PositivePAYEManual + PayDeduct.Amount;

                                        until PayDeduct.NEXT = 0;
                                    end;
                                end;


                                TotalDeduction := TotalDeduction + PayrollRounding(AssignMatrix.Amount) + PayrollRounding(PositivePAYEManual);

                                i := i + 1;
                            end;
                        until Deduct.NEXT = 0;
                    end;



                    NetPay := GrossPay - TotalDeduction;
                    NetPay := payroll.PayrollRounding(NetPay);


                    RefNo := 0D;
                    Amount := '';
                    EVALUATE(Amount, FORMAT(NetPay));
                    Amount := DELCHR(Amount, '=', ',');
                    //BankCode:=PADSTR(Employee."Employee's Bank", 2, '1');// Employee."Employee's Bank"+Employee."Bank Branch";
                    //BranchCode:= COPYSTR(Employee."Employee's Bank",3, 3);

                    EVALUATE(RefNo, Employee.GETFILTER(Employee."Pay Period Filter"));//Employee."No.";



                    TotalNet := TotalNet + NetPay;

                end;

                trigger OnPreDataItem();
                begin
                    Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                /*"Employee Bank AccountX1".RESET;
                "Employee Bank AccountX1".SETRANGE("Employee Bank AccountX1".Code,Employee."Employee's Bank");
                "Employee Bank AccountX1".SETRANGE("Employee Bank AccountX1"."Bank Branch No.",Employee."Bank Branch");
                IF "Employee Bank AccountX1".FIND('-') THEN BEGIN*/

                //IF EmpBank.GET(Employee."Employee's Bank",EmpBank."Bank Branch No.") THEN BEGIN
                //IF EmpBank.GET(Employee."No.",Employee."Employee's Bank") THEN

                BankName := "Staff  Bank Account".Name;
                BranchName := "Staff  Bank Account"."Name 2";
                //BranchCode:= "Employee Bank AccountX1"."Bank Branch No.";//COPYSTR(Employee."Employee's Bank",3, 3);

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

    var
        EmpBank: Record "Staff  Bank Account";
        ReportNameLbl: Label 'Bank Remittance';
        BankNameLbl: Label 'Name';
        BranchCodeLbl: Label 'Branch No.';
        AddressLbl: Label 'Address';
        EmpNoLbl: Label 'No';
        EmpNameLbl: Label 'Name';
        AccNoLbl: Label 'Account No';
        NetPayLbl: Label 'Net Pay';
        BranchCode: Code[30];
        NetPay: Decimal;
        BankName: Text;
        SubTotal: Decimal;
        GrandTotal: Decimal;
        SubTotalLbl: Label 'Sub Total';
        GrandTotalLbl: Label 'Grand Total';
        BatchNo: Code[20];
        //ContributionHeader: Record payment headerfin;
        LineNo: Integer;
        VendBankAcc: Record "Vendor Bank Account";
        Vend: Record Vendor;
        //PVLines: Record "PV Lines";
        Name: Text;
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        BankCode: Code[10];
        RefNo: Date;
        Amount: Text[30];
        payroll: Codeunit PayrollRounding;
        Amtlen: Integer;
        Space: Text[12];
        i: Integer;
        j: Integer;
        BankAcc: Text[20];
        Amtlen2: Integer;
        Space2: Text[20];
        BranchName: Text[50];
        ExcelBuf: Record "Excel Buffer" temporary;
        TotalNet: Decimal;
        TextRefNo: Text[50];
        PayrollPeriods: Record "Payroll Period";
        GrossPay: Decimal;
        TotalDeduction: Decimal;
        Earn: Record Earnings;
        Deduct: Record Deductions;
        AssignMatrix: Record "Assignment Matrix";
        PositivePAYEManual: Decimal;
        PayDeduct: Record "Assignment Matrix";
        LoanBalance: Decimal;
        MonthStartDate: Date;
        Counter: Integer;
        CompInfo: Record "Company Information";
        //SalaryEFT: XMLport "Salary EFT";
        OutStreamx: OutStream;
        CurrReport_PAGENOCaptionLbl: Label 'Page';

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

    procedure ChckRound(var AmtText: Text[30]) ChckRound: Text[30];
    var
        LenthOfText: Integer;
        DecimalPos: Integer;
        AmtWithoutDec: Text[30];
        DecimalAmt: Text[30];
        Decimalstrlen: Integer;
    begin
        LenthOfText := STRLEN(AmtText);
        DecimalPos := STRPOS(AmtText, '.');
        if DecimalPos = 0 then begin
            AmtWithoutDec := AmtText;
            DecimalAmt := '.00';
        end else begin
            AmtWithoutDec := COPYSTR(AmtText, 1, DecimalPos - 1);
            DecimalAmt := COPYSTR(AmtText, DecimalPos + 1, 2);
            Decimalstrlen := STRLEN(DecimalAmt);
            if Decimalstrlen < 2 then begin
                DecimalAmt := '.' + DecimalAmt + '0';
            end else
                DecimalAmt := '.' + DecimalAmt
        end;
        ChckRound := AmtWithoutDec + DecimalAmt;
    end;
}

