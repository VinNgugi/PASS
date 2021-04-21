page 51514002 "Pending Claim List"
{
    PageType = List;
    CardPageId = "Pending Claim Card";
    UsageCategory = Lists;
    SourceTable = Claim;
    Editable = false;
    // ModifyAllowed = false;
    SourceTableView = sorting("No.") where("Approval Status" = filter("Pending Approval"));
    Caption = 'Pending Claim List';
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