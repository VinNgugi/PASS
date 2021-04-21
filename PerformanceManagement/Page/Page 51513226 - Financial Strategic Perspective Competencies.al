page 51513226 "Financial Competencies"
{
    PageType = ListPart;

    SourceTable = "Appraisal Lines";
    SourceTableView = SORTING("No.") WHERE("Strategic Perspective" = CONST(Financial));
    Caption = 'Financial Strategic Perspective Competencies Jim Test';
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
                field("Line No"; "Line No")
                {
                    Visible = false;
                }
                Field(Objective; Objective)
                {
                    Editable = false;
                }
                Field(Measure; Measure)
                {
                    Visible = false;
                }
                Field("Review Comments/ Achievements"; "Review Comments/ Achievements")
                {

                }
                Field("Weighting(%)"; "Weighting(%)")
                {


                }
                Field("Performance Ratings(%)"; "Performance Ratings(%)")
                {
                    Caption = 'Rating(%)';
                }
                field("Weighted Ratings(%)"; "Weighted Ratings(%)")
                {

                }

                Field("Appraiser's Comments"; "Appraiser's Comments")
                {

                }
                Field("Appraisee's comments"; "Appraisee's comments")
                {

                }

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Objective Performance Measures")
            {
                Image = Track;
                RunObject = page "Objective Performance Measures";
                RunPageLink = ObjectiveID = FIELD("Line No"), "Appraisal No" = FIELD("Appraisal No");

                trigger OnAction()
                begin

                    MeasureFormats.RESET;
                    IF MeasureFormats.FIND('-') THEN
                        REPEAT
                            ObjectiveMeasures.INIT;
                            ObjectiveMeasures.MeasureID := MeasureFormats.MeasureID;
                            ObjectiveMeasures."Measure Description" := MeasureFormats.Description;
                            ObjectiveMeasures."Appraisal No" := "Appraisal No";
                            ObjectiveMeasures.ObjectiveID := "Line No";
                            ObjectiveMeasures.Targets := MeasureFormats.Targets;
                            ObjectiveMeasures.Initiatives := MeasureFormats.Initiatives;
                            ObjectiveMeasures."Review Comments" := MeasureFormats."Review Comments/Achievements";
                            ObjectiveMeasures."Weighting(%)" := MeasureFormats."Weighting(%)";
                            ObjectiveMeasures."Performance Ratings" := MeasureFormats."Performance Ratings(%)";
                            ObjectiveMeasures."Weighted Ratings" := MeasureFormats."Weighted Ratings(%)";
                            IF NOT ObjectiveMeasures.GET(MeasureFormats.MeasureID, "Line No", "Appraisal No") THEN
                                ObjectiveMeasures.INSERT;
                        UNTIL MeasureFormats.NEXT = 0;
                end;

            }
        }
    }
    var
        AppraisalTypes: Record "Appraisal Types";
        ObjectiveMeasures: Record "Objective Performance Measures";
        MeasureFormats: Record "Objective Activities Formats";
}