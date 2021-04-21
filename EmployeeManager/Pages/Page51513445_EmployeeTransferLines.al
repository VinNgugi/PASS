page 51513445 "Employee Transfer Lines"
{
    // version HR

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Employee Transfer Lines";
    Caption = 'Employee Transfer Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No."; "Employee No.")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                }
                field("Current Job Title"; "Current Job Title")
                {
                }
                field("Curent Department"; "Curent Department")
                {
                }
                field("New Job Title"; "New Job Title")
                {
                }
                field("New Department"; "New Department")
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


}

