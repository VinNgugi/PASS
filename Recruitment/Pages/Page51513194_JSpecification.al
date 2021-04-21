page 51513194 "J. Specification"
{
    PageType = Card;
    SourceTable = "Company Jobs";

    layout
    {
        area(Content)
        {
            group(general)
            {
                field("Job ID"; "Job ID")
                {

                }
                field("Job Description"; "Job Description")
                {

                }
                field("Total Score"; "Total Score")
                {

                }
            }
            part(KPA; "Job Requirement Lines")
            {
                SubPageLink = "Job Id" = FIELD ("Job ID");
            }
            part(EducationalNeeds; "Job Education Needs")
            {
                Caption = 'Educational Needs';
                SubPageLink = "Job ID" = FIELD ("Job ID");
            }
            part(ProfessionalCertifications; "Professional Bodies Needs")
            {
                Caption = 'Professional Certifications';
                SubPageLink = "Job ID" = FIELD ("Job ID");
            }
            part(Membership; "Job Professional Bodies")
            {
                Caption = 'Membership';
                SubPageLink = "Job ID" = FIELD ("Job ID");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}