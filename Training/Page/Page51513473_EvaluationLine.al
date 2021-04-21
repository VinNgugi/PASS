page 51513473 "Evaluation Lines"
{
    PageType = ListPart;
    SourceTable = "Training Evaluation Line";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Header No."; "Header No.")
                {

                }
                field("Evaluation Area"; "Evaluation Area")
                {
                    ApplicationArea = All;

                }

                field("Evaluation Question"; "Evaluation Question")
                {

                }
                field("Evaluation Option"; "Evaluation Option")
                {

                }
                field("Evaluation Points"; "Evaluation Points")
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