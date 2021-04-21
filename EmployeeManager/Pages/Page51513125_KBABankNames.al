page 51513125 "KBA Bank Names"
{
    // version PAYROLL

    //CardPageID = "KBA Bank Code Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    PageType = List;
    SourceTable = "KBA Bank Names";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Code"; "Bank Code")
                {
                    Editable = false;
                }
                field("Bank Name"; "Bank Name")
                {
                    Editable = false;
                }
                field(Location; Location)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

