page 51513162 "Employee Absence List"
{
    // version HR

    CardPageID = "Employee Absentism Card";
    PageType = List;
    SourceTable = "Employee Absentism";
    Caption = 'Employee Absence List';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Absent No."; "Absent No.")
                {
                }
                field("Employee No"; "Employee No")
                {
                }
                field("Absent From"; "Absent From")
                {
                }
                field("Absent To"; "Absent To")
                {
                }
                field("Absentism code"; "Absentism code")
                {
                }
                field("No. of  Days Absent"; "No. of  Days Absent")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                }
                field("Reason for Absentism"; "Reason for Absentism")
                {
                }
                field(Penalty; Penalty)
                {
                }
            }
        }
    }

    actions
    {
    }
}

