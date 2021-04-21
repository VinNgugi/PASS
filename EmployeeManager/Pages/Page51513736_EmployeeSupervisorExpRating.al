page 51513736 "Employee Supervisor Exp Rating"
{
    PageType = ListPart;
    SourceTable = "Supervisor Experience Rating";
    Caption = 'Employee Supervisor Exp Rating';
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

    actions
    {
    }
}

