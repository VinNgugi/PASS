page 51513811 "Enterprenuership Test Entry"
{
    PageType = ListPart;
    SourceTable = "Enterprenuership Test Entry";
    InsertAllowed = false;

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
                field("Test Code"; "Test Code")
                {

                }
                field("Test Question"; "Test Question")
                {
                    MultiLine = true;
                }
                field("Option Code"; "Option Code")
                {

                }
                field("Option Text"; "Option Text")
                {
                    MultiLine = true;
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