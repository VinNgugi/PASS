page 51513607 "Investment List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Investment Header";
    SourceTableView = where ("FD Status" = filter (" "));
    DeleteAllowed = false;
    CardPageId = Investment;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field(Description; Description)
                {

                }
                field("Document Date"; "Document Date")
                {

                }
                field("Investment Start Date"; "Investment Start Date")
                {

                }
                field("Investment Duration"; "Investment Duration")
                {

                }
                field("Investment End Date"; "Investment End Date")
                {

                }
                field("Investment Rate"; "Investment Rate")
                {

                }
                field("FD Status"; "FD Status")
                {

                }
                field("Investment Principal"; "Investment Principal")
                {

                }
                field("Investment Principle(LCY)"; "Investment Principle(LCY)")
                {

                }
                field("Source Bank"; "Source Bank")
                {

                }
                field("Source Bank Name"; "Source Bank Name")
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