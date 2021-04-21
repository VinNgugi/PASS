report 51513143 "Staff Salaries and Allowance"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Staff Salaries and Allowance.rdl';
    Caption = 'Staff Salaries and Allowance';

    dataset
    {
        dataitem(Employee; Employee)
        {
            CalcFields = "Total Allowances", Basic;
            RequestFilterFields = "Posting Group";
            column(No_Employee; Employee."No.")
            {
            }
            column(FirstName_Employee; Employee."First Name")
            {
            }
            column(MiddleName_Employee; Employee."Middle Name")
            {
            }
            column(LastName_Employee; Employee."Last Name")
            {
            }
            column(BasicPay_Employee; Basic)
            {
            }
            /*column(Grosspay_Employee; Employee."Gross pay")
            {
            }*/
            column(TaxableAllowance_Employee; Employee."Taxable Allowance")
            {
            }
            column(OtherAllowances; OtherAllowances)
            {
            }
            column(UserID; USERID)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(Picture; CompanyInfo.Picture)
            {
            }
            column("filter"; Filters)
            {
            }
            dataitem("Assignment Matrix"; "Assignment Matrix")
            {
                DataItemLink = "Employee No" = FIELD ("No.");
            }

            trigger OnAfterGetRecord();
            begin
                CALCFIELDS(Basic, "Taxable Allowance", "Total Allowances");
                OtherAllowances := "Taxable Allowance" - Basic;
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
        Title = 'STAFF SALARIES AND ALLOWANCES';
    }

    trigger OnPreReport();
    begin
        Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);


        //Filters:= Employee.GETFILTER("Date Filter")
        Filters := Employee.GETFILTER("Pay Period Filter")
    end;

    var
        OtherAllowances: Decimal;
        GrossPay: Decimal;
        CompanyInfo: Record "Company Information";
        Filters: Text[200];
        AssignMat: Record "Assignment Matrix";
        LastMonth: Date;
        Thismonth: Date;
        FoundThismonth: Boolean;
        FoundLastmonth: Boolean;
        Counter: Integer;
        CompInfo: Record "Company Information";
        AssignMatrix: Record "Assignment Matrix";
        AccPeriod: Record "Accounting Period";
        DateSpecified: Date;
        i: Integer;
        Earn: Record Earnings;
        ReliefAmnt: Decimal;
        MonthStartDate: Date;
}

