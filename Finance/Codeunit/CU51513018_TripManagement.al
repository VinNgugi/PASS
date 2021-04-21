codeunit 51513018 "Trip Request Management"
{

    trigger OnRun()
    begin
    end;

    var
        Text00001: Label 'You cannot accept this trip since you have the following imprest documents unsurrendered and are overdue, %1.';
        OnesText: array[20] of Text[90];
        TensText: array[20] of Text[90];
        ThousText: array[20] of Text[90];
        AmountInWords: Text[300];
        WholeInWords: Text[300];
        DecimalInWords: Text[300];
        WholePart: Integer;
        DecimalPart: Integer;
        Text00002: Label 'You cannot prepare a Payment doc for  trip number %1 before it is fully reviewed';
        Text00003: Label 'Trip %1 is already posted.';
        Text00004: Label 'Are you sure you want to post trip no %1 using posting date %2 ?';

    procedure FnCreateGnlJournalLine(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[50]; TransactionDate: Date; TransactionAmount: Decimal; Dimension1: Code[40]; Dimension2: Code[40]; ExternalDocumentNo: Code[50]; TransactionDescription: Text; LoanNumber: Code[50]; Currency: Code[10])
    var
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
        //GenJournalLine."Transaction Type" := TransactionType;
        //GenJournalLine."Loan No" := LoanNumber;
        GenJournalLine."Currency Code" := Currency;
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine."External Document No." := ExternalDocumentNo;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Shortcut Dimension 1 Code" := Dimension1;
        GenJournalLine."Shortcut Dimension 2 Code" := Dimension2;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount <> 0 THEN
            GenJournalLine.INSERT;
    end;

    procedure FnCreateGnlJournalLineBalanced(TemplateName: Text; BatchName: Text; DocumentNo: Code[30]; LineNo: Integer; AccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner"; AccountNo: Code[50]; TransactionDate: Date; TransactionDescription: Text; BalancingAccountType: Option "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Member,Investor; BalancingAccountNo: Code[50]; TransactionAmount: Decimal; Dimension1: Code[40]; Dimension2: Code[40]; ExtDocNo: Code[20])
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.INIT;
        GenJournalLine."Journal Template Name" := TemplateName;
        GenJournalLine."Journal Batch Name" := BatchName;
        GenJournalLine."Document No." := DocumentNo;
        GenJournalLine."Line No." := LineNo;
        //GenJournalLine."Transaction Type" := TransactionType;
        GenJournalLine."Account Type" := AccountType;
        GenJournalLine."Account No." := AccountNo;
        GenJournalLine.VALIDATE(GenJournalLine."Account No.");
        GenJournalLine."Posting Date" := TransactionDate;
        GenJournalLine.Description := TransactionDescription;
        GenJournalLine.VALIDATE(GenJournalLine."Currency Code");
        GenJournalLine.Amount := TransactionAmount;
        GenJournalLine.VALIDATE(GenJournalLine.Amount);
        GenJournalLine."Bal. Account Type" := BalancingAccountType;
        GenJournalLine."Bal. Account No." := BalancingAccountNo;
        GenJournalLine."External Document No." := ExtDocNo;
        GenJournalLine.VALIDATE(GenJournalLine."Bal. Account No.");
        GenJournalLine."Shortcut Dimension 1 Code" := Dimension1;
        GenJournalLine."Shortcut Dimension 2 Code" := Dimension2;
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 1 Code");
        GenJournalLine.VALIDATE(GenJournalLine."Shortcut Dimension 2 Code");
        IF GenJournalLine.Amount <> 0 THEN
            GenJournalLine.INSERT;
    end;

    procedure CheckForUnsurrenderedImprest(StaffNo: Code[20])
    var
        RequestHeader: Record "Payments HeaderFin";
        ImpDocs: Text;
    begin
        //TripSetup.GET();
        RequestHeader.RESET;
        RequestHeader.SETRANGE(RequestHeader."Employee No", StaffNo);
        RequestHeader.SETFILTER("Payment Type", '=%1', RequestHeader."Payment Type"::Imprest);
        RequestHeader.SETRANGE(RequestHeader.Posted, TRUE);
        RequestHeader.SETRANGE(RequestHeader.Surrendered, FALSE);
        IF RequestHeader.FINDSET THEN BEGIN
            ImpDocs := '';
            REPEAT
            //IF CALCDATE(TripSetup."Unsurrendered Period", RequestHeader."Imprest Deadline") <= TODAY THEN BEGIN
            //   ImpDocs := ImpDocs + ', ' + RequestHeader."No.";
            // END;
            UNTIL RequestHeader.NEXT = 0;

            IF ImpDocs <> '' THEN
                ERROR(Text00001, ImpDocs);
        END;

    end;

    procedure CheckForOverLappingDays(StaffNo: Code[20]; Startdate: Date; EndDate: Date; DocNo: Code[20])
    var
        TripLines: Record "Memo Request Lines";
        ImpDocs: Text;
    begin
        //TripSetup.GET();

        //*****************************Check for Other Trips with similar timelines***************//
        TripLines.Reset();
        TripLines.SETRANGE(TripLines."Employee No", StaffNo);
        TripLines.SETRANGE(TripLines."Travel Start Date", Startdate, EndDate);
        TripLines.SETFILTER(TripLines."Header No.", '<>%1', DocNo);
        if TripLines.FINDSET then
            repeat
                //IF TripLines.Accepted = true then
                ERROR('You have already have a trip number %1, with description %2 within the same period as this trip', TripLines."Header No.", TripLines."Trip Description");
            until TripLines.NEXT() = 0;


        //*****************************Check for Other Trips with similar timelines***************//

    end;

    procedure EmailNotificationsToStaff(EmpNo: Text[50]; SenderNameName: Text[100]; SenderEmailAdd: Text[50]; NotifyMessage: Text[1000]; NotifyAction: Code[50])
    var
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        HREmp: Record Employee;
    begin
        SMTPSetup.GET();
        IF SenderNameName = '' THEN
            SenderNameName := SMTPSetup."User ID";

        IF SenderEmailAdd = '' THEN
            SenderEmailAdd := SMTPSetup."User ID";

        IF HREmp.GET(EmpNo) then begin
            SMTPMail.CreateMessage(SenderNameName, SenderEmailAdd, HREmp."E-Mail", NotifyAction, '', TRUE);
            SMTPMail.AppendBody(STRSUBSTNO(NotifyMessage, HREmp."First Name", COPYSTR(NotifyAction, 14, 50), SenderNameName, ''));
            SMTPMail.AppendBody(SenderEmailAdd);
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.Send();
        end;
    end;

    procedure NumberInWords(number: Decimal; CurrencyName: Text[30]; DenomName: Text[30]): Text[300]
    begin
        WholePart := ROUND(ABS(number), 1, '<');
        DecimalPart := ABS((ABS(number) - WholePart) * 100);

        WholeInWords := NumberToWords(WholePart, CurrencyName);

        IF DecimalPart <> 0 THEN BEGIN
            DecimalInWords := NumberToWords(DecimalPart, DenomName);
            WholeInWords := WholeInWords + ' and ' + DecimalInWords;
        END;

        AmountInWords := WholeInWords + ' Only';
        EXIT(AmountInWords);
    end;

    procedure NumberToWords(Number: Integer; appendScale: Text): Text[200]
    var
        numString: Text;
        pow: Integer;
        powStr: Text;
        log: Integer;
    begin
        InitTextVariables();

        numString := '';
        IF Number < 100 THEN
            IF Number < 20 THEN BEGIN
                IF Number <> 0 THEN numString := OnesText[Number];
            END ELSE BEGIN
                numString := TensText[Number DIV 10];
                IF (Number MOD 10) > 0 THEN
                    numString := numString + ' ' + OnesText[Number MOD 10];
            END
        ELSE BEGIN
            pow := 0;
            powStr := '';
            IF Number < 1000 THEN BEGIN // number is between 100 and 1000
                pow := 100;
                powStr := ThousText[1];
            END ELSE BEGIN
                log := ROUND(STRLEN(FORMAT(Number DIV 1000)) / 3, 1, '>');
                pow := POWER(1000, log);
                powStr := ThousText[log + 1];
            END;

            numString := NumberToWords(Number DIV pow, powStr) + ' ' + NumberToWords(Number MOD pow, '');
        END;

        EXIT(numString + ' ' + appendScale);
    end;

    procedure InitTextVariables()
    begin
        OnesText[1] := 'one';
        OnesText[2] := 'two';
        OnesText[3] := 'three';
        OnesText[4] := 'four';
        OnesText[5] := 'five';
        OnesText[6] := 'six';
        OnesText[7] := 'seven';
        OnesText[8] := 'eight';
        OnesText[9] := 'nine';
        OnesText[10] := 'ten';
        OnesText[11] := 'eleven';
        OnesText[12] := 'twelve';
        OnesText[13] := 'thirteen';
        OnesText[14] := 'fourteen';
        OnesText[15] := 'fifteen';
        OnesText[16] := 'sixteen';
        OnesText[17] := 'seventeen';
        OnesText[18] := 'eighteen';
        OnesText[19] := 'nineteen';

        TensText[1] := '';
        TensText[2] := 'twenty';
        TensText[3] := 'thirty';
        TensText[4] := 'forty';
        TensText[5] := 'fivty';
        TensText[6] := 'sixty';
        TensText[7] := 'seventy';
        TensText[8] := 'eighty';
        TensText[9] := 'ninty';

        ThousText[1] := 'hundred';
        ThousText[2] := 'thousand';
        ThousText[3] := 'million';
        ThousText[4] := 'billion';
        ThousText[5] := 'trillion';
    end;

    procedure EmailrejectionNotificationsToTripOwner(EmpNo: Text[50]; SenderNameName: Text[100]; SenderEmailAdd: Text[50]; NotifyMessage: Text[1000]; NotifyAction: Code[50])
    var
        SMTPMail: Codeunit "SMTP Mail";
        SMTPSetup: Record "SMTP Mail Setup";
        HREmp: Record Employee;
    begin
        SMTPSetup.GET();
        IF SenderNameName = '' THEN
            SenderNameName := SMTPSetup."User ID";

        IF SenderEmailAdd = '' THEN
            SenderEmailAdd := SMTPSetup."User ID";

        IF HREmp.GET(EmpNo) THEN BEGIN
            SMTPMail.CreateMessage(SenderNameName, SenderEmailAdd, HREmp."E-Mail", NotifyAction, '', TRUE);
            SMTPMail.AppendBody(STRSUBSTNO(NotifyMessage, HREmp."First Name", COPYSTR(NotifyAction, 14, 50), SenderNameName, ''));
            SMTPMail.AppendBody(SenderEmailAdd);
            SMTPMail.AppendBody('<br><br>');
            SMTPMail.Send;
        END;
    end;


    /*[EventSubscriber(ObjectType::Codeunit, Codeunit::"Code Factory", 'OnAfterInsertLeaveAllowance', '', false, false)]
    procedure OnAfterInsertLeaveAllowancePayroll(var LeaveApp: Record "Employee Leave Application")

    begin

    end;*/

}

