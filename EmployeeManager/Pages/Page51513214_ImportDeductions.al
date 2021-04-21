page 51513214 "Import Deductions"
{
    CardPageID = "Deduction Import";
    PageType = List;
    SourceTable = "Import Deductions";
    Caption = 'Import Deductions';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field("Deduction Code"; "Deduction Code")
                {
                }
                field(Description; Description)
                {
                }
                field("Payroll Period"; "Payroll Period")
                {
                }
                field("Deduction Added"; "Deduction Added")
                {
                }
            }
        }
    }

    actions
    {
    }
}

