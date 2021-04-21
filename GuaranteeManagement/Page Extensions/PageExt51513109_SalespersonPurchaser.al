pageextension 51513109 "Salespersons/Purchasers Ext" extends "Salespersons/Purchasers"
{
    Caption = 'PASS Profesionals';

    layout
    {
        // Add changes to page layout here
        addlast(Control1)
        {
            field("CGC Signatory"; "CGC Signatory")
            {

            }
            field("Postal Address"; "Postal Address")
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