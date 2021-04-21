page 51513128 "Payroll Subcategories"
{
    // version PAYROLL

    PageType = List;
    SourceTable = "Payroll Subcategories";
    Caption = 'Payroll Subcategories';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Payroll Group"; "Payroll Group")
                {
                }
                field("Payroll Subcategory"; "Payroll Subcategory")
                {
                }
                field(Description; Description)
                {
                }
            }
        }
    }

    actions
    {
    }
}

