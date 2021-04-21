report 51513417 "Business Approved by Subsector"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Approved Associated to Youth';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/BusinessApprovedbySubsector.rdl';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = sorting ("Primary Key");

            column(Name_; Name)
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
            dataitem("Guarantee Contracts"; "Guarantee Contracts")
            {
                DataItemTableView = sorting ("No.") where ("Contract Status" = filter (>= "BP with Bank"));
                column(NoofProjects; NoofProjects)
                {

                }
                column(LoanAmoun; LoanAmount)
                {

                }

                dataitem("Subsector & Line of Business"; "Subsector & Line of Business")
                {
                    DataItemLink = "Client No." = field ("No.");
                    column(Subsector; Subsector)
                    {

                    }
                }

                trigger OnAfterGetRecord()
                begin
                    if "Contract Status" = "Contract Status"::"BP with Bank" then
                        LoanAmount := "Loan Amount(LCY)"
                    else
                        LoanAmount := "Approved Loan Amount(LCY)"
                end;
            }

        }
    }

    var
        NoofProjects: Integer;
        LoanAmount: Decimal;
}