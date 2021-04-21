page 51513113 "Email Sent"
{
    // version PAYROLL

    PageType = List;
    SourceTable = "Email Sent";
    Caption = 'Email Sent';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field("Recepient Email"; "Recepient Email")
                {
                }
                field("Sender Email"; "Sender Email")
                {
                }
                field("Subject REF"; "Subject REF")
                {
                }
                field("Date Sent"; "Date Sent")
                {
                }
                field(Sender; Sender)
                {
                }
                field("Time Sent"; "Time Sent")
                {
                }
            }
        }
    }

    actions
    {
    }
}

