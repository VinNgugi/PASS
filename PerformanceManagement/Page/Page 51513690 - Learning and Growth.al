page 51513690 "Learning & Growth"
{
    // version HR

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Appraisal Objectives Lines";
    SourceTableView = where ("Strategic Perspective" = filter ("Learning and Growth"));
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
        area(processing)
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
        Objectives: Record "Employee Appraisal Objectives";

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Strategic Perspective" := "Strategic Perspective"::"Learning and Growth";
        if objectives.Get("Appraisal No") then begin
            "Appraisal Period" := objectives."Appraisal Period";
            "Employee No" := objectives."Employee No";

        end;
    end;
}

