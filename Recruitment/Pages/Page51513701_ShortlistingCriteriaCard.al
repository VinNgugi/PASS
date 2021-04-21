page 51513701 "Shortlisting Criteria Card"
{
    PageType = Card;
    Caption = 'Shortlisting Criteria Card';
    SourceTable = "Recruitment Needs";
    SourceTableView = where ("Dept Requisition Type" = filter ("Normal Employment"));
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {


                }
                field("Job ID"; "Job ID")
                {

                }
                field(Position; Position)
                {

                }
            }
            part(ShortListingCriteriaLines; "ShortListing Criteria Lines")
            {
                SubPageLink = "Need Code" = FIELD ("No."), "Job ID" = FIELD ("Job ID");
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