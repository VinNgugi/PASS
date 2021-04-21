page 51513432 "Applicants List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Job Applicants";
    SourceTableView = sorting ("No.") order(descending) where ("Job Function" = filter ("Normal Job"));
    Editable = false;
    Caption = 'Applicants List';
    CardPageId = "Applicant Card";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
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
                field("Marital Status"; "Marital Status")
                {

                }
                field("ID Number"; "ID Number")
                {

                }
                field(Citizenship; Citizenship)
                {

                }
                field("Date Of Birth"; "Date Of Birth")
                {

                }
                field(Employ; Employ)
                {

                }
                field("Job ID"; "Job ID")
                {

                }
                field("Employee No"; "Employee No")
                {

                }
                field(Submitted; Submitted)
                {

                }
                field("E-Mail"; "E-Mail")
                {

                }
                field("Application Date"; "Application Date")
                {

                }
            }
        }

    }
}