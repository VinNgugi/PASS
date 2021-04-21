report 51513137 "Helb Report"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Helb Report.rdl';
    Caption = 'Helb Report';

    dataset
    {
        dataitem(Deductions; Deductions)
        {
            DataItemTableView = WHERE ("HELB Deduction" = CONST (true));
            dataitem("Assignment Matrix"; "Assignment Matrix")
            {
                DataItemLink = Code = FIELD (Code);
                DataItemTableView = SORTING (Type, Retirement) ORDER(Ascending) WHERE (Type = CONST (Deduction));
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO)
                {
                }
                column(USERID; USERID)
                {
                }
                column(COMPANYNAME; UPPERCASE(COMPANYNAME))
                {
                }
                column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<Month Text> <year4>')))
                {
                }
                column(CompRec_Address; CompRec.Address)
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
                column(Emp__ID_Number_; Emp."ID Number")
                {
                }
                column(helb; helb)
                {
                }
                column(univ; univ)
                {
                }
                column(EmployeeTotal; EmployeeTotal)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(UserCaption; UserCaptionLbl)
                {
                }
                column(PeriodCaption; PeriodCaptionLbl)
                {
                    IncludeCaption = false;
                }
                column(HIGHER_EDUCATION_LOANS_BOARDCaption; HIGHER_EDUCATION_LOANS_BOARDCaptionLbl)
                {
                }
                column(EmployerCaption; EmployerCaptionLbl)
                {
                }
                column(Address_Caption; Address_CaptionLbl)
                {
                }
                column(HELB_REPAYMENT_SCHEDULECaption; HELB_REPAYMENT_SCHEDULECaptionLbl)
                {
                }
                column(Payroll_No_Caption; Payroll_No_CaptionLbl)
                {
                }
                column(NameCaption; NameCaptionLbl)
                {
                }
                column(Amount_DeductedCaption; Amount_DeductedCaptionLbl)
                {
                }
                column(Identity_Card_No_Caption; Identity_Card_No_CaptionLbl)
                {
                }
                column(University_Reg__No_Caption; University_Reg__No_CaptionLbl)
                {
                }
                column(University_NameCaption; University_NameCaptionLbl)
                {
                }
                column(TotalCaption; TotalCaptionLbl)
                {
                }
                column(Certified_correct_by_Company_Authorised_Officer_Caption; Certified_correct_by_Company_Authorised_Officer_CaptionLbl)
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
                column(Assignment_Matrix_X1_Type; Type)
                {
                }
                column(Assignment_Matrix_X1_Code; Code)
                {
                }
                column(Assignment_Matrix_X1_Payroll_Period; "Payroll Period")
                {
                }
                column(Assignment_Matrix_X1_Reference_No; "Reference No")
                {
                }
                column(CompRec_Picture; CompRec.Picture)
                {
                }

                trigger OnAfterGetRecord();
                begin

                    if Emp.GET("Employee No") then begin
                        Name := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                        Emp.SETRANGE(Emp."Pay Period Filter", "Assignment Matrix"."Payroll Period");
                        Emp.CALCFIELDS(Emp."Cumm. Basic Pay");
                        if BeginDate = DateSpecified then
                            BasicPay := Emp."Basic Pay"
                        else
                            BasicPay := Emp."Cumm. Basic Pay";
                        SSFNo := Emp."Social Security No.";
                    end;
                    if "Assignment Matrix".Type = "Assignment Matrix".Type::Payment then begin
                        if Payment.GET("Assignment Matrix".Code) then
                            GroupHeader := Payment.Description;
                    end;

                    if "Assignment Matrix".Type = "Assignment Matrix".Type::Deduction then begin
                        if Deduction.GET("Assignment Matrix".Code) then
                            GroupHeader := Deduction.Description;
                    end;
                    TotalBasic := TotalBasic + BasicPay;
                    EmployerTotal := EmployerTotal + ABS("Assignment Matrix"."Employer Amount");
                    EmployeeTotal := EmployeeTotal + ABS("Assignment Matrix".Amount);
                    SumTotal := SumTotal + ABS("Assignment Matrix"."Employer Amount") + ABS("Assignment Matrix".Amount);
                    if LoanApp.GET("Assignment Matrix"."Reference No", "Assignment Matrix".Code) then begin
                        helb := LoanApp."HELB No.";
                        univ := LoanApp."University Name";

                    end;
                end;

                trigger OnPreDataItem();
                begin
                    /*StartDate := "Assignment Matrix".GETRANGEMIN("Pay Period Filter");
                    EndDate := "Assignment Matrix".GETRANGEMAX("Pay Period Filter");*/

                    if PayPeriod.GET(DateSpecified) then
                        PayPeriodText := PayPeriod.Name;
                    nssfcode := "Assignment Matrix".GETRANGEMIN("Assignment Matrix".Code);

                    CompRec.CALCFIELDS(CompRec.Picture);

                    LastFieldNo := FIELDNO(Code);
                    //"Assignment Matrix-X".SETRANGE("Assignment Matrix-X".Retirement,TRUE);
                    "Assignment Matrix".SETRANGE("Assignment Matrix".Type, "Assignment Matrix".Type::Deduction);
                    "Assignment Matrix".SETRANGE("Payroll Period", BeginDate);

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DateSpecified; DateSpecified)
                {
                    Caption = 'Month StartDate';
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

        CompRec.GET;
        //CoNssf := CompRec."N.S.S.F No.";
        GetPayPeriod;
        // liz DateSpecified:="Assignment Matrix".GETRANGEMIN("Assignment Matrix"."Payroll Period");
        /*IF PayPeriod.GET(DateSpecified) THEN
        PayPeriodText:=PayPeriod.Name;
        nssfcode:="Assignment Matrix".GETRANGEMIN("Assignment Matrix".Code);
        */

    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label '"Total for "';
        Emp: Record Employee;
        Name: Text[250];
        Payment: Record Earnings;
        Deduction: Record Deductions;
        TypeFilter: Text[30];
        GroupHeader: Text[30];
        BasicPay: Decimal;
        SSFNo: Code[30];
        TotalBasic: Decimal;
        PayPeriod: Record "Payroll Period";
        PayPeriodText: Text[30];
        Title: Text[30];
        DateSpecified: Date;
        BeginDate: Date;
        CompRec: Record "Company Information";
        CoNssf: Text[30];
        SumTotal: Decimal;
        EmployeeTotal: Decimal;
        EmployerTotal: Decimal;
        GroupCode: Code[20];
        CUser: Code[20];
        nssfcode: Code[10];
        LoanApp: Record "Loan Application";
        helb: Code[100];
        univ: Text[30];
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        UserCaptionLbl: Label 'User';
        PeriodCaptionLbl: Label 'Period';
        HIGHER_EDUCATION_LOANS_BOARDCaptionLbl: Label 'HIGHER EDUCATION LOANS BOARD';
        EmployerCaptionLbl: Label 'Employer';
        Address_CaptionLbl: Label 'Address:';
        HELB_REPAYMENT_SCHEDULECaptionLbl: Label 'HELB REPAYMENT SCHEDULE';
        Payroll_No_CaptionLbl: Label 'Payroll No.';
        NameCaptionLbl: Label 'Name';
        Amount_DeductedCaptionLbl: Label 'Amount Deducted';
        Identity_Card_No_CaptionLbl: Label 'Identity Card No.';
        University_Reg__No_CaptionLbl: Label 'University Reg. No.';
        University_NameCaptionLbl: Label 'University Name';
        TotalCaptionLbl: Label 'Total';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label '"Certified correct by Company Authorised Officer "';
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        StartDate: Date;
        EndDate: Date;

    procedure GetPayPeriod();
    begin
        PayPeriod.SETRANGE(PayPeriod.Closed, false);
        if PayPeriod.FIND('-') then
            BeginDate := PayPeriod."Starting Date";
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

