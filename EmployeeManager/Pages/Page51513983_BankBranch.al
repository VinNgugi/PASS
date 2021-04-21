page 51513983 "Bank Branch"
{
    PageType = ListPart;
    SourceTable = "Kenya Bankers Association Code";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bank Code"; "Bank Code")
                {
                }
                field("Branch Name"; "Branch Name")
                {
                }
                field("Branch Code"; "Branch Code")
                {
                }
            }
        }
    }

    actions
    {
    }
}

