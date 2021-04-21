page 51513971 "Bank Payout Integration"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bank Payout Integration";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Payment No."; "Payment No.")
                {
                    ApplicationArea = All;

                }
                field("Payment Date"; "Payment Date")
                {

                }
                field(Name; Name)
                {

                }
                field("Bank Account No"; "Bank Account No")
                {

                }
                field(Bank; Bank)
                {

                }
                field(Branch; Branch)
                {

                }
                field(Description; Description)
                {

                }
                field("Currency Code"; "Currency Code")
                {

                }
                field(Amount; Amount)
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