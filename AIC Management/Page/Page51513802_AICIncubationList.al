page 51513802 "Incubation List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Incubation;
    SourceTableView = sorting ("No.") order(ascending);
    CardPageId = Incubation;
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
                field(Name; Name)
                {

                }
                field("Document Date"; "Document Date")
                {

                }
                field("Incubation Start Date"; "Incubation Start Date")
                {

                }
                field("Incubation Duration"; "Incubation Duration")
                {

                }
                field("Incubation End Date"; "Incubation End Date")
                {

                }
                field("No. of Participants"; "No. of Participants")
                {

                }
                field("Requested By"; "Requested By")
                {

                }
                field(Status; Status)
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {

                }

            }
        }


    }
}