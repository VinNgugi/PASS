codeunit 51513025 "HR Leave Jnl.-Post Line"
{
    // version HR

    Permissions = TableData "Ins. Coverage Ledger Entry" = rimd,
                  TableData "Insurance Register" = rimd;
    TableNo = "HR Journal Line";

    trigger OnRun();
    begin
        GLSetup.GET;
        TempJnlLineDim2.RESET;
        TempJnlLineDim2.DELETEALL;
        if "Shortcut Dimension 1 Code" <> '' then begin
            TempJnlLineDim2."Table ID" := DATABASE::"HR Journal Line";
            TempJnlLineDim2."Journal Template Name" := "Journal Template Name";
            TempJnlLineDim2."Journal Batch Name" := "Journal Batch Name";
            TempJnlLineDim2."Journal Line No." := "Line No.";
            TempJnlLineDim2."Dimension Code" := GLSetup."Global Dimension 1 Code";
            TempJnlLineDim2."Dimension Value Code" := "Shortcut Dimension 1 Code";
            TempJnlLineDim2.INSERT;
        end;
        if "Shortcut Dimension 2 Code" <> '' then begin
            TempJnlLineDim2."Table ID" := DATABASE::"HR Journal Line";
            TempJnlLineDim2."Journal Template Name" := "Journal Template Name";
            TempJnlLineDim2."Journal Batch Name" := "Journal Batch Name";
            TempJnlLineDim2."Journal Line No." := "Line No.";
            TempJnlLineDim2."Dimension Code" := GLSetup."Global Dimension 2 Code";
            TempJnlLineDim2."Dimension Value Code" := "Shortcut Dimension 2 Code";
            TempJnlLineDim2.INSERT;
        end;
        RunWithCheck(Rec, TempJnlLineDim2);
    end;

    var
        GLSetup: Record "General Ledger Setup";
        FA: Record Employee;
        HR: Record "Employee Leave Application";
        HRJnlLine: Record "HR Journal Line";
        LeaveLedgEntry: Record "HR Leave Ledger Entries";
        LeaveLedgEntry2: Record "HR Leave Ledger Entries";
        HRReg: Record "HR Leave Register";
        HRJnlCheckLine: Codeunit "HR Leave Jnl.-Check Line";
        DimMgt: Codeunit DimensionManagement;
        NextEntryNo: Integer;
        TempJnlLineDim: Record "Journal Line Dimension";
        TempJnlLineDim2: Record "Journal Line Dimension";

    procedure RunWithCheck(var HRJnlLine2: Record "HR Journal Line"; TempJnlLineDim2: Record "Journal Line Dimension");
    begin
        HRJnlLine.COPY(HRJnlLine2);
        TempJnlLineDim.RESET;
        TempJnlLineDim.DELETEALL;
        //DimMgt.CopyJnlLineDimToJnlLineDim(TempJnlLineDim2,TempJnlLineDim);
        Code(true);
        HRJnlLine2 := HRJnlLine;
    end;

    procedure RunWithOutCheck(var HRJnlLine2: Record "HR Journal Line"; TempJnlLineDim: Record "Journal Line Dimension");
    begin
        HRJnlLine.COPY(HRJnlLine2);

        TempJnlLineDim.RESET;
        TempJnlLineDim.DELETEALL;
        //DimMgt.CopyJnlLineDimToJnlLineDim(TempJnlLineDim2,TempJnlLineDim);

        Code(false);
        HRJnlLine2 := HRJnlLine;
    end;

    local procedure "Code"(CheckLine: Boolean);
    begin
        with HRJnlLine do begin
            if "Document No." = '' then
                exit;
            if CheckLine then
                //    HRJnlCheckLine.RunCheck(HRJnlLine,TempJnlLineDim);
                HR.RESET;
            //HR.SETRANGE("Leave Application No.",
            // HR.GET("Document No.");
            FA.GET("Staff No.");
            CopyFromJnlLine(LeaveLedgEntry, HRJnlLine);
            //MakeInsCoverageLedgEntry.CopyFromHRCard(InsCoverageLedgEntry,HR);
        end;
        if NextEntryNo = 0 then begin
            LeaveLedgEntry.LOCKTABLE;
            if LeaveLedgEntry2.FIND('+') then
                NextEntryNo := LeaveLedgEntry2."Entry No.";
            HRReg.LOCKTABLE;
            if HRReg.FIND('+') then
                HRReg."No." := HRReg."No." + 1
            else
                HRReg."No." := 1;
            HRReg.INIT;
            HRReg."From Entry No." := NextEntryNo + 1;
            HRReg."Creation Date" := TODAY;
            HRReg."Source Code" := HRJnlLine."Source Code";
            HRReg."Journal Batch Name" := HRJnlLine."Journal Batch Name";
            HRReg."User ID" := USERID;
        end;
        NextEntryNo := NextEntryNo + 1;
        LeaveLedgEntry."Entry No." := NextEntryNo;
        LeaveLedgEntry.INSERT;
        /*
        DimMgt.MoveJnlLineDimToLedgEntryDim(
          TempJnlLineDim,DATABASE::"HR Leave Ledger Entries",
          InsCoverageLedgEntry."Entry No.");
        */
        if HRReg."To Entry No." = 0 then begin
            HRReg."To Entry No." := NextEntryNo;
            HRReg.INSERT;
        end else begin
            HRReg."To Entry No." := NextEntryNo;
            HRReg.MODIFY;
        end;

    end;

    procedure CopyFromJnlLine(var ObjLeaveLedgEntry: Record "HR Leave Ledger Entries"; var ObjLeaveJnlLine: Record "HR Journal Line");
    begin
        with ObjLeaveLedgEntry do begin
            "User ID" := USERID;
            "Leave Period" := ObjLeaveJnlLine."Leave Period";
            "Staff No." := ObjLeaveJnlLine."Staff No.";
            "Staff Name" := ObjLeaveJnlLine."Staff Name";
            "Posting Date" := ObjLeaveJnlLine."Posting Date";
            "Leave Recalled No." := ObjLeaveJnlLine."Leave Recalled No.";
            "Leave Entry Type" := ObjLeaveJnlLine."Leave Entry Type";
            if ObjLeaveJnlLine."Leave Entry Type" = ObjLeaveJnlLine."Leave Entry Type"::Negative then begin
                if ObjLeaveJnlLine."No. of Days" > 0 then
                    "No. of days" := ObjLeaveJnlLine."No. of Days" * -1
                else
                    "No. of days" := ObjLeaveJnlLine."No. of Days";
            end else begin
                "No. of days" := ObjLeaveJnlLine."No. of Days";
            end;
            "Leave Type" := ObjLeaveJnlLine."Leave Type";
            "Leave Approval Date" := ObjLeaveJnlLine."Leave Approval Date";
            "Leave Type" := ObjLeaveJnlLine."Leave Type";
            if "Leave Approval Date" = 0D then
                "Leave Approval Date" := "Posting Date";
            "Document No." := ObjLeaveJnlLine."Document No.";
            "External Document No." := ObjLeaveJnlLine."External Document No.";
            "Leave Posting Description" := ObjLeaveJnlLine.Description;
            "Global Dimension 1 Code" := ObjLeaveJnlLine."Shortcut Dimension 1 Code";
            "Global Dimension 2 Code" := ObjLeaveJnlLine."Shortcut Dimension 2 Code";
            "Source Code" := ObjLeaveJnlLine."Source Code";
            "Journal Batch Name" := ObjLeaveJnlLine."Journal Batch Name";
            "Reason Code" := ObjLeaveJnlLine."Reason Code";
            "Credited Back" := ObjLeaveJnlLine."Credited Back";
            "No. Series" := ObjLeaveJnlLine."Posting No. Series";
            "Transaction Type" := ObjLeaveJnlLine."Transaction Type";
        end;
    end;
}

