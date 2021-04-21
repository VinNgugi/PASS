page 51513111 "Scale Benefits"
{
    // version PAYROLL

    PageType = List;
    SourceTable = "Scale Benefits";
    Caption = 'Scale Benefits';

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Salary Scale"; "Salary Scale")
                {
                }
                field("Salary Pointer"; "Salary Pointer")
                {
                }
                field("ED Code"; "ED Code")
                {
                }
                field("ED Description"; "ED Description")
                {
                }
                field("G/L Account"; "G/L Account")
                {
                    Visible = false;
                }
                field(Amount; Amount)
                {
                }
            }
        }
    }

}

