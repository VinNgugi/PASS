page 51513133 "HR Leave Ledger Entries"
{
    // version HR

    Caption = 'Leave Ledger Entries';
    DataCaptionFields = "Leave Period";
    Editable = false;
    PageType = List;
    SourceTable = "HR Leave Ledger Entries";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Posting Date"; "Posting Date")
                {
                }
                field("Leave Period"; "Leave Period")
                {
                }
                field("Staff No."; "Staff No.")
                {
                }
                field("Staff Name"; "Staff Name")
                {
                }
                field("Leave Type"; "Leave Type")
                {
                }
                field("Leave Entry Type"; "Leave Entry Type")
                {
                }
                field("No. of days"; "No. of days")
                {
                }
                field("Leave Posting Description"; "Leave Posting Description")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Ent&ry")
            {
                Caption = 'Ent&ry';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    //RunObject = Page Page544;
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
        }
        area(processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    Navigate.SetDoc("Posting Date", "Document No.");
                    Navigate.RUN;
                end;
            }
        }
    }

    var
        Navigate: Page Navigate;
}

