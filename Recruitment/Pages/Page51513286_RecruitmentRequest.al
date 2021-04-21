page 51513286 "Recruitment Request"
{
    PageType = Card;
    SourceTable = "Recruitment Needs";
    SourceTableView = sorting ("No.") order(ascending) where ("Dept Requisition Type" = filter ("Normal Employment"));
    Caption = 'Recruitment Request';
    RefreshOnActivate = true;
    PromotedActionCategories = 'New,Applicants,Report,Job,Approve,Request Approval,Navigate,Interviews';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {

                }
                field(Date; Date)
                {

                }
                field("Job ID"; "Job ID")
                {

                }
                field(Description; Description)
                {

                }
                field("Requisition Type"; "Requisition Type")
                {

                }
                field(Position; Position)
                {

                }
                field("Appointment Type"; "Appointment Type")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Reason for Recruitment"; "Reason for Recruitment")
                {

                }
                field("Start Date"; "Start Date")
                {

                }
                field("End Date"; "End Date")
                {

                }
                field("Expected Reporting Date"; "Expected Reporting Date")
                {

                }
                field("Requested By"; "Requested By")
                {

                }
                field("Requester Name"; "Requester Name")
                {

                }
                field(Status; Status)
                {

                }
                field("Pay Grade"; "Pay Grade")
                {

                }
            }
            part(JobRequiredDocuments; "Job Required Documents")
            {
                SubPageLink = "Recruitment Req. No." = FIELD ("No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {

            group("Job Specific Requirements")
            {
                Caption = 'Job';
                action(Responsibilities)
                {

                    Caption = 'Key Responsibilities';
                    Image = Agreement;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = page "Job Responsiblities";
                    RunPageLink = "Job ID" = FIELD ("Job ID");

                }
                action("Job Requirements")
                {

                    Caption = 'Job Requirements';
                    Image = Agreement;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    RunObject = page "Job Requirement Lines";
                    RunPageLink = "Job ID" = FIELD ("Job ID");

                }

            }
            group(Applicants)
            {
                action("View Applicants")
                {
                    Caption = 'View Applicants';
                    Image = ContactPerson;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page "Applicants List";
                    RunPageLink = "Job ID" = FIELD ("No.");
                }
                action(Interviewees)
                {
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page "Applicant Interview List";
                    RunPageLink = "Recruitment Code" = FIELD ("No.");
                }
            }
        }
        area(Creation)
        {
            group(Interview)
            {
                Image = Info;
                action("Interview Test")
                {
                    Image = Info;
                    Promoted = true;
                    PromotedCategory = Category8;
                    PromotedIsBig = true;
                    RunObject = page "Job Interview List";
                    RunPageLink = "Recruitment No." = FIELD ("No.");


                }
                action("Interview Panel")
                {
                    Image = Group;
                    Promoted = true;
                    PromotedCategory = Category8;
                    RunObject = page "Job Interviewers List";
                    RunPageLink = "Recruitment Need" = FIELD ("No.");

                }
                action("Start Oral Interview")
                {
                    Image = Start;
                    Promoted = true;
                    PromotedCategory = Category8;

                    trigger onAction()
                    var
                        ApplicantInterviewTable: Record "Applicant Interview Table";
                        ApplicantInterviewLines: Record "Applicant Interview Lines";
                        Interviewers: Record "Job Interviewers";
                        JobApplicationsTable: Record "Job Applicants";
                        JobInterviewList: Record "Job Interview List";
                        testnumbers: Integer;
                        appnumber: Integer;
                        ApplicantInterview: Record "Applicant Interview Table";
                    begin
                        TestField(Status, Status::Released);
                        TESTFIELD(Status, Status::Released);
                        TESTFIELD("In Oral Test", FALSE);
                        TESTFIELD("Past Oral Test", FALSE);
                        testnumbers := 200;
                        appnumber := 100;
                        ApplicantInterview.SETCURRENTKEY(Code);
                        ApplicantInterview.ASCENDING(FALSE);
                        IF ApplicantInterview.FINDFIRST THEN BEGIN
                            appnumber := ApplicantInterview.Code + 1;
                        END;

                        IF "Short Listing Done?" = FALSE THEN
                            ERROR('Sorry!!,Shortilisting Has Not Been Done!');
                        IF CONFIRM('Are You Sure You Want to Start Oral Interview Test??', FALSE) = TRUE THEN BEGIN
                            Interviewers.RESET;
                            Interviewers.SETRANGE("Recruitment Need", "No.");
                            Interviewers.SETRANGE("Interview Type", Interviewers."Interview Type"::"Oral Interview");
                            IF Interviewers.FINDFIRST THEN BEGIN
                                REPEAT
                                    JobApplicationsTable.RESET;
                                    JobApplicationsTable.SETRANGE("Job ID", Interviewers."Recruitment Need");
                                    //JobApplicationsTable.SETRANGE("Passed Short Listing",TRUE);
                                    JobApplicationsTable.SETRANGE(Qualified, TRUE);
                                    IF JobApplicationsTable.FINDFIRST THEN BEGIN
                                        REPEAT
                                            ApplicantInterviewTable.INIT;
                                            ApplicantInterviewTable.Code := appnumber;
                                            ApplicantInterviewTable."Recruitment Code" := JobApplicationsTable."Job ID";
                                            ApplicantInterviewTable."Applicant ID" := JobApplicationsTable."No.";
                                            ApplicantInterviewTable."Applicant Name" := JobApplicationsTable."First Name" + ' ' + JobApplicationsTable."Middle Name" + ' ' + JobApplicationsTable."Last Name";
                                            ApplicantInterviewTable."Interview Type" := Interviewers."Interview Type"::"Oral Interview";
                                            ApplicantInterviewTable."Stage Code" := "Stage Code";
                                            IF NOT ApplicantInterviewTable.GET(appnumber) THEN BEGIN
                                                ApplicantInterviewTable.INSERT;
                                                appnumber := appnumber + 1;
                                                // MESSAGE('this is name %1 and number %2',JobApplicationsTable.ApplicantName,appnumber);
                                                // ================lines
                                                JobInterviewList.RESET;
                                                JobInterviewList.SETRANGE("Recruitment No.", ApplicantInterviewTable."Recruitment Code");
                                                JobInterviewList.SETRANGE("Interview Type", ApplicantInterviewTable."Interview Type");
                                                IF JobInterviewList.FINDFIRST THEN BEGIN
                                                    REPEAT
                                                        ApplicantInterviewLines.INIT;
                                                        ApplicantInterviewLines."Line Number" := testnumbers;
                                                        ;
                                                        ApplicantInterviewLines."Recruitment Code" := ApplicantInterviewTable."Recruitment Code";
                                                        ApplicantInterviewLines."Applicant ID" := ApplicantInterviewTable."Applicant ID";
                                                        ApplicantInterviewLines.Description := JobInterviewList.Description;
                                                        ApplicantInterviewLines.Score := 0;
                                                        ApplicantInterviewLines."Interview Type" := ApplicantInterviewTable."Interview Type";
                                                        ApplicantInterviewLines."Maximum Score" := JobInterviewList."Maximum Score";
                                                        ApplicantInterviewLines."User ID" := Interviewers.Interviewer;
                                                        ApplicantInterviewLines.Code := ApplicantInterviewTable.Code;
                                                        ApplicantInterviewLines."Stage Code" := ApplicantInterviewTable."Stage Code";
                                                        ApplicantInterviewLines.INSERT;
                                                        testnumbers := testnumbers + 1;
                                                    UNTIL JobInterviewList.NEXT = 0;
                                                END else
                                                    Error('Oral interview questions does not exists');
                                                //===========================end lines
                                            END;

                                        UNTIL JobApplicationsTable.NEXT = 0;
                                    END;

                                UNTIL Interviewers.NEXT = 0;
                            END else
                                Error('Oral Interview panel does not exists');
                            "In Oral Test" := TRUE;
                            MESSAGE('Oral Interview Successfully Started!!');
                        END;
                    end;
                }
            }
            action("Start Technical Interview")
            {
                image = Start;
                Promoted = true;
                PromotedCategory = Category8;

                trigger OnAction()
                var
                    ApplicantInterviewLines: Record "Applicant Interview Lines";
                    Interviewers: Record "Job Interviewers";
                    JobApplicationsTable: Record "Job Applicants";
                    JobInterviewList: Record "Job Interview List";
                    testnumbers: Integer;
                    appnumber: Integer;
                    ApplicantInterview: Record "Applicant Interview Table";
                    ApplicantInterviewTable: Record "Applicant Interview Table";
                begin
                    TESTFIELD(Status, Status::Released);
                    TestField("Past Oral Test", true);
                    TESTFIELD("In Technical Test", FALSE);
                    testnumbers := 200;
                    appnumber := 100;
                    ApplicantInterview.SETCURRENTKEY(Code);
                    ApplicantInterview.ASCENDING(FALSE);
                    IF ApplicantInterview.FINDFIRST THEN BEGIN
                        appnumber := ApplicantInterview.Code + 1;
                    END;

                    IF "Past Oral Test" = FALSE THEN
                        ERROR('Sorry!!,Oral Interview Has Not Been Done or Completed!');
                    IF CONFIRM('Are You Sure You Want to Start Technical Interview Test??', FALSE) = TRUE THEN BEGIN
                        Interviewers.RESET;
                        Interviewers.SETRANGE("Recruitment Need", "No.");
                        Interviewers.SETRANGE("Interview Type", Interviewers."Interview Type"::"Technical Interview");
                        IF Interviewers.FINDFIRST THEN BEGIN
                            REPEAT
                                JobApplicationsTable.RESET;
                                JobApplicationsTable.SETRANGE("Job ID", Interviewers."Recruitment Need");
                                JobApplicationsTable.SETRANGE("Passed Oral Interview", TRUE);
                                JobApplicationsTable.SETRANGE(Qualified, TRUE);
                                IF JobApplicationsTable.FINDFIRST THEN BEGIN
                                    REPEAT
                                        ApplicantInterviewTable.INIT;
                                        ApplicantInterviewTable.Code := appnumber;
                                        ApplicantInterviewTable."Recruitment Code" := JobApplicationsTable."Job ID";
                                        ApplicantInterviewTable."Applicant ID" := JobApplicationsTable."No.";
                                        ApplicantInterviewTable."Applicant Name" := JobApplicationsTable."First Name" + ' ' + JobApplicationsTable."Middle Name" + ' ' + JobApplicationsTable."Last Name";
                                        ApplicantInterviewTable."Interview Type" := Interviewers."Interview Type"::"Technical Interview";
                                        IF NOT ApplicantInterviewTable.GET(appnumber) THEN BEGIN
                                            ApplicantInterviewTable.INSERT;
                                            appnumber := appnumber + 1;
                                            // MESSAGE('this is name %1 and number %2',JobApplicationsTable.ApplicantName,appnumber);
                                            // ================lines
                                            JobInterviewList.RESET;
                                            JobInterviewList.SETRANGE("Recruitment No.", ApplicantInterviewTable."Recruitment Code");
                                            JobInterviewList.SETRANGE("Interview Type", ApplicantInterviewTable."Interview Type");
                                            IF JobInterviewList.FINDFIRST THEN BEGIN
                                                REPEAT
                                                    ApplicantInterviewLines.INIT;
                                                    ApplicantInterviewLines."Line Number" := testnumbers;
                                                    ;
                                                    ApplicantInterviewLines."Recruitment Code" := ApplicantInterviewTable."Recruitment Code";
                                                    ApplicantInterviewLines."Applicant ID" := ApplicantInterviewTable."Applicant ID";
                                                    ApplicantInterviewLines.Description := JobInterviewList.Description;
                                                    ApplicantInterviewLines.Score := 0;
                                                    ApplicantInterviewLines."Interview Type" := ApplicantInterviewTable."Interview Type";
                                                    ApplicantInterviewLines."Maximum Score" := JobInterviewList."Maximum Score";
                                                    ApplicantInterviewLines."User ID" := Interviewers.Interviewer;
                                                    ApplicantInterviewLines.Code := ApplicantInterviewTable.Code;
                                                    ApplicantInterviewLines."Stage Code" := ApplicantInterviewTable."Stage Code";
                                                    ApplicantInterviewLines.INSERT;
                                                    testnumbers := testnumbers + 1;
                                                UNTIL JobInterviewList.NEXT = 0;
                                            END else
                                                Error('Technical Interview test questions does not exists');
                                            //===========================end lines
                                        END;

                                    UNTIL JobApplicationsTable.NEXT = 0;
                                END;

                            UNTIL Interviewers.NEXT = 0;
                        END ELSE
                            Error('Technical Interview Panel does not exists ');
                        "In Technical Test" := TRUE;
                        MESSAGE('Technical Interview Successfully Started!!');
                    END;
                end;
            }
        }
        area(Processing)
        {
            group("Employee Creation")
            {
                action("Convert To Employee")
                {
                    Caption = 'Convert To Employee';
                    Image = Employee;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()

                    begin

                        JobApplicationsTable.RESET;
                        JobApplicationsTable.SETRANGE("Job ID", "No.");
                        JobApplicationsTable.SETRANGE("Offer Letter of Appointment", TRUE);
                        JobApplicationsTable.SETRANGE("Offer Letter Accepted", TRUE);
                        IF JobApplicationsTable.FINDFIRST THEN BEGIN
                            IF CONFIRM('Are You Sure You Want To Convert  ' + JobApplicationsTable."First Name" + '  As Employee?', FALSE) = TRUE THEN BEGIN

                                REPEAT
                                    JobApplicationsTable.EmployApplicant(JobApplicationsTable, "Job ID", Description);
                                UNTIL JobApplicationsTable.NEXT = 0;
                            END;
                        END ELSE
                            MESSAGE('NO SUCH RECORD!');
                    end;
                }
            }

            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Visible = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()

                    begin

                        if ApprovalsMgmtExt.CheckRecruitmentApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendRecruitmentforApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Visible = CanCancelApprovalForRecord or CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()

                    begin
                        ApprovalsMgmtExt.OnCancelRecruitmentforApproval(Rec);

                    end;
                }
            }
        }
    }

    var
        JobApplicationsTable: Record "Job Applicants";
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmtExt: Codeunit "Approvals Mgmt. HR Ext";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";


    trigger OnOpenPage()

    begin
        SetControlAppearance();

    end;

    trigger OnAfterGetRecord()

    begin
        SetControlAppearance;

    end;

    local procedure SetControlAppearance()

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForRecord);

    end;
}