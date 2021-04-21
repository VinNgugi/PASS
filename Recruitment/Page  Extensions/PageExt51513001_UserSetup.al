pageextension 51513001 "User Setup Ext" extends "User Setup"
{
    layout
    {
        addafter(Email)
        {
            field("Employee No."; "Employee No.")
            {

            }
            field("Immediate Supervisor"; "Immediate Supervisor")
            {

            }
            field("Imprest Account"; "Imprest Account")
            {

            }
            field(Picture; Picture)
            {
                Caption = 'Signature';
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