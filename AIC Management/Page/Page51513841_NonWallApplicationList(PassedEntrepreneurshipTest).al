page 51513841 "Passed Nonwall Application"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Non-Wall Applications";
    CardPageId = "Passed NonWall ApplicationCard";
    Editable = false;
    DeleteAllowed = false;
    Caption = 'Nonwall application List(Passed Enterpreneurship Test)';
    SourceTableView = where (Submitted = filter (true), Qualified = filter (true));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Application ID"; "Application ID")
                {
                    ApplicationArea = All;

                }
                field("Application Date"; "Application Date")
                {

                }
                field("Application Time"; "Application Time")
                {

                }
                field("Business Name"; "Business Name")
                {

                }
                field("Business Email"; "Business Email")
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
}