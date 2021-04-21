page 51513800 "AIC Company Job List"
{
    PageType = List;
    // UsageCategory = Lists;
    SourceTable = "Company Jobs";
    SourceTableView = order(ascending) where("Job Funcion" = filter("AIC Job"));
    CardPageId = "AIC Company Jobs";
    Editable = false;


    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Job ID"; "Job ID")
                {
                    Caption = 'Incubation';
                }
                field("Incubation Name"; "Incubation Name")
                {

                }
                field("Incubation Type"; "Incubation Type")
                {

                }
                field("No. of Posts"; "No. of Posts")
                {

                }
                field("Occupied Establishments"; "Occupied Establishments")
                {

                }
                field("Vacant Establishments"; "Vacant Establishments")
                {

                }
                field("Incubation Start Date"; "Incubation Start Date")
                {

                }
                field("Incubation End Date"; "Incubation End Date")
                {

                }
                field(Status; Status)
                {

                }
                field("Date Active"; "Date Active")
                {

                }
                field("Dimension 1"; "Dimension 1")
                {

                }
                field("Dimension 2"; "Dimension 2")
                {

                }


            }
        }
    }
}

