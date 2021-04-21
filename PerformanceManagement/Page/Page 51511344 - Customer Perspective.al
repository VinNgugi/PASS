page 51513344 "Customer Perspective"
{
    // version HR

    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Appraisal Objectives Lines";
    SourceTableView = where ("Strategic Perspective" = filter (Stakeholder));
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
        "Strategic Perspective" := "Strategic Perspective"::Stakeholder;
        if objectives.Get("Appraisal No") then begin
            "Appraisal Period" := objectives."Appraisal Period";
            "Employee No" := objectives."Employee No";

        end;
    end;
}

