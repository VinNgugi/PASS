page 51513038 "PostedImprestRequisitionList"
{
    PageType = List;
    Caption = 'Posted Imprest Requisition List';
    UsageCategory = History;
    SourceTable = "Payments HeaderFin";
    Editable = false;
    DeleteAllowed = false;
    SourceTableView = WHERE("Payment Type" = CONST("Imprest Requisitioning"), Posted = CONST(true));
    CardPageId = "PostedImprestRequisitioning";
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
                field("Payment Type"; "Payment Type")
                {

                }
                field(Surrendered; Surrendered)
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