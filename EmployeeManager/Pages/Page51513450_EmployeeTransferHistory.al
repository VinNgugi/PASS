page 51513450 "Employee Transfer History"
{
    // version HR

    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Employee Transfer Lines";
    Caption = 'Employee Transfer History';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; "Line No.")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                }
                field("Current Job Title"; "Current Job Title")
                {
                }
                field("New Job Title"; "New Job Title")
                {
                }
                field("Transfer Type"; "Transfer Type")
                {
                }
                field(Remark; Remark)
                {
                }
            }
        }
    }

    actions
    {
    }
}

