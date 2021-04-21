page 51513039 "Imprest Rates"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Imprest Rates";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Imprest Code"; "Imprest Code")
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {

                }
                field(Amount; Amount)
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