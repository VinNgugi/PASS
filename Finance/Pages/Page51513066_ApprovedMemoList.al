page 51513066 "Approved Memo List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Memo Request Header";
    SourceTableView = sorting("Request No.") order(ascending) where("Approval Status" = filter(Approved));
    CardPageId = "Memo Card";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Request No."; "Request No.")
                {
                    ApplicationArea = All;

                }
                field("Creation Date"; "Creation Date")
                {

                }
                field("Creation Time"; "Creation Time")
                {

                }
                field("Trip Name"; "Trip Name")
                {

                }
                field("Trip Description"; "Trip Description")
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        /*FILTERGROUP(2);
        SETRANGE("Created By", USERID);
        FILTERGROUP(0);*/
    end;
}