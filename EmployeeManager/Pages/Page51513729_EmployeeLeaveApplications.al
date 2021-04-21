page 51513729 "Employee Leave Applications"
{
    PageType = ListPart;
    SourceTable = "Employee Leave Application";
    Caption = 'Employee Leave Applications';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; "Employee No")
                {
                }
                field("Application No"; "Application No")
                {
                }
                field("Leave Code"; "Leave Code")
                {
                }
                field("Days Applied"; "Days Applied")
                {
                }
                field("Start Date"; "Start Date")
                {
                }
                field("End Date"; "End Date")
                {
                }
                field(Status; Status)
                {
                }
                field("Balance brought forward"; "Balance brought forward")
                {
                }
            }
        }
    }

    actions
    {
    }
}

