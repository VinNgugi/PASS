page 51513737 "Job Exit Interview List"
{
    CardPageID = "Job Exit Interview Card";
    PageType = List;
    SourceTable = "Job Exit Interview";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                }
                field(Position; Position)
                {
                }
                field(Supervisor; Supervisor)
                {
                }
                field("Date of Join"; "Date of Join")
                {
                }
                field("Termination Date"; "Termination Date")
                {
                }
                field("Future Re-Employment"; "Future Re-Employment")
                {
                }
                field("Leaving could have prevented"; "Leaving could have prevented")
                {
                }
            }
        }
    }

    actions
    {
    }
}

