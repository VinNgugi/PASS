page 51513356 "Appraisal Types"
{
    // version HR

    PageType = Card;
    SourceTable = "Appraisal Types";
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Max. Weighting"; "Max. Weighting")
                {
                }
                field("Minimum Job Group"; "Minimum Job Group")
                {
                }
                field("Maximum Job Group"; "Maximum Job Group")
                {
                }
                field("Max. Score"; "Max. Score")
                {
                }
                field("Use Template"; "Use Template")
                {
                }
                field("Template Link"; "Template Link")
                {
                }
                field(Remarks; Remarks)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Appraisal)
            {
                Caption = 'Appraisal';
                action("Appraisal Format")
                {
                    Caption = 'Appraisal Format';
                    RunObject = Page "Appraisal Formats";
                    RunPageLink = "Appraisal Code" = FIELD (Code);
                }
            }
        }
    }
}

