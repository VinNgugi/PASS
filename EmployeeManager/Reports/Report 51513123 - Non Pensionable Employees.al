report 51513123 "Non Pensionable Employees"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Non Pensionable Employees.rdl';
    Caption = 'Non Pensionable Employees';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = "Pay Period Filter";
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
            column(UPPERCASE_FORMAT_DateSpecified_0___Month_Text___year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<Month Text> <year4>')))
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(First_Name_________Middle_Name________Last_Name_; "First Name" + '  ' + "Middle Name" + '  ' + "Last Name")
            {
            }
            column(NON_PENSIONABLE_EMPLOYEESCaption; NON_PENSIONABLE_EMPLOYEESCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                Deductions.RESET;
                Deductions.SETRANGE(Deductions."Pension Scheme", true);
                if Deductions.FINDFIRST then begin

                    if Deductions."Calculation Method" = Deductions."Calculation Method"::"% of Basic Pay" then begin
                        AssignRec.SETRANGE(AssignRec."Employee No", Employee."No.");
                        AssignRec.SETRANGE(AssignRec.Type, AssignRec.Type::Deduction);
                        AssignRec.SETRANGE(AssignRec."Payroll Period", Employee.GETRANGEMIN(Employee."Pay Period Filter"));
                        AssignRec.SETRANGE(AssignRec.Code, Deductions.Code);
                        if AssignRec.FIND('-') then
                            CurrReport.SKIP;
                    end;
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(MonthBeginDate; MonthStartDate)
                {
                    Caption = 'MonthBeginDate';
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
        Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);

        DateSpecified := MonthStartDate;



        //DateSpecified:=Employee.GETRANGEMIN(Employee."Pay Period Filter");
    end;

    var
        AssignRec: Record "Assignment Matrix";
        Deductions: Record Deductions;
        DateSpecified: Date;
        NON_PENSIONABLE_EMPLOYEESCaptionLbl: Label 'NON PENSIONABLE EMPLOYEES';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
        MonthStartDate: Date;
}

