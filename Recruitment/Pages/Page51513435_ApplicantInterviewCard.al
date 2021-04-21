page 51513435 "Applicant Interview Card"
{
    PageType = Card;
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = true;
    SourceTable = "Applicant Interview Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(code; code)
                {
                    Editable = false;

                }
                field("Recruitment Code"; "Recruitment Code")
                {
                    Editable = false;
                }
                field("Applicant ID"; "Applicant ID")
                {
                    Editable = false;
                }
                field("Interview Type"; "Interview Type")
                {
                    Editable = false;
                }
                field("Applicant Name"; "Applicant Name")
                {
                    Editable = false;
                }
                field("Number of Panel"; "Number of Panel")
                {

                }
            }
            part(ApplicantInterviewLines; "Applicant Interview Lines")
            {
                SubPageLink = Code = FIELD (Code);
            }
        }
    }


}