page 51513452 "Training Plan List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Training Plan";
    CardPageId = "Plan Card";
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Request No."; "Request No.")
                {
                    ApplicationArea = All;

                }
                field("Budget Code"; "Budget Code")
                {

                }
                field("Training Description"; "Training Description")
                {

                }
                field("Training Start Date"; "Training Start Date")
                {

                }
                field("Training End Date"; "Training End Date")
                {

                }
                field("Training Type"; "Training Type")
                {

                }
                field("Created By"; "Created By")
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