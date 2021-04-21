page 51513116 "Overtime List"
{
    // version PAYROLL
    Caption = 'Overtime List';
    CardPageID = "Overtime Header";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Overtime Header";
    SourceTableView = WHERE (Types = FILTER (Overtime));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field("Pay Period"; "Pay Period")
                {
                }
                field(Month; Month)
                {
                }
                field(Computed; Computed)
                {
                }
                field(Unit; Unit)
                {
                }
                field("Unit Name"; "Unit Name")
                {
                }
                field(Paid; Paid)
                {
                }
                field(Description; Description)
                {
                }
                field(Status; Status)
                {
                }
            }
        }
    }

    actions
    {
    }
}

