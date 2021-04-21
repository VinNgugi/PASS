page 51513251 "Casuals Payment List"
{
    CardPageID = "Casuals Payments";
    PageType = List;
    SourceTable = "Casuals Payments";
    Caption = 'Casuals Payment List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field("Payroll Period"; "Payroll Period")
                {
                }
                field(Unit; Unit)
                {
                }
                field("Date Prepared"; "Date Prepared")
                {
                }
                field("Unit Name"; "Unit Name")
                {
                }
                field("User ID"; "User ID")
                {
                }
                field(Status; Status)
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
            }
        }
    }

    actions
    {
    }
}

