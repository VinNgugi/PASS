table 51513034 "Petty Cash Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Petty Cash Lines';
    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No';

        }
        field(2; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            caption = 'Line No';
            AutoIncrement = true;
        }
        field(3; "Account Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Account Type';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(4; "Account No"; Code[20])
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
            end;

            trigger OnLookup()

            begin

            end;
        }
        field(5; "Account Name"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Account Name';
        }
        field(6; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(7; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Amount';

            trigger OnValidate()

            begin

                TESTFIELD("Transaction Type");
                //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                /*   GenLedSetup.GET;
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

                   PettyCashHeader.RESET;
                   PettyCashHeader.SETRANGE(PettyCashHeader."No.", No);
                   IF PettyCashHeader.FIND('-') THEN BEGIN
                       IF PettyCashHeader.Date = 0D THEN
                           ERROR('Please insert the Petty Cash date');
                       CommitmentEntries.SETRANGE(CommitmentEntries."Commitment Date", GenLedSetup."Current Budget Start Date",
                                                 PettyCashHeader.Date);
                       CommitmentEntries.CALCSUMS(CommitmentEntries."Committed Amount");
                       CommittedAmount := CommitmentEntries."Committed Amount";

                       IF LineBudget(No, "Account No.", "Line No") THEN
                                       MESSAGE('Line No %1 has been included in the Budget', "Line No")
                                   ELSE}

                      { IF Rec."Account Type" = "Account Type"::"G/L Account" THEN
                                       IF CommittedAmount + Amount > BudgetAvailable THEN
                                           ERROR('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3 CommittedAmount %4'
                                          , "Account No",
                                           ABS(BudgetAvailable - (CommittedAmount + Amount)), BudgetAvailable, CommittedAmount);  */
                "W/Tax Amount" := 0;
                "VAT Amount" := 0;
                "Net Amount" := 0;
                "Net Amount" := Amount;

                TaxTarriffCode.RESET;
                TaxTarriffCode.SETRANGE(TaxTarriffCode.Code, "VAT Code");
                IF TaxTarriffCode.FIND('-') THEN BEGIN
                    "VAT Amount" := ROUND("Net Amount" * (1 / (1 + (TaxTarriffCode.Percentage / 100))), 0.01, '=');
                    "VAT Amount" := ROUND("VAT Amount" * (TaxTarriffCode.Percentage / 100), 0.01, '=');
                    "Net Amount" := ROUND(Amount - ("VAT Amount"), 0.01, '=');
                END;

                TaxTarriffCode.RESET;
                TaxTarriffCode.SETRANGE(TaxTarriffCode.Code, "W/Tax Code");
                IF TaxTarriffCode.FIND('-') THEN BEGIN
                    "W/Tax Amount" := ROUND("Net Amount" * (TaxTarriffCode.Percentage / 100), 0.01, '=');
                    "Net Amount" := ROUND("Net Amount" - ("W/Tax Amount"), 0.01, '=');
                END;




                if PettyCashHeader.Get(No) then begin
                    IF PettyCashHeader.Currency = '' then begin
                        "Amount LCY" := Amount;
                        "VAT Amount LCY" := "VAT Amount";
                        "W/Tax Amount LCY" := "W/Tax Amount";
                        "Net Amount LCY" := "Net Amount";
                    end
                    else begin
                        "Amount LCY" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PettyCashHeader.Date, PettyCashHeader.Currency, amount, PettyCashHeader."Currency Factor"));
                        "VAT Amount LCY" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PettyCashHeader.Date, PettyCashHeader.Currency, "VAT Amount", PettyCashHeader."Currency Factor"));
                        "W/Tax Amount LCY" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PettyCashHeader.Date, PettyCashHeader.Currency, "W/Tax Amount", PettyCashHeader."Currency Factor"));
                        "Net Amount LCY" := ROUND(CurrExchRate.ExchangeAmtFCYToLCY(PettyCashHeader.Date, PettyCashHeader.Currency, "Net Amount", PettyCashHeader."Currency Factor"));
                    end;

                end;




            END;

            // end;
        }
        field(8; "Global Dimension 1 Code"; Code[20])
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
        field(9; "Global Dimension 2 Code"; Code[20])
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
        field(10; "Transaction Type"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Transaction Type';
            TableRelation = "Transaction Types".Code where("Transaction Ref" = filter("Petty Cash" | Both));
            trigger OnValidate()

            begin

                IF TransType.GET("Transaction Type") THEN BEGIN
                    "Account Type" := TransType."Account Type";
                    "Account No" := TransType."Account No.";
                    "Account Name" := TransType."Transaction Name";
                END;
                VALIDATE(Amount);
            end;
        }
        field(11; "Amount LCY"; Decimal)
        {
            Editable = false;
        }
        field(12; "VAT Amount"; Decimal)
        {
            Editable = false;
        }
        field(13; "VAT Amount LCY"; Decimal)
        {
            Editable = false;
        }
        field(14; "W/Tax Amount"; Decimal)
        {
            Editable = false;
        }
        field(15; "W/Tax Amount LCY"; Decimal)
        {
            Editable = false;
        }
        field(16; "VAT Code"; Code[20])
        {
            TableRelation = "Tax Tarriff Code".Code where(Type = const(VAT));
            DataClassification = CustomerContent;
            Caption = 'VAT Code';

            trigger OnValidate()

            begin
                Validate(Amount);
            end;
        }
        field(17; "W/Tax Code"; Code[50])
        {
            TableRelation = "Tax Tarriff Code".Code where(Type = const("W/Tax"));
            DataClassification = CustomerContent;
            Caption = 'W/Tax Code';

            trigger OnValidate()

            begin
                Validate(Amount);
            end;
        }
        field(18; "Net Amount"; Decimal)
        {
            Editable = false;
        }
        field(19; "Net Amount LCY"; Decimal)
        {
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
            SumIndexFields = Amount;
        }
    }

    var
        TransType: Record "Transaction Types";
        GLAccount: Record "G/L Account";
        Vendor: Record Vendor;
        Bank: Record "Bank Account";
        Customer: Record Customer;
        FixedAsset: Record "Fixed Asset";
        TaxTarriffCode: Record "Tax Tarriff Code";
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
        PettyCashHeader: Record "Payments HeaderFin";
        CurrExchRate: Record "Currency Exchange Rate";
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