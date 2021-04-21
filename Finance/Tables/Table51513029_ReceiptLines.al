table 51513029 "Receipt Lines"
{
    // version FINANCE
    Caption = 'Receipt Lines';
    DataClassification = CustomerContent;
    //DrillDownPageID = "Shortlisting Criteria Card";
    //LookupPageID = "Shortlisting Criteria Card";

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Receipt No."; Code[20])
        {
            TableRelation = "Receipts Header";

            trigger OnValidate()

            begin
                IF Receipt.Get("Receipt No.") THEN begin

                    "Receipt Date" := Receipt.Date;
                    if GuaranteeApp.Get(Receipt."Guarantee Application No.") THEN BEGIN

                        "Account Type" := "Account Type"::Customer;
                        "Account No." := GuaranteeApp."Customer No.";
                        Validate("Account No.");

                    end;
                END;
            end;
        }
        field(3; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";

            trigger Onvalidate()

            begin
                Validate("Receipt No.");
            end;
        }
        field(4; "Account No."; Code[20])
        {
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" where(Blocked = const(false), "Direct Posting" = const(true))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer where(Blocked = const(" "))
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor where(Blocked = const(" "))
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset" where(Blocked = const(false))
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account" where(Blocked = const(false));

            trigger OnValidate();
            begin

                case "Account Type" of
                    "Account Type"::"G/L Account":
                        begin
                            if GLAccount.GET("Account No.") then
                                "Account Name" := GLAccount.Name
                            else
                                "Account Name" := '';
                        end;
                    "Account Type"::Customer:
                        begin
                            if Cust.GET("Account No.") then
                                "Account Name" := Cust.Name
                            else
                                "Account Name" := '';
                        end;
                    "Account Type"::Vendor:
                        begin
                            if Vendor.GET("Account No.") then
                                "Account Name" := Vendor.Name else
                                "Account Name" := '';
                        end;
                end;
            end;
        }
        field(5; "Account Name"; Text[100])
        {
        }
        field(6; Description; Text[100])
        {
        }
        field(7; "VAT Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(8; "W/Tax Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
        }
        field(9; "VAT Amount"; Decimal)
        {
        }
        field(10; "W/Tax Amount"; Decimal)
        {
        }
        field(11; Amount; Decimal)
        {

            trigger OnValidate();
            begin
                VALIDATE("Applies to Doc. No");
                "Net Amount" := Amount;

                IF "Currency Code" = '' THEN
                    "Amount(LCY)" := Amount
                ELSE
                    "Amount(LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Receipt Date", "Currency Code",
                           Amount, "Currency Factor"));
            end;
        }
        field(12; "Net Amount"; Decimal)
        {
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(14; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(15; "Applies to Doc. No"; Code[20])
        {
            Caption = 'Applies-to Doc. No.';

            trigger OnLookup();
            var
                GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
                PaymentToleranceMgt: Codeunit "Payment Tolerance Management";
            begin
                "Applies to Doc. No" := '';
                Amt := 0;
                NetAmount := 0;
                //VATAmount:=0;
                //"W/TAmount":=0;

                case "Account Type" of
                    "Account Type"::Customer:
                        begin
                            CustLedger.RESET;
                            CustLedger.SETCURRENTKEY(CustLedger."Customer No.", Open, "Document No.");
                            CustLedger.SETRANGE(CustLedger."Customer No.", "Account No.");
                            CustLedger.SETRANGE(Open, true);
                            CustLedger.CALCFIELDS("Remaining Amount");
                            if PAGE.RUNMODAL(0, CustLedger) = ACTION::LookupOK then begin

                                if CustLedger."Applies-to ID" <> '' then begin
                                    CustLedger1.RESET;
                                    CustLedger1.SETCURRENTKEY(CustLedger1."Customer No.", Open, "Applies-to ID");
                                    CustLedger1.SETRANGE(CustLedger1."Customer No.", "Account No.");
                                    CustLedger1.SETRANGE(Open, true);
                                    CustLedger1.SETRANGE("Applies-to ID", CustLedger."Applies-to ID");
                                    if CustLedger1.FIND('-') then begin
                                        repeat
                                            "Currency Code" := CustLedger1."Currency Code";
                                            CustLedger1.CALCFIELDS("Remaining Amount");
                                            Amt := Amt + ABS(CustLedger1."Remaining Amount");
                                        until CustLedger1.NEXT = 0;
                                    end;

                                    if Amt <> Amt then
                                        //ERROR('Amount is not equal to the amount applied on the application form');
                                        if Amount = 0 then
                                            Amount := Amt;
                                    "Currency Code" := CustLedger."Currency Code";
                                    Validate("Currency Code");
                                    VALIDATE(Amount);
                                    "Applies to Doc. No" := CustLedger."Document No.";
                                end else begin
                                    if Amount <> ABS(CustLedger."Remaining Amount") then
                                        CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                                    if Amount = 0 then
                                        Amount := ABS(CustLedger."Remaining Amount");
                                    "Currency Code" := CustLedger."Currency Code";
                                    Validate("Currency Code");
                                    VALIDATE(Amount);
                                    "Applies to Doc. No" := CustLedger."Document No.";

                                end;
                            end;
                            VALIDATE(Amount);
                        end;

                    "Account Type"::Vendor:
                        begin
                            VendLedger.RESET;
                            VendLedger.SETCURRENTKEY(VendLedger."Vendor No.", Open, "Document No.");
                            VendLedger.SETRANGE(VendLedger."Vendor No.", "Account No.");
                            VendLedger.SETRANGE(Open, true);
                            VendLedger.CALCFIELDS("Remaining Amount");
                            if PAGE.RUNMODAL(0, VendLedger) = ACTION::LookupOK then begin

                                if VendLedger."Applies-to ID" <> '' then begin
                                    VendLedger1.RESET;
                                    VendLedger1.SETCURRENTKEY(VendLedger1."Vendor No.", Open, "Applies-to ID");
                                    VendLedger1.SETRANGE(VendLedger1."Vendor No.", "Account No.");
                                    VendLedger1.SETRANGE(Open, true);
                                    VendLedger1.SETRANGE(VendLedger1."Applies-to ID", VendLedger."Applies-to ID");
                                    if VendLedger1.FIND('-') then begin
                                        repeat
                                            VendLedger1.CALCFIELDS(VendLedger1."Remaining Amount");

                                            NetAmount := NetAmount + ABS(VendLedger1."Remaining Amount");
                                            "Currency Code" := VendLedger1."Currency Code";
                                        until VendLedger1.NEXT = 0;
                                    end;

                                    if NetAmount <> NetAmount then
                                        //ERROR('Amount is not equal to the amount applied on the application form');
                                        if Amount = 0 then
                                            Amount := NetAmount;
                                    Validate("Currency Code");
                                    VALIDATE(Amount);
                                    "Applies to Doc. No" := VendLedger."Document No.";
                                end else begin
                                    if Amount <> ABS(VendLedger."Remaining Amount") then
                                        VendLedger.CALCFIELDS(VendLedger."Remaining Amount");
                                    if Amount = 0 then
                                        Amount := ABS(VendLedger."Remaining Amount");
                                    "Currency Code" := VendLedger."Currency Code";
                                    Validate("Currency Code");
                                    VALIDATE(Amount);
                                    "Applies to Doc. No" := VendLedger."Document No.";

                                end;
                            end;
                            Amount := ABS(VendLedger."Remaining Amount");
                            VALIDATE(Amount);
                        end;
                end;
            end;

            trigger OnValidate();
            var
                CustLedgEntry: Record "Cust. Ledger Entry";
                VendLedgEntry: Record "Vendor Ledger Entry";
                TempGenJnlLine: Record "Gen. Journal Line" temporary;
            begin

                case "Account Type" of
                    "Account Type"::Customer:
                        begin
                            CustLedger.RESET;
                            CustLedger.SETRANGE("Customer No.", "Account No.");
                            CustLedger.SETRANGE(Open, true);
                            CustLedger.SETRANGE("Document No.", "Applies to Doc. No");
                            if CustLedger.FIND('-') then begin
                                "Applies-to Doc. Type" := CustLedger."Document Type";
                                "Global Dimension 1 Code" := CustLedger."Global Dimension 1 Code";
                                "Global Dimension 2 Code" := CustLedger."Global Dimension 2 Code";
                            end;
                        end;
                    "Account Type"::Vendor:
                        begin
                            VendLedger.RESET;
                            VendLedger.SETRANGE("Vendor No.", "Account No.");
                            VendLedger.SETRANGE(Open, true);
                            VendLedger.SETRANGE("Document No.", "Applies to Doc. No");
                            if VendLedger.FIND('-') then begin
                                "Applies-to Doc. Type" := VendLedger."Document Type";
                                "Global Dimension 1 Code" := VendLedger."Global Dimension 1 Code";
                                "Global Dimension 2 Code" := VendLedger."Global Dimension 2 Code";
                            end;
                        end;
                end;
            end;
        }
        field(16; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type';
            OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(17; "Procurement Method"; Option)
        {
            OptionCaption = '" ,Direct,RFQ,RFP,Tender,Low Value,Specially Permitted,EOI"';
            OptionMembers = " ",Direct,RFQ,RFP,Tender,"Low Value","Specially Permitted",EOI;
        }
        field(18; "Procurement Request"; Code[30])
        {
            //TableRelation = "Journal Line Dimension";
        }
        field(19; "Global Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,1,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(20; "Currency Code"; Code[50])
        {
            TableRelation = Currency.Code;
            trigger OnValidate()

            begin

                //Validate("Loan Amount");
                IF "Currency Code" <> '' THEN BEGIN
                    //GetCurrency;
                    IF ("Currency Code" <> xRec."Currency Code") OR
                       ("Receipt Date" <> xRec."Receipt Date") OR
                       (CurrFieldNo = FIELDNO("Currency Code")) OR
                       ("Currency Factor" = 0)
                    THEN
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate("Receipt Date", "Currency Code");
                END ELSE
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");

                IF Receipt.Get("Receipt No.") THEN begin
                    Receipt."Currency Code" := "Currency Code";
                    Receipt.Modify();
                end;
            end;
        }
        field(21; "Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Receipt Date';
        }
        field(22; "Currency Factor"; Decimal)
        {
            Editable = false;
            MinValue = 0;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF ("Currency Code" = '') AND ("Currency Factor" <> 0) THEN
                    FIELDERROR("Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION("Currency Code")));
                VALIDATE(Amount);
            end;
        }
        field(23; "Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount(LCY)';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            editable = false;
            TableRelation = "Dimension Set Entry";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Global Dimension 1 Code", "Global Dimension 2 Code");
            end;

            trigger OnLookUp()
            var
                myInt: Integer;
            begin
                ShowDimensions;
            end;
        }
    }

    keys
    {
        key(Key1; "Line No", "Receipt No.")
        {
            SumIndexFields = Amount;
        }
    }

    fieldgroups
    {
    }

    var
        GLAccount: Record "G/L Account";
        Cust: Record Customer;
        Vendor: Record Vendor;
        FixedAsset: Record "Fixed Asset";
        BankAccount: Record "Bank Account";
        CustLedger: Record "Cust. Ledger Entry";
        CustLedger1: Record "Cust. Ledger Entry";
        VendLedger: Record "Vendor Ledger Entry";
        VendLedger1: Record "Vendor Ledger Entry";
        Amt: Decimal;
        NetAmount: Decimal;
        Receipt: record "Receipts Header";
        GuaranteeApp: Record "Guarantee Application";
        CurrExchRate: Record "Currency Exchange Rate";
        Text002: TextConst ENU = 'cannot be specified without %1';
        DimMgt: Codeunit DimensionManagement;


    procedure ShowDimensions()
    var
        myInt: Integer;
    begin
        "Dimension Set ID" :=
          DimMgt.EditDimensionSet2(
            "Dimension Set ID", STRSUBSTNO('%1 %2 %3', '', '', ''), "Global Dimension 1 Code", "Global Dimension 2 Code");
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        myInt: Integer;
    begin
        //TESTFIELD("Check Printed",FALSE);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
}

