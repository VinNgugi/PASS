page 51513610 "Investment Types"
{
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Investment Types";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {

                }
                field(Name; Name)
                {

                }
                field("Interest Receivable Account"; "Interest Receivable Account")
                {

                }
                field("Interest Income Account"; "Interest Income Account")
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