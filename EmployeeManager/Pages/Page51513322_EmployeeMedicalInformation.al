page 51513322 "Employee Medical Information"
{
    // version HR

    PageType = Card;
    SourceTable = Employee;
    SourceTableView = WHERE (Status = CONST (Active));
    Caption = 'Employee Medical Information';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                    Enabled = true;
                }
                field("Middle Name"; "Middle Name")
                {
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
                    Enabled = true;
                }
                field(Initials; Initials)
                {
                    Editable = false;
                }
                field("ID Number"; "ID Number")
                {
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    Editable = false;
                }
                field(Position; Position)
                {
                    Editable = false;
                }
                field("Contract Type"; "Contract Type")
                {
                    Editable = false;
                }
                field("Date Of Join"; "Date Of Join")
                {
                    Editable = false;
                }
            }
            field(Control1000000030; '')
            {
                CaptionClass = Text19004863;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(KPA; "Medical Info")
            {
            }
        }
    }

    actions
    {
    }

    var
        KPACode: Code[20];
        Text19004863: Label 'Medical Info.';
}

