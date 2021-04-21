page 51513140 "Employee Leave-List"
{
    PageType = List;

    SourceTable = Employee;
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    CardPageId = "Employee Leaves";
    Caption = 'Employee Leave-List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
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
                field("Contract Type"; "Contract Type")
                {
                }
                field("Employment Date"; "Employment Date")
                {
                }
            }
            part(Control1000000028; "Employee Leave Assignment")
            {
                SubPageLink = "Employee No" = FIELD ("No.");
            }
        }

    }

}

