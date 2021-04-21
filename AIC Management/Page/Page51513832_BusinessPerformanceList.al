page 51513832 "Business Performance List"
{
    PageType = ListPart;
    SourceTable = "Business Performance";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Item; Item)
                {
                    ApplicationArea = All;

                }
                field("Before Last Year"; "Before Last Year")
                {

                }
                field("Last Year"; "Last Year")
                {

                }
                field("This Year"; "This Year")
                {

                }
                field("Next Year"; "Next Year")
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