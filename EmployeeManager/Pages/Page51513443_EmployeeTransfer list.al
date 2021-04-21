page 51513443 "Employee Transfer list"
{
    // version HR

    CardPageID = "Employee Transfer Card";
    PageType = List;
    SourceTable = "Employee Transfer Header";
    Caption = 'Employee Transfer list';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Date Created"; "Date Created")
                {
                }
                field("Effective Transfer Date"; "Effective Transfer Date")
                {
                }
            }
        }
    }

}

