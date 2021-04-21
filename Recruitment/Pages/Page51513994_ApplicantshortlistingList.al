page 51513994 "Applicant shortlisting List"
{
    PageType = List;
    SourceTable = "Applicant Shortlisting Table";
    CardPageId = "Applicant Shortlisting Card";
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    Caption = 'Applicant shortlisting List';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(code; code)
                {


                }
                field("Recruitment Code"; "Recruitment Code")
                {

                }
                field("Applicant ID"; "Applicant ID")
                {

                }
                field("Applicant Name"; "Applicant Name")
                {

                }
                field("Interview Type"; "Interview Type")
                {

                }
            }
        }

    }
}