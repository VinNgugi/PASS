page 51513008 "Imprest Surrender List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payments HeaderFin";
    Caption = 'Imprest Retirement List';
    Editable = false;
    DeleteAllowed = false;
    CardPageId = "Imprest Surrender";
    SourceTableView = WHERE ("Surrender Type" = filter (Surrender), Surrendered = FILTER (false), Status = filter (<> Released));
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

    trigger OnOpenPage()
    begin
        FILTERGROUP(10);
        SETRANGE(Cashier, UserId);
        FILTERGROUP(0);
    end;
}