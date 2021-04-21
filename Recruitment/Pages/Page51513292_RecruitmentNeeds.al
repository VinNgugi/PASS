page 51513292 "Recruitment Needs"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Recruitment Needs";
    SourceTableView = sorting ("No.") order(ascending) where ("Dept Requisition Type" = filter ("Normal Employment"));
    CardPageId = 51513286;
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
                field("Job ID"; "Job ID")
                {

                }
                field(Date; Date)
                {

                }
                field(Description; Description)
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Reason for Recruitment"; "Reason for Recruitment")
                {

                }
                field("Requested By"; "Requested By")
                {

                }
                field("Appointment Type"; "Appointment Type")
                {

                }
                field("Expected Reporting Date"; "Expected Reporting Date")
                {

                }
                field(Status; Status)
                {

                }
                field("Start Date"; "Start Date")
                {

                }
            }
        }


    }
}