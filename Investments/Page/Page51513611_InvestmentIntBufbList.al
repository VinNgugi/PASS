page 51513611 "Investment Interest Buffer"
{
    PageType = List;
    SourceTable = "Investment Interest Buffer";
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No"; "Entry No")
                {

                }
                field("Document No."; "Document No.")
                {

                }
                field("Interest Date"; "Interest Date")
                {

                }
                field("Interest Amount"; "Interest Amount")
                {

                }
                field("W/H Tax Amount"; "W/H Tax Amount")
                {

                }
                field("Captured By"; "Captured By")
                {

                }
                field(Transfered; Transfered)
                {

                }
                field("Transfered By"; "Transfered By")
                {

                }
                field("Date Transfered"; "Date Transfered")
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