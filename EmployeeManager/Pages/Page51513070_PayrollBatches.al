page 51513070 "Payroll Batches"
{
    PageType = List;
    SourceTable = "Payroll Batches";
    Caption = 'Payroll Batches';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Batch No"; "Batch No")
                {
                }
                field("Batch Name"; "Batch Name")
                {
                }
                field("Pay Date"; "Pay Date")
                {
                }
                field(Status; Status)
                {
                    Editable = false;
                }
                field("Payroll Period"; "Payroll Period")
                {
                }
                field("Payroll Group"; "Payroll Group")
                {
                }
            }
        }
    }

    actions
    {
    }
}

