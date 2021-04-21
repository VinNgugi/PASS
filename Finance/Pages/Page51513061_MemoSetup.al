page 51513061 "Memo Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Memo Setup";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Request Nos"; "Memo Request Nos")
                {
                    ApplicationArea = All;

                }
                field("Hotel Req Nos"; "Hotel Req Nos")
                {

                }
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