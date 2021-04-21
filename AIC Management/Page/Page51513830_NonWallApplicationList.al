page 51513830 "Nonwall Application List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Non-Wall Applications";
    CardPageId = "Non-Wall Application Card";
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Application ID"; "Application ID")
                {
                    ApplicationArea = All;

                }
                field("Application Date"; "Application Date")
                {

                }
                field("Application Time"; "Application Time")
                {

                }
                field("Business Name"; "Business Name")
                {

                }
                field("Business Email"; "Business Email")
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