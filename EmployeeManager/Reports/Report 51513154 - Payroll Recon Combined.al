report 51513154 "Payroll Recon Combined"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Payroll Recon Combined.rdl';
    Caption = 'Payroll Recon Combined';

    dataset
    {
        dataitem(Earnings; Earnings)
        {
            PrintOnlyIfDetail = true;
            column(USERID; USERID)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(Earnings__Pay_Period_Filter_; "Pay Period Filter")
            {
            }
            column(Earnings_Description; Description)
            {
            }
            column(Earnings_Code; Code)
            {
            }
            column(EmployeeCaption; EmployeeCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Current_PeriodCaption; Current_PeriodCaptionLbl)
            {
            }
            column(Previous_PeriodCaption; Previous_PeriodCaptionLbl)
            {
            }
            column(VarianceCaption; VarianceCaptionLbl)
            {
            }
            column(PerVarianceCaption; PerVarianceLbl)
            {
            }
            column(CurrentDate; CurrentDate)
            {
            }
            column(PreviousDate; PreviousDate)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Emp__NoCaption; Emp__NoCaptionLbl)
            {
            }
            dataitem(Employee; Employee)
            {
                DataItemTableView = SORTING ("No.");
                RequestFilterFields = "No.";
                column(EmpName; EmpName)
                {
                }
                column(Amount; Amount)
                {
                }
                column(LastMonthAmount; LastMonthAmount)
                {
                }
                column(Difference; Difference)
                {
                }
                column(PerVariance; PerVariance)
                {
                }
                column(Employee__No__; "No.")
                {
                }

                trigger OnAfterGetRecord();
                begin

                    EmpName := Employee."First Name" + ' ' + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    AssignMatrixCurrent.RESET;
                    AssignMatrixCurrent.SETRANGE(AssignMatrixCurrent."Employee No", Employee."No.");
                    AssignMatrixCurrent.SETRANGE(AssignMatrixCurrent.Type, AssignMatrixCurrent.Type::Payment);
                    AssignMatrixCurrent.SETRANGE(AssignMatrixCurrent.Code, Earnings.Code);
                    // AssignMatrixCurrent.SETRANGE(AssignMatrixCurrent."Payroll Period",Earnings.GETRANGEMIN(Earnings."Pay Period Filter"));
                    AssignMatrixCurrent.SETRANGE(AssignMatrixCurrent."Payroll Period", MonthStartDate);
                    if AssignMatrixCurrent.FIND('-') then
                        Amount := AssignMatrixCurrent.Amount
                    else
                        Amount := 0;

                    AssignMatrixCurrent.RESET;
                    AssignMatrixCurrent.SETRANGE(AssignMatrixCurrent."Employee No", Employee."No.");
                    AssignMatrixCurrent.SETRANGE(AssignMatrixCurrent.Type, AssignMatrixCurrent.Type::Payment);
                    AssignMatrixCurrent.SETRANGE(AssignMatrixCurrent.Code, Earnings.Code);
                    AssignMatrixCurrent.SETRANGE(AssignMatrixCurrent."Payroll Period", Lastmonth);
                    if AssignMatrixCurrent.FIND('-') then
                        LastMonthAmount := AssignMatrixCurrent.Amount
                    else
                        LastMonthAmount := 0;
                    // END;
                    Difference := Amount - LastMonthAmount;

                    if Difference <> 0 then
                        if Amount = 0 then
                            PerVariance := -100 else
                            PerVariance := ROUND((Difference / Amount) * 100, 0.05);


                    if Difference = 0 then
                        CurrReport.SKIP;
                end;

                trigger OnPreDataItem();
                begin
                    LastFieldNo := FIELDNO("No.");
                end;
            }

            trigger OnAfterGetRecord();
            begin

                Thismonth := MonthStartDate;
                // Thismonth:=Earnings.GETRANGEMIN(Earnings."Pay Period Filter");
                Lastmonth := CALCDATE('-1M', Thismonth);
                CurrentDate := FORMAT(Thismonth, 0, '<month text> <year4>');
                PreviousDate := FORMAT(Lastmonth, 0, '<month text> <year4>');
            end;
        }
        dataitem(Deductions; Deductions)
        {
            PrintOnlyIfDetail = true;
            column(DeductionsX1_Code; Code)
            {
            }
            column(DeductionsX1_Description; Description)
            {
            }
            dataitem(Emp; Employee)
            {
                column(EmpName_Control1000000007; EmpName)
                {
                }
                column(Amount_Control1000000010; Amount)
                {
                }
                column(LastMonthAmount_Control1000000013; LastMonthAmount)
                {
                }
                column(Difference_Control1000000016; Difference)
                {
                }
                column(PerVarianceDed; PerVariance)
                {
                }
                column(Emp__No__; "No.")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    EmpName := Emp."First Name" + ' ' + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";

                    AssignMatrixPrevious.RESET;
                    AssignMatrixPrevious.SETRANGE(AssignMatrixPrevious."Employee No", Emp."No.");
                    AssignMatrixPrevious.SETRANGE(AssignMatrixPrevious.Type, AssignMatrixPrevious.Type::Deduction);
                    AssignMatrixPrevious.SETRANGE(AssignMatrixPrevious.Code, Deductions.Code);
                    // AssignMatrixPrevious.SETRANGE(AssignMatrixPrevious."Payroll Period",Earnings.GETRANGEMIN(Earnings."Pay Period Filter"));
                    AssignMatrixPrevious.SETRANGE(AssignMatrixPrevious."Payroll Period", MonthStartDate);

                    if AssignMatrixPrevious.FIND('-') then begin
                        //MESSAGE('Current Deduction Amount=%1',AssignMatrixCurrent.Amount);
                        Amount := AssignMatrixPrevious.Amount
                    end else
                        Amount := 0;


                    AssignMatrixPrevious.RESET;
                    AssignMatrixPrevious.SETRANGE(AssignMatrixPrevious."Employee No", Emp."No.");
                    AssignMatrixPrevious.SETRANGE(AssignMatrixPrevious.Type, AssignMatrixPrevious.Type::Deduction);
                    AssignMatrixPrevious.SETRANGE(AssignMatrixPrevious.Code, Deductions.Code);
                    AssignMatrixPrevious.SETRANGE(AssignMatrixPrevious."Payroll Period", Lastmonth);
                    if AssignMatrixPrevious.FIND('-') then begin
                        //MESSAGE('Previous Deduction Amount=%1',AssignMatrixCurrent.Amount);
                        LastMonthAmount := AssignMatrixPrevious.Amount
                    end else
                        LastMonthAmount := 0;

                    Difference := Amount - LastMonthAmount;

                    if Difference <> 0 then
                        if Amount = 0 then
                            PerVariance := -100 else
                            PerVariance := ROUND((Difference / Amount) * 100, 0.05);


                    if Difference = 0 then
                        CurrReport.SKIP;
                end;
            }
        }
        dataitem("Assignment Matrix"; "Assignment Matrix")
        {
            column(Assignment_Matrix_X1__Employee_No_; "Employee No")
            {
            }
            column(Assignment_Matrix_X1_Amount; Amount)
            {
            }
            column(Assignment_Matrix_X1_Amount_Control1000000015; Amount)
            {
            }
            column(Difference_Control1000000017; Difference)
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
        // Employee.SETFILTER("Pay Period Filter",'%1',MonthStartDate);
        Earnings.SETFILTER("Pay Period Filter", '%1', MonthStartDate);


        // PayPeriodtext:=Employee.GETFILTER("Pay Period Filter");

        Thismonth := MonthStartDate;



        // Thismonth:=Earnings.GETRANGEMIN(Earnings."Pay Period Filter");
        Lastmonth := CALCDATE('-1M', Thismonth);
        CurrentDate := FORMAT(Thismonth, 0, '<month text> <year4>');
        PreviousDate := FORMAT(Lastmonth, 0, '<month text> <year4>');
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        AssignMatrixCurrent: Record "Assignment Matrix";
        AssignMatrixPrevious: Record "Assignment Matrix";
        Amount: Decimal;
        LastMonthAmount: Decimal;
        Difference: Decimal;
        Thismonth: Date;
        Lastmonth: Date;
        EmpName: Text[150];
        EmployeeCaptionLbl: Label 'Employee';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Current_PeriodCaptionLbl: Label 'Current Period';
        Previous_PeriodCaptionLbl: Label 'Previous Period';
        VarianceCaptionLbl: Label 'Variance';
        NameCaptionLbl: Label 'Name';
        Emp__NoCaptionLbl: Label 'Emp. No';
        CurrentDate: Text[50];
        PreviousDate: Text[50];
        PerVariance: Decimal;
        PerVarianceLbl: Label 'Percentage Variance';
        MonthStartDate: Date;
}

