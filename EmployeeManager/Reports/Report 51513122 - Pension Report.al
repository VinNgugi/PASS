report 51513122 "Pension Report"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Pension Report.rdl';
    Caption = 'Pension Report';

    dataset
    {
        dataitem("Assignment Matrix"; "Assignment Matrix")
        {
            DataItemTableView = SORTING (Type, Retirement) ORDER(Ascending) WHERE (Type = CONST (Deduction));
            RequestFilterFields = "Code";
            //ReqFilterHeading = 'Pension Report';
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            /*column(CompRec__Pension_No__; CompRec."Pension No.")
            {
            }*/
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(PENSIONS_CONTRIBUTION_REPORT__; 'PENSIONS CONTRIBUTION REPORT ')
            {
            }
            column(Assignment_Matrix_X1__Employee_No_; "Employee No")
            {
            }
            column(Name; Name)
            {
            }
            column(Rep_Header; GroupHeader)
            {
            }
            column(Assigned_Amt; EmployAssigned)
            {
            }
            column(Employee_Voluntary_; EmloyVoluntary)
            {
            }
            column(ABS_Amount__Employee_Voluntary__; ABS(Amount + "Employee Voluntary"))
            {
            }
            column(ABS__Employer_Amount___; ABS("Employer Amount"))
            {
            }
            column(Assignment_Matrix_X1__Employee_Voluntary_; "Employee Voluntary")
            {
            }
            column(OwnPensionArrears_; OwnPensionArrears)
            {
            }
            column(EmpPensionArrears_; EmpPensionArrears)
            {
            }
            column(ABS__Employer_Amount____ABS_Amount_; ABS("Employer Amount") + ABS(Amount) + ABS("Employee Voluntary") + ABS(EmpPensionArrears))
            {
            }
            column(Line_No; LineNo)
            {
            }
            column(EmployeeTotal; EmployeeTotal)
            {
            }
            column(EmployerTotal; EmployerTotal)
            {
            }
            column(RSA_PIN; SSFNo)
            {
            }
            column(SumTotal; SumTotal)
            {
            }
            column(Remarks; Remarks)
            {
            }
            column(Assignment_Matrix_X1__Employee_Voluntary__Control1000000003; "Employee Voluntary")
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Pension_Contribution_No_Caption; Pension_Contribution_No_CaptionLbl)
            {
            }
            column(UserCaption; UserCaptionLbl)
            {
            }
            column(PERIODCaption; PERIODCaptionLbl)
            {
            }
            column(No_Caption; No_CaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Total_AmountCaption; Total_AmountCaptionLbl)
            {
            }
            column(Employer_AmountCaption; Employer_AmountCaptionLbl)
            {
            }
            column(Employee_AmountCaption; Employee_AmountCaptionLbl)
            {
            }
            column(Assignment_Matrix_X1__Employee_Voluntary_Caption; FIELDCAPTION("Employee Voluntary"))
            {
            }
            column(Emloyee_Voluntary; "Assignment Matrix"."Employee Voluntary")
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
            column(EmployeeArrearsCaption; EmployeeArrearsLbl)
            {
            }
            column(EmployerArrearsCaption; EmployerArrearsLbl)
            {
            }
            column(totalsum; totalsum)
            {
            }
            column(logo; COMPINFO.Picture)
            {
            }
            column(Monthname; Monthname)
            {
            }
            column(COMPNAME; COMPINFO.Name)
            {
            }
            column(EmployeeNo_AssignmentMatrixX1; "Assignment Matrix"."Employee No")
            {
            }

            trigger OnAfterGetRecord();
            begin
                OwnPensionArrears := 0;
                EmpPensionArrears := 0;
                EmloyVoluntary := 0;
                EmployAssigned := 0;

                //ERROR('%1',"Assignment Matrix".Amount);

                if Emp.GET("Employee No") then begin
                    Name := Emp."Last Name" + ' ' + Emp."First Name" + ' ' + Emp."Middle Name";
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

                if
                "Assignment Matrix".Type = "Assignment Matrix".Type::Deduction then begin
                    if Deduction.GET("Assignment Matrix".Code) then
                        GroupHeader := Deduction.Description;



                end;
                LineNo := LineNo + 1;
                EmloyVoluntary := "Assignment Matrix"."Employee Voluntary";
                EmployAssigned := ABS("Assignment Matrix".Amount) - "Assignment Matrix"."Employee Voluntary";
                TotalBasic := TotalBasic + BasicPay;
                EmployerTotal := EmployerTotal + ABS("Assignment Matrix"."Employer Amount");
                EmployeeTotal := EmployeeTotal + ABS("Assignment Matrix".Amount);
                SumTotal := SumTotal + ABS("Assignment Matrix"."Employer Amount") + ABS("Assignment Matrix".Amount);
                Remarks := 'For ' + Monthname + ' Only';
                //=========================================================
                totalsum := 0;
                totalsum := ABS("Assignment Matrix".Amount) + "Assignment Matrix"."Employer Amount";
                //=========================================================
            end;

            trigger OnPreDataItem();
            begin
                LastFieldNo := FIELDNO(Code);
                //"Assignment Matrix-X".SETRANGE("Assignment Matrix-X".Retirement,TRUE);
                "Assignment Matrix".SETRANGE("Assignment Matrix".Type, "Assignment Matrix".Type::Deduction);
                LineNo := 0;
                COMPINFO.RESET;
                COMPINFO.CALCFIELDS(COMPINFO.Picture);
                //==========================================================================================
                Monthno := DATE2DMY(MonthStartDate, 2);
                if Monthno = 1 then begin
                    Monthname := 'JANUARY ' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;
                if Monthno = 2 then begin
                    Monthname := 'FEBRUARY  ' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;
                if Monthno = 3 then begin
                    Monthname := 'MARCH ' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;
                if Monthno = 4 then begin
                    Monthname := 'APRIL ' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;
                if Monthno = 5 then begin
                    Monthname := 'MAY ' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;
                if Monthno = 6 then begin
                    Monthname := 'JUNE ' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;
                if Monthno = 7 then begin
                    Monthname := 'JULY ' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;
                if Monthno = 8 then begin
                    Monthname := 'AUGUST ' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;
                if Monthno = 9 then begin
                    Monthname := 'SEPTEMBER ' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;
                if Monthno = 10 then begin
                    Monthname := 'OCTOBER ' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;
                if Monthno = 11 then begin
                    Monthname := 'NOVEMBER ' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;
                if Monthno = 12 then begin
                    Monthname := 'DECEMBER' + FORMAT(DATE2DMY(MonthStartDate, 3));
                end;


                //===========================================================================================
                "Assignment Matrix".SETFILTER("Payroll Period", '%1', MonthStartDate);
                DateSpecified := MonthStartDate;
                if Deduction.GET("Assignment Matrix".Code) then
                    GroupHeader := Deduction.Description;
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

        //
        //DateSpecified:="Assignment Matrix".GETRANGEMIN("Assignment Matrix"."Payroll Period");
        if PayPeriod.GET(DateSpecified) then
            PayPeriodText := PayPeriod.Name;
        nssfcode := "Assignment Matrix".GETRANGEMIN("Assignment Matrix".Code);
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
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Pension_Contribution_No_CaptionLbl: Label 'Pension Contribution No.';
        UserCaptionLbl: Label 'User';
        PERIODCaptionLbl: Label 'PERIOD';
        No_CaptionLbl: Label 'No.';
        NameCaptionLbl: Label 'Name';
        Total_AmountCaptionLbl: Label 'Total Amount';
        Employer_AmountCaptionLbl: Label 'Employer Amount';
        Employee_AmountCaptionLbl: Label 'Employee Amount';
        TotalCaptionLbl: Label 'Total';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label 'Certified correct by';
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        MonthStartDate: Date;
        EmployeeArrearsLbl: Label 'Own Pension Arrears';
        EmployerArrearsLbl: Label 'Employer Pension Arrears';
        OwnPensionArrears: Decimal;
        EmpPensionArrears: Decimal;
        Assign: Record "Assignment Matrix";
        TEMPDEC: Decimal;
        assignment7: Record "Assignment Matrix";
        totalsum: Decimal;
        COMPINFO: Record "Company Information";
        Monthname: Text;
        Monthno: Integer;
        year: Integer;
        LineNo: Integer;
        EmployAssigned: Decimal;
        EmloyVoluntary: Integer;
        Remarks: Text;

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

    procedure getdate99(bddate: Date);
    begin
        MonthStartDate := bddate;
    end;
}

