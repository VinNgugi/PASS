page 51513847 "Deep Dive Analysis Card"
{
    PageType = Card;
    //Editable = false;
    UsageCategory = Tasks;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Non-Wall Applications";
    SourceTableView = sorting ("Application ID") where (Submitted = filter (true), Qualified = filter (true), Shortlisted = filter (true));
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
                field("Deep Dive Analysis Done"; "Deep Dive Analysis Done")
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
            part("Attached Documents"; "Document Attachment Factbox")
            {
                SubPageLink = "Table ID" = CONST (51513803), "No." = FIELD ("Application ID");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Attachments)
            {
                ApplicationArea = All;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GETTABLE(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RUNMODAL;
                end;
            }
        }
    }
}