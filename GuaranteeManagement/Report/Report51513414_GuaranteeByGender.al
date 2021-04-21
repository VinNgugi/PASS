report 51513414 "Guaratee by Gender"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Guarantee by Gender';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/GuarateebyGender.rdl';
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
                column(No_; "No.")
                {

                }
                column(Gender; Gender)
                {

                }
                column(No__of_Males; "No. of Males")
                {

                }
                column(No__of_Females; "No. of Females")
                {

                }
                column(Product; Product)
                {

                }
                column(NoOfClients; NoOfClients)
                {

                }
                column(Loan_Amount; "Loan Amount")
                {

                }
                column(CGC_Amount; "CGC Committed Funds")
                {

                }
                column(Male; Male)
                {

                }
                column(Female; Female)
                {

                }
                trigger OnAfterGetRecord()
                begin

                end;
            }
        }
    }




    var
        NoOfClients: Integer;
        Male: Integer;
        Female: Integer;
}