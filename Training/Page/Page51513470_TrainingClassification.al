page 51513470 "Training Classification"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Training Classification";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Code."; "Code.")
                {
                    ApplicationArea = All;

                }
                field(Type; Type)
                {

                }
                field("Account No"; "Account No")
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