page 51513456 "Applicant Work Experience"
{
    PageType = ListPart;

    SourceTable = "Applicant Work Experience";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Line No."; "Line No.")
                {

                }
                field("Applicant No."; "Applicant No.")
                {

                }
                field("Position Code"; "Position Code")
                {
                    Visible = false;
                }
                field("Position Description"; "Position Description")
                {

                }
                field("From Date"; "From Date")
                {

                }
                field("To Date"; "To Date")
                {

                }
                field(Responsibility; Responsibility)
                {

                }
                field("Institution/Company"; "Institution/Company")
                {

                }
                field(Salary; Salary)
                {

                }
            }
        }


    }
}