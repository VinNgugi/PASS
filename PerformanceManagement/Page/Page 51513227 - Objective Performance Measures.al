page 51513227 "Objective Performance Measures"
{
    PageType = ListPart;
    SourceTable = "Objective Performance Measures";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(MeasureID; MeasureID)
                {
                    Visible = false;
                }
                field(ObjectiveID; ObjectiveID)
                {
                    Visible = false;
                }
                field("Appraisal No"; "Appraisal No")
                {
                    Visible = false;
                }
                Field("Measure Description"; "Measure Description")
                {

                }
                field("Five-Year Targets"; "Five-Year Targets")
                {

                }
                Field(Targets; Targets)
                {

                }
                field("Appraisal Period Target"; "Appraisal Period Target")
                {

                }
                Field(Initiatives; Initiatives)
                {

                }
                field("Appraisal Period Actuals"; "Appraisal Period Actuals")
                {

                }
                Field("Review Comments"; "Review Comments")
                {

                }
                Field("Weighting(%)"; "Weighting(%)")
                {
                }
                Field("Performance Ratings"; "Performance Ratings")
                {

                }
                Field("Weighted Ratings"; "Weighted Ratings")
                {

                }


            }
        }
    }

}