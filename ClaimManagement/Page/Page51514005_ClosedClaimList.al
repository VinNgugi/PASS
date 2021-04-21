page 51514005 "Closed Claim List"
{
    PageType = List;
    CardPageId = "Closed Claim Card";
    UsageCategory = History;
    SourceTable = Claim;
    Editable = false;
    // ModifyAllowed = false;
    Caption = 'Closed Claim List';
    SourceTableView = sorting ("No.") where (Status = filter (Close));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    Caption = 'No.';

                }
                field("Claim Type"; "Claim Type")
                {
                    Visible = false;
                }
                field("Claim Date"; "Claim Date")
                {

                }
                field("Customer No."; "Customer No.")
                {

                }
                field("Customer Name"; "Customer Name")
                {

                }
            }
        }
        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {

            }
            systempart(Links; Links)
            {

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

                trigger OnAction();
                begin

                end;
            }
        }
    }
}