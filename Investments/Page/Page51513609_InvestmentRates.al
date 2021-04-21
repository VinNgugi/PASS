page 51513609 "Investment Rates"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Investment Rates";


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Type; Type)
                {

                }
                field(Code; Code)
                {

                }
                field(Rate; Rate)
                {

                }
            }
        }
        area(Factboxes)
        {
            systempart(Notes; Notes)
            {

            }
            systempart(Link; Links)
            {

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