page 51513821 "Resident Selection Lines"
{
    PageType = ListPart;
    SourceTable = "Residential Selection Lines";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Applicant No."; "Applicant No.")
                {
                    ApplicationArea = All;

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
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {

                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(Assess)
            {
                Image = AnalysisView;
                RunObject = page "Residential Assessment Header";
                RunPageLink = "Applicant No." = field ("Applicant No."), Selection = field (Selection);

            }
        }
    }
}