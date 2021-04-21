page 51513171 "Payments List Employee"
{
    PageType = List;
    Editable = false;
    DeleteAllowed = false;
    UsageCategory = Lists;
    Caption = 'Employee Payments List';
    SourceTable = "Payments HeaderFin";
    CardPageId = "Payments HeaderFin Employee";
    SourceTableView = WHERE ("Payment Type" = CONST ("Payment Voucher"), Posted = CONST (false), Status = FILTER (<> Released),"Transactions Source"=filter("Employee Transactions"));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field(Date; Date)
                {

                }
                field("Pay Mode"; "Pay Mode")
                {

                }
                field(Payee; Payee)
                {

                }
                field("On behalf of"; "On behalf of")
                {

                }
                field("Total Amount"; "Total Amount")
                {

                }
                field(Posted; Posted)
                {

                }
                field("Posted By"; "Posted By")
                {

                }
                field("Posted Date"; "Posted Date")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field(Cashier; Cashier)
                {

                }
                field("Cheque No"; "Cheque No")
                {

                }
                field("Cheque Date"; "Cheque Date")
                {

                }
                field("Bank Code"; "Bank Code")
                {

                }
            }
        }
        area(Factboxes)
        {
            systempart(link; Links)
            {

            }
            systempart(note; Notes)
            {

            }
        }
    }


}