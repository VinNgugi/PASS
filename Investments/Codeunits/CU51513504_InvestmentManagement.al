codeunit 51513504 "Investment Management"
{
    trigger OnRun()
    begin

    end;

    //*************************Create Journals***************************************//
    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; Dimension1: Code[40]; Dimension2: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; Currency: Code[10]; AppliesToDocType: Option "",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund; AppliesToDocNo: Code[50]; CurrencyFactor: Decimal)
    var
        myInt: Integer;
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine."Currency Code" := Currency;
        IF GenJournalLine."Currency Code" <> '' THEN
            GenJournalLine.VALIDATE("Currency Code");
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := Dimension1;
        GenJournalLine."Shortcut Dimension 2 Code" := Dimension2;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        GenJournalLine."Applies-to Doc. Type" := AppliesToDocType;
        GenJournalLine."Applies-to Doc. No." := AppliesToDocNo;
        GenJournalLine."Currency Factor" := CurrencyFactor;
        GenJournalLine.VALIDATE(Amount);
        IF GenJournalLine.Amount <> 0 THEN
            GenJournalLine.INSERT;
    end;

    //*************************Create Notification***************************************//
    procedure GlobalSendEmailNotification(DocumentNo: Code[20]; SenderName: Text; SenderAddress: Text; RecipientName: Text; RecipientAddress: Text; Subject: Text; EmailMessage: Text; CCEmails: Text);
    var
        SMTPSetup: Record "SMTP Mail Setup";
        SMTPMail: Codeunit "SMTP Mail";
        Company: Record "Company Information";
        TempBlob: Record TempBlob;
        FileName: Text;
        FileManagment: Codeunit "File Management";
    begin
        SMTPSetup.GET;
        Company.GET();
        Company.CALCFIELDS(Picture);

        SMTPMail.CreateMessage(SenderName, SMTPSetup."User ID", RecipientAddress, Subject, '', true);
        SMTPMail.AppendBody(EmailMessage);
        SMTPMail.AppendBody('<br><br>');
        if CCEmails <> '' then
            SMTPMail.AddCC(CCEmails);
        SMTPMail.AppendBody('<br><br>');

        //********************************Company Logo
        IF Company.Picture.HASVALUE THEN BEGIN
            TempBlob.INIT;
            TempBlob.DELETEALL;
            TempBlob.Blob := Company.Picture;
            TempBlob.INSERT;
            FileName := FileManagment.BLOBExport(TempBlob, 'Signature.jpg', FALSE);
        END;
        SMTPMail.AppendBody('<IMG style="HEIGHT: 153px; WIDTH: 445px" src="file:///' + FileName + '"' + 'width=300 height=100>');

        SMTPMail.Send;

    end;


    //**************************************Maturity Instructions********************************//
    procedure FnMaturityInstructionsTrigger(var Investment: Record "Investment Header")
    var
        ObjIntBuffer: Record "Investment Interest Buffer";
        InvSetup: Record "Investment Setup";
        LineNo: Integer;
        JTemplate: Code[20];
        JBatch: Code[20];
        WTaxAmt: Decimal;
        InvestH: Record "Investment Header";
        InvType: Record "Investment Types";
        ReceivableAcc: Code[20];
        IncomeAcc: Code[20];

    begin
        LineNo := 0;
        InvSetup.Get();
        JTemplate := InvSetup."Investment Template";
        JBatch := InvSetup."Investment Batch";

        if Investment."FD Status" = Investment."FD Status"::Active then begin
            if Today >= Investment."Investment End Date" then begin
                if not Investment.Closed then begin

                    Investment.CalcFields("Last Interest Date");

                    //*Populate Interest.
                    if Investment."Investment End Date" > Investment."Last Interest Date" then begin
                        InvestH.Reset();
                        InvestH.SetRange("No.", Investment."No.");
                        if InvestH.Find('-') then begin
                            Report.Run(51513500, false, false, InvestH);
                        end;
                    end;

                    if InvType.Get(Investment."Investment Type") then begin
                        InvType.TestField(InvType."Interest Receivable Account");
                        //InvType.TestField(InvType."Interest Income Account");
                        ReceivableAcc := InvType."Interest Receivable Account";
                        IncomeAcc := InvType."Interest Income Account";
                    end;

                    //*****Delete Existing Lines
                    JournalLine.Reset();
                    JournalLine.SetRange("Journal Template Name", JTemplate);
                    JournalLine.SetRange("Journal Batch Name", JBatch);
                    if JournalLine.FindSet() then
                        JournalLine.DeleteAll();


                    Investment.CalcFields("Interest Earned");

                    case Investment."Maturity Instructions" of
                        investment."Maturity Instructions"::"Roll Over Principle":
                            begin

                                //*********************Calc withholding Tax
                                WTaxAmt := Investment."Interest Earned" * (Investment."Withholding Tax Rate" / 100);

                                //***********************Post Principle Amount
                                //*******************************Credit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"Bank Account", Investment."Source Bank", Today, (Investment."Investment Principal"),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', 'Closure-' + Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', Investment."Currency Factor");

                                //*******************************Debit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"Bank Account", Investment."Destination Bank Account", Today, (Investment."Investment Principal" * -1),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', 'Closure-' + Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', investment."Currency Factor");

                                //***********************Post Interest Amount
                                //*******************************Credit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"Bank Account", Investment."Source Bank", Today, (Investment."Interest Earned"),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', 'Interest Transfred' + Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', Investment."Currency Factor");

                                //*******************************Debit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"G/L Account", ReceivableAcc, Today, (Investment."Interest Earned" * -1),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', 'Interest Transfred' + Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', investment."Currency Factor");

                                //***********************Post Wtax Amount
                                //*******************************Credit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"G/L Account", InvSetup."Withholding Tax G/L Account", Today, (WTaxAmt),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', 'W/Tax Transfred' + Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', Investment."Currency Factor");

                                //*******************************Debit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"Bank Account", Investment."Source Bank", Today, (WTaxAmt * -1),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', 'W/Tax Transfred' + Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', investment."Currency Factor");


                                //****************Modify Investment
                                Investment."FD Status" := Investment."FD Status"::Matured;
                                Investment.Closed := true;
                                Investment.Modify();

                                //****************Modify Lines
                                ObjIntBuffer.Reset();
                                ObjIntBuffer.SetRange("Document No.", Investment."No.");
                                if ObjIntBuffer.FindSet() then
                                    repeat
                                        ObjIntBuffer.Transfered := true;
                                        ObjIntBuffer."Transfered By" := UserId;
                                        ObjIntBuffer."Date Transfered" := Today;
                                        ObjIntBuffer.Modify();
                                    until ObjIntBuffer.Next() = 0;
                            end;
                        Investment."Maturity Instructions"::"Transfer To Other Bank":
                            begin

                                //*********************Calc withholding Tax
                                WTaxAmt := Investment."Interest Earned" * (Investment."Withholding Tax Rate" / 100);

                                //***********************Post Principle Amount
                                //*******************************Credit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"Bank Account", Investment."Source Bank", Today, (Investment."Investment Principal" * -1),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', Investment."Currency Factor");

                                //*******************************Debit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"Bank Account", Investment."Destination Bank Account", Today, (Investment."Investment Principal"),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', investment."Currency Factor");


                                //***********************Post Interest Amount
                                //*******************************Credit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"Bank Account", Investment."Source Bank", Today, (Investment."Interest Earned" * -1),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', Investment."Currency Factor");

                                //*******************************Debit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"Bank Account", Investment."Destination Bank Account", Today, (Investment."Interest Earned"),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', investment."Currency Factor");

                                //***********************Post Interest Amount
                                //*******************************Credit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"G/L Account", InvSetup."Withholding Tax G/L Account", Today, (WTaxAmt * -1),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', Investment."Currency Factor");

                                //*******************************Debit ************************************//
                                LineNo := LineNo + 10000;
                                FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"Bank Account", Investment."Destination Bank Account", Today, (WTaxAmt),
                                                        Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', investment."Currency Factor");

                                //****************Modify Investment
                                Investment."FD Status" := Investment."FD Status"::Matured;
                                Investment.Closed := true;
                                Investment.Modify();

                                //****************Modify Lines
                                ObjIntBuffer.Reset();
                                ObjIntBuffer.SetRange("Document No.", Investment."No.");
                                if ObjIntBuffer.FindSet() then
                                    repeat
                                        ObjIntBuffer.Transfered := true;
                                        ObjIntBuffer."Transfered By" := UserId;
                                        ObjIntBuffer."Date Transfered" := Today;
                                        ObjIntBuffer.Modify();
                                    until ObjIntBuffer.Next() = 0;


                            end;
                    end;
                    //***********************Post Journals
                    //*************** Post Journal
                    JournalLine.Reset();
                    JournalLine.SetRange("Journal Template Name", JTemplate);
                    JournalLine.SetRange("Journal Batch Name", JBatch);
                    if JournalLine.Find('-') then begin
                        Codeunit.Run(Codeunit::"Gen. Jnl.-Post", JournalLine);
                    end;

                end;
            end;
        end;

    end;

    procedure FnPostFixedDeposits(var Investment: Record "Investment Header")
    var
        myInt: Integer;
        JTemplate: Code[20];
        JBatch: Code[20];
        InvSetup: Record "Investment Setup";
        LineNo: Integer;
    begin
        LineNo := 0;
        InvSetup.Get();
        JTemplate := InvSetup."Investment Template";
        JBatch := InvSetup."Investment Batch";

        //*****Delete Existing Lines
        JournalLine.Reset();
        JournalLine.SetRange("Journal Template Name", JTemplate);
        JournalLine.SetRange("Journal Batch Name", JBatch);
        if JournalLine.FindSet() then
            JournalLine.DeleteAll();


        //*******************************Create Journal Lines************************************//
        //*Credit Source bank
        LineNo := LineNo + 10000;
        FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"Bank Account", Investment."Source Bank", Investment."Investment Start Date", (Investment."Investment Principal" * -1),
                                Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', Investment."Currency Factor");

        //*******************************Create Balancing Journal Lines************************************//
        //*Debit Destination bank
        LineNo := LineNo + 10000;
        FnCreateGnlJournalLine(JTemplate, JBatch, Investment."No.", LineNo, JournalLine."Account Type"::"Bank Account", Investment."Destination Bank Account", Investment."Investment Start Date", (Investment."Investment Principal"),
                                Investment."Global Dimension 1 Code", Investment."Global Dimension 2 Code", '', Investment.Description, '', Investment."Currency Code", JournalLine."Applies-to Doc. Type"::" ", '', investment."Currency Factor");

        JournalLine.Reset();
        JournalLine.SetRange("Journal Template Name", JTemplate);
        JournalLine.SetRange("Journal Batch Name", JBatch);
        if JournalLine.Find('-') then begin
            Codeunit.Run(Codeunit::"Gen. Jnl.-Post", JournalLine);

            //**********Modify Investment********************//
            Investment.Posted := true;
            Investment."Posted By" := UserId;
            Investment."Date Posted" := Today;
            Investment."FD Status" := Investment."FD Status"::Active;
            Investment.Modify();
        end;

    end;


    local procedure AutocreateNewInvestmentDocument(var DocNo: Code[20])
    var
        Investments: Record "Investment Header";
    begin

    end;

    procedure LeapYear(Year: Integer) LY: Boolean;
    var
        CenturyYear: Boolean;
        DivByFour: Boolean;
    begin
        CenturyYear := Year mod 100 = 0;
        DivByFour := Year mod 4 = 0;
        if ((not CenturyYear and DivByFour) or (Year mod 400 = 0)) then
            LY := true
        else
            LY := false;
    end;


    var
        myInt: Integer;
        JournalLine: Record "Gen. Journal Line";

}