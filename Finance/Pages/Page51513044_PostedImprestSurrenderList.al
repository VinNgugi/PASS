page 51513044 "PostedImprestSurrenderList"
{
    PageType = List;
    UsageCategory = History;
    SourceTable = "Payments HeaderFin";
    Caption = 'Posted Imprest Surrender List';
    Editable = false;
    DeleteAllowed = false;
    CardPageId = "Posted Imprest Surrender";
    SourceTableView = WHERE ("Surrender Type" = FILTER (Surrender), Surrendered = FILTER (true), Status = filter (Released));
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
        area(Factboxes)
        {
            systempart(Link; Links)
            {

            }
            systempart(Notes; Notes)
            {

            }
        }
    }



}