page 51513086 "Bracket Tables"
{
    // version PAYROLL

    PageType = List;
    SourceTable = "Bracket Tables";
    Caption = 'Bracket Tables';

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Bracket Code"; "Bracket Code")
                {
                }
                field("Bracket Description"; "Bracket Description")
                {
                }
                field(Annual; Annual)
                {
                }
                field("Effective Starting Date"; "Effective Starting Date")
                {
                }
                field("Effective End Date"; "Effective End Date")
                {
                }
                field(Type; Type)
                {
                }
                field(NHIF; NHIF)
                {
                }
                field("Tax Computation Method"; "Tax Computation Method")
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Brackets)
            {
                Caption = 'Brackets';
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Tax Table";
                RunPageLink = "Table Code" = FIELD ("Bracket Code");
                RunPageOnRec = false;
            }
            action("Dependants Brackets")
            {
                Caption = 'Dependants Brackets';
                RunObject = Page "Dependants Brackets";
                RunPageLink = "Table Code" = FIELD ("Bracket Code");
            }
        }
    }
}

