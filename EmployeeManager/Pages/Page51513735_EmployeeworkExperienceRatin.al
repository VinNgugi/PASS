page 51513735 "Employee work Experience Ratin"
{
    Caption = 'Employee work Experience Rating';
    PageType = ListPart;
    SourceTable = "Employee Experience Rating";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Exit Interview Code"; "Exit Interview Code")
                {
                }
                field(Description; Description)
                {
                }
                field(Rating; Rating)
                {
                }
            }
        }
    }


}

