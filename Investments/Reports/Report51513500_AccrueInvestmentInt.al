report 51513500 "Accrue Investments Interest"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem("Investment Header"; "Investment Header")
        {
            DataItemTableView = where (Posted = filter (true), Closed = filter (false), "FD Status" = filter (Active));


            trigger OnPredataItem()
            var
                myInt: Integer;
            begin
                if Rundate = 0D then
                    Rundate := Today;

                LineNo := 0;
                InvSetup.Get();
                JTemplate := InvSetup."Investment Template";
                JBatch := InvSetup."Investment Batch";

                if InvMgmt.LeapYear(Date2DMY(Rundate, 3)) then
                    TotalDaysinyear := 366
                else
                    TotalDaysinyear := 365;

                //*****Delete Existing Lines
                JournalLine.Reset();
                JournalLine.SetRange("Journal Template Name", JTemplate);
                JournalLine.SetRange("Journal Batch Name", JBatch);
                if JournalLine.FindSet() then
                    JournalLine.DeleteAll();
            end;


            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                InterestAmount := 0;
                WTaxAmount := 0;
                ReceivableAcc := '';
                IncomeAcc := '';

                if InvType.Get("Investment Header"."Investment Type") then begin
                    InvType.TestField(InvType."Interest Receivable Account");
                    InvType.TestField(InvType."Interest Income Account");

                    ReceivableAcc := InvType."Interest Receivable Account";
                    IncomeAcc := InvType."Interest Income Account";
                end;

                "Investment Header".CalcFields("Last Interest Date");
                if ("Investment Header"."Last Interest Date" = 0D) or ("Investment Header"."Last Interest Date" < Rundate) then begin
                    if "Investment Header"."Last Interest Date" <> 0D then begin
                        if "Investment Header"."Investment End Date" < Rundate then
                            InterestDays := "Investment Header"."Investment End Date" - "Investment Header"."Last Interest Date"
                        else
                            InterestDays := Rundate - "Investment Header"."Last Interest Date";
                    end
                    else begin
                        if "Investment Header"."Investment End Date" < Rundate then
                            InterestDays := "Investment Header"."Investment End Date" - "Investment Header"."Investment Start Date"
                        else
                            InterestDays := Rundate - "Investment Header"."Investment Start Date";
                    end;

                    //**********************Calculate Interest and wtax
                    InterestAmount := ("Investment Header"."Investment Principal" * (("Investment Header"."Investment Rate" / 100) * (1 / TotalDaysinyear) * InterestDays));
                    WTaxAmount := (InterestAmount * ("Investment Header"."Withholding Tax Rate" / 100));

                    //************************Populate Buffer
                    if InterestAmount <> 0 then begin
                        with ObjIntBuffer do begin
                            Init();
                            "Document No." := "Investment Header"."No.";
                            "Interest Date" := Rundate;
                            "Interest Amount" := InterestAmount;
                            "Captured By" := UserId;
                            "W/H Tax Amount" := WTaxAmount;
                            Insert(true);
                        end;
                    end;


                    //**********************Create Journals
                    //**********************Debit Receivable Account
                    LineNo := LineNo + 10000;
                    InvMgmt.FnCreateGnlJournalLine(JTemplate, JBatch, "Investment Header"."No.", LineNo, JournalLine."Account Type"::"G/L Account", ReceivableAcc, Rundate, InterestAmount,
                                            "Investment Header"."Global Dimension 1 Code", "Investment Header"."Global Dimension 2 Code", '', 'Interest Accrued ' + "Investment Header".Description, '', "Investment Header"."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', "Investment Header"."Currency Factor");

                    //**********************Credit Received Account
                    LineNo := LineNo + 10000;
                    InvMgmt.FnCreateGnlJournalLine(JTemplate, JBatch, "Investment Header"."No.", LineNo, JournalLine."Account Type"::"G/L Account", IncomeAcc, Rundate, (InterestAmount * -1),
                                            "Investment Header"."Global Dimension 1 Code", "Investment Header"."Global Dimension 2 Code", '', 'Interest Accrued ' + "Investment Header".Description, '', "Investment Header"."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', "Investment Header"."Currency Factor");


                end;

            end;


            trigger OnPostDataItem()
            var
                myInt: Integer;
            begin

                //*************** Post Journal
                JournalLine.Reset();
                JournalLine.SetRange("Journal Template Name", JTemplate);
                JournalLine.SetRange("Journal Batch Name", JBatch);
                if JournalLine.Find('-') then begin
                    Codeunit.Run(Codeunit::"Gen. Jnl.-Post", JournalLine);
                end;


                Message('Interest Accrual and posting as at %1 completed.', Rundate);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group("Running Date")
                {
                    field("Accrual Date"; Rundate)
                    {

                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        InvMgmt: Codeunit "Investment Management";
        Rundate: Date;
        JournalLine: Record "Gen. Journal Line";
        JTemplate: Code[20];
        JBatch: Code[20];
        LineNo: Integer;
        InvSetup: Record "Investment Setup";
        InterestAmount: Decimal;
        WTaxAmount: Decimal;
        InterestDays: Integer;
        TotalDaysinyear: Decimal;
        ObjIntBuffer: Record "Investment Interest Buffer";
        InvType: Record "Investment Types";
        ReceivableAcc: Code[20];
        IncomeAcc: Code[20];
        EntryNo: Integer;

}