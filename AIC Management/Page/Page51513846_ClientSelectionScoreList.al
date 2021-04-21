page 51513846 "Client Selection Score List"
{
    PageType = List;
    SourceTableView = sorting ("Application ID") where (Submitted = filter (true), Qualified = filter (true), Shortlisted = filter (false));
    //UsageCategory = Lists;
    SourceTable = "Non-Wall Applications";
    CardPageId = "Client Selection Score Card";
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Application ID"; "Application ID")
                {


                }
                field("Application Date"; "Application Date")
                {

                }
                field("Application Time"; "Application Time")
                {

                }
                field("Business Name"; "Business Name")
                {

                }
                field("Business Email"; "Business Email")
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

}