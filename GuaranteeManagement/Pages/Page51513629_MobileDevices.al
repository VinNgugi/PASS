page 51513629 "Mobile Devices"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Mobile Devices";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {

                }
                field(IMEI; IMEI)
                {

                }
                field(Comments; Comments)
                {

                }
                field("Date Entered"; "Date Entered")
                {

                }
                field("Time Entered"; "Time Entered")
                {

                }
                field("User ID"; "User ID")
                {

                }
                field(Blocked; Blocked)
                {

                }
                field("Date Blocked"; "Date Blocked")
                {

                }
                field("Blocked By"; "Blocked By")
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}