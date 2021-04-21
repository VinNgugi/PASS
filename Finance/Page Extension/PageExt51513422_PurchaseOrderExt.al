pageextension 51513422 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        addbefore("Posting Date")
        {
            field("Requisition No."; "Requisition No.")
            {

            }
        }
    }

}