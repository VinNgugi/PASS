report 51513202 "Leave Recall List"
{
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Leave Recall List.rdl';
    caption = 'Leave Recall List';

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
            dataitem("Leave Recall"; "Leave Recall")
            {
                DataItemTableView = WHERE(Status = FILTER(released));
                RequestFilterFields = "Recalled By", "Recall Leave Type", "Recall Date";
                column(No_; "No.")
                {

                }
                column(Employee_No; "Employee No")
                {

                }
                column(Employee_Name; "Employee Name")
                {

                }
                column(Leave_Application; "Leave Application")
                {

                }
                column(Recall_Date; "Recall Date")
                {

                }
                column(Recalled_From; "Recalled From")
                {

                }
                column(Recalled_To; "Recalled To")
                {

                }
                column(Recalled_By; "Recalled By")
                {

                }
                column(No__of_Off_Days; "No. of Off Days")
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