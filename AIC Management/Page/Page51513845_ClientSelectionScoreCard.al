page 51513845 "Client Selection Score Card"
{
    PageType = Card;
    //Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Non-Wall Applications";
    SourceTableView = sorting ("Application ID") where (Submitted = filter (true), Qualified = filter (true), Shortlisted = filter (false));
    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = false;
                field("Application ID"; "Application ID")
                {

                }
                field("Applicant Name"; "Applicant Name")
                {

                }
                field("Application Date"; "Application Date")
                {

                }
                field("Application Time"; "Application Time")
                {

                }
                field(Submitted; Submitted)
                {

                }
                field("Enterpreneurship Test Score"; "Enterpreneurship Test Score")
                {

                }
                field("WIF Total Score"; "WIF Total Score")
                {

                }

            }
            part(WIFTest; "WIF Test Entry")
            {
                Caption = 'Will it Fly Questions';
                SubPageLink = "Application ID" = field ("Application ID");
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
            action("Proceed to Deep Dive Analysis")
            {
                Image = MoveToNextPeriod;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    if not "Application fee Paid" then
                        Error('%1 has not paid application fee', "Business Name")
                    else begin
                        Shortlisted := true;
                        Modify();
                        Message('%1 successfully moved to deep dive analysis stage');
                    end;

                end;
            }
        }
    }
}