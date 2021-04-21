page 51513594 "Green Activities Setup"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Green Activities Setup";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry Code"; "Entry Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
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