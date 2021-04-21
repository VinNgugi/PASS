report 51513119 "Master Report"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Master Report.rdl';
    Caption = 'Master Report';

    dataset
    {
        dataitem("Assignment Matrix"; "Assignment Matrix")
        {
            DataItemTableView = SORTING(Type, Code);
            RequestFilterFields = Type, "Code";
            //ReqFilterHeading = 'Detailed Earnings and Deductions';
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(USERID; USERID)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(ReportCaption; ReportCaption)
            {
            }
            column(GroupHeader; GroupHeader)
            {
            }
            column(Assignment_Matrix_X1_Code; Code)
            {
            }
            column(Assignment_Matrix_X1__Employee_No_; "Employee No")
            {
            }
            column(Name; Name)
            {
            }
            column(ABS_Amount_; ABS(Amount))
            {
            }
            column(Assignment_Matrix_X1__Employer_Amount_; "Employer Amount")
            {
            }
            column(ExternalDocNo; ExternalDocNo)
            {
            }
            column(GroupHeader______Total_; GroupHeader + '  Total')
            {
            }
            column(ABS_Amount__Control20; ABS(Amount))
            {
            }
            column(Assignment_Matrix_X1__Employer_Amount__Control1000000002; "Employer Amount")
            {
            }
            column(Page_Caption; Page_CaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(UserCaption; UserCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Assignment_Matrix_X1__Employer_Amount_Caption; FIELDCAPTION("Employer Amount"))
            {
            }
            column(Policy_No__Loan_No__Caption; Policy_No__Loan_No__CaptionLbl)
            {
            }
            column(Assignment_Matrix_X1_Type; Type)
            {
            }
            column(Assignment_Matrix_X1_Payroll_Period; "Payroll Period")
            {
            }
            column(Assignment_Matrix_X1_Reference_No; "Reference No")
            {
            }
            column(NAME_________________________________________________________________________Caption; NAME_________________________________________________________________________CaptionLbl)
            {
            }
            column(SIGNATURE___________________________________________________________Caption; SIGNATURE___________________________________________________________CaptionLbl)
            {
            }
            column(DESIGNATION____________________________________________________________Caption; DESIGNATION____________________________________________________________CaptionLbl)
            {
            }
            column(DATE_____________________________________________________________________Caption; DATE_____________________________________________________________________CaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                // IF ("Assignment Matrix-X".Amount =0) AND ("Assignment Matrix-X"."Outstanding Amount" =0) THEN
                // CurrReport.SKIP;

                if Emp.GET("Employee No") then
                    Name := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name"
                else
                    Name := '';

                if "Assignment Matrix".Type = "Assignment Matrix".Type::Payment then begin
                    if Payment.GET("Assignment Matrix".Code) then begin
                        GroupHeader := Payment.Description;
                        Payment.SETRANGE(Payment."Employee Filter", "Employee No");
                        Payment.CALCFIELDS(Payment."Total Amount");
                        Cumulative := Payment."Total Amount";
                    end;
                end;

                if "Assignment Matrix".Type = "Assignment Matrix".Type::Deduction then begin
                    if Deduction.GET("Assignment Matrix".Code) then begin
                        GroupHeader := Deduction.Description;
                        Deduction.SETRANGE(Deduction."Employee Filter", "Assignment Matrix"."Employee No");
                        Deduction.CALCFIELDS(Deduction."Total Amount");
                        Cumulative := Deduction."Total Amount";
                    end;

                end;
                CodeHolder := "Assignment Matrix".Code;



                LoanApp.RESET;
                LoanApp.SETRANGE(LoanApp."Loan No", "Assignment Matrix"."Reference No");
                if LoanApp.FIND('-') then begin
                    repeat
                        ExternalDocNo := LoanApp."HELB No."
                    until LoanApp.NEXT = 0;
                end;
            end;

            trigger OnPreDataItem();
            begin
                "Assignment Matrix".SETRANGE("Payroll Period", MonthStartDate);


                LastFieldNo := FIELDNO(Code);
                TotalCum := 0;
                CurrReport.CREATETOTALS(Cumulative);
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

    trigger OnPreReport();
    begin
        ReportCaption := '';
        TypeFilter := "Assignment Matrix".GETFILTER("Assignment Matrix".Type);

        if TypeFilter = 'Payment' then
            ReportCaption := 'ALLOWANCES REPORT';
        if TypeFilter = 'Deduction' then
            ReportCaption := 'DEDUCTIONS REPORT';
        if TypeFilter = '' then
            ReportCaption := 'ALLOWANCES AND DEDUCTIONS';
        if TypeFilter = 'Saving Scheme' then
            ReportCaption := 'DEDUCTIONS REPORT';


        "Assignment Matrix".SETFILTER("Payroll Period", '%1', MonthStartDate);
        DateSpecified := MonthStartDate;
        DateSpecified := "Assignment Matrix".GETRANGEMIN("Assignment Matrix"."Payroll Period");
        if PayPeriod.GET(DateSpecified) then
            PayPeriodText := PayPeriod.Name;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label '"Total for "';
        Emp: Record Employee;
        Name: Text[50];
        Payment: Record Earnings;
        Deduction: Record Deductions;
        TypeFilter: Text[80];
        GroupHeader: Text[80];
        PayPeriod: Record "Payroll Period";
        PayPeriodText: Text[80];
        ReportCaption: Text[80];
        DateSpecified: Date;
        PdCode: Code[10];
        Cumulative: Decimal;
        TotalCum: Decimal;
        CodeHolder: Code[10];
        GroupCode: Code[20];
        CUser: Code[20];
        LoanApp: Record "Loan Application";
        ExternalDocNo: Text[30];
        Page_CaptionLbl: Label '"Page "';
        PERIODCaptionLbl: Label 'PERIOD';
        UserCaptionLbl: Label 'User';
        No_CaptionLbl: Label 'No.';
        NameCaptionLbl: Label 'Name';
        AmountCaptionLbl: Label 'Amount';
        Policy_No__Loan_No__CaptionLbl: Label '"""Policy No./Loan No."""';
        MonthStartDate: Date;
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';

    procedure GetPayperiod();
    begin
        PayPeriod.SETRANGE(PayPeriod.Closed, false);
        if PayPeriod.FIND('-') then
            PayPeriodText := PayPeriod.Name;
    end;

    procedure getdate99(bddate: Date);
    begin
        MonthStartDate := bddate;
    end;
}

