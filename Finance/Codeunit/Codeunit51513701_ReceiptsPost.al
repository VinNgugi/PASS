codeunit 51513701 "Receipts-Post"
{

    trigger OnRun();
    begin
    end;

    var
        CMSetup: Record "Cash Management Setup";


    procedure PostReceipt(RptHeader: Record "Receipts Header");
    var
        GenJnLine: Record "Gen. Journal Line";
        RcptLine: Record "Receipt Lines";
        LineNo: Integer;
        Batch: Record "Gen. Journal Batch";
        GLEntry: Record "G/L Entry";
        GuaranteeApp: Record "Guarantee Application";
        GuaranteeContract: Record "Guarantee Contracts";
        JobApplicants: Record "Incubation Applicants";
        NonWall: Record "Non-Wall Applications";

    begin

        if CONFIRM('Are you sure you want to post the receipt no ' + RptHeader."No." + ' ?') = true then begin

            if RptHeader.Posted then
                ERROR('The Receipt has been posted');
            // Check Amount
            RptHeader.CALCFIELDS(RptHeader."Total Amount");
            IF RptHeader.Amount <> RptHeader."Total Amount" THEN
                //ERROR(' The Amount must be equal to the Total Amount on the Lines');

            RptHeader.TESTFIELD("Bank Code");
            RptHeader.TESTFIELD("Pay Mode");
            RptHeader.TESTFIELD("Received From");
            RptHeader.TESTFIELD(Date);
            RptHeader.TestField("Global Dimension 1 Code");

            if RptHeader."Pay Mode" = 'CHEQUE' then begin
                RptHeader.TESTFIELD("Cheque No");
                RptHeader.TESTFIELD("Cheque Date");
            end;

            CMSetup.GET();
            // Delete Lines Present on the General Journal Line
            GenJnLine.RESET;
            GenJnLine.SETRANGE(GenJnLine."Journal Template Name", CMSetup."Receipt Template");
            GenJnLine.SETRANGE(GenJnLine."Journal Batch Name", RptHeader."No.");
            GenJnLine.DELETEALL;

            Batch.INIT;
            if CMSetup.GET() then
                Batch."Journal Template Name" := CMSetup."Receipt Template";
            Batch.Name := RptHeader."No.";
            if not Batch.GET(Batch."Journal Template Name", Batch.Name) then
                Batch.INSERT;

            //Post Bank entries
            RptHeader.CALCFIELDS(RptHeader."Total Amount");
            LineNo := LineNo + 1000;
            GenJnLine.INIT;
            GenJnLine."Journal Template Name" := CMSetup."Receipt Template";
            GenJnLine."Journal Batch Name" := RptHeader."No.";
            GenJnLine."Line No." := LineNo;
            GenJnLine."Account Type" := GenJnLine."Account Type"::"Bank Account";
            GenJnLine."Account No." := RptHeader."Bank Code";
            GenJnLine."Posting Date" := RptHeader.Date;
            GenJnLine."Document No." := RptHeader."No.";
            GenJnLine."Document Type" := GenJnLine."Document Type"::Payment;
            GenJnLine.Description := RptHeader."On Behalf Of";
            GenJnLine.Amount := RptHeader."Total Amount";
            GenJnLine.VALIDATE(GenJnLine.Amount);
            GenJnLine."Currency Code" := RptHeader."Currency Code";
            GenJnLine.VALIDATE(GenJnLine."Currency Code");
            GenJnLine."External Document No." := RptHeader."Cheque No";
            GenJnLine."Currency Code" := RptHeader."Currency Code";
            GenJnLine.VALIDATE(GenJnLine."Currency Code");
            GenJnLine."Pay Mode" := RptHeader."Pay Mode";
            GenJnLine."Guarantee Application No." := RptHeader."Guarantee Application No.";
            GenJnLine."Guarantee Entry Type" := RptHeader."Guarantee Entry Type";
            //GenJnLine.
            if RptHeader."Pay Mode" = 'CHEQUE' then
                GenJnLine."Cheque Date" := RptHeader."Cheque Date";
            GenJnLine."Shortcut Dimension 1 Code" := RptHeader."Global Dimension 1 Code";
            GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
            GenJnLine."Shortcut Dimension 2 Code" := RptHeader."Global Dimension 2 Code";
            GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");

            if GenJnLine.Amount <> 0 then
                GenJnLine.INSERT;

            //message(Format(GenJnLine."Shortcut Dimension 1 Code"));
            //Post the receipt lines
            RcptLine.SETRANGE(RcptLine."Receipt No.", RptHeader."No.");
            if RcptLine.FINDFIRST then begin
                repeat
                    RcptLine.VALIDATE(Amount);
                    LineNo := LineNo + 1000;
                    GenJnLine.INIT;
                    GenJnLine."Journal Template Name" := CMSetup."Receipt Template";
                    GenJnLine."Journal Batch Name" := RptHeader."No.";
                    GenJnLine."Line No." := LineNo;
                    GenJnLine."Account Type" := RcptLine."Account Type";
                    GenJnLine."Account No." := RcptLine."Account No.";
                    GenJnLine.VALIDATE(GenJnLine."Account No.");
                    GenJnLine."Posting Date" := RptHeader.Date;
                    GenJnLine."Document No." := RptHeader."No.";
                    GenJnLine."Document Type" := GenJnLine."Document Type"::Payment;
                    GenJnLine.Description := RcptLine.Description;
                    GenJnLine.Amount := -RcptLine."Net Amount";
                    GenJnLine.VALIDATE(GenJnLine.Amount);
                    GenJnLine."External Document No." := RptHeader."Cheque No";
                    GenJnLine."Currency Code" := RptHeader."Currency Code";
                    GenJnLine.VALIDATE(GenJnLine."Currency Code");
                    GenJnLine."Shortcut Dimension 1 Code" := RcptLine."Global Dimension 1 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 1 Code");
                    GenJnLine."Shortcut Dimension 2 Code" := RcptLine."Global Dimension 2 Code";
                    GenJnLine.VALIDATE(GenJnLine."Shortcut Dimension 2 Code");
                    if RcptLine."Applies to Doc. No" <> '' then begin
                        GenJnLine."Applies-to Doc. Type" := RcptLine."Applies-to Doc. Type";
                        GenJnLine."Applies-to Doc. No." := RcptLine."Applies to Doc. No";
                        GenJnLine.VALIDATE(GenJnLine."Applies-to Doc. No.");
                    end;
                    if GenJnLine.Amount <> 0 then
                        GenJnLine.INSERT;
                until
                 RcptLine.NEXT = 0;
            end;

            CODEUNIT.RUN(CODEUNIT::"Gen. Jnl.-Post", GenJnLine);
            GLEntry.RESET;
            GLEntry.SETRANGE(GLEntry."Document No.", RptHeader."No.");
            GLEntry.SETRANGE(GLEntry.Reversed, false);
            if GLEntry.FINDFIRST then begin
                RptHeader.Posted := true;
                RptHeader."Posted Date" := TODAY;
                RptHeader."Posted Time" := TIME;
                RptHeader."Posted By" := USERID;
                RptHeader.MODIFY;
                RptHeader.CalcFields("Total Amount");


                ///Incubants application fee
                if RptHeader."AIC fee" then begin
                    if RptHeader."AIC fee Type" = RptHeader."AIC fee Type"::"Wall Application fee" then begin
                        if JobApplicants.Get(RptHeader."ApplicatIon No.") then begin
                            JobApplicants."Application fee Paid" := true;
                            JobApplicants."Application fee No." := RptHeader."No.";
                            JobApplicants.Modify();

                        end;
                    end else
                        if RptHeader."AIC fee Type" = RptHeader."AIC fee Type"::"Nonwall Application fee" then begin
                            if NonWall.Get(RptHeader."ApplicatIon No.") then begin
                                NonWall."Application fee Paid" := true;
                                NonWall.Modify();
                            end;
                        end;

                end;
                ///
                //==============================================
                if RptHeader."Guarantee Entry Type" = RptHeader."Guarantee Entry Type"::"Application fee" then BEGIN
                    if GuaranteeApp.Get(RptHeader."Guarantee Application No.") then begin

                        if GuaranteeApp."Application Status" = GuaranteeApp."Application Status"::" " then
                            GuaranteeApp."Application Status" := GuaranteeApp."Application Status"::"Commitment Paid";
                        GuaranteeApp."Application fee Paid" := RptHeader."Total Amount";
                        GuaranteeApp.Modify;
                    end;
                END else
                    IF RptHeader."Guarantee Entry Type" = RptHeader."Guarantee Entry Type"::Consultancy then BEGIN
                        if GuaranteeContract.Get(RptHeader."Guarantee Application No.") then begin

                            GuaranteeContract."Consultancy Fee Paid" := RptHeader."Total Amount";
                            GuaranteeContract.Modify;

                        end;
                    end else
                        IF RptHeader."Guarantee Entry Type" = RptHeader."Guarantee Entry Type"::"Linkage Banking" then begin
                            if GuaranteeContract.Get(RptHeader."Guarantee Application No.") then begin

                                GuaranteeContract."Linkage fee Paid" := RptHeader."Total Amount";
                                GuaranteeContract.Modify;

                            end;
                            //===============================================
                        end;
            end;
        end;
    end;

}

