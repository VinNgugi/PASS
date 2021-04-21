page 51513122 "Consultancy Payment  List"
{
    // version PAYROLL

    CardPageID = "Consultancy Payment Card";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Overtime Header";
    SourceTableView = WHERE (Types = FILTER (Bonus));

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
                field(Description; Description)
                {
                }
                field(Status; Status)
                {
                }
                field("User ID"; "User ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}

