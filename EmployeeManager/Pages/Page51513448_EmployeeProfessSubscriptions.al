page 51513448 "Employee Profess Subscriptions"
{
    // version HR

    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Employee Professional Bodies";
    Caption = 'Employee Profess Subscriptions';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Employee; Employee)
                {
                }
                field("Proffesional Body"; "Proffesional Body")
                {
                }
                field("Professional Body Name"; "Professional Body Name")
                {
                    Editable = false;
                }
                field("Date of Join"; "Date of Join")
                {
                }
                field("Annual Fee"; "Annual Fee")
                {
                }
                field("Date of Leaving"; "Date of Leaving")
                {
                }
                field(Status; Status)
                {
                }
            }
        }
    }

}

