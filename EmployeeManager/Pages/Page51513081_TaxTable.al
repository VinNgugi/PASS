page 51513081 "Tax Table"
{
    // version PAYROLL

    PageType = List;
    SourceTable = "Brackets Lines";
    Caption = 'Tax Table';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Table Code"; "Table Code")
                {
                }
                field("Tax Band"; "Tax Band")
                {
                }
                field("Taxable Amount"; "Taxable Amount")
                {
                }
                field(Percentage; Percentage)
                {
                }
                field("Lower Limit"; "Lower Limit")
                {
                    Visible = true;
                }
                field("Upper Limit"; "Upper Limit")
                {
                    Visible = true;
                }
                field(Amount; Amount)
                {
                }
                field(Deduction; Deduction)
                {
                }
                field("From Date"; "From Date")
                {
                    Visible = false;
                }
                field("End Date"; "End Date")
                {
                    Visible = false;
                }
                field(Institution; Institution)
                {
                }
                field("Contribution Rates Inclusive"; "Contribution Rates Inclusive")
                {
                }
                field("Relief 1(Burundi)"; "Relief 1(Burundi)")
                {
                }
                field("Relief 2(Burundi)"; "Relief 2(Burundi)")
                {
                }
            }
        }
    }

}

