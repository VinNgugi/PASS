page 51513150 "HR Employee List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = Employee;
    Editable = false;
    CardPageId = "HR Employee";
    Caption = 'HR Employee List';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    Caption = 'No.';

                }
                field(FullName; FullName)
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
                field("Job Title"; "Job Title")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Post Code"; "Post Code")
                {

                }
                field("Country/Region Code"; "Country/Region Code")
                {

                }
                field(Extension; Extension)
                {

                }
                field("Phone No."; "Phone No.")
                {

                }
                field("Mobile Phone No."; "Mobile Phone No.")
                {

                }
                field("E-Mail"; "E-Mail")
                {

                }
                field("Statistics Group Code"; "Statistics Group Code")
                {

                }
                field("Resource No."; "Resource No.")
                {

                }
                field("Search Name"; "Search Name")
                {

                }
                field(Comment; Comment)
                {

                }

            }
        }
        area(Factboxes)
        {
            part(Control1; "Employee Picture")
            {
                ApplicationArea = "#BasicHR";
                SubPageLink = "No." = FIELD ("No.");
                Visible = true;
            }
            systempart(Links; Links)
            {

            }
            systempart(Notes; Notes)
            {

            }
        }


    }
}