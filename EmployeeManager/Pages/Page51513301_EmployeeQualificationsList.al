page 51513301 "Employee Qualifications List"
{
    // version HR

    Caption = 'Employee Qualifications Lis';
    CardPageID = "Emp Qualification";
    Editable = false;
    PageType = List;
    SourceTable = Employee;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("No."; "No.")
                {
                }
                field(FullName; FullName)
                {
                    Caption = 'Full Name';
                }
                field("First Name"; "First Name")
                {
                    Visible = false;
                }
                field("Middle Name"; "Middle Name")
                {
                    Visible = false;
                }
                field("Last Name"; "Last Name")
                {
                    Visible = false;
                }
                field(Initials; Initials)
                {
                    Visible = false;
                }
                field("Job Title"; "Job Title")
                {
                }
                field("Post Code"; "Post Code")
                {
                    Visible = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    Visible = false;
                }
                field(Extension; Extension)
                {
                }
                field("Phone No."; "Phone No.")
                {
                    Visible = false;
                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {
                    Visible = false;
                }
                field("E-Mail"; "E-Mail")
                {
                    Visible = false;
                }
                field("Statistics Group Code"; "Statistics Group Code")
                {
                    Visible = false;
                }
                field("Resource No."; "Resource No.")
                {
                    Visible = false;
                }
                field("Search Name"; "Search Name")
                {
                }
                field(Comment; Comment)
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("E&mployee")
            {
                Caption = 'E&mployee';
                action("Q&ualifications")
                {
                    Caption = 'Q&ualifications';
                    Image = QualificationOverview;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Employee Qualifications";
                    RunPageLink = "Employee No." = FIELD ("No.");
                }
            }
        }
    }
}

