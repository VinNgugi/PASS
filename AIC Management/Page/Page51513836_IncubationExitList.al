page 51513836 "Incubates Exit List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Incubates Register";
    CardPageId = "Incubates Exit Card";
    InsertAllowed = false;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                }
                field("Middle Name"; "Middle Name")
                {
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                }
                field("Job ID"; "Job ID")
                {
                    Editable = false;
                }
                field("Job Description"; "Job Description")
                {
                    Editable = false;
                }
                field("Date of Exit"; "Date of Exit")
                {

                }
                field("Incubate Type"; "Incubate Type")
                {
                    Editable = false;
                }
                field("Incubation Start Date"; "Incubation Start Date")
                {

                }
                field("Incubation Period"; "Incubation Period")
                {

                }
                field("Incubation End Date"; "Incubation End Date")
                {

                }

            }
        }

    }
}