page 51513156 "Employee Leave Assignment"
{
    // version HR

    PageType = ListPart;
    SourceTable = "Employee Leave Entitlement";
    Caption = 'Employee Leave Assignment';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Leave Code"; "Leave Code")
                {
                }
                field("Maturity Date"; "Maturity Date")
                {
                }
                field(Entitlement; Entitlement)
                {
                }
                field("Total Days Taken"; "Total Days Taken")
                {
                }
                field("Balance Brought Forward"; "Balance Brought Forward")
                {
                }
                field("Recalled Days"; "Recalled Days")
                {
                }
                field(Balance; Balance)
                {
                }
                field("Employee No"; "Employee No")
                {
                }
            }
        }
    }

    actions
    {
    }
}

