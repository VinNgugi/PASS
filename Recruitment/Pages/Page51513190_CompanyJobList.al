page 51513190 "Company Job List"
{
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Company Jobs";
    CardPageId = "Company Jobs";
    Editable = false;
    //SourceTableView = sorting ("Job ID") order(descending) where ("Job Funcion" = filter ("Pass Job"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Job ID"; "Job ID")
                {


                }
                field("Job Description"; "Job Description")
                {


                }
                field("No. of Posts"; "No. of Posts")
                {


                }
                field(Grade; Grade)
                {


                }
                field("Occupied Establishments"; "Occupied Establishments")
                {


                }
                field("Vacant Establishments"; "Vacant Establishments")
                {


                }
                field("Dimension 1"; "Dimension 1")
                {


                }
                field("Dimension 2"; "Dimension 2")
                {


                }
                field("Notice Period"; "Notice Period")
                {


                }
                field("Probation Period"; "Probation Period")
                {


                }
                field(Status; Status)
                {

                }
                field("Date Active"; "Date Active")
                {

                }

            }
        }
    }
}

