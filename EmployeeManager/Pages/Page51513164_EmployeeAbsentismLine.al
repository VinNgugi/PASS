page 51513164 "Employee Absentism Line"
{
    // version HR

    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Employee Absentism";
    Caption = 'Employee Absentism Line';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Absent No."; "Absent No.")
                {
                }
                field("Absent From"; "Absent From")
                {
                }
                field("Absent To"; "Absent To")
                {
                }
                field("No. of  Days Absent"; "No. of  Days Absent")
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

