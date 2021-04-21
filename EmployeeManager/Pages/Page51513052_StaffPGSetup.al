page 51513052 "Staff PG Setup"
{
    // version FINANCE

    PageType = List;
    SourceTable = "Staff PGroups";
    Caption = 'Staff PGroups';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Type; Type)
                {
                }
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("G/L Account"; "G/L Account")
                {
                }
                field("GL Account Employer"; "GL Account Employer")
                {
                }
            }
        }
    }

    actions
    {
    }
}

