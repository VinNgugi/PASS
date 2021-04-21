page 51513127 "Dependants Bands"
{
    // version PAYROLL

    PageType = List;
    SourceTable = "Dependants Band Table";
    Caption = 'Dependants Bands';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Bands; Bands)
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field(Dependants; Dependants)
                {
                }
                field(Percentage; Percentage)
                {
                }
            }
        }
    }

    actions
    {
    }
}

