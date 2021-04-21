page 51513051 "Staff Posting Group"
{
    // version FINANCE

    PageType = List;
    SourceTable = "Staff Posting Group";
    Caption = 'Staff Posting Group';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Tax Percentage"; "Tax Percentage")
                {
                }
                field("Salary Incre Month"; "Salary Incre Month")
                {
                    Caption = 'Salary Increament Month';
                }

                field("Increament Percentage"; "Increament Percentage")
                {
                }
                field("Dependant Tax relief Perc"; "Dependant Tax relief Perc")
                {
                }
                field("Tax Code"; "Tax Code")
                {
                }
                field("Account Type"; "Account Type")
                {

                }
                field("Net Salary Payable"; "Net Salary Payable")
                {

                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Posting Group")
            {
                Caption = 'Posting Group';
                action("Accounts Mapping")
                {
                    Caption = 'Accounts Mapping';
                    RunObject = Page "Staff PG Setup";
                    RunPageLink = "Posting Group" = FIELD (Code);
                }
                action(Provisions)
                {
                    Caption = 'Provisions';
                    RunObject = Page "Employment Provisions";
                    RunPageLink = "Staff Group" = FIELD (Code);
                }
                action("Staff Categories")
                {
                    Caption = 'Staff Categories';
                    RunObject = Page "Staff Categories";
                    RunPageLink = "Posting Group" = FIELD (Code);
                }
            }
        }
    }
}

