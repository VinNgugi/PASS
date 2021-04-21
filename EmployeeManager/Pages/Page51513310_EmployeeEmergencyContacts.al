page 51513310 "Employee Emergency Contacts"
{
    // version HR

    PageType = Card;
    SourceTable = Employee;
    SourceTableView = WHERE (Status = CONST (Active));
    Caption = 'Employee Emergency Contacts';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                Enabled = true;
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
                CaptionClass = Text19067221;
                Style = Strong;
                StyleExpr = TRUE;
            }
            part(KPA; "Emergency Contacts")
            {
                SubPageLink = "Employee No." = FIELD ("No.");
            }
        }
    }


    var
        KPACode: Code[20];
        Text19067221: Label 'Emergency Contacts';
}

