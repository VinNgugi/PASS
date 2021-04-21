page 51513980 "Payroll Bank List"
{
    CardPageID = "Employee Banks";
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
                }
                field("Bank Name"; "Bank Name")
                {
                }
                /*  field(Address; Address)
                  {
                  }
                  field(Contacts; Contacts)
                  {
                  }*/
            }
        }
    }

    actions
    {
    }
}

