codeunit 51513022 "HR Leave Jnl.-Post"
{
    // version HR

    TableNo = "HR Journal Line";

    trigger OnRun();
    begin
        HRJournalLine.COPY(Rec);
        Code;
        Rec.COPY(HRJournalLine);
    end;

    var
        Text000: Label 'Do you want to post the journal lines?';
        Text001: Label 'There is nothing to post.';
        Text002: Label 'The journal lines were successfully posted.';
        Text003: Label 'The journal lines were successfully posted. You are now in the %1 journal.';
        HRLeaveJournalTemplate: Record "HR Leave Journal Template";
        HRJournalLine: Record "HR Journal Line";
        HRLeaveJnlPostBatch: Codeunit "HR Leave Jnl.-Post Batch";
        TempJnlBatchName: Code[10];

    local procedure "Code"();
    begin
        with HRJournalLine do begin
            HRLeaveJournalTemplate.GET("Journal Template Name");
            HRLeaveJournalTemplate.TESTFIELD("Force Posting Report", false);

            if not CONFIRM(Text000, false) then
                exit;

            TempJnlBatchName := "Journal Batch Name";

            HRLeaveJnlPostBatch.RUN(HRJournalLine);

            if "Line No." = 0 then
                MESSAGE(Text001)
            else
                if TempJnlBatchName = "Journal Batch Name" then
                    MESSAGE(Text002)
                else
                    MESSAGE(
                      Text003,
                      "Journal Batch Name");

            if not FIND('=><') or (TempJnlBatchName <> "Journal Batch Name") then begin
                RESET;
                FILTERGROUP := 2;
                SETRANGE("Journal Template Name", "Journal Template Name");
                SETRANGE("Journal Batch Name", "Journal Batch Name");
                FILTERGROUP := 0;
                "Line No." := 1;
            end;
        end;
    end;
}

