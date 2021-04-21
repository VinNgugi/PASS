page 51513296 Advertisements
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Recruitment Needs";
    Editable = false;
    CardPageId = "Advertising Header";
    SourceTableView = sorting ("No.") where (Status = filter (Released));
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field("Job ID"; "Job ID")
                {

                }
                field(Description; Description)
                {

                }
                field(Date; Date)
                {

                }
                field(Position; Position)
                {

                }
                field(Approved; Approved)
                {

                }
                field("Date Approved"; "Date Approved")
                {

                }
                field("Start Date"; "Start Date")
                {

                }
                field("End Date"; "End Date")
                {

                }
                field(Status; Status)
                {

                }
                field("Requisition Type"; "Requisition Type")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Expected Reporting Date"; "Expected Reporting Date")
                {

                }
            }
        }

    }
}