codeunit 51513024 "HR Leave Jnl.-Check Line"
{
    // version HR

    TableNo = "HR Journal Line";

    trigger OnRun();
    var
        TempJnlLineDim: Record "Journal Line Dimension" temporary;
    begin
        GLSetup.GET;

        if "Shortcut Dimension 1 Code" <> '' then begin
            TempJnlLineDim."Table ID" := DATABASE::"HR Journal Line";
            TempJnlLineDim."Journal Template Name" := "Journal Template Name";
            TempJnlLineDim."Journal Batch Name" := "Journal Batch Name";
            TempJnlLineDim."Journal Line No." := "Line No.";
            TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 1 Code";
            TempJnlLineDim."Dimension Value Code" := "Shortcut Dimension 1 Code";
            TempJnlLineDim.INSERT;
        end;
        if "Shortcut Dimension 2 Code" <> '' then begin
            TempJnlLineDim."Table ID" := DATABASE::"HR Journal Line";
            TempJnlLineDim."Journal Template Name" := "Journal Template Name";
            TempJnlLineDim."Journal Batch Name" := "Journal Batch Name";
            TempJnlLineDim."Journal Line No." := "Line No.";
            TempJnlLineDim."Dimension Code" := GLSetup."Global Dimension 2 Code";
            TempJnlLineDim."Dimension Value Code" := "Shortcut Dimension 2 Code";
            TempJnlLineDim.INSERT;
        end;

        RunCheck(Rec, TempJnlLineDim);
    end;

    var
        Text000: Label 'The combination of dimensions used in %1 %2, %3, %4 is blocked. %5';
        Text001: Label 'A dimension used in %1 %2, %3, %4 has caused an error. %5';
        GLSetup: Record "General Ledger Setup";
        HRSetup: Record "Human Resources Setup";
        DimMgt: Codeunit DimensionManagement;
        CallNo: Integer;
        Text002: Label 'The Posting Date Must be within the open leave periods';
        Text003: Label 'The Posting Date Must be within the allowed Setup date';
        LeaveEntries: Record "HR Leave Ledger Entries";
        Text004: Label 'The Allocation of Leave days has been done for the period';
        ObjLeavePeriods: Record "HR Leave Periods";

    procedure ValidatePostingDate(var HRJnlLine: Record "HR Journal Line");
    begin
        with HRJnlLine do begin
            if "Leave Entry Type" = "Leave Entry Type"::Negative then begin
                TESTFIELD("Leave Period");
            end;
            TESTFIELD("Document No.");
            TESTFIELD("Posting Date");
            TESTFIELD("Staff No.");
            //  IF ("Posting Date"<"Leave Period Start Date") OR ("Posting Date">"Leave Period End Date")  THEN
            //     ERROR(FORMAT(Text002));

            ObjLeavePeriods.RESET;
            ObjLeavePeriods.SETRANGE("Period Code", "Leave Period");
            if ObjLeavePeriods.FIND('-') then begin
                if ObjLeavePeriods.Closed then
                    ERROR('Period %1 is already closed', ObjLeavePeriods."Period Code");
                if ("Posting Date" < ObjLeavePeriods."Starting Date") or ("Posting Date" > ObjLeavePeriods."Ending Date") then
                    ERROR(Text002);
            end;
        end;
        /*
             LeaveEntries.RESET;
             LeaveEntries.SETRANGE(LeaveEntries."Leave Type","Leave Type Code");
            IF LeaveEntries.FIND('-') THEN BEGIN
         IF LeaveEntries."Leave Transaction Type"=LeaveEntries."Leave Transaction Type"::"Leave Allocation" THEN BEGIN
         IF (LeaveEntries."Posting Date"<"Leave Period Start Date") OR
             (LeaveEntries."Posting Date">"Leave Period End Date")  THEN
             ERROR(FORMAT(Text004));
                     END;
           END;
        */
        //END;

    end;

    procedure RunCheck(var HRJnlLine: Record "HR Journal Line"; var JnlLineDim: Record "Journal Line Dimension");
    var
        TableID: array[10] of Integer;
        No: array[10] of Code[20];
    begin
        with HRJnlLine do begin
            if ("Transaction Type" = "Transaction Type"::"Leave Applied") or ("Transaction Type" = "Transaction Type"::"Leave Recall")
              or ("Transaction Type" = "Transaction Type"::Reversal) then begin
                TESTFIELD("Leave Application No.");
            end;

            TESTFIELD("Document No.");
            TESTFIELD("Posting Date");
            TESTFIELD("Staff No.");
            CallNo := 1;

            /* IF NOT DimMgt.CheckJnlLineDimComb(JnlLineDim) THEN
               ERROR(
                 Text000,
                 TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
                 DimMgt.GetDimCombErr);
             */
            //  TableID[1] := DATABASE::Table56175;
            TableID[1] := DATABASE::"HR Journal Line";
            No[1] := "Leave Application No.";
            /* IF NOT DimMgt.CheckJnlLineDimValuePosting(JnlLineDim,TableID,No) THEN
               IF "Line No." <> 0 THEN
                 ERROR(
                   Text001,
                   TABLECAPTION,"Journal Template Name","Journal Batch Name","Line No.",
                   DimMgt.GetDimValuePostingErr)
               ELSE
                 ERROR(DimMgt.GetDimValuePostingErr); */
        end;
        ValidatePostingDate(HRJnlLine);

    end;

    local procedure JTCalculateCommonFilters();
    begin
    end;
}

