page 51513812 "Residential Selection(AIC)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = false;
    Editable = false;
    SourceTable = Incubation;
    SourceTableView = sorting ("No.") order(ascending) where (Status = filter (Released));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }

                field("Document Date"; "Document Date")
                {

                }
                field(Name; Name)
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {

                }

                field("Requested By"; "Requested By")
                {

                }
                field(Status; Status)
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
            action("Applicants List")
            {
                Image = Employee;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "AIC Applicants";
                RunPageLink = "Incubation Code" = field ("No."), Submitted = const (true);
            }
        }
    }
}