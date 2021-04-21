page 51513406 "Medical Cover List"
{
    // version HR

    Editable = false;
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Medical Cover Types";
    Caption = 'Medical Cover List';
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
                field(Type; Type)
                {
                }
                field(Provider; Provider)
                {
                }
                field("Name of Provider"; "Name of Provider")
                {
                }
            }
        }
    }

    actions
    {
    }
}

