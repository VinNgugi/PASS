page 51513196 "J. Responsiblities"
{
    PageType = Card;
    UsageCategory = Administration;
    SourceTable = "Company Jobs";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Job ID"; "Job ID")
                {


                }
                field("Job Description"; "Job Description")
                {

                }
            }
            part(KPA; "Job Responsiblities")
            {
                Caption = 'Responsiblities';
                SubPageLink = "Job ID" = FIELD ("Job ID");
            }
        }
    }


}