page 51513152 "Leave Applications List"
{
    // version HR

    CardPageID = "Leave Application HR";
    PageType = List;
    SourceTable = "Employee Leave Application";
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Employee No"; "Employee No")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                }
                field("Application No"; "Application No")
                {
                }
                field("Leave Code"; "Leave Code")
                {
                }
                field("Days Applied"; "Days Applied")
                {
                }
                field("Start Date"; "Start Date")
                {
                }
                field("End Date"; "End Date")
                {
                }
                field("Application Date"; "Application Date")
                {
                }
                field("Approved Days"; "Approved Days")
                {
                }
                field("Approved End Date"; "Approved End Date")
                {
                }
                field("Approval Date"; "Approval Date")
                {
                }
                field(FirstApprover; FirstApprover)
                {
                    Caption = 'FirstApprover';
                }
                field(FirstApproverDate; FirstApproverDate)
                {
                    Caption = 'FirstApproverDate';
                }
                field(SecondApprover; SecondApprover)
                {
                    Caption = 'SecondApprover';
                }
                field(SecondApproverDate; SecondApproverDate)
                {
                    Caption = 'SecondApproverDate';
                }
                field(ThirdApprover; ThirdApprover)
                {
                    Caption = 'ThirdApprover';
                }
                field(ThirdApproverDate; ThirdApproverDate)
                {
                    Caption = 'ThirdApproverDate';
                }
                field("Leave Allowance Payable"; "Leave Allowance Payable")
                {
                }
                field(days; days)
                {
                }
                field("No. series"; "No. series")
                {
                }
                field("Resumption Date"; "Resumption Date")
                {
                }
                field(Status; Status)
                {
                }
                field("Balance brought forward"; "Balance brought forward")
                {
                }
                field("Leave Entitlment"; "Leave Entitlment")
                {
                }
                field("Recalled Days"; "Recalled Days")
                {
                }
                field("Total Leave Days Taken"; "Total Leave Days Taken")
                {
                }
                field("Days Absent"; "Days Absent")
                {
                }
                field("Leave balance"; "Leave balance")
                {
                }
                field("Acting Person"; "Acting Person")
                {
                }
                field(Name; Name)
                {
                }
                field("Annual Leave Entitlement Bal"; "Annual Leave Entitlement Bal")
                {
                }
                field("Mobile No"; "Mobile No")
                {
                }
                field("Approved Start Date"; "Approved Start Date")
                {
                }
                field("Leave Earned to Date"; "Leave Earned to Date")
                {
                }
                field("Maturity Date"; "Maturity Date")
                {
                }
                field("Date of Joining Company"; "Date of Joining Company")
                {
                }
                field("Fiscal Start Date"; "Fiscal Start Date")
                {
                }
                field("No. of Months Worked"; "No. of Months Worked")
                {
                }
                field("Off Days"; "Off Days")
                {
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {
                }
                field("Directorate name"; "Directorate name")
                {
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                }
                field("Department Name"; "Department Name")
                {
                }
                field("User ID"; "User ID")
                {
                }
                field("Contract No."; "Contract No.")
                {
                }
                field("Requires Attachment"; "Requires Attachment")
                {
                }
                field(Extension; Extension)
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetCurrRecord();
    begin

        /*ApprovalEntry.RESET;
        ApprovalEntry.SETRANGE(ApprovalEntry.Status,ApprovalEntry.Status::Approved);
        ApprovalEntry.SETRANGE(ApprovalEntry."Document No.","Application No");
        IF ApprovalEntry.FIND('-') THEN
        BEGIN
          FirstApprover:=;
          FirstApproverDate:=;
          SecondApprover:=;
          SecondApproverDate:=;

        END;
          */

        if Status = Status::Approved then begin
            ApprovalEntries.RESET;
            ApprovalEntries.SETRANGE(ApprovalEntries."Document No.", "Application No");
            ApprovalEntries.SETRANGE(ApprovalEntries.Status, ApprovalEntries.Status::Approved);
            if ApprovalEntries.FIND('-') then begin
                i := 0;
                repeat
                    i := i + 1;
                    if i = 1 then begin
                        FirstApprover := ApprovalEntries."Approver ID";
                        FirstApproverDate := DT2DATE(ApprovalEntries."Last Date-Time Modified");
                    end;

                    if i = 2 then begin
                        SecondApprover := ApprovalEntries."Approver ID";
                        SecondApproverDate := DT2DATE(ApprovalEntries."Last Date-Time Modified");
                    end;

                    if i = 3 then begin
                        ThirdApprover := ApprovalEntries."Approver ID";
                        ThirdApproverDate := DT2DATE(ApprovalEntries."Last Date-Time Modified");
                    end;

                until ApprovalEntries.NEXT = 0;
            end;
        end;

    end;

    var
        FirstApprover: Code[30];
        FirstApproverDate: Date;
        SecondApprover: Code[30];
        SecondApproverDate: Date;
        ApprovalEntries: Record "Approval Entry";
        i: Integer;
        ThirdApprover: Code[30];
        ThirdApproverDate: Date;

    trigger OnOpenPage();
    begin
        usersetup.RESET;
        if usersetup.GET(USERID) then begin
            emprec.RESET;
            if emprec.GET(usersetup."Employee No.") then begin
                //SETRANGE("Employee No", emprec."No.");
                FILTERGROUP(10);
                SETRANGE("Employee No", emprec."No.");
                FILTERGROUP(0);
            end;
        end;
    end;

    var
        usersetup: Record "User Setup";
        emprec: Record Employee;
}

