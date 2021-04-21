report 51513132 "Institution Based Report"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Institution Based Report.rdl';
    Caption = 'Institution Based Report';

    dataset
    {
        dataitem(Institution; Institution)
        {
            DataItemTableView = SORTING (Code);
            PrintOnlyIfDetail = true;
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(CompanyInfor_Picture; CompanyInfor.Picture)
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(GrandTotal; GrandTotal)
            {
            }
            column(SALARY_DEDUCTIONS_PER_INSTITUTIONCaption; SALARY_DEDUCTIONS_PER_INSTITUTIONCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Assignment_Matrix_X1__Employee_No_Caption; "Assignment Matrix".FIELDCAPTION("Employee No"))
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Institution1_Code; Code)
            {
            }
            dataitem(Deductions; Deductions)
            {
                DataItemLink = "Institution Code" = FIELD (Code);
                DataItemTableView = SORTING ("Institution Code");
                PrintOnlyIfDetail = true;
                RequestFilterFields = "Institution Code";
                column(DeductionsX1_Code; Code)
                {
                }
                column(DeductionsX1_Description; Description)
                {
                }
                column(Institution1_Name; Institution.Name)
                {
                }
                column(InstitutionTotal; InstitutionTotal)
                {
                }
                column(Institution1_Address; Institution.Address)
                {
                }
                column(Institution1_City; Institution.City)
                {
                }
                column(Institution1_Code_Control1000000008; Institution.Code)
                {
                }
                column(DeductionsX1_Institution_Code; "Institution Code")
                {
                }
                column(DeductionsX1_Pay_Period_Filter; "Pay Period Filter")
                {
                }
                dataitem("Assignment Matrix"; "Assignment Matrix")
                {
                    DataItemLink = Code = FIELD (Code), "Payroll Period" = FIELD ("Pay Period Filter");
                    DataItemTableView = SORTING ("Employee No", Type, Code, "Payroll Period", "Reference No") WHERE (Type = CONST (Deduction));
                    column(Assignment_Matrix_X1__Employee_No_; "Employee No")
                    {
                    }
                    column(ABS_Amount_; ABS(Amount))
                    {
                    }
                    column(EmployeeName; EmployeeName)
                    {
                    }
                    column(ABS_Amount__Control1000000021; ABS(Amount))
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

                    trigger OnAfterGetRecord();
                    begin
                        if EmpRec.GET("Assignment Matrix"."Employee No") then
                            EmployeeName := EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                    end;

                    trigger OnPreDataItem();
                    begin
                        CurrReport.CREATETOTALS("Assignment Matrix".Amount);
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    Deductions.CALCFIELDS(Deductions."Total Amount");
                    InstitutionTotal := InstitutionTotal + ABS(Deductions."Total Amount");
                    GrandTotal := GrandTotal + InstitutionTotal;
                end;

                trigger OnPreDataItem();
                begin
                    LastFieldNo := FIELDNO("Institution Code");
                    CurrReport.CREATETOTALS(InstitutionTotal);
                    Deductions.SETFILTER("Pay Period Filter", '%1', MonthStartDate);
                end;
            }

            trigger OnAfterGetRecord();
            begin

                InstitutionTotal := 0;
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
        // Employee.SETFILTER("Pay Period Filter",'%1',MonthStartDate);

        // DateSpecified:=DeductionsX1.GETRANGEMIN(DeductionsX1."Pay Period Filter");
        DateSpecified := MonthStartDate;
        CompanyInfor.CALCFIELDS(Picture);
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        TotalFor: Label '"Total for "';
        InstitutionTotal: Decimal;
        DateSpecified: Date;
        GrandTotal: Decimal;
        EmployeeName: Text[50];
        EmpRec: Record Employee;
        SALARY_DEDUCTIONS_PER_INSTITUTIONCaptionLbl: Label 'SALARY DEDUCTIONS PER INSTITUTION';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        AmountCaptionLbl: Label 'Amount';
        NameCaptionLbl: Label 'Name';
        MonthStartDate: Date;
        CompanyInfor: Record "Company Information";
}

