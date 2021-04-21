page 51513339 "Disciplinary Actions"
{
    // version HR

    PageType = List;
    SourceTable = "Disciplinary Actions";
    UsageCategory = Administration;
    Caption = 'Disciplinary Actions';
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
                field(Terminate; Terminate)
                {
                }
                field(Document; Document)
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

