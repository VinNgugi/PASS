table 51513033 "Imprest Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Imprest Lines';

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Payments HeaderFin"."No.";
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
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner";
        }
        field(4; "Account No."; code[20])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
            TableRelation = IF ("Account Type" = CONST("G/L Account")) "G/L Account" where(Blocked = const(false), "Direct Posting" = const(true))
            ELSE
            IF ("Account Type" = CONST(Customer)) Customer where(Blocked = const(" "))
            ELSE
            IF ("Account Type" = CONST(Vendor)) Vendor where(Blocked = const(" "))
            ELSE
            IF ("Account Type" = CONST("Fixed Asset")) "Fixed Asset" where(Blocked = const(false))
            ELSE
            IF ("Account Type" = CONST("Bank Account")) "Bank Account" where(Blocked = const(false));

            trigger Onvalidate()

            begin
                case "Account Type" of
                    "Account Type"::Customer:
                        begin
                            if Customer.Get("Account No.") then begin
                                "Account Name" := Customer.Name;
                            end else
                                "Account Name" := '';
                        end;
                    "Account Type"::"G/L Account":
                        begin
                            if GLAccount.Get("Account No.") then begin
                                "Account Name" := GLAccount.Name;
                            end else
                                "Account Name" := '';
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            if Bank.Get("Account No.") then begin
                                "Account Name" := Bank.Name;
                            end else
                                "Account Name" := '';
                        end;
                    "Account Type"::Vendor:
                        begin
                            if Vendor.Get("Account No.") then begin
                                "Account Name" := Vendor.Name;
                            end else
                                "Account Name" := '';
                        end;
                    "Account Type"::"Fixed Asset":
                        begin
                            if FixedAsset.Get("Account No.") then begin
                                "Account Name" := FixedAsset.Description;
                            end else
                                "Account Name" := '';
                        end;

                end;
                Validate(Amount);

            end;

            trigger OnLookUp()

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
            DataClassification = ToBeClassified;
            Caption = 'Amount';

            trigger Onvalidate()

            begin

                if ("Transaction Type" = 'DSA NON CLIENT') or ("Transaction Type" = 'DSA TO CLIENT') or ("Transaction Type" = 'DSAE') then begin
                    if ImprestHeader.Get(No) then begin
                        case ImprestHeader."DSA Option" of
                            ImprestHeader."DSA Option"::"Full DSA":
                                begin
                                    if Amount > (ImprestHeader."Imprest Rate" * ImprestHeader."No. of Days") then
                                        Error('You are not allowed to edit up the imprest amount. Kindly contact your supervisor');
                                end;
                            ImprestHeader."DSA Option"::"50% DSA":
                                begin
                                    if Amount > ((ImprestHeader."Imprest Rate" * (50 / 100)) * (ImprestHeader."No. of Days")) then
                                        Error('You are not allowed to edit up the imprest amount. Kindly contact your supervisor');
                                end;
                            ImprestHeader."DSA Option"::"60% DSA":
                                begin
                                    if Amount > ((ImprestHeader."Imprest Rate" * (60 / 100)) * (ImprestHeader."No. of Days" - 1.5)) + (ImprestHeader."Imprest Rate" * 1.5) then
                                        Error('You are not allowed to edit up the imprest amount. Kindly contact your supervisor');
                                end;
                        end;

                    end;
                end;

                IF "Currency Code" = '' THEN
                    "Amount LCY" := Amount
                ELSE
                    "Amount LCY" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          Today, "Currency Code",
                          Amount, "Currency Factor"));
                /*        
               //Confirm the Amount to be issued does not exceed the budget and amount Committed
                //Get Budget for the G/L
                GenLedSetup.GET;
                GLAccount.SETFILTER(GLAccount."Budget Filter",GenLedSetup."Current Budget");
                GLAccount.SETRANGE(GLAccount."No.","Account No.");
               //Get budget amount avaliable
               GLAccount.SETRANGE(GLAccount."Date Filter",GenLedSetup."Current Budget Start Date",GenLedSetup."Current Budget End Date");
                IF GLAccount.FIND('-') THEN BEGIN
                 GLAccount.CALCFIELDS(GLAccount."Budgeted Amount",GLAccount."Net Change");
                 BudgetAmount:=GLAccount."Budgeted Amount";
                 Expenses:=GLAccount."Net Change";
                 BudgetAvailable:=GLAccount."Budgeted Amount"-GLAccount."Net Change";
                END;
             //Get committed Amount
             CommittedAmount:=0;
             CommitmentEntries.RESET;
             CommitmentEntries.SETCURRENTKEY(CommitmentEntries.Account);
             CommitmentEntries.SETRANGE(CommitmentEntries.Account,"Account No.");

              ImprestHeader.RESET;
              ImprestHeader.SETRANGE(ImprestHeader."No.",No);
              IF ImprestHeader.FIND('-')THEN BEGIN
               IF ImprestHeader.Date=0D THEN
                ERROR('Please insert the imprest date');
                CommitmentEntries.SETRANGE(CommitmentEntries."Commitment Date",GenLedSetup."Current Budget Start Date",
                                          ImprestHeader.Date);
                CommitmentEntries.CALCSUMS(CommitmentEntries."Committed Amount");
                CommittedAmount:=CommitmentEntries."Committed Amount";

                {IF LineBudget(No,"Account No.","Line No")THEN
                   MESSAGE('Line No %1 has been included in the Budget',"Line No")
                ELSE}

                {IF Rec."Account Type" = "Account Type"::"G/L Account" THEN
                  IF CommittedAmount + Amount>BudgetAvailable THEN
                     ERROR('You have Exceeded Budget for G/L Account No %1 By %2 Budget Available %3 CommittedAmount %4'
                    ,"Account No.",
                     ABS(BudgetAvailable - (CommittedAmount+Amount)),BudgetAvailable,CommittedAmount);}

              END;
              */
            end;

        }
        field(8; "Applies- to Doc. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applies- to Doc. No.';
        }
        field(9; "Global Dimension 1 Code"; Code[20])
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
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;

        }
        field(11; "Actual Spent"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Actual Spent';

            trigger OnValidate()

            begin
                if ("Transaction Type" = 'DSA NON CLIENT') or ("Transaction Type" = 'DSA TO CLIENT') or ("Transaction Type" = 'DSAE') then begin
                    if ImprestHeader.Get(No) then begin
                        //if ImprestHeader."Total Days Spent" = 0 then
                        //   Error('Please update the total days spent');
                    end;
                end;
                "Remaining Amount" := Amount - "Actual Spent";
            end;
        }
        field(12; "Remaining Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Remaining Amount';
            Editable = false;
        }
        field(13; Committed; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Committed';
        }
        field(14; "Currency Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Currency Code';

            TableRelation = Currency;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    //GetCurrency;
                    IF ("Currency Code" <> xRec."Currency Code") OR
                       (CurrFieldNo = FIELDNO("Currency Code")) OR
                       ("Currency Factor" = 0)
                    THEN
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate(Today, "Currency Code");
                END ELSE
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");
            end;
        }
        field(15; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF ("Currency Code" = '') AND ("Currency Factor" <> 0) THEN
                    FIELDERROR("Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION("Currency Code")));
                VALIDATE(Amount);
            end;
        }
        field(16; "Amount LCY"; Decimal)
        {
            DataClassification = customercontent;
            Caption = 'Amount LCY';
        }
        field(17; "Expense Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Expense Type';
            OptionMembers = "Accountable Expenses","Non-Accountable Expenses";
        }
        field(18; "Transaction Type"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Transaction Type';
            TableRelation = "Transaction Types".Code where("Transaction Ref" = filter(imprest | Both));

            trigger OnValidate()

            begin

                IF TransType.GET("Transaction Type") THEN BEGIN
                    "Account Type" := TransType."Account Type";
                    "Account No." := TransType."Account No.";
                    "Account Name" := TransType."Transaction Name";
                END;
                if ("Transaction Type" = 'DSA NON CLIENT') or ("Transaction Type" = 'DSA TO CLIENT') or ("Transaction Type" = 'DSAE') then begin
                    if ImprestHeader.Get(No) then begin
                        case ImprestHeader."DSA Option" of
                            ImprestHeader."DSA Option"::"Full DSA":
                                begin
                                    Amount := (ImprestHeader."Imprest Rate" * ImprestHeader."No. of Days");
                                end;
                            ImprestHeader."DSA Option"::"50% DSA":
                                begin
                                    Amount := ((ImprestHeader."Imprest Rate" * (50 / 100)) * (ImprestHeader."No. of Days"));
                                end;
                            ImprestHeader."DSA Option"::"60% DSA":
                                begin
                                    Amount := ((ImprestHeader."Imprest Rate" * (60 / 100)) * (ImprestHeader."No. of Days" - 1.5)) + (ImprestHeader."Imprest Rate" * 1.5);
                                end;
                        end;

                    end;
                end;
                VALIDATE(Amount);

            end;
        }
        field(19; "Reason for Overspending"; Text[150])
        {

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
            SumIndexFields = Amount, "Actual Spent", "Remaining Amount";
        }
        key(Coe; "Expense Type")
        {

        }
    }

    var
        TransType: Record "Transaction Types";
        GLAccount: Record "G/L Account";
        Customer: Record Customer;
        Vendor: Record Vendor;
        Bank: Record "Bank Account";
        FixedAsset: Record "Fixed Asset";
        Amt: Decimal;
        CustLedger: Record "Cust. Ledger Entry";
        CustLedger1: Record "Cust. Ledger Entry";
        ImprestHeader: Record "Payments HeaderFin";
        PVLinesRec: Record "Imprest Lines";
        CurrExchRate: Record "Currency Exchange Rate";
        Text002: TextConst ENU = 'cannot be specified without %1';
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin
        ImprestHeader.Reset();
        ImprestHeader.SetRange("No.", No);
        if ImprestHeader.Find('-') then begin
            "Currency Code" := ImprestHeader.Currency;
            "Currency Factor" := ImprestHeader."Currency Factor";
        end;
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