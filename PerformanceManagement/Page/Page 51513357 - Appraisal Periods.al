page 51513357 "Appraisal Periods"
{
    // version HR

    CardPageID = "Appraisal Period";
    PageType = List;
    SourceTable = "Appraisal Periods";
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
                field("Payroll Group"; "Payroll Group")
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

