page 51513545 "No.Series Buffer"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "No. Series Buffer";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Document Type"; "Document Type")
                {

                }
                field("No. Series"; "No. Series")
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