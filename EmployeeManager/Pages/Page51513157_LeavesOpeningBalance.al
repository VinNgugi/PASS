page 51513157 "Leaves Opening Balance"
{
    // version HR

    PageType = List;
    SourceTable = "Employee Leave Entitlement";
    Caption = 'Leaves Opening Balance';
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Employee No"; "Employee No")
                {
                }
                field("Leave Code"; "Leave Code")
                {
                }
                field("Maturity Date"; "Maturity Date")
                {
                }
                field(Balance; Balance)
                {
                }
                field("Acrued Days"; "Acrued Days")
                {
                }
                field("Total Days Taken"; "Total Days Taken")
                {
                    Editable = false;
                }
                field(Entitlement; Entitlement)
                {
                }
                field("Balance Brought Forward"; "Balance Brought Forward")
                {
                }
                field("Recalled Days"; "Recalled Days")
                {
                    Editable = false;
                }
            }
        }
    }


}

