report 51513800 "AIC Applications Report"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/AIC Applications Report.rdl';
    caption = 'AIC Applications Report';


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
            column(AIC_Logo; "AIC Logo")
            {

            }
            column(AIC_Company_Name; "AIC Company Name")
            {

            }
            dataitem("Job Applicants"; "Job Applicants")
            {
                DataItemTableView = sorting ("No.") order(ascending) where ("Job Function" = filter ("AIC Job"), Submitted = filter (true));

                column(No_; "No.")
                {

                }
                column(Application_Date; "Application Date")
                {

                }
                column(Application_Time; "Application Time")
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
                column(ApplicantEmail; "E-Mail")
                {

                }
                column(Gender; Gender)
                {

                }
                column(ID_Number; "ID Number")
                {

                }
                column(Job_ID; "Job ID")
                {

                }
                column(Job_Applied_for; "Job Applied for")
                {

                }
                column(Job_Applied_for_Description; "Job Applied for Description")
                {

                }
                column(Submitted_Date; "Submitted Date")
                {

                }

            }
            trigger OnPredataItem()
            var
                myInt: Integer;
            begin
                "Company Information".CalcFields(Picture, "AIC Logo")
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