page 51513252 "Casual Payment Lines"
{
    PageType = ListPart;
    SourceTable = "Casuals Payment Lines";
    Caption = 'Casual Payment Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field("Line No"; "Line No")
                {
                }
                field("Employee No"; "Employee No")
                {
                }
                field(Name; Name)
                {
                }
                field("Calculated Hours"; "Calculated Hours")
                {
                }
                field("Actual Hours"; "Actual Hours")
                {
                }
                field("Overtime Hours"; "Overtime Hours")
                {
                }
                field(Arrears; Arrears)
                {
                }
            }
        }
    }

    actions
    {
    }
}

