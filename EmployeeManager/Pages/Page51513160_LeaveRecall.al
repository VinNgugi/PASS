page 51513160 "Leave Recall"
{
    // version HR

    PageType = Card;
    SourceTable = "Leave Recall";
    Caption = 'Leave Recall';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = (EditableData);

                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Recall Date"; "Recall Date")
                {
                }
                field("Leave Application"; "Leave Application")
                {
                    NotBlank = true;
                }
                field("Leave Ending Date"; "Leave Ending Date")
                {
                    Editable = false;
                }
                field("Employee No"; "Employee No")
                {
                    Editable = false;
                }
                field("Employee Name"; "Employee Name")
                {
                    Caption = 'Employee Name';
                    Editable = false;
                }
                field("Department Name"; "Department Name")
                {
                    Editable = false;
                }
                field("No. of Off Days"; "No. of Off Days")
                {
                    Caption = 'No. of Recalled Days';
                    Editable = true;
                }
                field("Recalled From"; "Recalled From")
                {
                }
                field("Recalled To"; "Recalled To")
                {
                    Editable = false;
                }
                field("Recalled By"; "Recalled By")
                {
                    Editable = false;
                    NotBlank = true;
                }
                field(Name; Name)
                {
                }
                field("Head Of Department"; "Head Of Department")
                {
                    Caption = 'Recalling Department';
                    Editable = false;
                    NotBlank = true;
                }
                field("Reason for Recall"; "Reason for Recall")
                {
                    NotBlank = true;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Approval Request")
            {
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;

                trigger OnAction();
                begin
                    if CONFIRM('Are you sure you want to recall this employee from leave?') = true then begin
                        TESTFIELD("Leave Application");
                        TESTFIELD("Employee No");
                        TESTFIELD(Name);
                        TESTFIELD("Leave Ending Date");
                        TESTFIELD("Recalled From");
                        TESTFIELD("Recalled To");
                        TESTFIELD("Recalled By");
                        TESTFIELD("Reason for Recall");
                        //TESTFIELD("Head Of Department");
                        //TESTFIELD("Department Name");
                        TESTFIELD("Recall Date");

                        if ApprovalMgmt.CheckLeaveRecallWorkflowEnabled(Rec) then
                            ApprovalMgmt.OnSendLeaveRecallForApproval(Rec);

                        //Status := Status::Released;
                    end;

                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = CanCancelApprovalForRecord;

                trigger OnAction()
                begin
                    if Confirm('Do you want to cancel the recall request') then begin
                        if ApprovalMgmt.CheckLeaveRecallWorkflowEnabled(Rec) then
                            ApprovalMgmt.OnCancelLeaveRecallApprovalRequest(Rec);
                    end;
                end;

            }
            action("DMS Link")
            {
                Image = Web;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction();
                begin

                    GLSetup.GET();
                    //link := GLSetup."DMS Imprest Link" + "No.";
                    HYPERLINK(link);
                end;
            }
        }
    }


    var
        d: Date;
        Mail: Codeunit Mail;
        EmployeeRec: Record Employee;
        email: Text[50];
        UserSetup: Record "User Setup";
        OfficeEmail: Text[50];
        Requester: Text[50];
        hod: Text[80];
        CompInfo: Record "Company Information";
        SMTP: Codeunit "SMTP Mail";
        SenderAddress: Text[80];
        Users: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        link: Text;
        EmployeeMail: Text;
        HrEmail: Text;
        HumanResourcesSetupRec: Record "Human Resources Setup";
        SMTPSetup: Record "SMTP Mail Setup";
        //CodeFactory: Codeunit "Code Factory";
        ApprovalMgmt: Codeunit "Approvals Mgmt. LV Ext";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EditableData: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        EditableData := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := TRUE;

        IF Status = Status::Released then begin
            OpenApprovalEntriesExist := FALSE;
            CanCancelApprovalForRecord := FALSE;
            EnabledApprovalWorkflowsExist := FALSE;
            EditableData := false;
        end;

        if Status <> Status::Open then begin
            CurrPage.Editable := false;
            EditableData := false;
        end;


    end;

    procedure FnSendRecallNotification(DocNum: Code[20]);
    begin
    end;
}

