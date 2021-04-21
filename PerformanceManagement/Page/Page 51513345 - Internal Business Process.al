page 51513345 "Internal Business Process"
{
    // version HR

    PageType = ListPart;
    SourceTable = "Appraisal Objectives Lines";
    SourceTableView = WHERE ("Strategic Perspective" = filter ("Internal Business Process"));

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Objective; Objective)
                {
                    Caption = 'Objective';
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
        Objectives: Record "Employee Appraisal Objectives";

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Strategic Perspective" := "Strategic Perspective"::"Internal Business Process";
        if objectives.Get("Appraisal No") then begin
            "Appraisal Period" := objectives."Appraisal Period";
            "Employee No" := objectives."Employee No";

        end;
    end;
}

