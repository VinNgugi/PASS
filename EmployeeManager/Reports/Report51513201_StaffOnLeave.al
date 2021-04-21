report 51513201 "Staff On Leave"
{
    // version HR

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Staff On Leave.rdl';
    caption = 'Staff On Leave';
    UsageCategory = ReportsAndAnalysis;
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
                DataItemTableView = WHERE (Status = FILTER (Approved));
                RequestFilterFields = "Application Date";
                column(EmpNo; "Employee Leave Application"."Employee No")
                {
                }
                column(DayaApplied; "Employee Leave Application"."Days Applied")
                {
                }
                column(StartDate; "Employee Leave Application"."Start Date")
                {
                }
                column(EndDate; "Employee Leave Application"."End Date")
                {
                }
                column(LeaveStatus; "Employee Leave Application"."Leave Status")
                {
                }
                column(Taken; "Employee Leave Application".Taken)
                {
                }
                column(EmployeeName; "Employee Leave Application"."Employee Name")
                {
                }
                column(ApprovedDays; "Employee Leave Application"."Approved Days")
                {
                }
                column(ApprovedStartDate; "Employee Leave Application"."Approved Start Date")
                {
                }
                column(ApprovedEndDate; "Employee Leave Application"."Approved End Date")
                {
                }
                column(LeaveCode; "Employee Leave Application"."Leave Code")
                {
                }

                trigger OnAfterGetRecord();
                begin
                    //i := i + 1;
                    // if i > 1 then
                    //   CLEAR(CompanyInfo.Picture);
                end;

                trigger OnPreDataItem();
                begin
                    i := 0;
                end;
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
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        i: Integer;
}

