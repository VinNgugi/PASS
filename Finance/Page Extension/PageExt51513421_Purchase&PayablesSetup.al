pageextension 51513421 "Purchase & Payables Setup Ext" extends "Purchases & Payables Setup"
{
    layout
    {
        addlast("Number Series")
        {
            field("Purchase Req No"; "Purchase Req No")
            {

            }
            field("Effective Procurement Plan"; "Effective Procurement Plan")
            {

            }
            field("Store Requisition Nos."; "Store Requisition Nos.")
            {

            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}