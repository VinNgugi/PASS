page 51513887 "Transaction Type"
{
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Transaction Types";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {

                }
                field("Transaction Name"; "Transaction Name")
                {

                }
                field("Account Type"; "Account Type")
                {

                }
                field("Account No."; "Account No.")
                {

                }
                field("Transaction Ref"; "Transaction Ref")
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