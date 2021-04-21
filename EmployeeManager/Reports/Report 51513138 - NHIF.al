report 51513138 NHIF
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/NHIF.rdl';
    Caption = 'NHIF';

    dataset
    {
        dataitem(Deductions; Deductions)
        {
            DataItemTableView = WHERE ("NHIF Deduction" = CONST (true));
            dataitem("Assignment Matrix"; "Assignment Matrix")
            {
                DataItemLink = Code = FIELD (Code);
                DataItemTableView = SORTING ("Employee No", Type, Code, "Payroll Period", "Reference No") WHERE (Type = CONST (Deduction));
                //ReqFilterHeading = 'NHIF';
                column(Comp_Picture; CompInfo.Picture)
                {
                }
                column(Comp_Name; CompInfo.Name)
                {
                }
                column(CurrReport_PAGENO; CurrReport.PAGENO)
                {
                }
                column(COMPANYNAME; UPPERCASE(COMPANYNAME))
                {
                }
                column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<Month Text> <year4>')))
                {
                }
                column(EmployerNHIFNo; EmployerNHIFNo)
                {
                }
                column(Address; Address)
                {
                }
                column(Tel; Tel)
                {
                }
                column(CompPINNo; CompPINNo)
                {
                }
                column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
                {
                }
                column(CurrReport_PAGENO_Control42; CurrReport.PAGENO)
                {
                }
                column(USERID; USERID)
                {
                }
                column(COMPANYNAME_Control1000000006; COMPANYNAME)
                {
                }
                column(EmployerNHIFNo_Control1000000007; EmployerNHIFNo)
                {
                }
                column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4_____Control1000000009; UPPERCASE(FORMAT(DateSpecified, 0, '<Month Text> <year4>')))
                {
                }
                column(ABS__Assignment_Matrix_X1__Amount_; ABS("Assignment Matrix".Amount))
                {
                }
                column(Emp__NHIF_No__; Emp."NHIF No.")
                {
                }
                column(FirstName_____Emp__Middle_Name______LastName; FirstName + ' ' + Emp."Middle Name" + ' ' + LastName)
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
                column(Assignment_Matrix_X1__Assignment_Matrix_X1___Employee_No_; "Assignment Matrix"."Employee No")
                {
                }
                column(YEAR; YEAR)
                {
                }
                column(Emp__ID_Number_; Emp."ID Number")
                {
                }
                column(TotalAmount; TotalAmount)
                {
                }
                column(Counter; Counter)
                {
                }
                column(AmountCaption; AmountCaptionLbl)
                {
                }
                column(ID_PassportCaption; ID_PassportCaptionLbl)
                {
                }
                column(Date_of_BirthCaption; Date_of_BirthCaptionLbl)
                {
                }
                column(PageCaption; PageCaptionLbl)
                {
                }
                column(NHIF_No_Caption; NHIF_No_CaptionLbl)
                {
                }
                column(MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NHIFCaption; MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NHIFCaptionLbl)
                {
                }
                column(Name_of_EmployeeCaption; Name_of_EmployeeCaptionLbl)
                {
                }
                column(EMPLOYER_NOCaption; EMPLOYER_NOCaptionLbl)
                {
                }
                column(Payroll_No_Caption; Payroll_No_CaptionLbl)
                {
                }
                column(PERIODCaption; PERIODCaptionLbl)
                {
                }
                column(EMPLOYERCaption; EMPLOYERCaptionLbl)
                {
                }
                column(ADDRESSCaption; ADDRESSCaptionLbl)
                {
                }
                column(EMPLOYER_PIN_NOCaption; EMPLOYER_PIN_NOCaptionLbl)
                {
                }
                column(TEL_NOCaption; TEL_NOCaptionLbl)
                {
                }
                column(PageCaption_Control44; PageCaption_Control44Lbl)
                {
                }
                column(UserCaption; UserCaptionLbl)
                {
                }
                column(NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaption; NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaptionLbl)
                {
                }
                column(EMPLOYER_NOCaption_Control1000000008; EMPLOYER_NOCaption_Control1000000008Lbl)
                {
                }
                column(PERIODCaption_Control1000000010; PERIODCaption_Control1000000010Lbl)
                {
                }
                column(Payroll_No_Caption_Control1000000056; Payroll_No_Caption_Control1000000056Lbl)
                {
                }
                column(Name_of_EmployeeCaption_Control1000000055; Name_of_EmployeeCaption_Control1000000055Lbl)
                {
                }
                column(NHIF_No_Caption_Control1000000053; NHIF_No_Caption_Control1000000053Lbl)
                {
                }
                column(Date_of_BirthCaption_Control1000000051; Date_of_BirthCaption_Control1000000051Lbl)
                {
                }
                column(ID_PassportCaption_Control1000000049; ID_PassportCaption_Control1000000049Lbl)
                {
                }
                column(AmountCaption_Control1000000005; AmountCaption_Control1000000005Lbl)
                {
                }
                column(Total_AmountCaption; Total_AmountCaptionLbl)
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
                column(PIC; COMPINFO2.Picture)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    /*CompInfo.GET;
                    CLEAR(CompInfo.Picture);
                    CompInfo.CALCFIELDS(Picture);
                    */
                    //

                    if Emp.GET("Assignment Matrix"."Employee No") then begin
                        NhifNo := Emp."N.H.I.F No";
                        FirstName := Emp."First Name";
                        MiddleName := Emp."Middle Name";
                        LastName := Emp."Last Name";
                        OtherNames := Emp."First Name" + ' ' + Emp."Middle Name";
                        //Id := Emp."National ID";
                        YEAR := Emp."Date Of Birth";
                        TotalAmount := TotalAmount + ABS("Assignment Matrix".Amount);
                    end;
                    Counter := Counter + 1;

                end;

                trigger OnPreDataItem();
                begin
                    /*StartDate := "Assignment Matrix".GETRANGEMIN("Pay Period Filter");
                    EndDate := "Assignment Matrix".GETRANGEMAX("Pay Period Filter");*/
                    "Assignment Matrix".SETRANGE("Payroll Period", DateSpecified);




                    //EmployerNHIFNo:=CompInfoSetup."N.H.I.F No";
                    // CompPINNo:=CompInfoSetup."Company P.I.N";
                    // Address:=CompInfoSetup."Maximum limit";
                    //Tel:=CompInfoSetup."Repayment Period";
                    COMPINFO2.CALCFIELDS(COMPINFO2.Picture);

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
        //DateSpecified:="Assignment Matrix".GETRANGEMIN("Assignment Matrix"."Payroll Period");
        //DateSpecified:="Assignment Matrix".GETRANGEMIN("Assignment Matrix"."Pay Period Filter");
        //NHIFCODE:="Assignment Matrix".GETRANGEMIN("Assignment Matrix".Code);
    end;

    var
        DateSpecified: Date;
        NhifNo: Code[20];
        Emp: Record Employee;
        Id: Code[20];
        FirstName: Text[30];
        LastName: Text[30];
        TotalAmount: Decimal;
        "Count": Integer;
        DeductionsRec: Record "Assignment Matrix";
        EmployerNHIFNo: Code[20];
        DOB: Date;
        CompInfoSetup: Record "Loans transactions";
        "HR Details": Record Employee;
        CompPINNo: Code[20];
        YEAR: Date;
        Address: Text[90];
        Tel: Text[30];
        Counter: Integer;
        LastFieldNo: Integer;
        BeginDate: Date;
        NHIFCODE: Code[10];
        AmountCaptionLbl: Label 'Amount';
        ID_PassportCaptionLbl: Label 'ID/Passport';
        Date_of_BirthCaptionLbl: Label 'Date of Birth';
        PageCaptionLbl: Label 'Page';
        NHIF_No_CaptionLbl: Label 'NHIF No.';
        MONTHLY_PAYROLL__BY_PRODUCT__RETURNS_TO_NHIFCaptionLbl: Label 'MONTHLY PAYROLL (BY-PRODUCT) RETURNS TO NHIF';
        Name_of_EmployeeCaptionLbl: Label 'Name of Employee';
        EMPLOYER_NOCaptionLbl: Label 'EMPLOYER NO';
        Payroll_No_CaptionLbl: Label 'Payroll No.';
        PERIODCaptionLbl: Label 'PERIOD';
        EMPLOYERCaptionLbl: Label 'EMPLOYER';
        ADDRESSCaptionLbl: Label 'ADDRESS';
        EMPLOYER_PIN_NOCaptionLbl: Label 'EMPLOYER PIN NO';
        TEL_NOCaptionLbl: Label 'TEL NO';
        PageCaption_Control44Lbl: Label 'Page';
        UserCaptionLbl: Label 'User';
        NATIONAL_HOSPITAL_INSURANCE_FUND_REPORTCaptionLbl: Label 'NATIONAL HOSPITAL INSURANCE FUND REPORT';
        EMPLOYER_NOCaption_Control1000000008Lbl: Label 'EMPLOYER NO';
        PERIODCaption_Control1000000010Lbl: Label 'PERIOD';
        Payroll_No_Caption_Control1000000056Lbl: Label 'Payroll No.';
        Name_of_EmployeeCaption_Control1000000055Lbl: Label 'Name of Employee';
        NHIF_No_Caption_Control1000000053Lbl: Label 'NHIF No.';
        Date_of_BirthCaption_Control1000000051Lbl: Label 'Date of Birth';
        ID_PassportCaption_Control1000000049Lbl: Label 'ID/Passport';
        AmountCaption_Control1000000005Lbl: Label 'Amount';
        Total_AmountCaptionLbl: Label 'Total Amount';
        StartDate: Date;
        EndDate: Date;
        CompInfo: Record "Company Information";
        NAME_________________________________________________________________________CaptionLbl: Label 'NAME  .......................................................................';
        SIGNATURE___________________________________________________________CaptionLbl: Label 'SIGNATURE ..........................................................';
        DESIGNATION____________________________________________________________CaptionLbl: Label 'DESIGNATION ...........................................................';
        DATE_____________________________________________________________________CaptionLbl: Label 'DATE ....................................................................';
        MiddleName: Text[50];
        OtherNames: Text[100];
        COMPINFO2: Record "Company Information";

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

