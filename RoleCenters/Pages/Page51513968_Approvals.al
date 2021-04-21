page 51513968 "Approval Activities"
{
    PageType = ListPart;
    Caption = 'Approvals Activities';
    SourceTable = "Credit Guarantee Cue";

    layout
    {
        area(Content)
        {
            CueGroup(Approvals)
            {

                Field("Requests to Approve"; "Requests to Approve")
                {
                    ApplicationArea = "#Suite";
                    DrillDownPageId = "Requests to Approve";
                    ToolTip = 'Specifies the number of approval requests that require your approval.';
                }
                field("My Approval Requests"; "My Approval Requests")
                {
                    ApplicationArea = "#Suite";
                    DrillDownPageId = "Approval Entries";
                    ToolTip = 'Specifies the number of your approval requests pending approval.';

                }

            }
        }

    }

    trigger OnOpenPage()
    begin

        SETFILTER("User Filter", USERID);
        SETFILTER("Date Filter", FORMAT(WORKDATE));
        if not Get then begin
            Init();
            Insert();
        end;
    end;
}
