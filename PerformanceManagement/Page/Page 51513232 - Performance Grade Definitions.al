page 51513232 "Performance Grade Definitions"
{
    PageType = ListPart;
    SourceTable = "Appraisal Grades";
    SourceTableView = sorting ("Lowest Points Awarded") order(descending);

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Lowest Points Awarded"; "Lowest Points Awarded")
                {

                }
                field("Highest Points Awarded"; "Highest Points Awarded")
                {

                }
                field(Description; Description)
                {

                }
            }
        }

    }

}