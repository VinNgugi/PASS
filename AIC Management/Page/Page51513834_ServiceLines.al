page 51513834 "Service Type Line List"
{
    PageType = ListPart;
    SourceTable = "Service Type Line";

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