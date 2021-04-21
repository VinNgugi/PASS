page 51513546 "User Batch Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "User Batch Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("User Name"; "User Name")
                {
                    ApplicationArea = All;

                }
                field("Payment Voucher Batch"; "Payment Voucher Batch")
                {

                }
                field("Petty Cash Batch"; "Petty Cash Batch")
                {

                }
                field("Imprest/Surrender Batch"; "Imprest/Surrender Batch")
                {

                }
            }
        }
        area(Factboxes)
        {

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