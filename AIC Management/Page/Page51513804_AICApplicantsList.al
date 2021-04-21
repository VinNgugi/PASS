page 51513804 "AIC Applicants List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Incubation Applicants";
    SourceTableView = sorting("No.") order(ascending);
    Editable = false;
    Caption = 'AIC Applicants List';
    CardPageId = "AIC Applicant Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {

                }
                field(Name; Name)
                {

                }

                field("Incubation Code"; "Incubation Code")
                {

                }
                field("Incubation Name"; "Incubation Name")
                {

                }
                field(Submitted; Submitted)
                {

                }

                field("E-Mail"; "E-Mail")
                {

                }
                field("Application Date"; "Application Date")
                {

                }
            }
        }

    }
}