report 51513118 Earnings
{
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Earnings.rdl';
    caption = 'Earnings';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Name; Name)
            {

            }
            column(Picture; Picture)
            {

            }
            column(E_Mail; "E-Mail")
            {

            }
            column(Home_Page; "Home Page")
            {

            }
            column(Address; Address)
            {

            }
            column(Phone_No_; "Phone No.")
            {

            }
            dataitem(Earnings; Earnings)
            {
                column(Code; Code)
                {

                }
                dataitem("Assignment Matrix"; "Assignment Matrix")
                {
                    DataItemLink = code = field (code);

                    column(EarningCode; Code)
                    {

                    }
                    column(Employee_No; "Employee No")
                    {

                    }
                    column(Description; Description)
                    {

                    }
                    column(Payroll_Period; "Payroll Period")
                    {

                    }
                    column(Amount; Amount)
                    {

                    }
                    dataitem(Employee; Employee)
                    {
                        DataItemLink = "No." = field ("Employee No");

                        column(No_; "No.")
                        {

                        }
                        column(First_Name; "First Name")
                        {

                        }
                        column(Middle_Name; "Middle Name")
                        {

                        }
                        column(Last_Name; "Last Name")
                        {

                        }
                    }
                }
            }
            trigger OnPredataItem()
            var
                myInt: Integer;
            begin
                "Company Information".CalcFields(Picture)
            end;

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        myInt: Integer;
}