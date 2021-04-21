page 51513991 "Job Applicants Qualified Card"
{
    PageType = Card;
    SourceTable = "Job Applicants";
    SourceTableView = WHERE (Qualified = FILTER (true));
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(content)
        {
            group(Group)
            {
                field("No."; "No.")
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
                field("Application Date"; "Application Date")
                {
                }
                field("Job ID"; "Job ID")
                {
                    Caption = 'Job Requisition No';
                }
                field("Job Applied for"; "Job Applied for")
                {
                }
                field("Job Applied for Description"; "Job Applied for Description")
                {
                }
                field("Date of Interview"; "Date of Interview")
                {
                }
                field("Interview Start Time"; "Interview Start Time")
                {
                }
                field("Interview End Time"; "Interview End Time")
                {
                }
                field("Interview Type"; "Interview Type")
                {
                }
                field("Interview Invitation Sent"; "Interview Invitation Sent")
                {
                }
                field(Venue; Venue)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {

            action("Send Interview Invitation")
            {
                Caption = 'Send Interview Invitation';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    FN: Text;
                begin

                    TESTFIELD(Qualified, true);
                    TESTFIELD("Date of Interview");
                    TESTFIELD("Interview Start Time");
                    TESTFIELD("Interview End Time");
                    TESTFIELD(Venue);


                    FN := "First Name" + ' ' + "Middle Name" + ' ' + "Last Name";
                    if not CONFIRM(Text002, false, FN) then exit;



                    if "Interview Invitation Sent" = true then ERROR('Applicant has already been notified');

                    HRJobApplications.SETRANGE("No.", "No.");
                    CurrPage.SETSELECTIONFILTER(HRJobApplications);

                    if HRJobApplications.FIND('-') then
                        //GET E-MAIL PARAMETERS FOR JOB APPLICATIONS
                        /*HREmailParameters.RESET;
                        HREmailParameters.SETRANGE(HREmailParameters."Associate With",HREmailParameters."Associate With"::"Interview Invitations");
                        IF NOT HREmailParameters.FIND('-') THEN ERROR('Please setup Email Parameters');*/
                        begin
                        repeat
                            HRJobApplications.TESTFIELD(HRJobApplications."E-Mail");
                            SMTP.CreateMessage('tshepo.sebusi@attain-es.com', 'tshepo.sebusi@attain-es.com', HRJobApplications."E-Mail",
                            'Interview Invitation', 'Dear' + ' ' + HRJobApplications."First Name" + '<BR><br>' + ' '
                            + HRJobApplications."Job Applied for Description" + ' ' + 'applied on ' + FORMAT("Application Date") + ' ' + '<br>'
                            + ' ' + FORMAT(HRJobApplications."Date of Interview") + ' '
                            + 'Starting at ' + FORMAT(HRJobApplications."Interview Start Time") + ' to ' + FORMAT(HRJobApplications."Interview End Time") + ' Venue ' + HRJobApplications.Venue
                            + '<br><br>Best Regards' + '<br>' + COMPANYNAME, true);

                            SMTP.Send();
                        until HRJobApplications.NEXT = 0;

                        "Interview Invitation Sent" := true;
                        MODIFY;
                        MESSAGE('%1 has been invited for the Interview Invitation via E-Mail ', FN)
                    end;

                end;
            }
        }
    }

    var
        Text002: Label 'Are you sure you want to Send this Interview invitation to\%1?';
        fn: Text;
        HRJobApplications: Record "Job Applicants";
        SMTP: Codeunit "SMTP Mail";
}

