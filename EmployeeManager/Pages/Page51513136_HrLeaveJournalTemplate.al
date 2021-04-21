page 51513136 "Hr Leave Journal Template Name"
{
    PageType = List;
    SourceTable = "HR Leave Journal Template";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Name; Name)
                {

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
            action(Batches)
            {
                Image = ChangeBatch;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "HR Leave Batches";
                RunPageLink = "Journal Template Name" = field (Name);

                trigger OnAction();
                begin

                end;
            }
        }
    }
}