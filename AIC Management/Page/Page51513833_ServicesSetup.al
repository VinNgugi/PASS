page 51513833 "Services Types"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Services Types";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Service No"; "Service No")
                {
                    ApplicationArea = All;

                }
                field("Service Name"; "Service Name")
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