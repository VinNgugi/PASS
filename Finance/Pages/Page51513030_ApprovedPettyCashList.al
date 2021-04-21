page 51513030 "Approved PettyCash List"
{
    PageType = List;
    Caption = 'Approved Petty Cash List';
    UsageCategory = Lists;
    SourceTable = "Payments HeaderFin";
    Editable = false;
    DeleteAllowed = false;
    CardPageId = "Approved Petty Cash";
    SourceTableView = WHERE ("Payment Type" = CONST ("Petty Cash"), Posted = CONST (false), Status = FILTER (Released));
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
            systempart(Link; Links)
            {

            }
            systempart(Note; Notes)
            {

            }
        }

    }
    trigger OnOpenPage()

    begin
        //FILTERGROUP(10);
        //SETRANGE(Cashier, UserId);
        //FILTERGROUP(0);
    end;

}