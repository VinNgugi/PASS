page 51513990 "Job Applicants Qualified List"
{
    CardPageID = "Job Applicants Qualified Card";
    Editable = false;

    PageType = List;
    SourceTable = "Job Applicants";
    SourceTableView = WHERE (Qualified = FILTER (true));
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field("Application Date"; "Application Date")
                {
                }
                field("Job ID"; "Job ID")
                {
                    Caption = 'Job Requisition No';
                }
                field("Job Applied for"; "Job Applied for")
                {
                }
                field("Job Applied for Description"; "Job Applied for Description")
                {
                }
                field("Date of Interview"; "Date of Interview")
                {
                }
                field("Interview Start Time"; "Interview Start Time")
                {
                }
                field("Interview End Time"; "Interview End Time")
                {
                }
                field(Venue; Venue)
                {
                }
            }
        }
    }

    actions
    {
    }
}

