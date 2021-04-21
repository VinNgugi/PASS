codeunit 51513026 LeaveJnlManagement

{
    trigger OnRun()
    begin

    end;

    var

        OldHRNo: Code[20];
        OldFANo: Code[20];
        OpenFromBatch: Boolean;
        Text000: TextConst ENU = 'Leave';
        Text001: TextConst ENU = 'Leave Journal';
        Text002: TextConst ENU = 'DEFAULT';
        Text003: TextConst ENU = 'Default Journal';

    procedure TemplateSelection(FormID: Integer; VAR HRJnlLine: Record "HR Journal Line"; VAR JnlSelected: Boolean)
    var

        HRJnlTempl: Record "HR Leave Journal Template";


    begin
        JnlSelected := TRUE;

        HRJnlTempl.RESET;
        HRJnlTempl.SETRANGE("Form ID", FormID);

        CASE HRJnlTempl.COUNT OF

            0:

                BEGIN
                    HRJnlTempl.RESET;
                    HRJnlTempl.SETRANGE(HRJnlTempl.Name, Text000);
                    IF HRJnlTempl.FIND('-') THEN
                        HRJnlTempl.DELETEALL;

                    HRJnlTempl.INIT;
                    HRJnlTempl.Name := Text000;
                    HRJnlTempl.Description := Text001;
                    HRJnlTempl.VALIDATE("Form ID");
                    HRJnlTempl.INSERT;
                    COMMIT;
                END;

            1:
                HRJnlTempl.FIND('-');
            ELSE
                JnlSelected := PAGE.RUNMODAL(0, HRJnlTempl) = ACTION::LookupOK;
        END;
        IF JnlSelected THEN BEGIN
            HRJnlLine.FILTERGROUP := 2;
            HRJnlLine.SETRANGE("Journal Template Name", HRJnlTempl.Name);
            HRJnlLine.FILTERGROUP := 0;
            IF OpenFromBatch THEN BEGIN
                HRJnlLine."Journal Template Name" := '';
                PAGE.RUN(HRJnlTempl."Form ID", HRJnlLine);
            END;
        END;
    end;

    procedure TemplateSelectionFromBatch(VAR HRJnlBatch: Record "HR Leave Journal Batch")
    var

        HRJnlLine: Record "HR Journal Line";
        HRJnlTempl: Record "HR Leave Journal Template";
        JnlSelected: Boolean;
    begin
        OpenFromBatch := TRUE;
        HRJnlTempl.GET(HRJnlBatch."Journal Template Name");
        HRJnlTempl.TESTFIELD("Form ID");
        HRJnlBatch.TESTFIELD(Name);

        HRJnlLine.FILTERGROUP := 2;
        HRJnlLine.SETRANGE("Journal Template Name", HRJnlTempl.Name);
        HRJnlLine.FILTERGROUP := 0;

        HRJnlLine."Journal Template Name" := '';
        HRJnlLine."Journal Batch Name" := HRJnlBatch.Name;
        PAGE.RUN(HRJnlTempl."Form ID", HRJnlLine);
    end;

    procedure OpenJournal(VAR CurrentJnlBatchName: Code[20]; VAR HRJnlLine: Record "HR Journal Line")
    begin
        CheckTemplateName(HRJnlLine.GETRANGEMAX("Journal Template Name"), CurrentJnlBatchName);
        HRJnlLine.FILTERGROUP := 2;
        HRJnlLine.SETRANGE("Journal Batch Name", CurrentJnlBatchName);
        HRJnlLine.FILTERGROUP := 0;
    end;

    procedure OpenJnlBatch(VAR HRJnlBatch: Record "HR Leave Journal Batch")
    var

        HRJnlTemplate: Record "HR Leave Journal Template";
        HRJnlLine: Record "HR Journal Line";
        JnlSelected: Boolean;
    begin
        IF HRJnlBatch.GETFILTER("Journal Template Name") <> '' THEN
            EXIT;
        HRJnlBatch.FILTERGROUP(2);
        IF HRJnlBatch.GETFILTER("Journal Template Name") <> '' THEN BEGIN
            HRJnlBatch.FILTERGROUP(0);
            EXIT;
        END;
        HRJnlBatch.FILTERGROUP(0);

        IF NOT HRJnlBatch.FIND('-') THEN BEGIN
            IF NOT HRJnlTemplate.FIND('-') THEN
                TemplateSelection(0, HRJnlLine, JnlSelected);
            IF HRJnlTemplate.FIND('-') THEN
                CheckTemplateName(HRJnlTemplate.Name, HRJnlBatch.Name);
        END;
        HRJnlBatch.FIND('-');
        JnlSelected := TRUE;
        IF HRJnlBatch.GETFILTER("Journal Template Name") <> '' THEN
            HRJnlTemplate.SETRANGE(Name, HRJnlBatch.GETFILTER("Journal Template Name"));
        CASE HRJnlTemplate.COUNT OF
            1:
                HRJnlTemplate.FIND('-');
            ELSE
                JnlSelected := PAGE.RUNMODAL(0, HRJnlTemplate) = ACTION::LookupOK;
        END;
        IF NOT JnlSelected THEN
            ERROR('');

        HRJnlBatch.FILTERGROUP(2);
        HRJnlBatch.SETRANGE("Journal Template Name", HRJnlTemplate.Name);
        HRJnlBatch.FILTERGROUP(0);
    end;

    procedure CheckName(CurrentJnlBatchName: Code[20]; VAR HRJnlLine: Record "HR Journal Line")
    var
        HRJnlBatch: Record "HR Leave Journal Batch";
    begin
        HRJnlBatch.GET(HRJnlLine.GETRANGEMAX("Journal Template Name"), CurrentJnlBatchName);
    end;

    procedure SetName(CurrentJnlBatchName: Code[20]; VAR HRJnlLine: Record "HR Journal Line")
    begin
        HRJnlLine.FILTERGROUP := 2;
        HRJnlLine.SETRANGE("Journal Batch Name", CurrentJnlBatchName);
        HRJnlLine.FILTERGROUP := 0;
        IF HRJnlLine.FIND('-') THEN;
    end;

    procedure LookupName(VAR CurrentJnlBatchName: Code[20]; VAR HRJnlLine: Record "HR Journal Line"): Boolean
    var
        HRJnlBatch: Record "HR Leave Journal Batch";
    begin
        COMMIT;

        HRJnlBatch."Journal Template Name" := HRJnlLine.GETRANGEMAX("Journal Template Name");
        HRJnlBatch.Name := HRJnlLine.GETRANGEMAX("Journal Batch Name");
        HRJnlBatch.FILTERGROUP(2);
        HRJnlBatch.SETRANGE("Journal Template Name", HRJnlBatch."Journal Template Name");
        HRJnlBatch.FILTERGROUP(0);
        IF PAGE.RUNMODAL(0, HRJnlBatch) = ACTION::LookupOK THEN BEGIN
            CurrentJnlBatchName := HRJnlBatch.Name;
            SetName(CurrentJnlBatchName, HRJnlLine);
        END;
    end;

    procedure CheckTemplateName(CurrentJnlTemplateName: Code[10]; VAR CurrentJnlBatchName: Code[20])
    var
        HRJnlBatch: Record "HR Leave Journal Batch";
    begin
        IF NOT HRJnlBatch.GET(CurrentJnlTemplateName, CurrentJnlBatchName) THEN BEGIN
            HRJnlBatch.SETRANGE("Journal Template Name", CurrentJnlTemplateName);
            IF NOT HRJnlBatch.FIND('-') THEN BEGIN
                HRJnlBatch.INIT;
                HRJnlBatch."Journal Template Name" := CurrentJnlTemplateName;
                HRJnlBatch.SetupNewBatch;
                HRJnlBatch.Name := Text002;
                HRJnlBatch.Description := Text003;
                HRJnlBatch.INSERT(TRUE);
                COMMIT;
            END;
            CurrentJnlBatchName := HRJnlBatch.Name;
        END;
    end;

    procedure GetDescriptions(HRJnlLine: Record "HR Journal Line"; VAR HRDescription: Text[30]; VAR FADescription: Text[30])
    var

        HR: Record "Employee Leave Application";
        FA: Record Employee;
    begin
        IF HRJnlLine."Document No." <> OldHRNo THEN BEGIN
            HRDescription := '';
            IF HRJnlLine."Document No." <> '' THEN
                IF HR.GET(HRJnlLine."Document No.") THEN
                    //HRDescription := HR.Description;
                    OldHRNo := HRJnlLine."Document No.";
        END;
        IF HRJnlLine."Staff No." <> OldFANo THEN BEGIN
            FADescription := '';
            IF HRJnlLine."Staff No." <> '' THEN
                IF FA.GET(HRJnlLine."Staff No.") THEN
                    FADescription := FA."First Name";
            OldFANo := FA."No.";
        END;
    end;
}