page 51513444 "Employee Transfer Card"
{
    // version HR

    PageType = Card;
    SourceTable = "Employee Transfer Header";
    Caption = 'Employee Transfer Card';


    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Date Created"; "Date Created")
                {
                    Editable = false;
                }
                field("Effective Transfer Date"; "Effective Transfer Date")
                {
                }
            }
            part(Control6; "Employee Transfer Lines")
            {
                SubPageLink = "Transfer No" = FIELD ("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send for Approval")
            {
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    if CONFIRM('Are you sure you want to send approval request?') = true then begin
                        TESTFIELD(Status, Status::Open);
                        Status := Status::"Pending Approval";
                        MODIFY;
                    end;
                end;
            }
        }
    }
}

