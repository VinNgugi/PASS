table 51513032 "PV Lines1"
{
    DataClassification = CustomerContent;
    Caption = 'PV Lines1';
    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No';
            TableRelation = "Payments HeaderFin";

        }
        field(2; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(3; Date; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Date';
        }
        field(4; "Account Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Account Type';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";


        }
        field(5; "Account No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Account No';
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" where(Blocked = const(false), "Direct Posting" = const(true))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer where(Blocked = const(" "))
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor where(Blocked = const(" "))
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset" where(Blocked = const(false))
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account" where(Blocked = const(false));

            trigger OnValidate()
            var
                myInt: Integer;
                PaymentHeader: Record "Payments HeaderFin";
            begin
                case "Account Type" of
                    "Account Type"::Customer:
                        begin
                            if Customer.Get("Account No") then begin
                                "Account Name" := Customer.Name;
                            end else
                                "Account Name" := '';
                        end;
                    "Account Type"::"G/L Account":
                        begin
                            if GLAccount.Get("Account No") then begin
                                "Account Name" := GLAccount.Name;
                            end else
                                "Account Name" := '';
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            if Bank.Get("Account No") then begin
                                "Account Name" := Bank.Name;
                            end else
                                "Account Name" := '';
                        end;
                    "Account Type"::Vendor:
                        begin
                            if Vendor.Get("Account No") then begin
                                "Account Name" := Vendor.Name;
                            end else
                                "Account Name" := '';
                        end;
                    "Account Type"::"Fixed Asset":
                        begin
                            if FixedAsset.Get("Account No") then begin
                                "Account Name" := FixedAsset.Description;
                            end else
                                "Account Name" := '';
                        end;

                end;



                if PaymentHeader.Get(No) then begin
                    Currency := PaymentHeader.Currency;
                    "Currency Factor" := PaymentHeader."Currency Factor";
                    Date := PaymentHeader.Date;
                end;

            end;

        }
        field(6; "Account Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Account Name';
        }
        field(7; "Description"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(8; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Amount';


            trigger OnValidate()

            begin

                CSetup.GET;
                CSetup.TESTFIELD("Rounding Precision");
                IF CSetup."Rounding Type" = CSetup."Rounding Type"::Up THEN
                    Direction := '>'
                ELSE
                    IF CSetup."Rounding Type" = CSetup."Rounding Type"::Nearest THEN
                        Direction := '='
                    ELSE
                        IF CSetup."Rounding Type" = CSetup."Rounding Type"::Down THEN
                            Direction := '<';
                CASE "Account Type" OF
                    "Account Type"::"G/L Account":
                        BEGIN
                            IF "VAT Code" <> '' THEN BEGIN
                                IF GLAccount.GET("Account No") THEN
                                    IF VATSetup.GET(GLAccount."VAT Bus. Posting Group", "VAT Code") THEN BEGIN
                                        IF VATSetup."VAT %" <> 0 THEN BEGIN
                                            VATAmount := ROUND((Amount / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                            NetAmount := Amount - VATAmount;
                                            "VAT Amount" := VATAmount;
                                            IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                                "Net Amount" := Amount - VATAmount
                                            ELSE
                                                "Net Amount" := Amount;
                                            IF "W/Tax Code" <> '' THEN BEGIN
                                                IF GLAccount.GET("Account No") THEN
                                                    IF VATSetup.GET(GLAccount."Gen. Bus. Posting Group", "W/Tax Code") THEN BEGIN
                                                        "W/TAmount" := ROUND(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                                            "Net Amount" := NetAmount
                                                        ELSE
                                                            "Net Amount" := Amount - "W/TAmount";
                                                    END;
                                            END;
                                        END ELSE BEGIN
                                            "Net Amount" := Amount;
                                            NetAmount := Amount;
                                            IF "W/Tax Code" <> '' THEN BEGIN
                                                IF GLAccount.GET("Account No") THEN
                                                    IF VATSetup.GET(GLAccount."Gen. Bus. Posting Group", "W/Tax Code") THEN BEGIN
                                                        "W/TAmount" := ROUND(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        "Net Amount" := Amount - "W/TAmount";
                                                    END;
                                            END;
                                        END;
                                    END;
                            END
                            ELSE BEGIN
                                "Net Amount" := Amount;
                                NetAmount := Amount;
                                IF "W/Tax Code" <> '' THEN BEGIN
                                    IF GLAccount.GET("Account No") THEN
                                        IF VATSetup.GET(GLAccount."Gen. Bus. Posting Group", "W/Tax Code") THEN BEGIN
                                            "W/TAmount" := ROUND(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);

                                            "W/Tax Amount" := "W/TAmount";
                                            NetAmount := NetAmount - "W/TAmount";
                                            "Net Amount" := Amount - "W/TAmount";
                                        END;
                                END;
                            END;
                        END;
                    "Account Type"::Customer:
                        BEGIN
                            IF "VAT Code" <> '' THEN BEGIN
                                IF Customer.GET("Account No") THEN
                                    IF VATSetup.GET(Customer."VAT Bus. Posting Group", "VAT Code") THEN BEGIN
                                        VATAmount := ROUND((Amount / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                        IF VATSetup."VAT %" <> 0 THEN BEGIN
                                            "VAT Amount" := VATAmount;
                                            NetAmount := Amount - VATAmount;

                                            IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                                "Net Amount" := Amount - VATAmount
                                            ELSE
                                                "Net Amount" := Amount;
                                            IF "W/Tax Code" <> '' THEN BEGIN
                                                IF Customer.GET("Account No") THEN
                                                    IF VATSetup.GET(Customer."VAT Bus. Posting Group", "W/Tax Code") THEN BEGIN
                                                        "W/TAmount" := ROUND(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                                            "Net Amount" := NetAmount
                                                        ELSE
                                                            "Net Amount" := Amount - "W/TAmount";
                                                    END;
                                            END;
                                        END ELSE BEGIN
                                            "Net Amount" := Amount;
                                            NetAmount := Amount;
                                            IF "W/Tax Code" <> '' THEN BEGIN
                                                IF Customer.GET("Account No") THEN
                                                    IF VATSetup.GET(Customer."VAT Bus. Posting Group", "W/Tax Code") THEN BEGIN
                                                        "W/TAmount" := ROUND(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        "Net Amount" := Amount - "W/TAmount";
                                                    END;
                                            END;
                                        END;
                                    END;
                            END
                            ELSE BEGIN
                                "Net Amount" := Amount;
                                NetAmount := Amount;
                                IF "W/Tax Code" <> '' THEN BEGIN
                                    IF Customer.GET("Account No") THEN
                                        IF VATSetup.GET(Customer."VAT Bus. Posting Group", "W/Tax Code") THEN BEGIN
                                            "W/TAmount" := ROUND(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                            "W/Tax Amount" := "W/TAmount";
                                            NetAmount := NetAmount - "W/TAmount";
                                            "Net Amount" := Amount - "W/TAmount";
                                        END;
                                END;
                            END;
                        END;
                    "Account Type"::Vendor:
                        BEGIN
                            IF "VAT Code" <> '' THEN BEGIN
                                IF Vendor.GET("Account No") THEN
                                    IF VATSetup.GET(Vendor."VAT Bus. Posting Group", "VAT Code") THEN BEGIN
                                        IF VATSetup."VAT %" <> 0 THEN BEGIN
                                            VATAmount := ROUND((Amount / (1 + VATSetup."VAT %" / 100) * VATSetup."VAT %" / 100), CSetup."Rounding Precision", Direction);
                                            NetAmount := Amount - VATAmount;
                                            "VAT Amount" := VATAmount;
                                            IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                                "Net Amount" := Amount - VATAmount
                                            ELSE
                                                "Net Amount" := Amount;
                                            IF "W/Tax Code" <> '' THEN BEGIN
                                                IF Vendor.GET("Account No") THEN
                                                    IF VATSetup.GET(Vendor."VAT Bus. Posting Group", "W/Tax Code") THEN BEGIN
                                                        "W/TAmount" := ROUND(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        IF CSetup."Post VAT" THEN//Check IF VAT is to be posted
                                                            "Net Amount" := NetAmount
                                                        ELSE
                                                            "Net Amount" := Amount - "W/TAmount";
                                                    END;
                                            END;
                                        END ELSE BEGIN
                                            "Net Amount" := Amount;
                                            NetAmount := Amount;
                                            IF "W/Tax Code" <> '' THEN BEGIN
                                                IF Vendor.GET("Account No") THEN
                                                    IF VATSetup.GET(Vendor."VAT Bus. Posting Group", "W/Tax Code") THEN BEGIN
                                                        "W/TAmount" := ROUND(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                                        "W/Tax Amount" := "W/TAmount";
                                                        NetAmount := NetAmount - "W/TAmount";
                                                        "Net Amount" := Amount - "W/TAmount";
                                                    END;
                                            END;
                                        END;
                                    END;
                            END
                            ELSE BEGIN
                                "Net Amount" := Amount;
                                NetAmount := Amount;
                                IF "W/Tax Code" <> '' THEN BEGIN
                                    IF Vendor.GET("Account No") THEN
                                        IF VATSetup.GET(Vendor."VAT Bus. Posting Group", "W/Tax Code") THEN BEGIN
                                            "W/TAmount" := ROUND(NetAmount * VATSetup."VAT %" / 100, CSetup."Rounding Precision", Direction);
                                            "W/Tax Amount" := "W/TAmount";
                                            NetAmount := NetAmount - "W/TAmount";
                                            "Net Amount" := Amount - "W/TAmount";
                                        END;
                                END;
                            END;
                        END;
                    "Account Type"::"Bank Account":
                        "Net Amount" := Amount;
                END;

                /*
                       //Confirm the Amount to be issued does not exceed the budget and amount Committed
                        //Get Budget for the G/L
                        GenLedSetup.GET;
                                GLAccount.SETFILTER(GLAccount."Budget Filter", GenLedSetup."Current Budget");
                                GLAccount.SETRANGE(GLAccount."No.", "Account No");
                                //Get budget amount avaliable
                                GLAccount.SETRANGE(GLAccount."Date Filter", GenLedSetup."Current Budget Start Date", GenLedSetup."Current Budget End Date");
                                IF GLAccount.FIND('-') THEN BEGIN
                                    GLAccount.CALCFIELDS(GLAccount."Budgeted Amount", GLAccount."Net Change");
                                    BudgetAmount := GLAccount."Budgeted Amount";
                                    Expenses := GLAccount."Net Change";
                                    BudgetAvailable := GLAccount."Budgeted Amount" - GLAccount."Net Change";
                                END;
                                //Get committed Amount
                                CommittedAmount := 0;
                                CommitmentEntries.RESET;
                                CommitmentEntries.SETCURRENTKEY(CommitmentEntries.Account);
                                CommitmentEntries.SETRANGE(CommitmentEntries.Account, "Account No");

                                PVHeader.RESET;
                                PVHeader.SETRANGE(PVHeader."No.", No);
                                IF PVHeader.FIND('-') THEN BEGIN
                                    IF PVHeader.Date = 0D THEN
                                        ERROR('Please insert the Payment Voucher date');
                                    CommitmentEntries.SETRANGE(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                                              PVHeader.Date);
                                    CommitmentEntries.CALCSUMS(CommitmentEntries."Committed Amount");
                                    CommittedAmount := CommitmentEntries."Committed Amount";

                        //IF LineBudget(No, "Account No.", "Line No") THEN
                                        MESSAGE('Line No %1 has been included in the Budget', "Line No")
                                    ELSE}

                        IF Rec."Account Type" = "Account Type"::"G/L Account" THEN
                                        IF CommittedAmount + Amount > BudgetAvailable THEN
                                            ERROR('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3 CommittedAmount %4'
                                           , "Account No",
                                            ABS(BudgetAvailable - (CommittedAmount + Amount)), BudgetAvailable, CommittedAmount);

                                END;
                */
                IF "Currency" = '' THEN begin
                    "Amount(LCY)" := Amount;
                    "VAT Amount(LCY)" := "VAT Amount";
                    "W/Tax Amount(LCY)" := "W/Tax Amount";
                    "Net Amount LCY" := "Net Amount";
                end ELSE begin
                    "Amount(LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Date", "Currency",
                           Amount, "Currency Factor"));

                    "VAT Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY(
                        Date, Currency, "VAT Amount", "Currency Factor"));

                    "W/Tax Amount(LCY)" := Round(CurrExchRate.ExchangeAmtFCYToLCY(
                        Date, Currency, "W/Tax Amount", "Currency Factor"));

                    "Net Amount LCY" := Round(CurrExchRate.ExchangeAmtFCYToLCY(
                    Date, Currency, "Net Amount", "Currency Factor"));
                end;



            end;
        }
        field(9; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Posted';
            Editable = false;
        }
        field(10; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Posting Date';
            Editable = false;
        }
        field(11; "Posting Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Time';
        }
        field(12; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(13; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(14; "Applies to Doc. No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applies to Doc. No';

            trigger OnLookup()

            begin

                "Applies to Doc. No" := '';
                Amt := 0;
                VATAmount := 0;
                "W/TAmount" := 0;

                CASE "Account Type" OF
                    "Account Type"::Customer:
                        BEGIN
                            CustLedger.RESET;
                            CustLedger.SETCURRENTKEY(CustLedger."Customer No.", Open, "Document No.");
                            CustLedger.SETRANGE(CustLedger."Customer No.", "Account No");
                            CustLedger.SETRANGE(Open, TRUE);
                            CustLedger.CALCFIELDS(CustLedger.Amount);
                            IF PAGE.RUNMODAL(25, CustLedger) = ACTION::LookupOK THEN BEGIN

                                IF CustLedger."Applies-to ID" <> '' THEN BEGIN
                                    CustLedger1.RESET;
                                    CustLedger1.SETCURRENTKEY(CustLedger1."Customer No.", Open, "Applies-to ID");
                                    CustLedger1.SETRANGE(CustLedger1."Customer No.", "Account No");
                                    CustLedger1.SETRANGE(Open, TRUE);
                                    CustLedger1.SETRANGE("Applies-to ID", CustLedger."Applies-to ID");
                                    IF CustLedger1.FIND('-') THEN BEGIN
                                        REPEAT
                                            CustLedger1.CALCFIELDS(CustLedger1.Amount);
                                            Amt := Amt + ABS(CustLedger1.Amount);
                                        UNTIL CustLedger1.NEXT = 0;
                                    END;

                                    IF Amt <> Amt THEN
                                        //ERROR('Amount is not equal to the amount applied on the application PAGE');
                                        IF Amount = 0 THEN
                                            Amount := Amt;
                                    VALIDATE(Amount);
                                    "Applies to Doc. No" := CustLedger."Document No.";
                                    Description := CustLedger.Description;
                                    "Global Dimension 1 Code" := CustLedger."Global Dimension 1 Code";
                                    Validate("Global Dimension 1 Code");
                                    "Global Dimension 2 Code" := CustLedger."Global Dimension 2 Code";
                                    Validate("Global Dimension 2 Code");
                                    "Dimension Set ID" := CustLedger."Dimension Set ID";
                                    Validate("Dimension Set ID");
                                END ELSE BEGIN
                                    IF Amount <> ABS(CustLedger.Amount) THEN
                                        CustLedger.CALCFIELDS(CustLedger."Remaining Amount");
                                    IF Amount = 0 THEN
                                        Amount := ABS(CustLedger."Remaining Amount");
                                    VALIDATE(Amount);
                                    "Applies to Doc. No" := CustLedger."Document No.";
                                    Description := CustLedger.Description;
                                    "Global Dimension 1 Code" := CustLedger."Global Dimension 1 Code";
                                    Validate("Global Dimension 1 Code");
                                    "Global Dimension 2 Code" := CustLedger."Global Dimension 2 Code";
                                    Validate("Global Dimension 2 Code");
                                    "Dimension Set ID" := CustLedger."Dimension Set ID";
                                    Validate("Dimension Set ID");

                                END;
                            END;
                            VALIDATE(Amount);
                        END;

                    "Account Type"::Vendor:
                        BEGIN
                            VendLedger.RESET;
                            VendLedger.SETCURRENTKEY(VendLedger."Vendor No.", Open, "Document No.");
                            VendLedger.SETRANGE(VendLedger."Vendor No.", "Account No");
                            VendLedger.SETRANGE(Open, TRUE);
                            VendLedger.CALCFIELDS("Remaining Amount");
                            IF PAGE.RUNMODAL(29, VendLedger) = ACTION::LookupOK THEN BEGIN

                                IF VendLedger."Applies-to ID" <> '' THEN BEGIN
                                    VendLedger1.RESET;
                                    VendLedger1.SETCURRENTKEY(VendLedger1."Vendor No.", Open, "Applies-to ID");
                                    VendLedger1.SETRANGE(VendLedger1."Vendor No.", "Account No");
                                    VendLedger1.SETRANGE(Open, TRUE);
                                    VendLedger1.SETRANGE(VendLedger1."Applies-to ID", VendLedger."Applies-to ID");
                                    IF VendLedger1.FIND('-') THEN BEGIN
                                        REPEAT
                                            VendLedger1.CALCFIELDS(VendLedger1."Remaining Amount");

                                            NetAmount := NetAmount + ABS(VendLedger1."Remaining Amount");

                                        UNTIL VendLedger1.NEXT = 0;
                                    END;

                                    IF Amount <> Amount THEN
                                        //ERROR('Amount is not equal to the amount applied on the application PAGE');
                                        IF Amount = 0 THEN
                                            Amount := Amount;

                                    VALIDATE(Amount);
                                    "Applies to Doc. No" := VendLedger."Document No.";
                                    Description := VendLedger.Description;
                                    "Global Dimension 1 Code" := VendLedger."Global Dimension 1 Code";
                                    Validate("Global Dimension 1 Code");
                                    "Global Dimension 2 Code" := VendLedger."Global Dimension 2 Code";
                                    Validate("Global Dimension 2 Code");
                                    "Dimension Set ID" := VendLedger."Dimension Set ID";
                                    Validate("Dimension Set ID");

                                END ELSE BEGIN
                                    IF Amount <> ABS(VendLedger."Remaining Amount") THEN
                                        VendLedger.CALCFIELDS(VendLedger."Remaining Amount");
                                    IF Amount = 0 THEN
                                        Amount := ABS(VendLedger."Remaining Amount");
                                    VALIDATE(Amount);
                                    "Applies to Doc. No" := VendLedger."Document No.";
                                    Description := VendLedger.Description;
                                    "Global Dimension 1 Code" := VendLedger."Global Dimension 1 Code";
                                    Validate("Global Dimension 1 Code");
                                    "Global Dimension 2 Code" := VendLedger."Global Dimension 2 Code";
                                    Validate("Global Dimension 2 Code");
                                    "Dimension Set ID" := VendLedger."Dimension Set ID";
                                    Validate("Dimension Set ID");
                                END;
                            END;
                            Amount := ABS(VendLedger."Remaining Amount");
                            VALIDATE(Amount);
                        END;
                END;
            end;
        }
        field(15; "VAT Code"; Code[20])
        {
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
            Caption = 'VAT Code';

            trigger OnValidate()

            begin
                Validate(Amount);
            end;
        }
        field(16; "W/Tax Code"; Code[50])
        {
            TableRelation = "VAT Product Posting Group";
            DataClassification = CustomerContent;
            Caption = 'W/Tax Code';

            trigger OnValidate()

            begin
                Validate(Amount);
            end;
        }
        field(17; "Retention Code"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Retention Code';
        }
        field(18; "VAT Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Amount';
        }
        field(19; "W/Tax Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'W/Tax Amount';
        }
        field(20; "Retention Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Retention Amount';
        }
        field(21; "Net Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Net Amount';
        }
        field(22; Quantity; Decimal)
        {
            trigger OnValidate()
            var

            begin
                Amount := Quantity * "Unit Price";
                Validate(Amount);
            end;
        }
        field(23; "Unit Price"; Decimal)
        {
            trigger OnValidate()
            var

            begin
                Amount := Quantity * "Unit Price";
                Validate(Amount);
            end;
        }
        field(24; Currency; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency';
            TableRelation = Currency;
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Currency <> '' THEN BEGIN
                    //GetCurrency;
                    IF (Currency <> xRec.Currency) OR
                       (CurrFieldNo = FIELDNO(Currency)) OR
                       ("Currency Factor" = 0)
                    THEN
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate(Today, Currency);
                END ELSE
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");
            end;

        }
        field(25; "Currency Factor"; Decimal)
        {
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF (Currency = '') AND ("Currency Factor" <> 0) THEN
                    FIELDERROR("Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION(Currency)));
            end;

        }
        field(26; "VAT Amount(LCY)"; Decimal)
        {
            Editable = False;
            DataClassification = CustomerContent;
            Caption = 'VAT Amount(LCY)';
        }
        field(27; "W/Tax Amount(LCY)"; Decimal)
        {
            editable = false;
            DataClassification = CustomerContent;
            Caption = 'W/Tax Amount(LCY)';
        }
        field(28; "Amount(LCY)"; Decimal)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Amount(LCY)';
        }
        field(29; "Global Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(30; "Net Amount LCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Amount LCY';
            Editable = false;
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
        key(PK; No, "Line No")
        {
            Clustered = true;
            SumIndexFields = "Net Amount", "VAT Amount", "W/Tax Amount";
        }
        key(PK2; "Line No")
        {
            SumIndexFields = "Net Amount", "VAT Amount", "W/Tax Amount";
        }
    }

    var
        CurrExchRate: Record "Currency Exchange Rate";
        GLAccount: Record "G/L Account";
        Vendor: Record Vendor;
        Bank: Record "Bank Account";
        Customer: Record Customer;
        FixedAsset: Record "Fixed Asset";
        TarriffCodes: Record "Petty Cash Lines";
        VATAmount: Decimal;
        "W/TAmount": Decimal;
        RetAmount: Decimal;
        NetAmount: Decimal;
        VATSetup: Record "VAT Posting Setup";
        CustLedger: Record "Cust. Ledger Entry";
        CustLedger1: Record "Cust. Ledger Entry";
        VendLedger: Record "Vendor Ledger Entry";
        VendLedger1: Record "Vendor Ledger Entry";
        Amt: Decimal;
        CSetup: Record "Cash Management Setup";
        Direction: Text[20];
        Text002: TextConst ENU = 'cannot be specified without %1';
        DimMgt: Codeunit DimensionManagement;


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

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