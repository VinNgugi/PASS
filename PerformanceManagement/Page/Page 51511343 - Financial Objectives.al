page 51513343 "Financial Objectives"
{
    // version HR

    PageType = ListPart;
    SourceTable = "Appraisal Objectives Lines";
    SourceTableView = where ("Strategic Perspective" = filter (Financial));
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Objective; Objective)
                {
                    Caption = 'Key Result Area';
                }
                field(Approved; Approved)
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
                Caption = 'Objective Performance Measures';
                Image = Track;
                RunObject = page "Objectives Measures";
                RunPageLink = ObjectiveID = FIELD ("Line No"), "Appraisal No" = FIELD ("Appraisal No");
            }
        }
    }

    var
        MeasureFormats: Record "Objective Activities Formats";
        ObjectiveMeasures: Record "Objective Performance Measures";
        objectives: Record "Employee Appraisal Objectives";

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Strategic Perspective" := "Strategic Perspective"::Financial;
        if objectives.Get("Appraisal No") then begin
            "Appraisal Period" := objectives."Appraisal Period";
            "Employee No" := objectives."Employee No";

        end;


    end;
}

