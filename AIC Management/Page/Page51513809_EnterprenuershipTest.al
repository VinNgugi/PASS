page 51513809 "Enterprenuership Test"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Enterprenuership Test";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Test Code"; "Test Code")
                {
                    ApplicationArea = All;

                }
                field("Test Question"; "Test Question")
                {
                    MultiLine = true;
                }
                field("Answer Prefix"; "Answer Prefix")
                {
                    MultiLine = true;
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
            action("Test Options")
            {
                ApplicationArea = All;
                Image = Answers;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                RunObject = page "Enterprenuership Test Options";
                RunPageLink = "Test Code" = field ("Test Code");

            }
        }
    }
}