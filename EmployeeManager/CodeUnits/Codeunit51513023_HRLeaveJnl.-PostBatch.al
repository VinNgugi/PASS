codeunit 51513023 "HR Leave Jnl.-Post Batch"
{
    // version HR

    //Permissions = TableData TableData56104=imd;
    TableNo = "HR Journal Line";

    trigger OnRun();
    begin
        HRJnlLine.COPY(Rec);
        Code;
        Rec := HRJnlLine;
    end;

    var
        Text000: Label 'cannot exceed %1 characters';
        Text001: Label 'Journal Batch Name    #1##########\\';
        Text002: Label 'Checking lines        #2######\';
        Text003: Label 'Posting lines         #3###### @4@@@@@@@@@@@@@';
        Text004: Label 'A maximum of %1 posting number series can be used in each journal.';
        HRJnlLine: Record "HR Journal Line";
        HRJnlTempl: Record "HR Leave Journal Template";
        HRJnlBatch: Record "HR Leave Journal Batch";
        HRReg: Record "HR Leave Register";
        LeaveLedgEntry: Record "HR Leave Ledger Entries";
        HRJnlLine2: Record "HR Journal Line";
        HRJnlLine3: Record "HR Journal Line";
        NoSeries: Record "No. Series" temporary;
        FAJnlSetup: Record "Human Resources Setup";
        HRJnlPostLine: Codeunit "HR Leave Jnl.-Post Line";
        HRJnlCheckLine: Codeunit "HR Leave Jnl.-Check Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NoSeriesMgt2: array[10] of Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        Window: Dialog;
        LineCount: Integer;
        StartLineNo: Integer;
        NoOfRecords: Integer;
        HRRegNo: Integer;
        LastDocNo: Code[20];
        LastDocNo2: Code[20];
        LastPostedDocNo: Code[20];
        NoOfPostingNoSeries: Integer;
        PostingNoSeriesNo: Integer;

    procedure "Code"();
    var
        UpdateAnalysisView: Codeunit "Update Analysis View";
        JnlLineDim: Record "Journal Line Dimension";
        TempJnlLineDim: Record "Journal Line Dimension" temporary;
    begin
        with HRJnlLine do begin
            SETRANGE("Journal Template Name", "Journal Template Name");
            SETRANGE("Journal Batch Name", "Journal Batch Name");
            if RECORDLEVELLOCKING then
                LOCKTABLE;

            HRJnlTempl.GET("Journal Template Name");
            HRJnlBatch.GET("Journal Template Name", "Journal Batch Name");
            if STRLEN(INCSTR(HRJnlBatch.Name)) > MAXSTRLEN(HRJnlBatch.Name) then
                HRJnlBatch.FIELDERROR(
                  Name,
                  STRSUBSTNO(
                    Text000,
                    MAXSTRLEN(HRJnlBatch.Name)));

            if not FIND('=><') then begin
                COMMIT;
                "Line No." := 0;
                exit;
            end;

            Window.OPEN(
              Text001 +
              Text002 +
              Text003);
            Window.UPDATE(1, "Journal Batch Name");

            // Check lines
            LineCount := 0;
            StartLineNo := "Line No.";
            repeat
                LineCount := LineCount + 1;
                Window.UPDATE(2, LineCount);

                JnlLineDim.SETRANGE("Table ID", DATABASE::"HR Journal Line");
                JnlLineDim.SETRANGE("Journal Template Name", "Journal Template Name");
                JnlLineDim.SETRANGE("Journal Batch Name", "Journal Batch Name");
                JnlLineDim.SETRANGE("Journal Line No.", "Line No.");
                JnlLineDim.SETRANGE("Allocation Line No.", 0);
                TempJnlLineDim.DELETEALL;
                //DimMgt.CopyJnlLineDimToJnlLineDim(JnlLineDim,TempJnlLineDim);
                HRJnlCheckLine.RunCheck(HRJnlLine, TempJnlLineDim);

                if NEXT = 0 then
                    FIND('-');
            until "Line No." = StartLineNo;
            NoOfRecords := LineCount;

            //LedgEntryDim.LOCKTABLE;
            LeaveLedgEntry.LOCKTABLE;
            if RECORDLEVELLOCKING then
                if LeaveLedgEntry.FIND('+') then;
            HRReg.LOCKTABLE;
            if HRReg.FIND('+') then
                HRRegNo := HRReg."No." + 1
            else
                HRRegNo := 1;

            // Post lines
            LineCount := 0;
            LastDocNo := '';
            LastDocNo2 := '';
            LastPostedDocNo := '';
            FIND('-');
            repeat
                LineCount := LineCount + 1;
                Window.UPDATE(3, LineCount);
                Window.UPDATE(4, ROUND(LineCount / NoOfRecords * 10000, 1));
                if not ("Leave Period" = '') and
                   (HRJnlBatch."No. Series" <> '') and
                   ("Document No." <> LastDocNo2)
                then
                    //TESTFIELD("Document No.",NoSeriesMgt.GetNextNo(HRJnlBatch."No. Series","Posting Date",FALSE));

                    //    LastDocNo2 := "Document No.";
                    LastDocNo2 := NoSeriesMgt.GetNextNo(HRJnlBatch."No. Series", "Posting Date", false);
                if "Posting No. Series" = '' then
                    "Posting No. Series" := HRJnlBatch."No. Series"
                else
                    if not ("Leave Period" = '') then
                        if "Document No." = LastDocNo then
                            "Document No." := LastPostedDocNo
                        else begin
                            if not NoSeries.GET("Posting No. Series") then begin
                                NoOfPostingNoSeries := NoOfPostingNoSeries + 1;
                                if NoOfPostingNoSeries > ARRAYLEN(NoSeriesMgt2) then
                                    ERROR(
                                      Text004,
                                      ARRAYLEN(NoSeriesMgt2));
                                NoSeries.Code := "Posting No. Series";
                                NoSeries.Description := FORMAT(NoOfPostingNoSeries);
                                NoSeries.INSERT;
                            end;
                            LastDocNo := "Document No.";
                            EVALUATE(PostingNoSeriesNo, NoSeries.Description);
                            "Document No." := NoSeriesMgt2[PostingNoSeriesNo].GetNextNo("Posting No. Series", "Posting Date", false);
                            LastPostedDocNo := "Document No.";
                        end;

                JnlLineDim.SETRANGE("Table ID", DATABASE::"HR Journal Line");
                JnlLineDim.SETRANGE("Journal Template Name", "Journal Template Name");
                JnlLineDim.SETRANGE("Journal Batch Name", "Journal Batch Name");
                JnlLineDim.SETRANGE("Journal Line No.", "Line No.");
                JnlLineDim.SETRANGE("Allocation Line No.", 0);
                TempJnlLineDim.DELETEALL;
                //DimMgt.CopyJnlLineDimToJnlLineDim(JnlLineDim,TempJnlLineDim);
                HRJnlPostLine.RunWithOutCheck(HRJnlLine, TempJnlLineDim);

            until NEXT = 0;

            if HRReg.FIND('+') then;
            if HRReg."No." <> HRRegNo then
                HRRegNo := 0;

            INIT;
            "Line No." := HRRegNo;

            // Update/delete lines
            if HRRegNo <> 0 then begin
                if not RECORDLEVELLOCKING then begin
                    JnlLineDim.LOCKTABLE(true, true);
                    LOCKTABLE(true, true);
                end;
                HRJnlLine2.COPYFILTERS(HRJnlLine);
                HRJnlLine2.SETFILTER("Leave Period", '<>%1', '');
                if HRJnlLine2.FIND('+') then; // Remember the last line

                JnlLineDim.SETRANGE("Table ID", DATABASE::"HR Journal Line");
                JnlLineDim.COPYFILTER("Journal Template Name", "Journal Template Name");
                JnlLineDim.COPYFILTER("Journal Batch Name", "Journal Batch Name");
                JnlLineDim.SETRANGE("Allocation Line No.", 0);

                HRJnlLine3.COPY(HRJnlLine);
                if HRJnlLine3.FIND('-') then
                    repeat
                        //JnlLineDim.SETRANGE("Journal Line No.",HRJnlLine3."Line No.");
                        //JnlLineDim.DELETEALL;
                        HRJnlLine3.DELETE;
                    until HRJnlLine3.NEXT = 0;
                HRJnlLine3.RESET;
                HRJnlLine3.SETRANGE("Journal Template Name", "Journal Template Name");
                HRJnlLine3.SETRANGE("Journal Batch Name", "Journal Batch Name");
                if not HRJnlLine3.FIND('+') then
                    if INCSTR("Journal Batch Name") <> '' then begin
                        HRJnlBatch.GET("Journal Template Name", "Journal Batch Name");
                        HRJnlBatch.DELETE;
                        //FAJnlSetup.IncHRJnlBatchName(HRJnlBatch);
                        HRJnlBatch.Name := INCSTR("Journal Batch Name");
                        if HRJnlBatch.INSERT then;
                        "Journal Batch Name" := HRJnlBatch.Name;
                    end;

                HRJnlLine3.SETRANGE("Journal Batch Name", "Journal Batch Name");
                if (HRJnlBatch."No. Series" = '') and not HRJnlLine3.FIND('+') then begin
                    HRJnlLine3.INIT;
                    HRJnlLine3."Journal Template Name" := "Journal Template Name";
                    HRJnlLine3."Journal Batch Name" := "Journal Batch Name";
                    HRJnlLine3."Line No." := 10000;
                    HRJnlLine3.INSERT;
                    HRJnlLine3.SetUpNewLine(HRJnlLine2);
                    HRJnlLine3.MODIFY;
                end;
            end;
            if HRJnlBatch."No. Series" <> '' then
                NoSeriesMgt.SaveNoSeries;
            if NoSeries.FIND('-') then
                repeat
                    EVALUATE(PostingNoSeriesNo, NoSeries.Description);
                    NoSeriesMgt2[PostingNoSeriesNo].SaveNoSeries;
                until NoSeries.NEXT = 0;

            COMMIT;
            CLEAR(HRJnlCheckLine);
            CLEAR(HRJnlPostLine);
        end;
        UpdateAnalysisView.UpdateAll(0, true);
        COMMIT;
    end;
}

