page 51513851 "Residential Assessment Header"
{
    PageType = Card;
    SourceTable = "Residential Selection Lines";
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = false;
                field("Applicant No."; "Applicant No.")
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
                field(Selection; Selection)
                {
                    Caption = 'Assessment Type';
                }
            }
            part(AssessmentLines; "Residential Assessment Lines")
            {
                SubPageLink = "Application ID" = field ("Applicant No."), Selection = field (Selection);
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Compute Score")
            {
                Image = NewSum;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    totalscore: Decimal;

                begin
                    totalscore := 0;
                    if Confirm('Are you sure you want to compute %1 score for %2?', false, Selection, "First Name") then begin
                        //Message("Applicant No.");
                        if applicant.Get("Applicant No.") then begin

                            Assessscore.Reset();
                            Assessscore.SetRange("Application ID", "Applicant No.");
                            Assessscore.SetRange(Selection, Selection);
                            if Assessscore.FindFirst() then begin
                                repeat
                                    totalscore := totalscore + Assessscore.Score;
                                    Assessscore.Submitted := true;
                                    Assessscore.Modify();
                                until Assessscore.Next() = 0;
                                if Selection = Selection::"Business Skills" then
                                    applicant."Buiness Skills Total Score" := totalscore
                                else
                                    if Selection = Selection::"Technical Training" then
                                        applicant."Technical Training Total Score" := totalscore
                                    else
                                        if Selection = Selection::"Face to Face Interviews" then
                                            applicant."F2F Interview Total Score" := totalscore;
                                applicant.Modify();
                                Message('%1 %2 score successfully computed and total score is %3', "Last Name", Selection, totalscore);
                            end;
                        end;


                    end;
                end;
            }
        }
    }

    var
        applicant: Record "Job Applicants";

        Assessscore: Record "Residential Assessment";
}