page 51513115 "Overtime Set Up"
{
    // version PAYROLL

    PageType = List;
    SourceTable = "Overtime Set Up";
    Caption = 'Overtime Set Up';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Rates Normal"; "Rates Normal")
                {
                }
                field("Max Hours Per Month"; "Max Hours Per Month")
                {
                }
                field(Type; Type)
                {
                }
            }
        }
    }

    actions
    {
    }
}

