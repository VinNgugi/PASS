page 51513163 "Employee Absentism Card"
{
    // version HR

    PageType = Card;
    SourceTable = "Employee Absentism";
    Caption = 'Employee Absentism Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Absent No."; "Absent No.")
                {
                }
                field("Employee No"; "Employee No")
                {
                    Editable = true;
                    NotBlank = true;

                    trigger OnValidate();
                    begin
                        if "Employee No" <> '' then
                            LinesVisible := true;
                    end;
                }
                field("Absent From"; "Absent From")
                {
                    NotBlank = true;
                }
                field("Absent To"; "Absent To")
                {
                    NotBlank = true;
                }
                field("Reason for Absentism"; "Reason for Absentism")
                {
                    NotBlank = true;
                }
                field(Penalty; Penalty)
                {
                    NotBlank = true;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                }
                field("No. of  Days Absent"; "No. of  Days Absent")
                {
                    Editable = false;
                }
            }
            part("Employee Absentism List"; "Employee Absentism Line")
            {
                Caption = 'Employee Absentism List';
                SubPageLink = "Employee No" = FIELD ("Employee No");
                Visible = LinesVisible;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(SendMail)
            {
                Caption = 'SendMail';
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    if CONFIRM('Are you sure you want to report this case?') = true then begin
                        HumanResourcesSetupRec.GET;
                        TESTFIELD("No. of  Days Absent");
                        TESTFIELD("Employee No");

                        if UserSetup.GET(USERID) then
                            SenderAddress := UserSetup."E-Mail";
                        //Get Hr hod email
                        if UserSetupCopy.GET(HumanResourcesSetupRec."HR HOD") then
                            HRHoDEmail := UserSetupCopy."E-Mail";
                        CompanyInformationRec.GET;
                        //CompanyInformationRec.TESTFIELD("Administrator Email");
                        if SenderAddress <> '' then begin
                            SenderName := COMPANYNAME;
                            Body := STRSUBSTNO('Hello,<br>This is to bring to your attention %1 absence  for %2 days for your action<br><br>Kind Regardsbr<br>');
                            Body := STRSUBSTNO(Body, "Absent No.", "Employee Name");
                            Subject := STRSUBSTNO('REF:Employee Absence');
                            SMTPSetup.CreateMessage(SenderName, SenderAddress, HRHoDEmail, Subject, Body, true);
                            SMTPSetup.Send;
                            Status := Status::Released;
                            MODIFY;
                        end;

                    end
                    else
                        exit;
                end;
            }
        }
    }

    trigger OnOpenPage();
    begin
        if "Employee No" <> '' then
            LinesVisible := true;
    end;

    var
        email: Text[50];
        Mail: Codeunit Mail;
        EmployeeRec: Record Employee;
        UserSetup: Record "User Setup";
        OfficeEmail: Text[50];
        d: Date;
        LinesVisible: Boolean;
        CompanyInformationRec: Record "Company Information";
        SMTPSetup: Codeunit "SMTP Mail";
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
}

