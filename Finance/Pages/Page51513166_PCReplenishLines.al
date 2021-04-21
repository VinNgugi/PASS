page 51513166 "PC Replenish Lines"
{
    PageType = ListPart;
    SourceTable = "InterBank Transfer Lines";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Bank Account"; "Bank Account")
                {
                    ApplicationArea = All;

                }
                field("Bank Acc. Name"; "Bank Acc. Name")
                {

                }
                field("Account Balance"; "Account Balance")
                {

                }
                field(Amount; Amount)
                {

                }
                field("Amount (LCY)"; "Amount (LCY)")
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