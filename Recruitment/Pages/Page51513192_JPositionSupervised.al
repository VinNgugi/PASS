page 51513192 "J. Position Supervised"
{
    PageType = Card;
    SourceTable = "Company Jobs";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Job ID"; "Job ID")
                {

                }
                field("Job Description"; "Job Description")
                {

                }
            }
            part(PositionSupervised; "Position Supervised")
            {
                SubPageLink = "Job ID" = FIELD ("Job ID");
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

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}