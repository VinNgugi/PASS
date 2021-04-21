report 51513413 "RepeatingClientsBankGender"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Repeating Clients by Bank & Gender';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/RepeatingClientsBankGende.rdl';
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
                DataItemTableView = sorting ("No.") where ("Repeating Client" = filter (true));
                column(Receivables_Acc__No_; "Receivables Acc. No.")
                {

                }
                column(Receivables_Acc__Name; "Receivables Acc. Name")
                {

                }
                column(NoOfCliennts; NoOfCliennts)
                {

                }
                column(Loan_Amount; "Loan Amount")
                {

                }

                dataitem("Guarantee App Financial Info"; "Guarantee App Financial Info")
                {

                    DataItemLink = "Application No." = field ("No.");
                    column(No__of_Female_Beneficiaries; "No. of Female Beneficiaries")
                    {

                    }
                    column(No__of_Male_Beneficiaries; "No. of Male Beneficiaries")
                    {

                    }
                }
                trigger OnAfterGetRecord()
                begin
                    NoOfCliennts := NoOfCliennts + 1;
                end;
            }
        }
    }





    var
        NoOfCliennts: Integer;


}