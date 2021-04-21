page 51513704 Shortlisting
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Recruitment Needs";
    SourceTableView = where ("Dept Requisition Type" = filter ("Normal Employment"));
    Caption = 'Shortlisting';
    Editable = true;
    CardPageId = "Shortlisting Card";

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
                field(Position; Position)
                {

                }
                field(Stage; Stage)
                {

                }
                field(Score; Score)
                {

                }
            }
        }
    }

}