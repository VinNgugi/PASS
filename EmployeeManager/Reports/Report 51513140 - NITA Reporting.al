report 51513140 "NITA Reporting"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/NITA Reporting.rdl';
    Caption = 'NITA Reporting';

    dataset
    {
        dataitem(Deductions; Deductions)
        {
            DataItemTableView = WHERE ("NITA Deduction" = CONST (true));
            dataitem("Assignment Matrix"; "Assignment Matrix")
            {
                DataItemLink = Code = FIELD (Code);
                DataItemTableView = SORTING ("Employee No", Type, Code, "Payroll Period", "Reference No") ORDER(Ascending) WHERE (Type = CONST (Deduction));
                //ReqFilterHeading = 'NITA';
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
                column(CoNssf; CoNssf)
                {
                }
                column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<Month Text> <year4>')))
                {
                }
                column(Assignment_Matrix_X1__Employee_No_; "Employee No")
                {
                }
                column(Employee_Name; NameCaptionLbl)
                {
                }
                column(Name; Name)
                {
                }
                column(FirstName; FirstName)
                {
                }
                column(MiddleName; MiddleName)
                {
                }
                column(LastName; LastName)
                {
                }
                column(OtherNames; OtherNames)
                {
                }
                column(IDNumber; IDNumber)
                {
                }
                column(ABS_Amount_; ABS(Amount))
                {
                }
                column(ABS__Employer_Amount___; ABS("Employer Amount"))
                {
                }
                column(Emp__NSSF_No__; Emp."NSSF No.")
                {
                }
                column(ABS__Employer_Amount____ABS_Amount_; ABS("Employer Amount") + ABS(Amount) + ABS(EmpVoluntary))
                {
                }
                column(EmployeeTotal; EmployeeTotal)
                {
                }
                column(EmployerTotal; EmployerTotal)
                {
                }
                column(SumTotal; SumTotal)
                {
                }
                column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
                {
                }
                column(COMPANY_NSSF_No_Caption; COMPANY_NSSF_No_CaptionLbl)
                {
                }
                column(UserCaption; UserCaptionLbl)
                {
                }
                column(CONTRIBUTIONS_RETURN_FORMCaption; CONTRIBUTIONS_RETURN_FORMCaptionLbl)
                {
                }
                column(PERIODCaption; PERIODCaptionLbl)
                {
                }
                column(NATIONAL_SOCIAL_SECURITY_FUNDCaption; NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl)
                {
                }
                column(P_O__BOX_30599Caption; P_O__BOX_30599CaptionLbl)
                {
                }
                column(NAIROBICaption; NAIROBICaptionLbl)
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
                column(EmployeeVoluntaryCaption; EmployeeVoluntaryLbl)
                {
                }
                column(EmpVoluntary_; ABS(EmpVoluntary))
                {
                }
                column(NSSF_No_Caption; NSSF_No_CaptionLbl)
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
                column(PIC; COMPINFO.Picture)
                {
                }

                trigger OnAfterGetRecord();
                begin

                    if Emp.GET("Employee No") then begin
                        Name := Emp."First Name" + '  ' + Emp."Middle Name" + '  ' + Emp."Last Name";
                        LastName := Emp."Last Name";
                        OtherNames := Emp."First Name" + ' ' + Emp."Middle Name";
                        IDNumber := Emp."ID Number";
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
                        if Deduction.GET("Assignment Matrix".Code) then begin
                            GroupHeader := Deduction.Description;
                            //******Get Voluntary Contributions***********//
                            Deduction.SETRANGE(Deduction."Voluntary Code", "Assignment Matrix".Code);
                            Deduction.SETRANGE(Deduction."Pay Period Filter", "Assignment Matrix"."Payroll Period");
                            Deduction.SETRANGE(Deduction."Employee Filter", "Assignment Matrix"."Employee No");
                            Deduction.CALCFIELDS("Voluntary Amount");
                            EmpVoluntary := Deduction."Voluntary Amount";
                        end;
                    end;
                    //=================================================================
                    assign7.RESET;
                    assign7.SETFILTER(assign7."Employee No", "Assignment Matrix"."Employee No");
                    assign7.SETFILTER(assign7.Type, '%1', assign7.Type::Deduction);
                    assign7.SETFILTER(assign7.Code, '893');
                    assign7.SETFILTER(assign7."Payroll Period", '%1', DateSpecified);
                    if assign7.FINDSET then begin
                        EmpVoluntary := ABS(assign7.Amount);
                    end;
                    //=================================================================
                    TotalBasic := TotalBasic + BasicPay;
                    EmployerTotal := EmployerTotal + ABS("Assignment Matrix"."Employer Amount");
                    EmployeeTotal := EmployeeTotal + ABS("Assignment Matrix".Amount);
                    SumTotal := SumTotal + ABS("Assignment Matrix"."Employer Amount") + ABS("Assignment Matrix".Amount);
                end;

                trigger OnPreDataItem();
                begin
                    /*StartDate := "Assignment Matrix".GETRANGEMIN("Pay Period Filter");
                    EndDate := "Assignment Matrix".GETRANGEMAX("Pay Period Filter");*/

                    //"Assignment Matrix".RESET;
                    "Assignment Matrix".SETRANGE("Payroll Period", DateSpecified);


                    LastFieldNo := FIELDNO(Code);
                    //"Assignment Matrix-X".SETRANGE("Assignment Matrix-X".Retirement,TRUE);
                    "Assignment Matrix".SETRANGE("Assignment Matrix".Type, "Assignment Matrix".Type::Deduction);


                    COMPINFO.CALCFIELDS(COMPINFO.Picture);

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
                    Visible = true;
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
        //DateSpecified:="Assignment Matrix".GETRANGEMIN("Assignment Matrix"."Pay Period Filter");
        if PayPeriod.GET(DateSpecified) then
            PayPeriodText := PayPeriod.Name;
        //nssfcode:="Assignment Matrix".GETRANGEMIN("Assignment Matrix".Code);
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
        COMPANY_NSSF_No_CaptionLbl: Label 'COMPANY NSSF No.';
        UserCaptionLbl: Label 'User';
        CONTRIBUTIONS_RETURN_FORMCaptionLbl: Label 'CONTRIBUTIONS RETURN FORM';
        PERIODCaptionLbl: Label 'PERIOD';
        NATIONAL_SOCIAL_SECURITY_FUNDCaptionLbl: Label 'NATIONAL SOCIAL SECURITY FUND';
        P_O__BOX_30599CaptionLbl: Label 'P.O. BOX 30599';
        NAIROBICaptionLbl: Label 'NAIROBI';
        No_CaptionLbl: Label 'No.';
        NameCaptionLbl: Label 'Employee Names';
        Total_AmountCaptionLbl: Label 'Total Amount';
        Employer_AmountCaptionLbl: Label 'Employer Amount';
        Employee_AmountCaptionLbl: Label 'Employee Amount';
        NSSF_No_CaptionLbl: Label 'NSSF No.';
        TotalCaptionLbl: Label 'Total';
        Certified_correct_by_Company_Authorised_Officer_CaptionLbl: Label '"Certified correct by Company Authorised Officer "';
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        StartDate: Date;
        EndDate: Date;
        EmpVoluntary: Decimal;
        EmployeeVoluntaryLbl: Label 'Employee Voluntary Amount';
        FirstName: Text[50];
        MiddleName: Text[50];
        LastName: Text[50];
        OtherNames: Text[100];
        IDNumber: Text[30];
        OtherNamesLbl: Label 'Other Names';
        LastNameLbl: Label 'Surname';
        NSSFEXtra: Decimal;
        assign7: Record "Assignment Matrix";
        COMPINFO: Record "Company Information";

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

    procedure Getdate(bddate: Date);
    begin
        DateSpecified := bddate;
    end;
}

