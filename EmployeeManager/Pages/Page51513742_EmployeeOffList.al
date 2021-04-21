page 51513742 "Employee Off List"
{
    PageType = List;
    SourceTable = "Holidays_Off Days";
    Caption = 'Employee Off List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Date; Date)
                {
                }
                field(Description; Description)
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                }
                field("Leave Type"; "Leave Type")
                {
                }
                field("Maturity Date"; "Maturity Date")
                {
                }
                field("No. of Days"; "No. of Days")
                {
                }
                field("Reason for Off"; "Reason for Off")
                {
                }
                field("Approved to Work"; "Approved to Work")
                {
                }
            }
        }
    }

    actions
    {
    }
}

