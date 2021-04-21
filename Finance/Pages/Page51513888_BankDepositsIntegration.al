page 51513888 "Bank Paymnets Integration"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Bank Payments Integration";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Receipt No."; "Receipt No.")
                {
                    ApplicationArea = All;

                }
                field("Receipt Date"; "Receipt Date")
                {

                }
                field("Pay Mode"; "Pay Mode")
                {

                }
                field("Received From"; "Received From")
                {

                }
                field("On Behalf Of"; "On Behalf Of")
                {

                }
                field("Cheque No."; "Cheque No.")
                {

                }
                field("Cheque Date"; "Cheque Date")
                {

                }
                field("Receipting Acc. Code"; "Receipting Acc. Code")
                {

                }
                field("Guarantee Application No."; "Guarantee Application No.")
                {

                }
                field("Guarantee Entry Type"; "Guarantee Entry Type")
                {

                }
                field("Applies To Doc No."; "Applies To Doc No.")
                {

                }
                field("Currency Code"; "Currency Code")
                {

                }
                field("Pass Branch Code"; "Pass Branch Code")
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