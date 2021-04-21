report 51513203 "Leave Application Report"
{

    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Leave Application Report.rdl';
    caption = 'Leave Application Report';

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
            dataitem("Employee Leave Application"; "Employee Leave Application")
            {
                DataItemTableView = where (Status = filter (Approved));
                column(Application_No; "Application No")
                {

                }
                column(Application_Date; "Application Date")
                {

                }
                column(Employee_No; "Employee No")
                {

                }
                column(Employee_Name; "Employee Name")
                {

                }
                column(Leave_Code; "Leave Code")
                {

                }
                column(Start_Date; "Start Date")
                {

                }
                column(End_Date; "End Date")
                {

                }
                column(Days_Applied; "Days Applied")
                {

                }
                column(Resumption_Date; "Resumption Date")
                {

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