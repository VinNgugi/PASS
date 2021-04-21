page 51513628 "Fee Waiver Aapplication List"
{
    PageType = List;
    UsageCategory = Tasks;
    SourceTable = "Fee Waiver Application";
    Caption = 'Fee Waiver Application List';
    CardPageId = 51513605;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field("Application Date"; "Application Date")
                {

                }
                field("Waive all fees"; "Waive all fees")
                {

                }
                field("Fee Type"; "Fee Type")
                {

                }
                field("Client No."; "Client No.")
                {

                }
                field("Client Name"; "Client Name")
                {

                }
                field(Reason; Reason)
                {

                }
                field(Status; Status)
                {

                }
            }
        }
        area(Factboxes)
        {
            systempart(Notes; Notes)
            {

            }
            systempart(Links; Links)
            {

            }
        }
    }



}