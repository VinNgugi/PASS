page 51513438 "Applicant Interview List"
{
    PageType = List;
    SourceTable = "Applicant Interview Table";
    Caption = 'Applicant Interview List';
    Editable = true;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    CardPageId = "Applicant Interview Card";
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
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Navigation)
        {
            group(Application)
            {
                action("View Application")
                {
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction();
                    var
                        ApplicantInterviewTable: Record "Applicant Interview Table";
                        ApplicantInterviewTable1: Record "Applicant Interview Table";
                    begin
                        CurrPage.SETSELECTIONFILTER(ApplicantInterviewTable);
                        IF ApplicantInterviewTable.FINDFIRST THEN
                            // MESSAGE(ApplicantInterviewTable."Recruitment Code"+'-'+ApplicantInterviewTable."Applicant Name"+'-'+FORMAT(ApplicantInterviewTable."Interview Type"));
                            PAGE.RUNMODAL(51513435, ApplicantInterviewTable);
                    end;
                }
            }
        }
    }
}