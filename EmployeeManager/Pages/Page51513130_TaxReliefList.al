page 51513130 "Tax Relief List"
{
    PageType = List;
    SourceTable = "Tax Relief Table";
    Caption = 'Tax Relief List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Relif Code"; "Relif Code")
                {
                }
                field("Relief Description"; "Relief Description")
                {
                }
                field(Amount; Amount)
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

