page 51513153 "Leave Application HR"
{
    // version HR

    Editable = true;
    PageType = Card;
    SourceTable = "Employee Leave Application";
    Caption = 'Leave Application HR';
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            group("Leave Application")
            {
                Caption = 'Leave Application';
                Editable = (EditableData);
                group(Application)
                {
                    Caption = 'Application';
                    Editable = true;
                    field("Application No"; "Application No")
                    {
                        Editable = false;
                    }
                    field("Employee No"; "Employee No")
                    {
                        Editable = true;
                        Visible = true;
                    }
                    field("Application Date"; "Application Date")
                    {
                        Caption = 'Date of Application';
                        Editable = false;
                    }
                    field("Employee Name"; "Employee Name")
                    {
                        Editable = false;
                        Visible = true;
                    }
                    field("Mobile No"; "Mobile No")
                    {
                    }
                    field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                    {
                    }
                    field("Department Name"; "Department Name")
                    {
                        Editable = false;
                    }
                    field(Extension; Extension)
                    {
                    }
                    field("Leave Code"; "Leave Code")
                    {
                        Caption = 'Leave Type';
                        NotBlank = true;
                    }
                    field("Leave Allowance Payable"; "Leave Allowance Payable")
                    {
                        Caption = 'Pay Leave Allowance';
                    }
                }
                group(Balances)
                {
                    Caption = 'Balances';
                    field("Balance brought forward"; "Balance brought forward")
                    {
                        Editable = false;
                    }
                    field("Leave Earned to Date"; "Leave Earned to Date")
                    {
                        Editable = false;
                    }
                    field("Total Leave Days Taken"; "Total Leave Days Taken")
                    {
                        Caption = 'No of Days Taken To Date';
                        Editable = false;
                    }
                    field("Leave Entitlment"; "Leave Entitlment")
                    {
                        Caption = 'Leave Entitlment';
                        Editable = false;
                    }
                    field("Recalled Days"; "Recalled Days")
                    {
                        Caption = 'Recalled Days';
                        Editable = false;
                    }
                    field("Days Absent"; "Days Absent")
                    {
                        Caption = 'Days Absent';
                    }
                    field("Leave balance"; "Leave balance")
                    {
                        Caption = 'Available Leave Balance';
                        Editable = false;
                    }
                }
                group("Current Application Details")
                {
                    Caption = 'Current Application Details';
                    Editable = true;
                    field("Start Date"; "Start Date")
                    {
                    }
                    field("Days Applied"; "Days Applied")
                    {
                        NotBlank = true;

                        trigger OnValidate();
                        begin
                            if "Days Applied" > "Leave balance" then
                                ERROR('The days applied for are more than your leave balance');
                        end;
                    }
                    field("End Date"; "End Date")
                    {
                        Editable = false;
                    }
                    field("Resumption Date"; "Resumption Date")
                    {
                        Editable = false;
                        NotBlank = true;
                    }
                    field("Annual Leave Entitlement Bal"; "Annual Leave Entitlement Bal")
                    {
                        Caption = 'Leave Balance';
                        Editable = false;
                    }
                    field("Acting Person"; "Acting Person")
                    {
                    }
                    field(Name; Name)
                    {
                    }
                    field(Comments; Comments)
                    {
                    }
                    field(Status; Status)
                    {
                        Editable = false;
                    }
                    field("No. of Approvals"; "No. of Approvals")
                    {
                        Editable = false;
                    }
                    field("Pending Approver"; "Pending Approver")
                    {
                        Editable = false;
                    }
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group(Approvals)
            {
                Caption = 'Approvals';
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = IsSendForApprovalVisible;

                    trigger OnAction();
                    begin
                        TESTFIELD("Application No");
                        TESTFIELD("Days Applied");
                        TESTFIELD("Leave Code");

                        days := "Days Applied";

                        IF ApprovalMgt.CheckLeaveApplicationApprovalWorkflowEnabled(Rec) THEN
                            ApprovalMgt.OnSendLeaveApplicationforApproval(Rec);

                        /*IF "Requires Attachment" THEN BEGIN
                            IF "Attachnemt Uploaded" THEN BEGIN
                                if ApprovalMgt.CheckLeaveApplicationApprovalWorkflowEnabled(Rec) then
                                    ApprovalMgt.OnSendLeaveApplicationforApproval(Rec);
                            END ELSE BEGIN
                                ERROR('This leave requires attached documentation. Please attach supporting documents to proceed');
                            END;
                        END ELSE BEGIN
                            IF ApprovalMgt.CheckLeaveApplicationApprovalWorkflowEnabled(Rec) THEN
                                ApprovalMgt.OnSendLeaveApplicationforApproval(Rec);
                        END;*/
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = IsCancelVisible;

                    trigger OnAction();
                    begin
                        ApprovalMgt.OnCancelLeaveApplicationforApproval(Rec);
                    end;
                }
                action(Comment)
                {
                    ApplicationArea = Suite;
                    Caption = 'Comments';
                    Image = ViewComments;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.GetApprovalComment(Rec);
                    end;
                }
            }
            group(ActionGroup5)
            {
                action(Approve)
                {
                    ApplicationArea = Suite;
                    Caption = 'Approve';
                    Image = Approve;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    ToolTip = 'Approve the requested changes.';
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.ApproveRecordApprovalRequest(RECORDID);
                        CurrPage.CLOSE;
                    end;
                }
                action(Reject)
                {
                    ApplicationArea = Suite;
                    Caption = 'Reject';
                    Image = Reject;
                    Promoted = true;
                    PromotedCategory = Category4;
                    PromotedIsBig = true;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.RejectRecordApprovalRequest(RECORDID);
                        CurrPage.CLOSE;
                    end;
                }
                action(Delegate)
                {
                    ApplicationArea = Suite;
                    Caption = 'Delegate';
                    Image = Delegate;
                    Promoted = true;
                    PromotedCategory = Category4;
                    Visible = OpenApprovalEntriesExistForCurrUser;

                    trigger OnAction();
                    var
                        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
                    begin
                        ApprovalsMgmt.DelegateRecordApprovalRequest(RECORDID);
                        CurrPage.CLOSE;
                    end;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';
                action(Print)
                {
                    Caption = 'Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = "Report";

                    trigger OnAction();
                    begin
                        RESET;
                        SETFILTER("Application No", "Application No");
                        REPORT.RUN(51511192, true, true, Rec);
                        RESET;
                    end;
                }
                action("View Attachments")
                {
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        SharePointLink.RESET;
                        //SharePointLink.SETRANGE("Document Type", SharePointLink."Document Type"::Leave);
                        if SharePointLink.FINDFIRST then begin
                            DocUrl := SharePointLink."URL Path" + "Application No" + '.pdf';
                            HYPERLINK(DocUrl);

                        end;
                    end;
                }
                action("Upload Leave Attachment")
                {
                    Image = Document;
                    Promoted = true;
                    PromotedCategory = "Report";
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        if CONFIRM('DO you want to upload an attachment?') then begin
                            SharePointLink.RESET;
                            //SharePointLink.SETRANGE("Document Type", SharePointLink."Document Type"::Leave1);
                            if SharePointLink.FINDFIRST then begin
                                FileName := SharePointLink."URL Path" + "Application No" + '.pdf';
                                Success := UPLOAD('upload File', 'C:\', 'PDF Files(*.pdf)|*.pdf', 'Select a file', FileName);
                                if Success then begin
                                    MESSAGE('Uploaded Successfully!');
                                    "Attachnemt Uploaded" := true;
                                    MODIFY;
                                end;
                            end;

                        end;
                    end;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        EditableData := true;
        If Status <> Status::Open then begin
            EditableData := false;
            CurrPage.Editable := false;
        end;
    end;

    trigger OnAfterGetRecord();
    begin
        if Status = Status::Open then
            IsSendForApprovalVisible := true
        else
            IsSendForApprovalVisible := false;

        if Status = Status::"Pending Approval" then
            IsCancelVisible := true
        else
            IsCancelVisible := false;

        //Approve,reject button visibility
        approvalentry.RESET;
        approvalentry.SETFILTER(approvalentry.Status, '%1', approvalentry.Status::Open);
        approvalentry.SETFILTER(approvalentry."Document Type", '%1', approvalentry."Document Type"::" ");
        approvalentry.SETFILTER(approvalentry."Approver ID", '%1', USERID);
        approvalentry.SETFILTER(approvalentry."Document No.", "Application No");
        if approvalentry.FINDSET then
            OpenApprovalEntriesExistForCurrUser := true
        else
            OpenApprovalEntriesExistForCurrUser := false;
    end;

    trigger OnOpenPage();
    begin
        /*
        IF NOT approvalentry.FINDSET THEN
          BEGIN
           OpenApprovalEntriesExistForCurrUser2:=TRUE;
          END;
        
        IF OpenApprovalEntriesExistForCurrUser=TRUE THEN
          BEGIN
           OpenApprovalEntriesExistForCurrUser2:=FALSE;
         END;
        IF Status=Status::Released THEN
         BEGIN
          OpenApprovalEntriesExistForCurrUser:=FALSE;
          OpenApprovalEntriesExistForCurrUser2:=FALSE;
        END;
        */

        if Status = Status::Open then
            IsSendForApprovalVisible := true
        else
            IsSendForApprovalVisible := false;

        if Status = Status::"Pending Approval" then
            IsCancelVisible := true
        else
            IsCancelVisible := false;

        //Approve,reject button visibility
        approvalentry.RESET;
        approvalentry.SETFILTER(approvalentry.Status, '%1', approvalentry.Status::Open);
        approvalentry.SETFILTER(approvalentry."Document Type", '%1', approvalentry."Document Type"::" ");
        approvalentry.SETFILTER(approvalentry."Approver ID", '%1', USERID);
        approvalentry.SETFILTER(approvalentry."Document No.", "Application No");
        if approvalentry.FINDSET then
            OpenApprovalEntriesExistForCurrUser := true
        else
            OpenApprovalEntriesExistForCurrUser := false;

    end;

    var
        ApprovalMgt: Codeunit "Approvals Mgmt. LV Ext";
        d: Date;
        Mail: Codeunit Mail;
        Body: Text[250];
        days: Decimal;
        LeaveAllowancePaid: Boolean;
        FiscalStart: Date;
        FiscalEnd: Date;
        AccPeriod: Record "Payroll Period";
        HRSetup: Record "Human Resources Setup";
        Text19051012: Label 'No. Of days to Apply';
        PendingApprover: Code[30];
        OpenApprovalEntriesExistForCurrUser: Boolean;
        approvalentry: Record "Approval Entry";
        OpenApprovalEntriesExistForCurrUser2: Boolean;
        i: Integer;
        approvalentries: Record "Approval Entry";
        IsCancelVisible: Boolean;
        IsSendForApprovalVisible: Boolean;
        CodeFactory: Codeunit "Code Factory";
        EmailMessage: Text;
        SMTPSetup: Record "SMTP Mail Setup";
        LeaveMessage: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt">Hope this finds you well. This is to notify you that your leave application serial No <b>%2</b> has been received and undergoing approval. Your supervisor will be notified of this for better work planning.</p> <p style="font-family:Verdana,Arial;font-size:9pt">Kindly do not proceed for any leave before you get an approval notification.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%3,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%4,</b></p>';
        SupervisorAppMail: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt">Hope this finds you well. This is to notify you that a staff, employee Number <b>%2</b> ,Name <b>%3</b> who is under your supervision has applied for a <b>%4</b> days leave starting from <b>%5</b> through to date <b>%6</b>. </p> <p style="font-family:Verdana,Arial;font-size:9pt">The reliever selected is <b>%7</b>.</p> <p style="font-family:Verdana,Arial;font-size:9pt">Should this affect your planned work schedule, or in the case that you don''t approve this, Kindly notify the HR department for further Actions.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%8,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%9,</b></p>';
        Employee: Record Employee;
        UserSetup: Record "User Setup";
        LeaveMessageCancel: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt">Hope this finds you well. This is to notify you that your leave application serial No <b>%2</b> has been cancelled. Your supervisor will be notified of this for better work planning.</p> <p style="font-family:Verdana,Arial;font-size:9pt">Kindly do not proceed for any leave before you get an approval notification.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%3,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%4,</b></p>';
        SupervisorAppMailCancel: TextConst ENU = '<p style="font-family:Verdana,Arial;font-size:10pt">Dear <b>%1</b>,</p> <p style="font-family:Verdana,Arial;font-size:9pt">Hope this finds you well. This is to notify you that a staff, employee Number <b>%2</b> ,Name <b>%3</b> who is under your supervision has applied for a <b>%4</b> days leave starting from <b>%5</b> through to date <b>%6</b>. </p> <p style="font-family:Verdana,Arial;font-size:9pt">The reliever selected is <b>%7</b>.</p> <p style="font-family:Verdana,Arial;font-size:9pt">Should this affect your planned work schedule, or in the case that you don''t approve this, Kindly notify the HR department for further Actions.</p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>Regards,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%8,</b></p> <p style="font-family:Verdana,Arial;font-size:9pt"><b>%9,</b></p>';
        SharePointLink: Record "Sharepoint Integration";
        DocUrl: Text;
        URL: TextConst ENU = 'https://cgiar.sharepoint.com/sites/IITA/Projects/msdynamics/Shared%20Documents/Forms/AllItems.aspx?id=%2Fsites%2FIITA%2FProjects%2Fmsdynamics%2FShared%20Documents%2FLeaves%2FLVA%2D5216%20%2Epdf&parent=%2Fsites%2FIITA%2FProjects%2Fmsdynamics%2FShared%20Documents%2FLeaves';
        FileName: Text;
        Success: Boolean;
        EditableData: Boolean;
}

