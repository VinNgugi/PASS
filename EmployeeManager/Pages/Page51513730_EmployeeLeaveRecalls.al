page 51513730 "Employee Leave Recalls"
{
    PageType = ListPart;
    SourceTable = "Leave Recall";
    Caption = 'Employee Leave Recalls';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Employee No"; "Employee No")
                {
                }
                field(Date; Date)
                {
                }
                field("Leave Application"; "Leave Application")
                {
                }
                field("Recall Date"; "Recall Date")
                {
                }
                field("No. of Off Days"; "No. of Off Days")
                {
                }
                field("Recalled By"; "Recalled By")
                {
                }
                field("Reason for Recall"; "Reason for Recall")
                {
                }
                field("Recalled From"; "Recalled From")
                {
                }
                field("Recalled To"; "Recalled To")
                {
                }
            }
        }
    }

    actions
    {
    }
}

