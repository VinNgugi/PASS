page 51513155 "Employee Leaves"
{
    // version HR

    PageType = Document;
    SourceTable = Employee;
    Caption = 'Employee Leaves';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
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

    actions
    {
    }
}

