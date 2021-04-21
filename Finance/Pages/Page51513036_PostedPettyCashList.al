page 51513036 "Posted PettyCash List"
{
    PageType = List;
    Caption = 'Posted PettyCash List';
    UsageCategory = History;
    SourceTable = "Payments HeaderFin";
    Editable = false;
    DeleteAllowed = false;
    CardPageId = "Posted Petty Cash";
    SourceTableView = WHERE ("Payment Type" = CONST ("Petty Cash"), Posted = CONST (true), Status = FILTER (Released));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field(Date; Date)
                {

                }
                field(Payee; Payee)
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field(Cashier; Cashier)
                {

                }
                field(Posted; Posted)
                {

                }
                field("Posted By"; "Posted By")
                {

                }
                field("Posted Date"; "Posted Date")
                {

                }
            }

        }
        area(FactBoxes)
        {
            systempart(Link; Links)
            {

            }
            systempart(Note; Notes)
            {

            }
        }
    }


}