page 51513689 "Objectives Measures"
{
    PageType = List;

    SourceTable = "Objectives Measures";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Appraisal No"; "Appraisal No")
                {
                    Visible = false;
                }
                field(ObjectiveID; ObjectiveID)
                {

                }
                field("Measure Description"; "Measure Description")
                {
                    Caption = 'Performance Measure';

                }
                field("Five-Year Targets"; "Five-Year Targets")
                {

                }
                field(Targets; Targets)
                {

                }
                field("Appraisal Period Target"; "Appraisal Period Target")
                {
                    Caption = 'Appraisal Period Targets';
                }
                field(Initiatives; Initiatives)
                {

                }
                field("Appraisal Period Actuals"; "Appraisal Period Actuals")
                {

                }
                field("Performance Ratings"; "Performance Ratings")
                {

                }
                field("Weighting(%)"; "Weighting(%)")
                {

                }
                field("Weighted Ratings"; "Weighted Ratings")
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }



}