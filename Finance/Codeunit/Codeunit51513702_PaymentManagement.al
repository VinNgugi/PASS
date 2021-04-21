codeunit 51513702 "Payment Management"
{
    trigger OnRun();
    begin
    end;

    var


        Cust: Record Customer;
        Gnljnline: Record "Gen. Journal Line";
        GenBatches: Record "Gen. Journal Batch";
        "GL Account": Record "G/L Account";
        GenSetUp: Record "Sales & Receivables Setup";
        Batch: Record "Gen. Journal Batch";
        CMSetup: Record "Cash Management Setup";
        ClaimRec: Record Claim;
        ClaimLines: Record "Guarantee Claim Line";
        TaxTarrifCode: Record "Tax Tarriff Code";

    procedure PostImprest(var imprest: Record "Payments HeaderFin")
    var

        ImprestLines: Record "Payments HeaderFin";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        GLEntry: Record "G/L Entry";
        BankRec: Record "Bank Account";
    begin
        imprest.TestField(Posted, false);
        IF CONFIRM('Are you sure you want to post Imprest No ' + Imprest."No." + '?', FALSE) = TRUE THEN BEGIN
            IF Imprest.Status <> Imprest.Status::Released THEN
                ERROR('The Imprest No ' + Imprest."No." + ' has not been fully approved');

            Imprest.TESTFIELD("Account No.");
            Imprest.TESTFIELD("Paying Bank Account");
            Imprest.TESTFIELD(Date);
            Imprest.TESTFIELD(Payee);
            Imprest.TESTFIELD("Pay Mode");
            IF Imprest.Payee = '' THEN
                Imprest.Payee := Imprest."Account Name";

            IF Imprest."Pay Mode" = '' THEN
                Imprest."Pay Mode" := 'CASH';

            IF Imprest."Pay Mode" = 'CHEQUE' THEN BEGIN
                Imprest.TESTFIELD("Cheque No");
                Imprest.TESTFIELD("Cheque Date");
            END;
            //Check if the imprest Lines have been populated
            ImprestLines.SETRANGE(ImprestLines."No.", Imprest."No.");
            IF NOT ImprestLines.FINDLAST THEN
                ERROR('The Imprest Lines are empty');

            Imprest.CALCFIELDS("Imprest Amount");
            IF Imprest."Imprest Amount" = 0 THEN
                ERROR('Amount cannot be zero');

            IF Imprest.Posted THEN
                ERROR('Imprest %1 has been posted', Imprest."No.");

            CMSetup.GET();
            CMSetup.TESTFIELD("Imprest Due Date");
            // Delete Lines Present on the General Journal Line
            GenJnLine.RESET;
            GenJnLine.SETRANGE(GenJnLine."Journal Template Name", CMSetup."Imprest Template");
            GenJnLine.SETRANGE(GenJnLine."Journal Batch Name", Imprest."No.");
            GenJnLine.DELETEALL;

            Batch.INIT;
            IF CMSetup.GET() THEN
                Batch."Journal Template Name" := CMSetup."Imprest Template";
            Batch.Name := Imprest."No.";
            IF NOT Batch.GET(Batch."Journal Template Name", Batch.Name) THEN
                Batch.INSERT;

            LineNo := 1000;
            GenJnLine.INIT;
            GenJnLine."Journal Template Name" := CMSetup."Imprest Template";
            GenJnLine."Journal Batch Name" := Imprest."No.";
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := Imprest."Paying Bank Account";
            GenJnLine."Posting Date" := imprest.Date;
            GenJnLine."Document No." := Imprest."No.";
            GenJnLine."External Document No." := Imprest."Cheque No";
            GenJnLine.Description := Imprest.Payee;
            GenJnLine.Amount := -Imprest."Imprest Amount";
            GenJnLine.VALIDATE(Amount);
            GenJnLine."Currency Code" := imprest.Currency;
            GenJnLine.Validate("Currency Code");
            GenJnLine."Currency Factor" := imprest."Currency Factor";
            GenJnLine.Validate("Currency Factor");
            GenJnLine."Shortcut Dimension 1 Code" := Imprest."Global Dimension 1 Code";
            GenJnLine.VALIDATE("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := Imprest."Global Dimension 2 Code";
            GenJnLine.VALIDATE("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := imprest."Dimension Set ID";
            //GenJnLine.Validate("Dimension Set ID");
            GenJnLine."Bal. Account Type" := GenJnLine."Bal. Account Type"::Customer;
            GenJnLine."Bal. Account No." := Imprest."Account No.";
            GenJnLine.VALIDATE("Bal. Account No.");

            IF GenJnLine.Amount <> 0 THEN
                GenJnLine.INSERT;

            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.RESET;
            GLEntry.SETRANGE(GLEntry."Document No.", Imprest."No.");
            GLEntry.SETRANGE(GLEntry.Reversed, FALSE);
            // GLEntry.SETRANGE("Posting Date", Imprest.Date);
            IF GLEntry.FINDFIRST THEN BEGIN
                Imprest.Posted := TRUE;
                Imprest."Posted By" := USERID;
                Imprest."Posted Date" := TODAY;
                Imprest."Time Posted" := TIME;
                //Update the Imprest Deadline
                Imprest."Imprest Deadline" := CALCDATE(CMSetup."Imprest Due Date", TODAY);
                Imprest.MODIFY;
            END;
            //
        END;

    end;

    procedure PostPettyCash(var PettyCash: Record "Payments HeaderFin")
    var

        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        PettyCashLines: Record "Petty Cash Lines";
        GLEntry: Record "G/L Entry";
        BankRec: Record "Bank Account";
        BatchSetup: Record "User Batch Setup";
        JBatch: Code[10];
    begin

        IF CONFIRM('Are you sure you want to post Petty Cash ' + PettyCash."No." + '?', FALSE) = TRUE THEN BEGIN
            IF PettyCash.Status <> PettyCash.Status::Released THEN
                ERROR('The Petty Cash No ' + PettyCash."No." + 'has not been fully approved');
            PettyCash.TESTFIELD(Date);
            PettyCash.TESTFIELD(Payee);
            PettyCash.TESTFIELD("Pay Mode");
            // PettyCash.TESTFIELD("Paying Bank Account");
            IF PettyCash."Pay Mode" = 'CHEQUE' THEN BEGIN
                PettyCash.TESTFIELD("Cheque No");
                PettyCash.TESTFIELD("Cheque Date");
            END;
            //Check if the petty cash Lines have been populated
            PettyCashLines.RESET;
            PettyCashLines.SETRANGE(PettyCashLines.No, PettyCash."No.");
            IF NOT PettyCashLines.FINDLAST THEN
                ERROR('The Petty Cash Lines are empty');

            IF PettyCash.Posted THEN
                ERROR('Petty Cash %1 has been posted', PettyCash."No.");

            JBatch := '';

            CMSetup.GET;
            if BatchSetup.Get(UserId) then begin
                BatchSetup.TestField("Petty Cash Batch");
                JBatch := BatchSetup."Petty Cash Batch";
            end else
                Error('Please complete the user batch set up for this user.%1', UserId);

            // Delete Lines Present on the General Journal Line
            GenJnLine.RESET;
            GenJnLine.SETRANGE(GenJnLine."Journal Template Name", CMSetup."Petty Cash Template");
            GenJnLine.SETRANGE(GenJnLine."Journal Batch Name", JBatch);
            GenJnLine.DELETEALL;

            Batch.INIT;
            IF CMSetup.GET() THEN
                Batch."Journal Template Name" := CMSetup."Petty Cash Template";
            Batch.Name := JBatch;
            IF NOT Batch.GET(Batch."Journal Template Name", JBatch) THEN
                Batch.INSERT;

            PettyCashLines.RESET;
            PettyCashLines.SETRANGE(PettyCashLines.No, PettyCash."No.");
            PettyCashLines.CALCSUMS(Amount);
            IF PettyCashLines.Amount = 0 THEN
                ERROR('Amount cannot be zero');
            PettyCash.CALCFIELDS("Petty Cash Amount");

            //Bank Entries
            LineNo := 10000;
            GenJnLine.INIT;
            GenJnLine."Journal Template Name" := CMSetup."Petty Cash Template";
            GenJnLine."Journal Batch Name" := JBatch;
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := PettyCash."Paying Bank Account";
            GenJnLine."Posting Date" := PettyCash.Date;
            GenJnLine."Document No." := PettyCash."No.";
            GenJnLine.Description := PettyCash.Payee;
            GenJnLine.Amount := -PettyCash."Petty Cash Amount";
            GenJnLine."Currency Code" := PettyCash.Currency;
            GenJnLine.Validate("Currency Code");
            GenJnLine."Currency Factor" := PettyCash."Currency Factor";
            GenJnLine.Validate("Currency Factor");
            GenJnLine."Shortcut Dimension 1 Code" := PettyCash."Global Dimension 1 Code";
            GenJnLine.VALIDATE("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := PettyCash."Global Dimension 2 Code";
            GenJnLine.VALIDATE("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := PettyCash."Dimension Set ID";
            //GenJnLine.Validate("Dimension Set ID");
            IF GenJnLine.Amount <> 0 THEN
                GenJnLine.INSERT;


            //Insert Petty Cash Lines
            PettyCashLines.RESET;
            PettyCashLines.SETRANGE(PettyCashLines.No, PettyCash."No.");
            IF PettyCashLines.FINDFIRST THEN BEGIN
                REPEAT
                    LineNo := LineNo + 10000;
                    GenJnLine.INIT;
                    GenJnLine."Journal Template Name" := CMSetup."Petty Cash Template";
                    GenJnLine."Journal Batch Name" := JBatch;
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := PettyCashLines."Account Type";
                    GenJnLine."Account No." := PettyCashLines."Account No";
                    GenJnLine.VALIDATE("Account No.");
                    GenJnLine."Posting Date" := PettyCash.Date;
                    GenJnLine."Document No." := PettyCash."No.";
                    GenJnLine.Description := CopyStr(PettyCashLines.Description, 1, 100);
                    GenJnLine.Amount := PettyCashLines."Net Amount";
                    GenJnLine."Currency Code" := PettyCash.Currency;
                    GenJnLine.Validate("Currency Code");
                    GenJnLine."Currency Factor" := PettyCash."Currency Factor";
                    GenJnLine.Validate("Currency Factor");
                    //Set these fields to blanks
                    GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                    GenJnLine.VALIDATE("Gen. Posting Type");
                    GenJnLine."Gen. Bus. Posting Group" := '';
                    GenJnLine.VALIDATE("Gen. Bus. Posting Group");
                    GenJnLine."Gen. Prod. Posting Group" := '';
                    GenJnLine.VALIDATE("Gen. Prod. Posting Group");
                    GenJnLine."VAT Bus. Posting Group" := '';
                    GenJnLine.VALIDATE("VAT Bus. Posting Group");
                    GenJnLine."VAT Prod. Posting Group" := '';
                    GenJnLine.VALIDATE("VAT Prod. Posting Group");
                    //

                    GenJnLine."Shortcut Dimension 1 Code" := PettyCashLines."Global Dimension 1 Code";
                    GenJnLine.VALIDATE("Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := PettyCashLines."Global Dimension 2 Code";
                    GenJnLine.VALIDATE("Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := PettyCashLines."Dimension Set ID";
                    //GenJnLine.Validate("Dimension Set ID");
                    IF GenJnLine.Amount <> 0 THEN
                        GenJnLine.INSERT;

                    if PettyCashLines."VAT Code" <> '' then begin
                        if CMSetup."Post VAT" then begin
                            TaxTarrifCode.Reset();
                            TaxTarrifCode.SetRange(Code, PettyCashLines."VAT Code");
                            if TaxTarrifCode.Find('-') then begin
                                LineNo := LineNo + 10000;
                                GenJnLine.INIT;
                                GenJnLine."Journal Template Name" := CMSetup."Petty Cash Template";
                                GenJnLine."Journal Batch Name" := JBatch;
                                GenJnLine."Line No." := LineNo;
                                GenJnLine."Account Type" := TaxTarrifCode."Account Type";
                                GenJnLine."Account No." := TaxTarrifCode."Account No.";
                                GenJnLine.VALIDATE("Account No.");
                                GenJnLine."Posting Date" := PettyCash.Date;
                                GenJnLine."Document No." := PettyCash."No.";
                                GenJnLine.Description := CopyStr(('VAT -' + PettyCashLines.No + ' ' + PettyCashLines.Description), 1, 100);
                                GenJnLine.Amount := PettyCashLines."VAT Amount";
                                GenJnLine."Currency Code" := PettyCash.Currency;
                                GenJnLine.Validate("Currency Code");
                                GenJnLine."Currency Factor" := PettyCash."Currency Factor";
                                GenJnLine.Validate("Currency Factor");
                                //Set these fields to blanks
                                GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                                GenJnLine.VALIDATE("Gen. Posting Type");
                                GenJnLine."Gen. Bus. Posting Group" := '';
                                GenJnLine.VALIDATE("Gen. Bus. Posting Group");
                                GenJnLine."Gen. Prod. Posting Group" := '';
                                GenJnLine.VALIDATE("Gen. Prod. Posting Group");
                                GenJnLine."VAT Bus. Posting Group" := '';
                                GenJnLine.VALIDATE("VAT Bus. Posting Group");
                                GenJnLine."VAT Prod. Posting Group" := '';
                                GenJnLine.VALIDATE("VAT Prod. Posting Group");
                                //

                                GenJnLine."Shortcut Dimension 1 Code" := PettyCashLines."Global Dimension 1 Code";
                                GenJnLine.VALIDATE("Shortcut Dimension 1 Code");
                                GenJnLine."Shortcut Dimension 2 Code" := PettyCashLines."Global Dimension 2 Code";
                                GenJnLine.VALIDATE("Shortcut Dimension 2 Code");
                                GenJnLine."Dimension Set ID" := PettyCashLines."Dimension Set ID";
                                //GenJnLine.Validate("Dimension Set ID");
                                IF GenJnLine.Amount <> 0 THEN
                                    GenJnLine.INSERT;
                            end;

                        end;
                    end;

                    if PettyCashLines."W/Tax Code" <> '' then begin
                        //if CMSetup."Post VAT" then begin
                        TaxTarrifCode.Reset();
                        TaxTarrifCode.SetRange(Code, PettyCashLines."W/Tax Code");
                        if TaxTarrifCode.Find('-') then begin
                            LineNo := LineNo + 10000;
                            GenJnLine.INIT;
                            GenJnLine."Journal Template Name" := CMSetup."Petty Cash Template";
                            GenJnLine."Journal Batch Name" := JBatch;
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := TaxTarrifCode."Account Type";
                            GenJnLine."Account No." := TaxTarrifCode."Account No.";
                            GenJnLine.VALIDATE("Account No.");
                            GenJnLine."Posting Date" := PettyCash.Date;
                            GenJnLine."Document No." := PettyCash."No.";
                            GenJnLine.Description := CopyStr(('W\TAX -' + PettyCashLines.No + ' ' + PettyCashLines.Description), 1, 100);
                            GenJnLine.Amount := PettyCashLines."VAT Amount";
                            GenJnLine."Currency Code" := PettyCash.Currency;
                            GenJnLine.Validate("Currency Code");
                            GenJnLine."Currency Factor" := PettyCash."Currency Factor";
                            GenJnLine.Validate("Currency Factor");
                            //Set these fields to blanks
                            GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                            GenJnLine.VALIDATE("Gen. Posting Type");
                            GenJnLine."Gen. Bus. Posting Group" := '';
                            GenJnLine.VALIDATE("Gen. Bus. Posting Group");
                            GenJnLine."Gen. Prod. Posting Group" := '';
                            GenJnLine.VALIDATE("Gen. Prod. Posting Group");
                            GenJnLine."VAT Bus. Posting Group" := '';
                            GenJnLine.VALIDATE("VAT Bus. Posting Group");
                            GenJnLine."VAT Prod. Posting Group" := '';
                            GenJnLine.VALIDATE("VAT Prod. Posting Group");
                            //

                            GenJnLine."Shortcut Dimension 1 Code" := PettyCashLines."Global Dimension 1 Code";
                            GenJnLine.VALIDATE("Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := PettyCashLines."Global Dimension 2 Code";
                            GenJnLine.VALIDATE("Shortcut Dimension 2 Code");
                            GenJnLine."Dimension Set ID" := PettyCashLines."Dimension Set ID";
                            //GenJnLine.Validate("Dimension Set ID");
                            IF GenJnLine.Amount <> 0 THEN
                                GenJnLine.INSERT;
                        end;

                        //end;
                    end;

                UNTIL PettyCashLines.NEXT = 0;

            END;

            //Post Entries
            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.RESET;
            GLEntry.SETRANGE(GLEntry."Document No.", PettyCash."No.");
            GLEntry.SETRANGE(GLEntry.Reversed, FALSE);
            IF GLEntry.FINDFIRST THEN BEGIN
                PettyCash.Posted := TRUE;
                PettyCash."Posted By" := USERID;
                PettyCash."Posted Date" := TODAY;
                PettyCash."Time Posted" := TIME;
                PettyCash.MODIFY;
            END;

            //
        END;

    end;

    procedure PostImprestSurrender(var ImprestSurrender: Record "Payments HeaderFin")
    var

        ImprestLines: Record "Imprest Lines";
        LineNo: Integer;
        GenJnLine: Record "Gen. Journal Line";
        GLEntry: Record "G/L Entry";
        ReceiptHeader: Record "Receipts Header";
        ReceiptLine: Record "Receipt Lines";
        PVHeader: Record "Payments HeaderFin";
        PVLine: Record "PV Lines1";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLSetup: Record "General Ledger Setup";
        Window: Dialog;
        Selection: Integer;
        ImprestRec: Record "Payments HeaderFin";
        Text001: TextConst ENU = '&Post and Create &Receipt/Payment Voucher';
    begin

        IF CONFIRM('Are u sure u want to post Imprest Surrender No. ' + ImprestSurrender."No." + '?', FALSE) = TRUE THEN BEGIN
            //Check if amount surrendered is less than amount advanced
            ImprestSurrender.CALCFIELDS("Remaining Amount");
            IF ImprestSurrender."Remaining Amount" <> 0 THEN
                Selection := STRMENU(Text001, 1);
            IF ImprestSurrender.Status <> ImprestSurrender.Status::Released THEN
                ERROR('The Imprest Surrender No. ' + ImprestSurrender."No." + ' has not been fully approved');

            ImprestSurrender.TESTFIELD("Account No.");
            //ImprestSurrender.TESTFIELD("Paying Bank Account");
            ImprestSurrender.TESTFIELD(Date);
            ImprestSurrender.TESTFIELD(Payee);
            ImprestSurrender.TESTFIELD("Pay Mode");
            IF ImprestSurrender."Pay Mode" = 'CHEQUE' THEN BEGIN
                ImprestSurrender.TESTFIELD("Cheque No");
                ImprestSurrender.TESTFIELD("Cheque Date");
            END;
            //Check if the imprest Lines have been populated
            ImprestLines.RESET;
            ImprestLines.SETRANGE(ImprestLines.No, ImprestSurrender."No.");
            IF NOT ImprestLines.FINDLAST THEN
                ERROR('The Imprest Surrender Lines are empty');

            ImprestLines.RESET;
            ImprestLines.SETRANGE(ImprestLines.No, ImprestSurrender."No.");
            ImprestLines.CALCSUMS("Actual Spent");
            //IF ImprestLines."Actual Spent" = 0 THEN
            //             ERROR('Actual Spent Amount cannot be zero');}

            IF ImprestSurrender.Surrendered THEN
                ERROR('Imprest %1 has been surrendered', ImprestSurrender."No.");

            GLSetup.GET;

            CMSetup.GET();
            // Delete Lines Present on the General Journal Line
            GenJnLine.RESET;
            GenJnLine.SETRANGE(GenJnLine."Journal Template Name", CMSetup."Imprest Surrender Template");
            GenJnLine.SETRANGE(GenJnLine."Journal Batch Name", ImprestSurrender."No.");
            GenJnLine.DELETEALL;

            Batch.INIT;
            IF CMSetup.GET() THEN
                Batch."Journal Template Name" := CMSetup."Imprest Surrender Template";
            Batch.Name := ImprestSurrender."No.";
            IF NOT Batch.GET(Batch."Journal Template Name", Batch.Name) THEN
                Batch.INSERT;
            //Staff entries
            LineNo := 10000;
            ImprestLines.RESET;
            ImprestLines.SETRANGE(ImprestLines.No, ImprestSurrender."No.");
            ImprestLines.CALCSUMS("Actual Spent");
            GenJnLine.INIT;
            GenJnLine."Journal Template Name" := CMSetup."Imprest Surrender Template";
            GenJnLine."Journal Batch Name" := ImprestSurrender."No.";
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::Customer;
            GenJnLine."Account No." := ImprestSurrender."Account No.";
            GenJnLine."Posting Date" := ImprestSurrender."Imprest Surrender Date";
            GenJnLine."Document No." := ImprestSurrender."No.";
            GenJnLine."External Document No." := ImprestSurrender."Cheque No";
            GenJnLine.Description := ImprestSurrender.Payee;
            GenJnLine.Amount := -ImprestLines."Actual Spent";
            GenJnLine."Currency Code" := ImprestSurrender.Currency;
            GenJnLine.Validate("Currency Code");
            GenJnLine.VALIDATE(Amount);
            GenJnLine."Currency Factor" := ImprestSurrender."Currency Factor";
            GenJnLine.Validate("Currency Factor");

            GenJnLine."Applies-to Doc. No." := ImprestSurrender."Applies- To Doc No.";
            GenJnLine."Shortcut Dimension 1 Code" := ImprestSurrender."Global Dimension 1 Code";
            GenJnLine.VALIDATE("Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := ImprestSurrender."Global Dimension 2 Code";
            GenJnLine.VALIDATE("Shortcut Dimension 2 Code");
            GenJnLine."Dimension Set ID" := ImprestSurrender."Dimension Set ID";
            //GenJnLine.Validate("Dimension Set ID");
            IF GenJnLine.Amount <> 0 THEN
                GenJnLine.INSERT;

            //Create Receipt/PV IF Chosen
            IF Selection = 1 THEN BEGIN
                //Insert Receipt Header
                ImprestSurrender.CALCFIELDS("Remaining Amount");
                IF ImprestSurrender."Remaining Amount" > 0 THEN BEGIN
                    IF ImprestSurrender."Receipt Created" = FALSE THEN BEGIN
                        ReceiptHeader.INIT;
                        //ReceiptHeader."No." := NoSeriesMgt.GetNextNo(CMSetup."Receipt No", TODAY, TRUE);
                        ReceiptHeader.Date := ImprestSurrender."Imprest Surrender Date";
                        ReceiptHeader."Received From" := ImprestSurrender.Payee;
                        ReceiptHeader.Status := ImprestSurrender.Status;
                        ReceiptHeader.Amount := ImprestSurrender."Remaining Amount";
                        ReceiptHeader."Pay Mode" := ImprestSurrender."Pay Mode";
                        ReceiptHeader."On Behalf Of" := ImprestSurrender."On behalf of";
                        ReceiptHeader."Imprest Receipt" := TRUE;
                        ReceiptHeader."Global Dimension 1 Code" := ImprestSurrender."Global Dimension 1 Code";
                        ReceiptHeader."Global Dimension 2 Code" := ImprestSurrender."Global Dimension 2 Code";
                        ReceiptHeader."Dimension Set ID" := ImprestSurrender."Dimension Set ID";
                        ReceiptHeader.Validate("Dimension Set ID");
                        //IF NOT ReceiptHeader.GET(ReceiptHeader."No.") THEN
                        if ReceiptHeader.INSERT(true) then
                            MESSAGE('Receipt No. %1 is successfully Created', ReceiptHeader."No.")
                        ELSE
                            ERROR('Receipt No. %1 already exists', ReceiptHeader."No.");
                    END;
                END;


                //Insert PV Header
                IF ImprestSurrender."Remaining Amount" < 0 THEN BEGIN
                    IF ImprestSurrender."PV Created" = FALSE THEN BEGIN
                        PVHeader.INIT;
                        //PVHeader."No." := NoSeriesMgt.GetNextNo(GLSetup."PV Nos", TODAY, TRUE);
                        PVHeader.Date := ImprestSurrender."Imprest Surrender Date";
                        PVHeader.Payee := ImprestSurrender.Payee;
                        //PVHeader.Status := ImprestSurrender.Status;
                        PVHeader."Pay Mode" := ImprestSurrender."Pay Mode";
                        PVHeader."On behalf of" := ImprestSurrender."On behalf of";
                        PVHeader."Payment Type" := PVHeader."Payment Type"::"Payment Voucher";
                        PVHeader."Imprest Payment" := TRUE;
                        PVHeader."Global Dimension 1 Code" := ImprestSurrender."Global Dimension 1 Code";
                        PVHeader."Global Dimension 2 Code" := ImprestSurrender."Global Dimension 2 Code";
                        PVHeader."Dimension Set ID" := ImprestSurrender."Dimension Set ID";
                        PVHeader.Validate("Dimension Set ID");
                        //IF NOT PVHeader.GET(PVHeader."No.") THEN
                        if PVHeader.INSERT(true) then
                            MESSAGE('Payment No. %1 is successfully Created', PVHeader."No.")
                        else
                            ERROR('Payment No. %1 is already exists', PVHeader."No.");
                    END;
                END;

            END;

            //Expenses
            ImprestLines.RESET;
            ImprestLines.SETRANGE(ImprestLines.No, ImprestSurrender."No.");
            IF ImprestLines.FINDFIRST THEN BEGIN
                REPEAT

                    LineNo := LineNo + 10000;
                    GenJnLine.INIT;
                    GenJnLine."Journal Template Name" := CMSetup."Imprest Surrender Template";
                    GenJnLine."Journal Batch Name" := ImprestSurrender."No.";
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := ImprestLines."Account Type";
                    IF GenJnLine."Account Type" = ImprestLines."Account Type"::"Fixed Asset" THEN
                        GenJnLine."FA Posting Type" := GenJnLine."FA Posting Type"::"Acquisition Cost";
                    GenJnLine."Account No." := ImprestLines."Account No.";
                    GenJnLine.VALIDATE("Account No.");
                    GenJnLine."Posting Date" := ImprestSurrender."Imprest Surrender Date";
                    GenJnLine."Document No." := ImprestSurrender."No.";
                    GenJnLine.Description := ImprestLines.Description;
                    GenJnLine.Amount := ImprestLines."Actual Spent";
                    GenJnLine.VALIDATE(Amount);
                    GenJnLine."Currency Code" := ImprestSurrender.Currency;
                    GenJnLine.Validate("Currency Code");
                    //Set these fields to blanks
                    GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                    GenJnLine.VALIDATE("Gen. Posting Type");
                    GenJnLine."Gen. Bus. Posting Group" := '';
                    GenJnLine.VALIDATE("Gen. Bus. Posting Group");
                    GenJnLine."Gen. Prod. Posting Group" := '';
                    GenJnLine.VALIDATE("Gen. Prod. Posting Group");
                    GenJnLine."VAT Bus. Posting Group" := '';
                    GenJnLine.VALIDATE("VAT Bus. Posting Group");
                    GenJnLine."VAT Prod. Posting Group" := '';
                    GenJnLine.VALIDATE("VAT Prod. Posting Group");
                    //
                    GenJnLine."Shortcut Dimension 1 Code" := ImprestLines."Global Dimension 1 Code";
                    GenJnLine.VALIDATE("Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := ImprestLines."Global Dimension 2 Code";
                    GenJnLine.VALIDATE("Shortcut Dimension 2 Code");
                    GenJnLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
                    //GenJnLine.Validate("Dimension Set ID");
                    IF GenJnLine.Amount <> 0 THEN
                        GenJnLine.INSERT;

                    //Insert Receipt Lines
                    IF Selection = 1 THEN BEGIN
                        //Creating Receipts
                        IF ImprestLines."Remaining Amount" > 0 THEN BEGIN
                            IF ImprestSurrender."Receipt Created" = FALSE THEN BEGIN
                                ReceiptLine.INIT;
                                ReceiptLine."Line No" := LineNo;
                                ReceiptLine."Receipt No." := ReceiptHeader."No.";
                                ReceiptLine."Account Type" := PVLine."Account Type"::Customer;//ImprestSurrender."Account Type";
                                ReceiptLine."Account No." := ImprestSurrender."Account No.";
                                ReceiptLine."Account Name" := ImprestSurrender."Account Name";
                                ReceiptLine.Description := ImprestLines.Description;
                                ReceiptLine.Amount := ImprestLines."Remaining Amount";
                                ReceiptLine."Global Dimension 1 Code" := ImprestLines."Global Dimension 1 Code";
                                ReceiptLine."Global Dimension 2 Code" := ImprestLines."Global Dimension 2 Code";
                                ReceiptLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
                                ReceiptLine.Validate("Dimension Set ID");
                                IF NOT ReceiptLine.GET(ReceiptLine."Line No", ReceiptLine."Receipt No.") THEN
                                    ReceiptLine.INSERT;
                            END;
                        END;

                        //Creating Payments
                        IF ImprestLines."Remaining Amount" < 0 THEN BEGIN
                            IF ImprestSurrender."PV Created" = FALSE THEN BEGIN
                                PVLine.INIT;
                                PVLine."Line No" := LineNo;
                                PVLine.No := PVHeader."No.";
                                PVLine."Account Type" := PVLine."Account Type"::Customer;
                                PVLine."Account No" := ImprestSurrender."Account No.";
                                PVLine."Account Name" := ImprestSurrender."Account Name";
                                PVLine.Description := ImprestLines.Description;
                                PVLine.Amount := ImprestLines."Remaining Amount" * -1;
                                PVLine.VALIDATE(Amount);
                                PVLine."Global Dimension 1 Code" := ImprestLines."Global Dimension 1 Code";
                                PVLine."Global Dimension 2 Code" := ImprestLines."Global Dimension 2 Code";
                                PVLine."Dimension Set ID" := ImprestLines."Dimension Set ID";
                                PVLine.Validate("Dimension Set ID");
                                IF NOT PVLine.GET(PVHeader."No.", PVLine."Line No") THEN
                                    PVLine.INSERT;
                            END;
                        END;
                    END;
                UNTIL ImprestLines.NEXT = 0;
            END;
            Codeunit.Run(Codeunit::"Adjust Gen. Journal Balance", GenJnLine);

            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);

            GLEntry.RESET;
            GLEntry.SETRANGE(GLEntry."Document No.", ImprestSurrender."No.");
            GLEntry.SETRANGE(GLEntry.Reversed, FALSE);
            GLEntry.SETRANGE("Posting Date", ImprestSurrender."Imprest Surrender Date");
            IF GLEntry.FINDFIRST THEN BEGIN
                ImprestSurrender.Surrendered := TRUE;
                IF Selection = 1 THEN BEGIN
                    IF ImprestSurrender."Remaining Amount" > 0 THEN
                        ImprestSurrender."Receipt Created" := TRUE;
                    IF ImprestSurrender."Remaining Amount" < 0 THEN
                        ImprestSurrender."PV Created" := TRUE;
                END;
                ImprestSurrender.MODIFY;

                IF ImprestRec.GET(ImprestSurrender."Surrender Imprest No") THEN BEGIN
                    ImprestRec.Surrendered := TRUE;
                    ImprestRec.MODIFY;
                END;
            END;
            //Uncommit Entries made to the varoius expenses accounts
            //Committment.UncommitImprest(ImprestSurrender);
        END;

    end;


    procedure PostPaymentVoucher(var PV: Record "Payments HeaderFin")
    var

        PVLines: Record "PV Lines1";
        PVLines1: Record "PV Lines1";
        GenJnLine: Record "Gen. Journal Line";
        LineNo: Integer;
        TarriffCodes: Record "Petty Cash Lines";
        VATSetup: Record "VAT Posting Setup";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        GLEntry: Record "G/L Entry";
        Acc: Record Vendor;
        SuppBankAcc: Code[20];
        TotalPaidAmnt: Decimal;

    begin

        IF CONFIRM('Are u sure u want to post the Payment Voucher No. ' + PV."No." + ' ?') = TRUE THEN BEGIN
            IF PV.Status <> PV.Status::Released THEN
                ERROR('The Payment Voucher No %1 has not been fully approved', PV."No.");
            IF PV.Posted THEN
                ERROR('Payment Voucher %1 has been posted', PV."No.");

            IF NOT PV."Imprest Payment" THEN BEGIN
                PV.TESTFIELD(Date);

                PV.TESTFIELD("Paying Bank Account");
                //PV.TESTFIELD(PV.Payee);
                PV.TESTFIELD(PV."Pay Mode");
                IF PV."Pay Mode" = 'CHEQUE' THEN BEGIN
                    PV.TESTFIELD(PV."Cheque No");
                    PV.TESTFIELD(PV."Cheque Date");
                END;
            END;

            //Check Lines
            PV.CALCFIELDS("Total Amount");
            IF PV."Total Amount" = 0 THEN
                ERROR('Amount is cannot be zero');
            PVLines.RESET;
            PVLines.SETRANGE(PVLines.No, PV."No.");
            IF NOT PVLines.FINDLAST THEN
                ERROR('Payment voucher Lines cannot be empty');

            PVLines.RESET;
            PVLines.SETRANGE(PVLines.No, PV."No.");
            IF PVLines.FindSet() THEN
                repeat
                    PVLines.TESTFIELD("Global Dimension 1 Code");
                //PVLines.TESTFIELD("Global Dimension 2 Code");
                until PVLines.Next() = 0;


            CMSetup.GET();
            // Delete Lines Present on the General Journal Line
            GenJnLine.RESET;
            GenJnLine.SETRANGE(GenJnLine."Journal Template Name", CMSetup."Payment Voucher Template");
            GenJnLine.SETRANGE(GenJnLine."Journal Batch Name", PV."No.");
            GenJnLine.DELETEALL;

            Batch.INIT;
            IF CMSetup.GET() THEN
                Batch."Journal Template Name" := CMSetup."Payment Voucher Template";
            Batch.Name := PV."No.";
            IF NOT Batch.GET(Batch."Journal Template Name", Batch.Name) THEN
                Batch.INSERT;

            //Bank Entries
            LineNo := LineNo + 10000;
            PV.CALCFIELDS(PV."Total Amount");
            PVLines.RESET;
            PVLines.SETRANGE(PVLines.No, PV."No.");
            PVLines.VALIDATE(PVLines.Amount);
            PVLines.CALCSUMS(PVLines.Amount);
            PVLines.CALCSUMS(PVLines."W/Tax Amount");
            PVLines.CALCSUMS(PVLines."VAT Amount");
            GenJnLine.INIT;
            IF CMSetup.GET THEN
                GenJnLine."Journal Template Name" := CMSetup."Payment Voucher Template";
            GenJnLine."Journal Batch Name" := PV."No.";
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := PV."Paying Bank Account";
            GenJnLine.VALIDATE(GenJnLine."Account No.");
            GenJnLine."Posting Date" := PV.Date;
            GenJnLine."Document No." := PV."No.";
            GenJnLine."External Document No." := PV."Cheque No";
            GenJnLine.Description := PV."Transaction Description";
            GenJnLine.Amount := -(PV."Total Amount" - TotalPaidAmnt);
            GenJnLine."Currency Code" := PV.Currency;
            GenJnLine.Validate("Currency Code");
            Gnljnline."Currency Factor" := PV."Currency Factor";
            GenJnLine.VALIDATE(GenJnLine.Amount);
            GenJnLine."Pay Mode" := PV."Pay Mode";
            IF PV."Pay Mode" = 'CHEQUE' THEN
                GenJnLine."Cheque Date" := PV."Cheque Date";
            IF PV.Date = 0D THEN
                ERROR('You must specify the PV date');
            GenJnLine."Shortcut Dimension 1 Code" := PV."Global Dimension 1 Code";
            GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := PV."Global Dimension 2 Code";
            GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
            /*GenJnLine."Dimension Set ID" := PV."Dimension Set ID";
            GenJnLine.Validate("Dimension Set ID");*/
            IF GenJnLine.Amount <> 0 THEN
                GenJnLine.INSERT;



            //PV Lines Entries
            PVLines.RESET;
            PVLines.SETRANGE(PVLines.No, PV."No.");
            IF PVLines.FINDFIRST THEN BEGIN
                REPEAT
                    PVLines.VALIDATE(PVLines.Amount);
                    LineNo := LineNo + 10000;
                    GenJnLine.INIT;
                    IF CMSetup.GET THEN
                        GenJnLine."Journal Template Name" := CMSetup."Payment Voucher Template";
                    GenJnLine."Journal Batch Name" := PV."No.";
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := PVLines."Account Type";
                    GenJnLine."Account No." := PVLines."Account No";
                    GenJnLine.VALIDATE(GenJnLine."Account No.");
                    IF PV.Date = 0D THEN
                        ERROR('You must specify the PV date');
                    GenJnLine."Posting Date" := PV.Date;
                    GenJnLine."Document No." := PV."No.";
                    GenJnLine."External Document No." := PV."Cheque No";
                    GenJnLine.Description := PVLines.Description;
                    // GenJnLine."Description 2" := PV."On behalf of";
                    GenJnLine."Currency Code" := PV.Currency;
                    GenJnLine.Validate("Currency Code");
                    GenJnLine.Amount := PVLines."Net Amount";
                    GenJnLine.VALIDATE(GenJnLine.Amount);
                    IF PV."Pay Mode" = 'CHEQUE' THEN
                        GenJnLine."Pay Mode" := PV."Pay Mode";
                    GenJnLine."Shortcut Dimension 1 Code" := PVLines."Global Dimension 1 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := PVLines."Global Dimension 2 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                    /* GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                     GenJnLine.Validate("Dimension Set ID");*/

                    //****Application
                    GenJnLine."Applies-to Doc. Type" := GenJnLine."Applies-to Doc. Type"::Invoice;
                    GenJnLine."Applies-to Doc. No." := PVLines."Applies to Doc. No";
                    GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");

                    IF GenJnLine.Amount <> 0 THEN
                        GenJnLine.INSERT;

                    //Post VAT
                    IF CMSetup."Post VAT" THEN BEGIN
                        IF PVLines."VAT Code" <> '' THEN BEGIN
                            PVLines.VALIDATE(PVLines.Amount);
                            LineNo := LineNo + 10000;
                            GenJnLine.INIT;
                            IF CMSetup.GET THEN
                                GenJnLine."Journal Template Name" := CMSetup."Payment Voucher Template";
                            GenJnLine."Journal Batch Name" := PV."No.";
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := PVLines."Account Type";
                            GenJnLine."Account No." := PVLines."Account No";
                            GenJnLine.VALIDATE(GenJnLine."Account No.");
                            IF PV.Date = 0D THEN
                                ERROR('You must specify the PV date');
                            GenJnLine."Posting Date" := PV.Date;
                            GenJnLine."Document No." := PV."No.";
                            GenJnLine."External Document No." := PV."Cheque No";
                            GenJnLine.Description := 'VAT Amount ' + PVLines.Description;
                            GenJnLine."Currency Code" := PVLines.Currency;
                            GenJnLine.Validate("Currency Code");
                            GenJnLine.Amount := PVLines."VAT Amount";
                            GenJnLine.VALIDATE(GenJnLine.Amount);
                            //Set these fields to blanks
                            GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                            GenJnLine.VALIDATE("Gen. Posting Type");
                            GenJnLine."Gen. Bus. Posting Group" := '';
                            GenJnLine.VALIDATE("Gen. Bus. Posting Group");
                            GenJnLine."Gen. Prod. Posting Group" := '';
                            GenJnLine.VALIDATE("Gen. Prod. Posting Group");
                            GenJnLine."VAT Bus. Posting Group" := '';
                            GenJnLine.VALIDATE("VAT Bus. Posting Group");
                            GenJnLine."VAT Prod. Posting Group" := '';
                            GenJnLine.VALIDATE("VAT Prod. Posting Group");
                            //
                            IF PV."Pay Mode" = 'CHEQUE' THEN
                                GenJnLine."Pay Mode" := PV."Pay Mode";
                            GenJnLine."Shortcut Dimension 1 Code" := PVLines."Global Dimension 1 Code";
                            GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := PVLines."Global Dimension 2 Code";
                            GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                            /*GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                            GenJnLine.Validate("Dimension Set ID");*/
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                            //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                            //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                            IF GenJnLine.Amount <> 0 THEN
                                GenJnLine.INSERT;

                            LineNo := LineNo + 10000;
                            GenJnLine.INIT;
                            IF CMSetup.GET THEN
                                GenJnLine."Journal Template Name" := CMSetup."Payment Voucher Template";
                            GenJnLine."Journal Batch Name" := PV."No.";
                            GenJnLine."Line No." := LineNo;
                            GenJnLine."Account Type" := GenJnLine."Account Type"::"G/L Account";
                            CASE PVLines."Account Type" OF
                                PVLines."Account Type"::"G/L Account":
                                    BEGIN
                                        GLAccount.GET(PVLines."Account No");
                                        GLAccount.TESTFIELD("VAT Bus. Posting Group");
                                        IF VATSetup.GET(GLAccount."VAT Bus. Posting Group", PVLines."VAT Code") THEN begin
                                            GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                            GenJnLine.Description := 'VAT ' + format(VATSetup."VAT %") + ' % ' + PVLines.Description;
                                            GenJnLine.VALIDATE(GenJnLine."Account No.");
                                        end;
                                    END;
                                PVLines."Account Type"::Vendor:
                                    BEGIN
                                        Vendor.GET(PVLines."Account No");
                                        Vendor.TESTFIELD("VAT Bus. Posting Group");
                                        IF VATSetup.GET(Vendor."VAT Bus. Posting Group", PVLines."VAT Code") THEN begin
                                            GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                            GenJnLine.VALIDATE(GenJnLine."Account No.");
                                            GenJnLine.Description := 'VAT ' + format(VATSetup."VAT %") + ' % ' + PVLines.Description;
                                        end;

                                    END;
                                PVLines."Account Type"::Customer:
                                    BEGIN
                                        Customer.GET(PVLines."Account No");
                                        Customer.TESTFIELD("VAT Bus. Posting Group");
                                        IF VATSetup.GET(Customer."VAT Bus. Posting Group", PVLines."VAT Code") THEN begin
                                            GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                            GenJnLine.VALIDATE(GenJnLine."Account No.");
                                            GenJnLine.Description := 'VAT ' + format(VATSetup."VAT %") + ' % ' + PVLines.Description;
                                        end;

                                    END;
                            END;
                            IF PV.Date = 0D THEN
                                ERROR('You must specify the PV date');
                            GenJnLine."Posting Date" := PV.Date;
                            GenJnLine."Document No." := PV."No.";
                            GenJnLine."External Document No." := PV."Cheque No";
                            //GenJnLine.Description := PVLines.Description;
                            GenJnLine."Currency Code" := PVLines.Currency;
                            GenJnLine.Validate("Currency Code");
                            GenJnLine.Amount := -PVLines."VAT Amount";
                            GenJnLine.VALIDATE(GenJnLine.Amount);
                            //Set these fields to blanks
                            GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                            GenJnLine.VALIDATE("Gen. Posting Type");
                            GenJnLine."Gen. Bus. Posting Group" := '';
                            GenJnLine.VALIDATE("Gen. Bus. Posting Group");
                            GenJnLine."Gen. Prod. Posting Group" := '';
                            GenJnLine.VALIDATE("Gen. Prod. Posting Group");
                            GenJnLine."VAT Bus. Posting Group" := '';
                            GenJnLine.VALIDATE("VAT Bus. Posting Group");
                            GenJnLine."VAT Prod. Posting Group" := '';
                            GenJnLine.VALIDATE("VAT Prod. Posting Group");
                            //
                            IF PV."Pay Mode" = 'CHEQUE' THEN
                                GenJnLine."Pay Mode" := PV."Pay Mode";
                            GenJnLine."Shortcut Dimension 1 Code" := PVLines."Global Dimension 1 Code";
                            GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                            GenJnLine."Shortcut Dimension 2 Code" := PVLines."Global Dimension 2 Code";
                            GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                            /*GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                            GenJnLine.Validate("Dimension Set ID");*/
                            //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                            //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                            //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                            IF GenJnLine.Amount <> 0 THEN
                                GenJnLine.INSERT;

                        END;
                        //End of Posting VAT
                    END;
                    //Post Withholding Tax
                    IF PVLines."W/Tax Code" <> '' THEN BEGIN
                        PVLines.VALIDATE(PVLines.Amount);
                        LineNo := LineNo + 10000;
                        GenJnLine.INIT;
                        IF CMSetup.GET THEN
                            GenJnLine."Journal Template Name" := CMSetup."Payment Voucher Template";
                        GenJnLine."Journal Batch Name" := PV."No.";
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := PVLines."Account Type";
                        GenJnLine."Account No." := PVLines."Account No";
                        GenJnLine.VALIDATE(GenJnLine."Account No.");
                        IF PV.Date = 0D THEN
                            ERROR('You must specify the PV date');
                        GenJnLine."Posting Date" := PV.Date;
                        GenJnLine."Document No." := PV."No.";
                        GenJnLine."External Document No." := PV."Cheque No";
                        GenJnLine.Description := 'WHT Amount ' + PVLines.Description;
                        GenJnLine."Currency Code" := PVLines.Currency;
                        GenJnLine.Validate("Currency Code");
                        GenJnLine.Amount := PVLines."W/Tax Amount";
                        GenJnLine.VALIDATE(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.VALIDATE("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group" := '';
                        GenJnLine.VALIDATE("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group" := '';
                        GenJnLine.VALIDATE("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group" := '';
                        GenJnLine.VALIDATE("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group" := '';
                        GenJnLine.VALIDATE("VAT Prod. Posting Group");
                        //
                        IF PV."Pay Mode" = 'CHEQUE' THEN
                            GenJnLine."Pay Mode" := PV."Pay Mode";
                        GenJnLine."Shortcut Dimension 1 Code" := PVLines."Global Dimension 1 Code";
                        GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PVLines."Global Dimension 2 Code";
                        GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                        /* GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                         GenJnLine.Validate("Dimension Set ID");*/

                        GenJnLine."Applies-to Doc. Type" := GenJnLine."Applies-to Doc. Type"::Invoice;
                        GenJnLine."Applies-to Doc. No." := PVLines."Applies to Doc. No";
                        GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        IF GenJnLine.Amount <> 0 THEN
                            GenJnLine.INSERT;

                        LineNo := LineNo + 10000;
                        GenJnLine.INIT;
                        IF CMSetup.GET THEN
                            GenJnLine."Journal Template Name" := CMSetup."Payment Voucher Template";
                        GenJnLine."Journal Batch Name" := PV."No.";
                        GenJnLine."Line No." := LineNo;
                        GenJnLine."Account Type" := GenJnLine."Account Type"::"G/L Account";
                        CASE PVLines."Account Type" OF
                            PVLines."Account Type"::"G/L Account":
                                BEGIN
                                    GLAccount.GET(PVLines."Account No");
                                    GLAccount.TESTFIELD("VAT Bus. Posting Group");
                                    IF VATSetup.GET(GLAccount."VAT Bus. Posting Group", PVLines."W/Tax Code") THEN begin
                                        GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                        GenJnLine.VALIDATE(GenJnLine."Account No.");
                                        GenJnLine.Description := 'WHT ' + format(VATSetup."VAT %") + ' % ' + PVLines.Description;
                                    end;
                                END;
                            PVLines."Account Type"::Vendor:
                                BEGIN
                                    Vendor.GET(PVLines."Account No");
                                    Vendor.TESTFIELD("VAT Bus. Posting Group");
                                    IF VATSetup.GET(Vendor."VAT Bus. Posting Group", PVLines."W/Tax Code") THEN begin
                                        GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                        GenJnLine.VALIDATE(GenJnLine."Account No.");
                                        GenJnLine.Description := 'WHT ' + format(VATSetup."VAT %") + ' % ' + PVLines.Description;
                                    end;
                                END;
                            PVLines."Account Type"::Customer:
                                BEGIN
                                    Customer.GET(PVLines."Account No");
                                    Customer.TESTFIELD("VAT Bus. Posting Group");
                                    IF VATSetup.GET(Customer."VAT Bus. Posting Group", PVLines."W/Tax Code") THEN begin
                                        GenJnLine."Account No." := VATSetup."Purchase VAT Account";
                                        GenJnLine.VALIDATE(GenJnLine."Account No.");
                                        GenJnLine.Description := 'WHT ' + format(VATSetup."VAT %") + ' % ' + PVLines.Description;
                                    end;
                                END;
                        END;
                        IF PV.Date = 0D THEN
                            ERROR('You must specify the PV date');
                        GenJnLine."Posting Date" := PV.Date;
                        GenJnLine."Document No." := PV."No.";
                        GenJnLine."External Document No." := PV."Cheque No";
                        //GenJnLine.Description := PVLines.Description;
                        GenJnLine."Currency Code" := PVLines.Currency;
                        GenJnLine.Validate("Currency Code");
                        GenJnLine.Amount := -PVLines."W/Tax Amount";
                        GenJnLine.VALIDATE(GenJnLine.Amount);
                        //Set these fields to blanks
                        GenJnLine."Gen. Posting Type" := GenJnLine."Gen. Posting Type"::" ";
                        GenJnLine.VALIDATE("Gen. Posting Type");
                        GenJnLine."Gen. Bus. Posting Group" := '';
                        GenJnLine.VALIDATE("Gen. Bus. Posting Group");
                        GenJnLine."Gen. Prod. Posting Group" := '';
                        GenJnLine.VALIDATE("Gen. Prod. Posting Group");
                        GenJnLine."VAT Bus. Posting Group" := '';
                        GenJnLine.VALIDATE("VAT Bus. Posting Group");
                        GenJnLine."VAT Prod. Posting Group" := '';
                        GenJnLine.VALIDATE("VAT Prod. Posting Group");

                        IF PV."Pay Mode" = 'CHEQUE' THEN
                            GenJnLine."Pay Mode" := PV."Pay Mode";
                        GenJnLine."Shortcut Dimension 1 Code" := PVLines."Global Dimension 1 Code";
                        GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                        GenJnLine."Shortcut Dimension 2 Code" := PVLines."Global Dimension 2 Code";
                        GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                        /* GenJnLine."Dimension Set ID" := PVLines."Dimension Set ID";
                         GenJnLine.Validate("Dimension Set ID");*/
                        //GenJnLine."Applies-to Doc. Type":=GenJnLine."Applies-to Doc. Type"::Invoice;
                        //GenJnLine."Applies-to Doc. No.":=PVLines."Applies to Doc. No";
                        //GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                        IF GenJnLine.Amount <> 0 THEN
                            GenJnLine.INSERT;
                    END;
                //End of Posting Withholding Tax

                UNTIL PVLines.NEXT = 0;
            END;

            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.RESET;
            GLEntry.SETRANGE(GLEntry."Document No.", PV."No.");
            GLEntry.SETRANGE(GLEntry.Reversed, FALSE);
            IF GLEntry.FINDFIRST THEN BEGIN
                PV.Posted := TRUE;
                PV."Posted By" := USERID;
                PV."Posted Date" := TODAY;
                PV."Time Posted" := TIME;
                PV.MODIFY;
                //Create Imprest Surrender in the event the document originated from an imprest.
                IF PV."Original Document" = PV."Original Document"::Imprest THEN BEGIN
                    PV."Payment Type" := PV."Payment Type"::"Imprest Surrender";
                    PV.Status := PV.Status::Open;
                    PV.MODIFY;
                END;

                IF PV."Bank Call-Up " then begin
                    if ClaimRec.get(pv."Claim No.") then begin
                        ClaimRec.Status := ClaimRec.Status::Close;
                        ClaimRec."PV No." := PV."No.";
                        ClaimRec."PV Amount" := PV."Total Amount";
                        ClaimRec.modify;

                        ClaimLines.RESET;
                        ClaimLines.setrange("Claim No.", PV."Claim No.");
                        IF ClaimLines.FindFirst() then begin
                            repeat
                                ClaimLines.Paid := true;
                                ClaimLines.Modify();
                            until ClaimLines.Next() = 0;
                        end;
                    end;
                end;

            END;
        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WorkflowResponseHandling FMExt", 'OnAfterApproveMemo', '', true, true)]
    local procedure FnMarkEntriesAsReleased(var ObjMemo: Record "Memo Request Header")
    var
        ObjMemoLines: Record "Memo Request Lines";
    begin
        ObjMemoLines.Reset();
        ObjMemoLines.SetRange("Header No.", ObjMemo."Request No.");
        if ObjMemoLines.FindSet() then
            repeat
                ObjMemoLines.Released := true;
                ObjMemoLines.Modify(true);
            until ObjMemoLines.Next() = 0;

    end;

    procedure FnPostInterBankTransfer(var ObjInterBank: Record "InterBank Transfer Header")
    var
        ObjIntBLines: Record "InterBank Transfer Lines";
        JTemplate: Code[20];
        JBatch: Code[20];
        TotalLineAmt: Decimal;
        LineNo: Integer;

    begin
        if Confirm(('Do you want to post Interbank Transfer no ' + ObjInterBank."No." + ' ?')) = true then Begin
            ObjInterBank.CalcFields("Bank Acc Balance");
            if ObjInterBank.Amount > (ObjInterBank."Bank Acc Balance" * -1) then
                if Confirm('This Transaction will result in overdrawing the Bank account ' + ObjInterBank."Bank Account" + '. Do you wish to continue?', false) = false then
                    exit;

            ObjIntBLines.Reset();
            ObjIntBLines.SetRange("Header No.", ObjInterBank."No.");
            if not ObjIntBLines.Find('-') then
                Error('There is nothing to post');

            if ObjIntBLines.FindSet() then
                ObjIntBLines.CalcSums(Amount);
            TotalLineAmt := ObjIntBLines.Amount;

            if ObjInterBank.Amount <> TotalLineAmt then
                Error('Header amount =&1,Total Lines amount = &2, Your journal will be out of balance by &3. Please adjust the amounts for posting.', ObjInterBank.Amount, TotalLineAmt, (ObjInterBank.Amount - TotalLineAmt));

            JTemplate := 'GENERAL';
            JBatch := 'INTERBANK';
            GenBatches.Reset();
            GenBatches.SetRange("Journal Template Name", JTemplate);
            GenBatches.SetRange(Name, JBatch);
            if not GenBatches.Find('-') then begin
                GenBatches.Init();
                GenBatches."Journal Template Name" := JTemplate;
                GenBatches.Name := JBatch;
                GenBatches.Description := 'Interbank Transfers';
                GenBatches."Template Type" := GenBatches."Template Type"::General;
                GenBatches.Insert(true);
            end;



            Gnljnline.Reset();
            Gnljnline.SetRange("Journal Template Name", JTemplate);
            Gnljnline.SetRange("Journal Batch Name", JBatch);
            if Gnljnline.FindSet() then
                Gnljnline.DeleteAll();

            LineNo := 0;

            //*****************************Create Source Lines***************************//
            LineNo := LineNo + 10000;
            Gnljnline.INIT;
            Gnljnline."Journal Template Name" := JTemplate;
            Gnljnline."Journal Batch Name" := JBatch;
            Gnljnline."Line No." := LineNo;
            Gnljnline."Account Type" := Gnljnline."Account Type"::"Bank Account";
            Gnljnline."Account No." := ObjInterBank."Bank Account";
            Gnljnline.VALIDATE("Account No.");
            Gnljnline."Posting Date" := TODAY;
            Gnljnline."Document No." := ObjInterBank."No.";
            //Gnljnline."External Document No." := ObjInterBank."No.";
            Gnljnline.Description := ObjInterBank."Transaction Description";
            Gnljnline.Amount := (ObjInterBank.Amount * -1);
            Gnljnline.VALIDATE(Amount);
            Gnljnline."Shortcut Dimension 1 Code" := ObjInterBank."Global Dimension 1 Code";
            Gnljnline.VALIDATE("Shortcut Dimension 1 Code");
            Gnljnline."Shortcut Dimension 2 Code" := ObjInterBank."Global Dimension 2 Code";
            Gnljnline.VALIDATE("Shortcut Dimension 2 Code");
            Gnljnline."Dimension Set ID" := ObjInterBank."Dimension Set ID";
            Gnljnline.Validate("Dimension Set ID");
            //Set these fields to blanks
            Gnljnline."Gen. Posting Type" := Gnljnline."Gen. Posting Type"::" ";
            Gnljnline.VALIDATE("Gen. Posting Type");
            Gnljnline."Gen. Bus. Posting Group" := '';
            Gnljnline.VALIDATE("Gen. Bus. Posting Group");
            Gnljnline."Gen. Prod. Posting Group" := '';
            Gnljnline.VALIDATE("Gen. Prod. Posting Group");
            Gnljnline."VAT Bus. Posting Group" := '';
            Gnljnline.VALIDATE("VAT Bus. Posting Group");
            Gnljnline."VAT Prod. Posting Group" := '';
            Gnljnline.VALIDATE("VAT Prod. Posting Group");

            IF Gnljnline.Amount <> 0 THEN
                Gnljnline.INSERT;
            //*****************************Create Source Lines***************************//
            //*****************************Create Destination Lines***************************//
            if ObjIntBLines.FindSet() then
                repeat
                    LineNo := LineNo + 10000;
                    Gnljnline.INIT;
                    Gnljnline."Journal Template Name" := JTemplate;
                    Gnljnline."Journal Batch Name" := JBatch;
                    Gnljnline."Line No." := LineNo;
                    Gnljnline."Account Type" := Gnljnline."Account Type"::"Bank Account";
                    Gnljnline."Account No." := ObjIntBLines."Bank Account";
                    Gnljnline.VALIDATE("Account No.");
                    Gnljnline."Posting Date" := TODAY;
                    Gnljnline."Document No." := ObjInterBank."No.";
                    //Gnljnline."External Document No." := ObjInterBank."No.";
                    Gnljnline.Description := ObjInterBank."Transaction Description";
                    Gnljnline.Amount := (ObjIntBLines.Amount * -1);
                    Gnljnline.VALIDATE(Amount);
                    Gnljnline."Shortcut Dimension 1 Code" := ObjInterBank."Global Dimension 1 Code";
                    Gnljnline.VALIDATE("Shortcut Dimension 1 Code");
                    Gnljnline."Shortcut Dimension 2 Code" := ObjInterBank."Global Dimension 2 Code";
                    Gnljnline.VALIDATE("Shortcut Dimension 2 Code");
                    Gnljnline."Dimension Set ID" := ObjInterBank."Dimension Set ID";
                    Gnljnline.Validate("Dimension Set ID");
                    //Set these fields to blanks
                    Gnljnline."Gen. Posting Type" := Gnljnline."Gen. Posting Type"::" ";
                    Gnljnline.VALIDATE("Gen. Posting Type");
                    Gnljnline."Gen. Bus. Posting Group" := '';
                    Gnljnline.VALIDATE("Gen. Bus. Posting Group");
                    Gnljnline."Gen. Prod. Posting Group" := '';
                    Gnljnline.VALIDATE("Gen. Prod. Posting Group");
                    Gnljnline."VAT Bus. Posting Group" := '';
                    Gnljnline.VALIDATE("VAT Bus. Posting Group");
                    Gnljnline."VAT Prod. Posting Group" := '';
                    Gnljnline.VALIDATE("VAT Prod. Posting Group");

                    IF Gnljnline.Amount <> 0 THEN
                        Gnljnline.INSERT;
                until ObjIntBLines.Next() = 0;

            //*****************************Create Destination Lines***************************//
            Gnljnline.Reset();
            Gnljnline.SetRange("Journal Template Name", JTemplate);
            Gnljnline.SetRange("Journal Batch Name", JBatch);
            if Gnljnline.Find('-') then begin
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Gnljnline);

                ObjInterBank.Posted := true;
                ObjInterBank."Posted By" := UserId;
                ObjInterBank."Posted Date and Time" := CurrentDateTime;
                ObjInterBank.Modify(true);
            end;

            //***************Mark Document As posted******************//


        End;
    end;

    procedure FnPostPettyCashReplenishment(var ObjInterBank: Record "InterBank Transfer Header")
    var
        ObjIntBLines: Record "InterBank Transfer Lines";
        JTemplate: Code[20];
        JBatch: Code[20];
        TotalLineAmt: Decimal;
        LineNo: Integer;
        ObjBank: Record "Bank Account";

    begin
        if Confirm(('Do you want to post Interbank Transfer no ' + ObjInterBank."No." + ' ?')) = true then Begin
            ObjInterBank.TestField("Approval Status", ObjInterBank."Approval Status"::Approved);
            ObjInterBank.CalcFields("Bank Acc Balance");
            if ObjInterBank.Amount > (ObjInterBank."Bank Acc Balance" * -1) then
                if Confirm('This Transaction will result in overdrawing the Bank account ' + ObjInterBank."Bank Account" + '. Do you wish to continue?', false) = false then
                    exit;

            ObjIntBLines.Reset();
            ObjIntBLines.SetRange("Header No.", ObjInterBank."No.");
            if not ObjIntBLines.Find('-') then
                Error('There is nothing to post');

            if ObjIntBLines.FindSet() then
                ObjIntBLines.CalcSums(Amount);
            TotalLineAmt := ObjIntBLines.Amount;

            if ObjInterBank.Amount <> TotalLineAmt then
                Error('Header amount =&1,Total Lines amount = &2, Your journal will be out of balance by &3. Please adjust the amounts for posting.', ObjInterBank.Amount, TotalLineAmt, (ObjInterBank.Amount - TotalLineAmt));

            JTemplate := 'GENERAL';
            JBatch := 'INTERBANK';
            GenBatches.Reset();
            GenBatches.SetRange("Journal Template Name", JTemplate);
            GenBatches.SetRange(Name, JBatch);
            if not GenBatches.Find('-') then begin
                GenBatches.Init();
                GenBatches."Journal Template Name" := JTemplate;
                GenBatches.Name := JBatch;
                GenBatches.Description := 'Interbank Transfers';
                GenBatches."Template Type" := GenBatches."Template Type"::General;
                GenBatches.Insert(true);
            end;



            Gnljnline.Reset();
            Gnljnline.SetRange("Journal Template Name", JTemplate);
            Gnljnline.SetRange("Journal Batch Name", JBatch);
            if Gnljnline.FindSet() then
                Gnljnline.DeleteAll();

            LineNo := 0;

            //*****************************Create Source Lines***************************//
            LineNo := LineNo + 10000;
            Gnljnline.INIT;
            Gnljnline."Journal Template Name" := JTemplate;
            Gnljnline."Journal Batch Name" := JBatch;
            Gnljnline."Line No." := LineNo;
            Gnljnline."Account Type" := Gnljnline."Account Type"::"Bank Account";
            Gnljnline."Account No." := ObjInterBank."Bank Account";
            Gnljnline.VALIDATE("Account No.");
            Gnljnline."Posting Date" := TODAY;
            Gnljnline."Document No." := ObjInterBank."No.";
            //Gnljnline."External Document No." := ObjInterBank."No.";
            Gnljnline.Description := ObjInterBank."Transaction Description";
            Gnljnline.Amount := (ObjInterBank.Amount);
            Gnljnline.VALIDATE(Amount);
            Gnljnline."Shortcut Dimension 1 Code" := ObjInterBank."Global Dimension 1 Code";
            Gnljnline.VALIDATE("Shortcut Dimension 1 Code");
            Gnljnline."Shortcut Dimension 2 Code" := ObjInterBank."Global Dimension 2 Code";
            Gnljnline.VALIDATE("Shortcut Dimension 2 Code");
            Gnljnline."Dimension Set ID" := ObjInterBank."Dimension Set ID";
            Gnljnline.Validate("Dimension Set ID");
            //Set these fields to blanks
            Gnljnline."Gen. Posting Type" := Gnljnline."Gen. Posting Type"::" ";
            Gnljnline.VALIDATE("Gen. Posting Type");
            Gnljnline."Gen. Bus. Posting Group" := '';
            Gnljnline.VALIDATE("Gen. Bus. Posting Group");
            Gnljnline."Gen. Prod. Posting Group" := '';
            Gnljnline.VALIDATE("Gen. Prod. Posting Group");
            Gnljnline."VAT Bus. Posting Group" := '';
            Gnljnline.VALIDATE("VAT Bus. Posting Group");
            Gnljnline."VAT Prod. Posting Group" := '';
            Gnljnline.VALIDATE("VAT Prod. Posting Group");

            IF Gnljnline.Amount <> 0 THEN
                Gnljnline.INSERT;
            //*****************************Create Source Lines***************************//
            //*****************************Create Destination Lines***************************//
            if ObjIntBLines.FindSet() then
                repeat
                    LineNo := LineNo + 10000;
                    Gnljnline.INIT;
                    Gnljnline."Journal Template Name" := JTemplate;
                    Gnljnline."Journal Batch Name" := JBatch;
                    Gnljnline."Line No." := LineNo;
                    Gnljnline."Account Type" := Gnljnline."Account Type"::"Bank Account";
                    Gnljnline."Account No." := ObjIntBLines."Bank Account";
                    Gnljnline.VALIDATE("Account No.");
                    Gnljnline."Posting Date" := TODAY;
                    Gnljnline."Document No." := ObjInterBank."No.";
                    //Gnljnline."External Document No." := ObjInterBank."No.";
                    Gnljnline.Description := ObjInterBank."Transaction Description";
                    Gnljnline.Amount := (ObjIntBLines.Amount * -1);
                    Gnljnline.VALIDATE(Amount);
                    Gnljnline."Shortcut Dimension 1 Code" := ObjInterBank."Global Dimension 1 Code";
                    Gnljnline.VALIDATE("Shortcut Dimension 1 Code");
                    Gnljnline."Shortcut Dimension 2 Code" := ObjInterBank."Global Dimension 2 Code";
                    Gnljnline.VALIDATE("Shortcut Dimension 2 Code");
                    Gnljnline."Dimension Set ID" := ObjInterBank."Dimension Set ID";
                    Gnljnline.Validate("Dimension Set ID");
                    //Set these fields to blanks
                    Gnljnline."Gen. Posting Type" := Gnljnline."Gen. Posting Type"::" ";
                    Gnljnline.VALIDATE("Gen. Posting Type");
                    Gnljnline."Gen. Bus. Posting Group" := '';
                    Gnljnline.VALIDATE("Gen. Bus. Posting Group");
                    Gnljnline."Gen. Prod. Posting Group" := '';
                    Gnljnline.VALIDATE("Gen. Prod. Posting Group");
                    Gnljnline."VAT Bus. Posting Group" := '';
                    Gnljnline.VALIDATE("VAT Bus. Posting Group");
                    Gnljnline."VAT Prod. Posting Group" := '';
                    Gnljnline.VALIDATE("VAT Prod. Posting Group");

                    IF Gnljnline.Amount <> 0 THEN
                        Gnljnline.INSERT;
                until ObjIntBLines.Next() = 0;

            //*****************************Create Destination Lines***************************//
            Gnljnline.Reset();
            Gnljnline.SetRange("Journal Template Name", JTemplate);
            Gnljnline.SetRange("Journal Batch Name", JBatch);
            if Gnljnline.Find('-') then begin
                CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", Gnljnline);

                ObjInterBank.Posted := true;
                ObjInterBank."Posted By" := UserId;
                ObjInterBank."Posted Date and Time" := CurrentDateTime;
                ObjInterBank.Modify(true);
                if ObjBank.Get(ObjInterBank."Bank Account") then begin
                    ObjBank."Last Replenish Date" := Today;
                    ObjBank.Modify(true);
                end;

            end;

            //***************Mark Document As posted******************//
            //***************Notify Till Custodian******************//
            if ObjInterBank."Created By" <> '' then begin
                if UserSetup.Get(ObjInterBank."Created By") then begin

                end;
            end;
            //***************Notify Till Custodian******************//


        End;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"WorkflowResponseHandling LVExt", 'OnAfterInsertLeaveAllowance', '', true, true)]
    /// <summary> 
    /// Description for PopoulateLeavePV.
    /// </Creates a payment voucher for Leave allowance>
    /// <param name="LeaveApp">Parameter of type Record "Employee Leave Application".</param>
    procedure PopoulateLeavePV(LeaveApp: Record "Employee Leave Application")
    var
        ObjLeaveApp: Record "Employee Leave Application";
        ObjEmp: Record Employee;
        ObjPV: Record "Payments HeaderFin";
        ObjPVLines: Record "PV Lines1";
        LinesRef: Code[20];
        assignMatrix1: Record "Assignment Matrix";
        HumanResSetup: Record "Human Resources Setup";
        LeaveAllAmt: Decimal;
        ObjUserSetup: Record "User Setup";
        CLNo: Code[20];

    begin
        LeaveAllAmt := 0;
        if ObjLeaveApp.Get(LeaveApp."Application No") then begin
            if ObjLeaveApp."Leave Allowance Payable" then begin
                if ObjEmp.Get(ObjLeaveApp."Employee No") then begin

                    with ObjPV do begin
                        Init();
                        Payee := ObjEmp."First Name" + ' ' + ObjEmp."Middle Name" + ' ' + ObjEmp."Last Name";
                        "Transaction Description" := 'Leave Allowance ' + ObjLeaveApp."Employee Name";
                        "Pay Mode" := 'EFT';
                        "Payment Type" := "Payment Type"::"Payment Voucher";
                        "On behalf of" := ObjLeaveApp."Employee Name";
                        "Global Dimension 1 Code" := ObjEmp."Global Dimension 1 Code";
                        Validate("Global Dimension 1 Code");
                        "Global Dimension 2 Code" := ObjEmp."Global Dimension 2 Code";
                        Validate("Global Dimension 2 Code");
                        "Dimension Set ID" := ObjEmp."Dimension Set ID";
                        Insert(true);

                        LinesRef := "No.";
                    end;
                    //*******************Insert PV No to leave Record***************//
                    ObjLeaveApp."PV No." := LinesRef;
                    ObjLeaveApp.Modify();

                    //*********************Get Amount**************//
                    assignMatrix1.Reset();
                    assignMatrix1.SetRange("Payroll Period", ObjLeaveApp."Current Payroll Period");
                    assignMatrix1.SetRange("Employee No", ObjLeaveApp."Employee No");
                    assignMatrix1.SetFilter(Code, HumanResSetup."Leave Allowance Code");
                    if assignMatrix1.Find('-') then
                        LeaveAllAmt := assignMatrix1.Amount;
                    //*********************Get Amount**************//
                    CLNo := '';
                    ObjUserSetup.Reset();
                    ObjUserSetup.SetRange("Employee No.", ObjEmp."No.");
                    if ObjUserSetup.FindFirst() then begin
                        ObjUserSetup.TestField("Imprest Account");
                        CLNo := ObjUserSetup."Imprest Account";
                    end;

                    with ObjPVLines do begin
                        Init();
                        No := LinesRef;
                        "Account Type" := "Account Type"::Customer;
                        "Account No" := CLNo;
                        Validate("Account No");
                        Description := 'Leave Allowance period ' + Format(ObjLeaveApp."Application Date");
                        Amount := LeaveAllAmt;
                        validate(Amount);
                        "Global Dimension 1 Code" := ObjEmp."Global Dimension 1 Code";
                        Validate("Global Dimension 1 Code");
                        "Global Dimension 2 Code" := ObjEmp."Global Dimension 2 Code";
                        Validate("Global Dimension 2 Code");
                        "Dimension Set ID" := ObjEmp."Dimension Set ID";
                        Insert(true);
                    end;
                    Message('Payment Voucher Created. Voucher Number is %1. Please head to the PV number and assign a bank to pay out', LinesRef);
                end;
            end;
        end;
    end;

    var
        UserSetup: Record "User Setup";
}