report 51513125 "Employee Details"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Employee Details.rdl';
    Caption = 'Employee Details';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING ("No.") WHERE (Status = CONST (Active));
            RequestFilterFields = "Pay Period Filter", "No.", Status;
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(TIME; TIME)
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
            column(PF_No__; 'PF No.')
            {
            }
            column(Name_; 'Name')
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
            column(First_Name_________Middle_Name_______Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(Employee__Date_Of_Join_; "Date Of Join")
            {
            }
            column(Employee_Status; Status)
            {
            }
            column(Employee_Position; Position)
            {
            }
            column(Employee__Job_Title_; "Job Title")
            {
            }
            column(Employee__Salary_Scale_; "Salary Scale")
            {
            }
            column(Employee_Present; Present)
            {
            }
            column(Employee__Global_Dimension_1_Code_; "Global Dimension 1 Code")
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
            column(STRSUBSTNO__Employees__1__counter_; STRSUBSTNO('Employees=%1', counter))
            {
            }
            column(EMPLOYEE_DETAILSCaption; EMPLOYEE_DETAILSCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee__Date_Of_Join_Caption; FIELDCAPTION("Date Of Join"))
            {
            }
            column(Employee_StatusCaption; FIELDCAPTION(Status))
            {
            }
            column(Employee_PositionCaption; FIELDCAPTION(Position))
            {
            }
            column(Employee__Job_Title_Caption; FIELDCAPTION("Job Title"))
            {
            }
            column(Employee__Salary_Scale_Caption; FIELDCAPTION("Salary Scale"))
            {
            }
            column(Employee_PresentCaption; FIELDCAPTION(Present))
            {
            }
            column(Employee__Global_Dimension_1_Code_Caption; FIELDCAPTION("Global Dimension 1 Code"))
            {
            }

            trigger OnAfterGetRecord();
            begin
                Employee.CALCFIELDS(Employee."Total Allowances", Employee."Total Deductions");
                if (Employee."Total Allowances" + Employee."Total Deductions") = 0 then
                    CurrReport.SKIP;
                counter := counter + 1;
                NetPay := Employee."Total Allowances" + Employee."Total Deductions";

                NetPay := Payroll.PayrollRounding(NetPay);


                for i := 1 to 10 do begin
                    CLEAR(Allowances[i]);
                    CLEAR(Deductions[i]);
                end;
                OtherEarn := 0;
                OtherDeduct := 0;
                Totallowances := 0;
                OtherDeduct := 0;
                TotalDeductions := 0;

                for i := 1 to 10 do begin
                    Assignmat.RESET;
                    Assignmat.SETRANGE(Assignmat."Employee No", Employee."No.");
                    Assignmat.SETRANGE(Assignmat.Type, Assignmat.Type::Payment);
                    Assignmat.SETRANGE(Assignmat.Code, Earncode[i]);
                    Assignmat.SETRANGE(Assignmat."Payroll Period", DateSpecified);
                    if Assignmat.FIND('-') then
                        Allowances[i] := Assignmat.Amount;
                    Totallowances := Totallowances + Allowances[i];
                end;
                OtherEarn := Employee."Total Allowances" - Totallowances;

                for i := 1 to 10 do begin
                    Assignmat.RESET;
                    Assignmat.SETRANGE(Assignmat."Employee No", Employee."No.");
                    Assignmat.SETRANGE(Assignmat.Type, Assignmat.Type::Deduction);
                    Assignmat.SETRANGE(Assignmat.Code, deductcode[i]);
                    Assignmat.SETRANGE(Assignmat."Payroll Period", DateSpecified);
                    if Assignmat.FIND('-') then
                        Deductions[i] := ABS(Assignmat.Amount);
                    TotalDeductions := TotalDeductions + Deductions[i];
                end;
                OtherDeduct := ABS(Employee."Total Deductions" + TotalDeductions);
            end;

            trigger OnPreDataItem();
            begin
                //CurrReport.CREATETOTALS(Allowances, Deductions, OtherEarn, OtherDeduct, NetPay);
                HRSetup.GET;
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
    begin

        DateSpecified := Employee.GETRANGEMIN(Employee."Pay Period Filter");

        EarnRec.RESET;
        EarnRec.SETRANGE(EarnRec."Show on Master Roll", true);
        if EarnRec.FIND('-') then
            repeat
                i := i + 1;
                Earncode[i] := EarnRec.Code;
                EarnDesc[i] := EarnRec.Description;
            until EarnRec.NEXT = 0;


        DedRec.RESET;
        DedRec.SETRANGE(DedRec."Show on Master Roll", true);
        if DedRec.FIND('-') then
            repeat
                j := j + 1;
                deductcode[j] := DedRec.Code;
                DedDesc[j] := DedRec.Description;
            until DedRec.NEXT = 0;
    end;

    var
        Allowances: array[20] of Decimal;
        Deductions: array[20] of Decimal;
        EarnRec: Record Earnings;
        DedRec: Record Deductions;
        Earncode: array[20] of Code[20];
        deductcode: array[20] of Code[20];
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
        HRSetup: Record "Human Resources Setup";
        NetPay: Decimal;
        EMPLOYEE_DETAILSCaptionLbl: Label 'EMPLOYEE DETAILS';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Payroll: Codeunit PayrollRounding;
}

