page 51513728 "Employee Leave Records"
{
    PageType = List;
    SourceTable = Employee;
    Caption = 'Employee Leave Records';
    Editable = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
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
                field("Job Title"; "Job Title")
                {
                }
                field("Phone No."; "Phone No.")
                {
                }
                field("ID Number"; "ID Number")
                {
                }

            }


            part(Control12; "Employee Leave Applications")
            {
                Caption = 'Leaves';
                SubPageLink = "Employee No" = FIELD ("No.");
            }
            part(Control14; "Employee Leave Recalls")
            {
                Caption = 'Recalls';
                SubPageLink = "Employee No" = FIELD ("No.");

            }
            part(Control16; "Employee Absentism Line")
            {
                Caption = 'Absence';
                SubPageLink = "Employee No" = FIELD ("No.");
            }

        }
    }


}

