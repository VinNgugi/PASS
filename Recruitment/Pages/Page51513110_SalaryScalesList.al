page 51513110 "Salary Scales List"
{
    PageType = List;

    UsageCategory = Administration;
    SourceTable = "Salary Scales";
    Caption = 'Salary Scales List';

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Scale; Scale)
                {
                }
                field("Minimum Pointer"; "Minimum Pointer")
                {
                }
                field("Maximum Pointer"; "Maximum Pointer")
                {
                }
                field("Medical Cover Category"; "Medical Cover Category")
                {
                }
                field("In Patient Limit"; "In Patient Limit")
                {
                }
                field("Out Patient Limit"; "Out Patient Limit")
                {
                }
                /*
                field("Payroll Category"; "Payroll Category")
                {
                }
                field("Vehicle Grant"; "Vehicle Grant")
                {
                }*/
            }
        }
    }


}
