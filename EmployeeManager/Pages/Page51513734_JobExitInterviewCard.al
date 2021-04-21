page 51513734 "Job Exit Interview Card"
{
    PageType = Card;
    SourceTable = "Job Exit Interview";
    Caption = 'Job Exit Interview Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Employee No."; "Employee No.")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                }
                field(Supervisor; Supervisor)
                {
                    Editable = false;
                }
                field("Date of Join"; "Date of Join")
                {
                    Editable = false;
                }
                field("Termination Date"; "Termination Date")
                {
                }
                field("Reason for Leaving"; "Reason for Leaving")
                {
                }
                field("Job Satisfying areas"; "Job Satisfying areas")
                {
                    MultiLine = true;
                }
                field("Job Frustrating Areas"; "Job Frustrating Areas")
                {
                    MultiLine = true;
                }
                field("Complicated Company Policies"; "Complicated Company Policies")
                {
                    Caption = 'Complicated Company Policies/Procedures';
                    MultiLine = true;
                }
                field("Future Re-Employment"; "Future Re-Employment")
                {
                }
                field("Recommend To Others"; "Recommend To Others")
                {
                }
                field("Leaving could have prevented"; "Leaving could have prevented")
                {

                    trigger OnValidate();
                    begin
                        if "Leaving could have prevented" = true then
                            PreventiveMeasureDescriptionEnabled := true
                        else
                            PreventiveMeasureDescriptionEnabled := false;
                    end;
                }
                group(Control25)
                {
                    Visible = PreventiveMeasureDescriptionEnabled;
                    field("Preventive Measure Description"; "Preventive Measure Description")
                    {
                        MultiLine = true;
                    }
                }
            }
            group("Employment Experience Rating")
            {
                Caption = 'Employment Experience Rating';
            }
            part(Control19; "Employee work Experience Ratin")
            {
                SubPageLink = "Exit Interview Code" = FIELD (Code);
            }
            group("Supervisor Rating")
            {
                Caption = 'Supervisor Rating';
            }
            part("Employee-Supervisor Experience Rating"; "Employee Supervisor Exp Rating")
            {
                Caption = 'Employee-Supervisor Experience Rating';
                SubPageLink = "Exit Interview Code" = FIELD (Code);
            }
            field("Other Helpful  Information"; "Other Helpful  Information")
            {
                MultiLine = true;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Mail")
            {
                Caption = 'Send Mail';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    if CONFIRM('Are you sure you want to send notification to your supervisor?') = true then begin
                        HumanResourcesSetupRec.GET;
                        TESTFIELD("Termination Date");
                        TESTFIELD("Reason for Leaving");

                        //Get Hod's email
                        /*  SupervisorEmail := '';
                          UserSetupCopy.RESET;
                          UserSetupCopy.SETRANGE(UserSetupCopy."Employee No.", "Employee No.");
                          if UserSetupCopy.FINDFIRST then
                              if UserSetupRec.GET(UserSetupCopy."Immediate Supervisor") then
                                  SupervisorEmail := UserSetupRec."E-Mail";
  */
                        //Get Hr hod email
                        if UserSetupCopy.GET(HumanResourcesSetupRec."HR HOD") then
                            HRHoDEmail := UserSetupCopy."E-Mail";

                        CompanyInformationRec.GET;
                        //CompanyInformationRec.TESTFIELD("Administrator Email");
                        //SenderAddress := CompanyInformationRec."Administrator Email";
                        if SenderAddress <> '' then begin
                            SenderName := COMPANYNAME;
                            Body := STRSUBSTNO('Hello,<br>This is to bring to you attention my exit interview %1  for your action<br><br>Kind Regardsbr<br>');
                            Body := STRSUBSTNO(Body, Code);
                            Subject := STRSUBSTNO('REF:Exit Interview');
                            SMTPSetup.CreateMessage(SenderName, SenderAddress, SupervisorEmail, Subject, Body, true);
                            SMTPSetup.AddCC(HRHoDEmail);
                            SMTPSetup.Send;
                            MODIFY;
                        end;
                        CurrPage.CLOSE();
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        if "Leaving could have prevented" = true then
            PreventiveMeasureDescriptionEnabled := true
        else
            PreventiveMeasureDescriptionEnabled := false;
    end;

    var
        CompanyInformationRec: Record "Company Information";
        SMTPSetup: Codeunit "SMTP Mail";
        UserSetup: Record "User Setup";
        SenderAddress: Text[80];
        Recipients: Text[80];
        SenderName: Text[50];
        Body: Text[250];
        Subject: Text[80];
        HumanResourcesSetupRec: Record "Human Resources Setup";
        userchoice: Integer;
        UserSetupCopy: Record "User Setup";
        UserSetupRec: Record "User Setup";
        SupervisorEmail: Text;
        HRHoDEmail: Text;
        PreventiveMeasureDescriptionEnabled: Boolean;
}

