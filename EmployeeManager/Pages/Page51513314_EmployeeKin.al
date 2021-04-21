page 51513314 "Employee Kin"
{
    // version HR

    PageType = Card;
    SourceTable = Employee;
    SourceTableView = WHERE (Status = CONST (Active));
    Caption = 'Employee Kin';
    layout
    {
        area(content)
        {
            group(Genera)
            {
                Caption = 'Genera';
                Editable = false;
                field("No."; "No.")
                {
                }
                field("First Name"; "First Name")
                {
                }
                field("Middle Name"; "Middle Name")
                {
                }
                field("Last Name"; "Last Name")
                {
                }
                field(Initials; Initials)
                {
                }
                field("ID Number"; "ID Number")
                {
                }
                field(Gender; Gender)
                {
                }
                field(Position; Position)
                {
                }
                field("Contract Type"; "Contract Type")
                {
                }
                field("Date Of Join"; "Date Of Join")
                {
                }
            }
            field(Control1000000030; '')
            {
                CaptionClass = Text19079240;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(KPA; "Employee Kin Lines")
            {
                SubPageLink = "Employee Code" = FIELD ("No.");
            }
        }
    }

    actions
    {
    }

    var
        KPACode: Code[20];
        Text19079240: Label 'Next Of Kin';
}

