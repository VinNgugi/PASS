report 51513401 "Lender Option list"
{
    Caption = 'Lender Option list';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Lender Option list.rdl';
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

            dataitem("Lenders Option Single CGC"; "Lenders Option Single CGC")
            {

                column(Description; Description)
                {

                }
                column(Reference_No_; "Reference No.")
                {

                }
                column(No__of_Loans; "No. of Loans")
                {

                }
                dataitem("Guarantee Contracts"; "Guarantee Contracts")
                {
                    RequestFilterFields = "Reference No.";
                    DataItemLink = "Reference No." = field ("Reference No.");
                    DataItemTableView = sorting ("No.");
                    column(Loan_No_; "Loan No.")
                    {

                    }
                    column(Name; Name)
                    {

                    }
                    column(No_; "No.")
                    {

                    }
                    column(Pct__Guarantee_Approved; "Pct. Guarantee Approved")
                    {

                    }

                    column(CGC_No_; "CGC No.")
                    {

                    }
                    column(Bank_Account_No; "Bank Account No")
                    {

                    }
                    column(SNnumbers; SNnumbers)
                    {

                    }
                    column(Receivables_Acc__Name; "Receivables Acc. Name")
                    {

                    }
                    column(Bank_Branch_Name; "Bank Branch Name")
                    {

                    }
                    column(Approved_Loan_Amount; "Approved Loan Amount")

                    {

                    }
                    column(CGC_Committed_Funds; "CGC Committed Funds")
                    {

                    }
                    trigger OnAfterGetRecord()

                    begin
                        SNnumbers := SNnumbers + 1;
                    end;

                    trigger OnPredataItem()

                    begin
                        "Lenders Option Single CGC".CalcFields("No. of Loans");
                    end;
                }
            }
        }
    }


    var
        SNnumbers: Integer;
}