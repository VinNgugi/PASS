page 51513632 "Validation Lines"
{
    PageType = ListPart;
    SourceTable = "Validation Lines";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Reporting Date"; "Reporting Date")
                {
                    Caption = 'Reporting Period End Date';
                }
                field("Contract No."; "Contract No.")
                {

                }
                field("Loan No"; "Loan No")
                {

                }
                field("Customer Name"; "Customer Name")
                {

                }
                field("Account No."; "Account No.")
                {

                }
                field("Approved Amount"; "Approved Amount")
                {

                }
                field("Disbursed Amount"; "Disbursed Amount")
                {

                }
                field("Repayment Installment Amt"; "Repayment Installment Amt")
                {

                }
                field("Total Exposure"; "Total Exposure")
                {

                }
                field("Total Principal Amt Paid "; "Total Principal Amt Paid ")
                {

                }
                field("Outstanding Principal Amt"; "Outstanding Principal Amt")
                {

                }

                field("Interest Amt Accrued"; "Interest Amt Accrued")
                {

                }
                field("Principal Amt In Arrears"; "Principal Amt In Arrears")
                {

                }
                field("Interest Amt In Arrears"; "Interest Amt In Arrears")
                {

                }
                field("Total No. of Installments"; "Total No. of Installments")
                {

                }
                field("No. of Installments In Arrears"; "No. of Installments In Arrears")
                {

                }
                field("Days Past Due"; "Days Past Due")
                {

                }
                field(Guarantee; Guarantee)
                {
                    Caption = 'Guarantee %';
                }

                field("Guarantee Amt"; "Guarantee Amt")
                {

                }
                field("System Classification"; "System Classification")
                {

                }
                field("Loan Value Date"; "Loan Value Date")
                {

                }
                field("Loan Maturity Date"; "Loan Maturity Date")

                {

                }
                field(Validated; Validated)
                {

                }

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}