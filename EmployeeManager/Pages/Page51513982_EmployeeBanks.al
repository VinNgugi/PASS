page 51513982 "Employee Banks"
{
    PageType = Card;
    SourceTable = "KBA Bank Names";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Bank Code"; "Bank Code")
                {
                }
                field("Bank Name"; "Bank Name")
                {
                }
                /*                field(Address; Address)
                {
                }
                field(Contacts; Contacts)
                {
                }*/
            }
            group(Branch)
            {
                Caption = 'Branch';
            }
            part(Control7; "Bank Branch")
            {
                SubPageLink = "Bank Code" = FIELD ("Bank Code");
            }
        }
    }

    actions
    {
    }
}

