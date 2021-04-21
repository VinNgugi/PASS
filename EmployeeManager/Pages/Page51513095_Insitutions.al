page 51513095 Insitutions
{
    // version PAYROLL

    PageType = List;
    SourceTable = Institution;
    Caption = 'Insitutions';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code"; Code)
                {
                }
                field(Name; Name)
                {
                }
                field(Address; Address)
                {
                }
                field(City; City)
                {
                }
                field("Institution's Bank"; "Institution's Bank")
                {
                }
                field("Bank Account Number"; "Bank Account Number")
                {
                }
                field("Bank Branch"; "Bank Branch")
                {
                }
                field("Paying Bank Code"; "Paying Bank Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

