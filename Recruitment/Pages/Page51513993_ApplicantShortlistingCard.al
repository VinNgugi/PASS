page 51513993 "Applicant Shortlisting Card"
{
    PageType = Card;
    SourceTable = "Applicant Shortlisting Table";
    Caption = 'Applicant Shortlisting Card';
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
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
                field("Interview Type"; "Interview Type")
                {

                }
                field("Applicant Name"; "Applicant Name")
                {

                }
                field("Number of Panel"; "Number of Panel")
                {

                }
            }
            part(ApplicantShortlistingLines; "Applicant Shortlisting Lines")
            {
                SubPageLink = Code = FIELD (Code);
            }
        }
    }



}