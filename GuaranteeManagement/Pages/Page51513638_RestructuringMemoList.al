page 51513638 "Restructuring Memo List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Restructuring Memo Header";
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    CardPageId = "Restructuring Memo";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field("Document Date"; "Document Date")
                {

                }
                field(Subject; Subject)
                {

                }
                field("Contract No."; "Contract No.")
                {

                }
                field(Name; Name)
                {

                }
                field("Search Name"; "Search Name")
                {

                }
                field("Loan Amount"; "Loan Amount")
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