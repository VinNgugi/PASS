page 51513340 "Disciplinary Offenses"
{
    // version HR

    PageType = List;
    SourceTable = "Disciplinary Offenses";
    Caption = 'Disciplinary Offenses';
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
                field(Rating; Rating)
                {
                }
                field(Comments; Comments)
                {
                }
            }
        }
    }

    actions
    {
    }
}

