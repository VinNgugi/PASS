page 51513700 "Shortlisting Criteria List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Recruitment Needs";
    SourceTableView = where ("Dept Requisition Type" = filter ("Normal Employment"));
    Caption = 'Shortlisting Criteria List';
    Editable = false;
    CardPageId = "Shortlisting Criteria Card";
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
                field("Turn Around Time"; "Turn Around Time")
                {

                }
            }
        }

    }
}