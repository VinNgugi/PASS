page 51513703 "Shortlisting Card"
{
    PageType = Card;
    SourceTable = "Recruitment Needs";
    SourceTableView = where ("Dept Requisition Type" = filter ("Normal Employment"));
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {

                }
                field("Job ID"; "Job ID")
                {

                }
                field(Description; Description)
                {

                }
                field(Position; Position)
                {

                }
                field("Position Filter"; "No Filter")
                {

                }
                field(Qualified; Qualified)
                {

                }
            }
            group("Short Listing")
            {
                field("Stage Code"; "Stage Code")
                {

                }
            }
            part("Short Listed Candidates"; "Stage Shortlist")
            {
                SubPageLink = "Need Code" = FIELD ("No."), "Stage Code" = FIELD ("Stage Code");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group("Shortlist Applicants")
            {
                action("Start Shortlisting")
                {
                    Image = Start;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    var
                        ApplicantShortlistingLines: Record "Applicant Shortlisting Lines";
                        Interviewers: Record "Job Interviewers";
                        testnumbers: Integer;
                        appnumber: Integer;
                        ApplicantShortlisting: Record "Applicant Shortlisting Table";
                        JobApplicationsTable: Record "Job Applicants";
                        ShortlistingCriteria: Record "R. Shortlisting Criteria";
                        ApplicantShortlistingTable: Record "Applicant Shortlisting Table";


                    begin

                        testnumbers := 200;
                        appnumber := 100;
                        ApplicantShortlisting.SETCURRENTKEY(Code);
                        ApplicantShortlisting.ASCENDING(FALSE);
                        IF ApplicantShortlisting.FINDFIRST THEN BEGIN
                            appnumber := ApplicantShortlisting.Code + 1;
                        END;

                        IF "In Shortlisting" = TRUE THEN
                            ERROR('Sorry!!,Shortilisting Has Been Done!');
                        IF CONFIRM('Are You Sure You Want to Start Shortlisting??', FALSE) = TRUE THEN BEGIN
                            Interviewers.RESET;
                            Interviewers.SETRANGE("Recruitment Need", "No.");
                            Interviewers.SETRANGE(Shortlisting, true);
                            IF Interviewers.FINDFIRST THEN BEGIN
                                REPEAT


                                    JobApplicationsTable.RESET;
                                    JobApplicationsTable.SETRANGE("Job ID", Interviewers."Recruitment Need");
                                    JobApplicationsTable.SETRANGE(Submitted, TRUE);
                                    IF JobApplicationsTable.FINDFIRST THEN BEGIN
                                        REPEAT
                                            ApplicantShortlistingTable.INIT;
                                            ApplicantShortlistingTable.Code := appnumber;
                                            ApplicantShortlistingTable."Recruitment Code" := JobApplicationsTable."Job ID";
                                            ApplicantShortlistingTable."Applicant ID" := JobApplicationsTable."No.";
                                            ApplicantShortlistingTable."Applicant Name" := JobApplicationsTable."First Name";
                                            ApplicantShortlistingTable."Stage Code" := "Stage Code";
                                            IF NOT ApplicantShortlistingTable.GET(appnumber) THEN BEGIN

                                                ApplicantShortlistingTable.INSERT(true);
                                                appnumber := appnumber + 1;
                                                // MESSAGE('this is name %1 and number %2',JobApplicationsTable.ApplicantName,appnumber);
                                                // ================lines
                                                ShortlistingCriteria.RESET;
                                                ShortlistingCriteria.SETRANGE("Need Code", ApplicantShortlistingTable."Recruitment Code");
                                                ShortlistingCriteria.SETRANGE("Stage Code", ApplicantShortlistingTable."Stage Code");
                                                IF ShortlistingCriteria.FINDFIRST THEN BEGIN
                                                    //ERROR(ShortlistingCriteria."Criterion Description");
                                                    REPEAT
                                                        ApplicantShortlistingLines.INIT;
                                                        ApplicantShortlistingLines."Line Number" := testnumbers;
                                                        ;
                                                        ApplicantShortlistingLines."Recruitment Code" := ApplicantShortlistingTable."Recruitment Code";
                                                        ApplicantShortlistingLines."Applicant ID" := ApplicantShortlistingTable."Applicant ID";
                                                        ApplicantShortlistingLines.Description := ShortlistingCriteria.Qualification;
                                                        ApplicantShortlistingLines.Score := 0;
                                                        ApplicantShortlistingLines."Interview Type" := ApplicantShortlistingTable."Interview Type";
                                                        ApplicantShortlistingLines."Maximamum Score" := ShortlistingCriteria."Desired Core";
                                                        ApplicantShortlistingLines."User ID" := Interviewers.Interviewer;
                                                        ApplicantShortlistingLines.Code := ApplicantShortlistingTable.Code;
                                                        ApplicantShortlistingLines."Stage Code" := ApplicantShortlistingTable."Stage Code";
                                                        ApplicantShortlistingLines.INSERT(true);
                                                        testnumbers := testnumbers + 1;
                                                    UNTIL ShortlistingCriteria.NEXT = 0;
                                                END ELSE
                                                    Error('Shortlisting criteria does not exist')
                                                //===========================end lines
                                            END;

                                        UNTIL JobApplicationsTable.NEXT = 0;
                                    END;

                                UNTIL Interviewers.NEXT = 0;
                            END else
                                Error('Shortlisting panel does not exists');
                            "In Shortlisting" := TRUE;
                            MESSAGE('Shortlisting  Successfully Started!!');
                        END;

                    end;
                }
                action("Award Scores")
                {
                    Image = List;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Applicant shortlisting List";
                    RunPageLink = "Recruitment Code" = FIELD ("No."), "Stage Code" = FIELD ("Stage Code");
                }
                action(Shortlist)
                {
                    Image = CreateMovement;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()

                    Begin

                        Applicants.RESET;
                        Applicants.SETRANGE("Job ID", "No.");
                        IF Applicants.FINDFIRST THEN
                            REPORT.RUNMODAL(51513534, TRUE, TRUE, Applicants);


                    end;
                }

                action("Compute Oral Interview")
                {
                    Image = CreateMovement;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        TESTFIELD("In Oral Test", TRUE);
                        IF CONFIRM('Are You Sure You Want to Compute Oral Interview??', FALSE) = TRUE THEN BEGIN
                            //"Past Oral Test" := TRUE;
                            Applicants.RESET;
                            Applicants.SETRANGE("Job ID", "No.");
                            IF Applicants.FINDFIRST THEN
                                REPORT.RUNMODAL(51513535, TRUE, TRUE, Applicants);
                        END;
                    end;
                }
                action("Compute Tech Interview")
                {
                    Image = CreateMovement;
                    Promoted = true;
                    PromotedCategory = Process;
                    trigger OnAction()
                    begin
                        TESTFIELD("In Technical Test", TRUE);
                        IF CONFIRM('Are You Sure You Want to Compute Technical Interview??', FALSE) = TRUE THEN BEGIN
                            //"Past Technical Test" := TRUE;
                            Applicants.RESET;
                            Applicants.SETRANGE("Job ID", "No.");
                            IF Applicants.FINDFIRST THEN
                                REPORT.RUNMODAL(51513536, TRUE, TRUE, Applicants);
                        END;
                    end;
                }
            }
        }
    }
    var
        Applicants: Record "Job Applicants";

}