report 51513128 "Repeating clients"
{
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;

    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Repeating Clients.rdl';

    dataset
    {

        dataitem("Guarantee Contracts"; "Guarantee Contracts")
        {
            //DataItemLink=
            column(Customer_No_; "Customer No.")
            {

            }
            column(CustName; Name)
            {

            }
            column(Gender; Gender)
            {

            }

            column(Product_Type; "Product Type")
            {

            }
            column(Product; Product)
            {

            }
            column(Loan_Amount; "Loan Amount")
            {

            }
            column(CGC_Amount; "CGC Amount")
            {

            }
            column(CGC_Start_Date; "CGC Start Date")
            {

            }
            column(CGC_Expiry_Date; "CGC Expiry Date")
            {

            }
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