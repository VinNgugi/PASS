page 51513005 "Imprest Requisition List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Payments HeaderFin";
    Editable = false;
    DeleteAllowed = false;
    SourceTableView = WHERE ("Payment Type" = CONST ("Imprest Requisitioning"), Posted = CONST (false), Status = filter (<> Released));
    CardPageId = "Imprest Requisitioning";
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
                field("Imprest Amount"; "Imprest Amount")
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