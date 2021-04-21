page 51513574 "Purchase Requisitions List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Requisition Header";
    CardPageId = "Requisition Header";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field("Employee Code"; "Employee Code")
                {

                }
                field("Employee Name"; "Employee Name")
                {

                }
                field("Purchase Name"; "Purchase Name")
                {

                }

                field("Requisition Date"; "Requisition Date")
                {

                }
                field(Status; Status)
                {

                }
                field("Raised by"; "Raised by")
                {

                }
                field(Ordered; Ordered)
                {

                }
            }
        }
        area(Factboxes)
        {
            systempart(link; Links)
            {

            }
            systempart(note; Notes)
            {

            }
        }
    }

    trigger OnOpenPage()
    begin
        SetRange("Raised by", UserId);
    end;

}