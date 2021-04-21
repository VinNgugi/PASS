page 51513810 "Enterprenuership Test Options"
{
    PageType = List;
    //ApplicationArea = All;
    //UsageCategory = Lists;
    SourceTable = "Enterprenuership Test Options";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Test Code"; "Test Code")
                {
                    ApplicationArea = All;

                }
                field("Option Code"; "Option Code")
                {

                }
                field("Option Text"; "Option Text")
                {
                    MultiLine = true;
                }
                field("Weighted Score"; "Weighted Score")
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