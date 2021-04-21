page 51513114 "Effected Salary Increament"
{
    // version PAYROLL
    Caption = 'Effected Salary Increament';
    PageType = List;
    SourceTable = "Effected Basic Salary Incre";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Period; Period)
                {
                }
                field("Initial Basic Salary"; "Initial Basic Salary")
                {
                }
                field("Increased by Amount"; "Increased by Amount")
                {
                }
                field("New Basic Salary"; "New Basic Salary")
                {
                }
                field(Date; Date)
                {
                }
                field(Time; Time)
                {
                }
            }
        }
    }

    actions
    {
    }
}

