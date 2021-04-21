
page 51514004 "Guarantee Claim Lines"
{
    Caption = 'Guarantee Claim Lines';
    PageType = ListPart;
    SourceTable = "Guarantee Claim Line";


    layout
    {

        area(content)
        {
            repeater(Group)
            {


                field("Contract No."; "Contract No.")
                {

                }

                field("Client Name"; "Client Name")
                {

                }
                field("CGC No."; "CGC No.")
                {

                }
                field("Claim Amount"; "Claim Amount")
                {

                }


                field("Payable Amount"; "Payable Amount")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("CGC Date"; "CGC Date")
                {

                }

                field("CGC Start Date"; "CGC Start Date")
                {

                }

                field("CGF %"; "CGF %")
                {

                }

                field("CGC Expiry Date"; "CGC Expiry Date")
                {

                }

                field("Guarantee Source"; "Guarantee Source")
                {

                }

                field("Loan No."; "Loan No.")
                {

                }

                field("Loan Maturity Date"; "Loan Maturity Date")
                {

                }

                field("Product"; "Product")
                {

                }

                field("CGC Amount"; "CGC Amount")
                {

                }

                field("Approved Loan Amount"; "Approved Loan Amount")
                {

                }

                field("Last Aging Date"; "Last Aging Date")
                {

                }

                field("Days in Arrears"; "Days in Arrears")
                {

                }
                field("Outstanding Principal Amt"; "Outstanding Principal Amt")
                {

                }
                field("Approved Amount"; "Approved Amount")
                {

                }
                field("Approval Status"; "Approval Status")
                {

                }
            }
        }
    }

}