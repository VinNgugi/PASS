page 51513165 "Employee Leave Buffer"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Leave Balance Buffer";

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;

                }
                field("Leave Code"; "Leave Code")
                {

                }
                field(Balance; Balance)
                {

                }
                field("Days taken"; "Days taken")
                {

                }
                field(Entitlement; Entitlement)
                {

                }
                field("Recalled Days"; "Recalled Days")
                {

                }
                field("Days Credited Back"; "Days Credited Back")
                {

                }
                field("Balance Brought Forward"; "Balance Brought Forward")
                {

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}