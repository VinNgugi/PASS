page 51513069 "Pending Hotel Application List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Hotel Request Header";
    CardPageId = "Hotel Application Card";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Request No"; "Request No")
                {
                    ApplicationArea = All;

                }
                field("Created Date"; "Created Date")
                {

                }
                field("Staff No."; "Staff No.")
                {

                }
                field("Staff Name"; "Staff Name")
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
        FILTERGROUP(2);
        SETRANGE("Created By", USERID);
        FILTERGROUP(0);
    end;
}