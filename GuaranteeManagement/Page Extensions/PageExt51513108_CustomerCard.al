pageextension 51513108 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(Invoicing)
        {
            field("Linkage Risk Sharing fee %"; "Linkage Risk Sharing fee %")
            {

            }
            field("Traditional Risk Sharing fee %"; "Traditional Risk Sharing fee %")
            {

            }

        }
        addfirst(Invoicing)
        {
            field("Customer TIN"; "Customer TIN")
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