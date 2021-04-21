page 51513135 "HR Leave Journal Line"
{
    PageType = List;
    SourceTable = "HR Journal Line";
    Caption = 'HR Leave Journal Line';
    layout
    {
        area(Content)
        {

            field(CurrentJnlBatchName; CurrentJnlBatchName)
            {
                Caption = 'Batch Name';

                trigger OnValidate()
                begin

                    LeaveJnlManagement.CheckName(CurrentJnlBatchName, Rec);

                    CurrentJnlBatchNameOnAfterVali;
                end;

                trigger OnLookup(VAR Text: Text): Boolean
                begin
                    CurrPage.SAVERECORD;

                    LeaveJnlManagement.LookupName(CurrentJnlBatchName, Rec);
                    CurrPage.UPDATE(FALSE);


                end;
            }

            repeater(GroupName)
            {

                field("Line No."; "Line No.")
                {

                }
                field("Leave Period"; "Leave Period")
                {

                }
                field("Staff No."; "Staff No.")
                {

                }
                field("Staff Name"; "Staff Name")
                {

                }
                field("Leave Type"; "Leave Type")
                {

                }
                field("Transaction Type"; "Transaction Type")
                {

                }
                field("Leave Entry Type"; "Leave Entry Type")
                {

                }
                field("No. of Days"; "No. of Days")
                {

                }
                field(Description; Description)
                {

                }
                field("Document No."; "Document No.")
                {

                }
                field("Posting Date"; "Posting Date")
                {

                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {

                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {

                }
                field("Leave Application No."; "Leave Application No.")
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }



    actions
    {
        area(Processing)
        {
            action("Post Adjustments")
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;


                trigger OnAction();
                var
                    CurrentJnlBatchName: Code[20];
                begin
                    CODEUNIT.RUN(CODEUNIT::"HR Leave Jnl.-Post", Rec);

                    CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(FALSE);
                end;
            }
        }

    }

    var
        JnlSelected: Boolean;
        HRLeaveTypes: Record "Multi- Comp Leave Types";
        HREmp: Record Employee;
        HRLeaveLedger: Record "HR Leave Ledger Entries";
        LeaveJnlManagement: Codeunit LeaveJnlManagement;
        TestReportPrint: Codeunit "Test Report-Print";
        CurrentJnlBatchName: Code[20];
        LeaveDescription: Text[30];
        EmpDescription: Text[30];
        ShortcutDimCode: Code[20];
        OpenedFromBatch: Boolean;
        HRLeavePeriods: Record "HR Leave Periods";
        AllocationDone: Boolean;
        HRJournalBatch: Record "HR Leave Journal Batch";
        OK: Boolean;
        ApprovalEntries: Record "Approval Entry";
        LLE: Record "HR Leave Ledger Entries";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";

        OpenApprovalEntriesExistForCurrUser: Boolean;
        OpenApprovalEntriesExist: Boolean;
        InsuranceJnlManagement: Codeunit LeaveJnlManagement;


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        OpenedFromBatch := ("Journal Batch Name" <> '') AND ("Journal Template Name" = '');
        IF OpenedFromBatch THEN BEGIN
            CurrentJnlBatchName := "Journal Batch Name";
            LeaveJnlManagement.OpenJournal(CurrentJnlBatchName, Rec);
            EXIT;
        END;
        LeaveJnlManagement.TemplateSelection(PAGE::"HR Leave Journal Line", Rec, JnlSelected);
        IF NOT JnlSelected THEN
            ERROR('');
        LeaveJnlManagement.OpenJournal(CurrentJnlBatchName, Rec);
    end;


    procedure CheckGender(Emp: Record Employee; LeaveType: Record "Multi- Comp Leave Types") Allocate: Boolean

    //CHECK IF LEAVE TYPE ALLOCATION APPLIES TO EMPLOYEE'S GEND
    begin
        IF Emp.Gender = Emp.Gender::Male THEN BEGIN
            IF LeaveType.Gender = LeaveType.Gender::Male THEN
                Allocate := TRUE;
        END;

        IF Emp.Gender = Emp.Gender::Female THEN BEGIN
            IF LeaveType.Gender = LeaveType.Gender::Female THEN
                Allocate := TRUE;
        END;

        IF LeaveType.Gender = LeaveType.Gender::Both THEN
            Allocate := TRUE;
        EXIT(Allocate);

        IF Emp.Gender <> LeaveType.Gender THEN
            Allocate := FALSE;

        EXIT(Allocate);
    end;

    LOCAL procedure CurrentJnlBatchNameOnAfterVali()
    begin
        CurrPage.SAVERECORD;
        LeaveJnlManagement.SetName(CurrentJnlBatchName, Rec);
        CurrPage.UPDATE(FALSE);
    end;


}