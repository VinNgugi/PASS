page 51513316 "Employee Dependants"
{
    Caption = 'Employee Dependants';
    PageType = Card;
    SourceTable = Employee;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {

                }
                field("First Name"; "First Name")
                {

                }
                field("Middle Name"; "Middle Name")
                {

                }
                field("Last Name"; "Last Name")
                {

                }
                field(Initials; Initials)
                {

                }
                field("ID Number"; "ID Number")
                {

                }
                field(Gender; Gender)
                {

                }
                field(Position; Position)
                {

                }
                field("Employment Date"; "Employment Date")
                {

                }
            }
            part("Employee Beneficiaries Lines"; "Employee Beneficiaries Lines")
            {
                SubPageLink = "Employee Code" = FIELD ("No.");
            }
        }

    }
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}