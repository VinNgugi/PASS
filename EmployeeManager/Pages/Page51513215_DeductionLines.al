page 51513215 "Deduction Lines"
{
    PageType = ListPart;
    SourceTable = "Deduction Lines";
    Caption = 'Deduction Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    Visible = false;
                }
                field("Line No"; "Line No")
                {
                    Visible = false;
                }
                field("Employee No"; "Employee No")
                {
                }
                field(Deduction; Deduction)
                {
                }
                field(Amount; Amount)
                {
                }
            }
        }
    }

    actions
    {
    }
}

