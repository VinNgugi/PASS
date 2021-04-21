page 51513327 "Succesion Planning"
{
    // version HR

    PageType = Card;
    SourceTable = Employee;
    SourceTableView = WHERE (Status = CONST (Active));
    Caption = 'Succesion Planning';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = true;
                field("No."; "No.")
                {
                    Editable = false;
                }
                field("First Name"; "First Name")
                {
                    Editable = false;
                }
                field("Middle Name"; "Middle Name")
                {
                    Editable = false;
                }
                field("Last Name"; "Last Name")
                {
                    Editable = false;
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
                field("Position To Succeed"; "Position To Succeed")
                {
                }
                field("Succesion Date"; "Succesion Date")
                {
                }
            }

            /* part("Position To Succed Educational Needs"; "Job Education Needs")
             {
                 Caption = 'Position To Succed Educational Needs';
                 SubPageLink = "Job ID" = FIELD ("Position To Succeed");
             }*/

            part("Position To Succed Professional Certifications"; "Professional Bodies Needs")
            {
                Caption = 'Position To Succed Professional Certifications';
                SubPageLink = "Job ID" = FIELD ("Position To Succeed");
            }

            part("Position To Succed Professional  Membership"; "Job Professional Bodies")
            {
                Caption = 'Position To Succed Professional  Membership';
                SubPageLink = "Job ID" = FIELD ("Position To Succeed");
            }

            part(Control9; "Employee Qualification")
            {
                SubPageLink = "Employee No." = FIELD ("No.");
            }

            part(KPA; "Succession Requirements")
            {
                SubPageLink = "Employee No." = FIELD ("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Action8)
            {
            }
        }
    }

    var
        JobReq: Record "Leave Recall";
        Text19062331: Label 'Requirements Gaps';
        Text19065507: Label 'Succesion Training and Development Requirements';
}

