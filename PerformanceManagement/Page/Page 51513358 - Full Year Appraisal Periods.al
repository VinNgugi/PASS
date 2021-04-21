page 51513358 "Full Year Appraisal Periods"
{
    // version HR

    PageType = Card;
    SourceTable = "Full Year Appraisal Periods";
    Caption = 'Full Year Appraisal Periods';
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Period; Period)
                {
                }
                field("Start Date"; "Start Date")
                {
                }
                field("End Date"; "End Date")
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

