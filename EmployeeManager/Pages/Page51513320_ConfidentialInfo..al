page 51513320 "Confidential Info."
{
    // version HR

    PageType = Card;
    SourceTable = Employee;
    SourceTableView = WHERE (Status = CONST (Active));
    Caption = 'Confidential Info.';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
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
                CaptionClass = Text19056241;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(KPA; "Emp Confidential Information")
            {
                SubPageLink = "Employee No." = FIELD ("No.");
            }
        }
    }



    var
        KPACode: Code[20];
        Text19056241: Label 'Confidential Information';
}

