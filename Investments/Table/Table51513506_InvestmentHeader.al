table 51513506 "Investment Header"
{
    DataClassification = CustomerContent;
    DrillDownPageId = "Investment List";
    LookupPageId = "Investment List";
    Caption = 'Investment Header';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            Editable = false;

        }
        field(2; Description; Text[50])
        {
            caption = 'Description';
        }
        field(3; "Investment Start Date"; Date)
        {
            caption = 'Investment Start Date';
        }
        field(4; "Investment End Date"; Date)
        {
            caption = 'Investment End Date';
            Editable = false;
        }
        field(5; "Document Date"; Date)
        {
            Caption = 'Document Date';

        }
        field(6; "Source Bank"; Code[20])
        {
            Caption = 'Source Bank';
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            var

            begin
                IF "Source Bank" <> '' THEN BEGIN
                    BankCodes.GET("Source Bank");
                    "Source Bank Name" := BankCodes.Name;
                    "Currency Code" := BankCodes."Currency Code";
                    Validate("Currency Code");
                END ELSE BEGIN
                    "Source Bank Name" := '';
                    "Currency Code" := '';
                    Validate("Currency Code");
                END;
            end;
        }
        field(7; "Source Bank Name"; Text[150])
        {
            Caption = 'Source Bank Name';
            Editable = false;
        }
        field(8; "Investment Rate"; Decimal)
        {
            caption = 'Investment Rate';
            TableRelation = "Investment Rates".Rate WHERE (Type = FILTER (Interest));
        }
        field(9; "Investment Withholding Tax"; Decimal)
        {
            caption = 'Investment Withholding Tax';
            Editable = false;

        }

        field(10; "Investment Type"; Code[50])
        {
            caption = 'Investment Type';
            TableRelation = "Investment Types";

            trigger OnValidate()
            var
                InvType: Record "Investment Types";
            begin
                if InvType.Get("Investment Type") then begin
                    InvType.TestField(InvType."Interest Receivable Account");
                    InvType.TestField(InvType."Interest Income Account");

                end;
            end;
        }
        field(11; "Investment Principal"; Decimal)
        {
            caption = 'Investment Principal';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" = '' THEN
                    "Investment Principle(LCY)" := "Investment Principal"
                ELSE
                    "Investment Principle(LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Document Date", "Currency Code",
                          "Investment Principal", "Currency Factor"));
            end;
        }
        field(12; "Investment Duration"; DateFormula)
        {
            caption = 'Investment Duration';

            trigger Onvalidate()

            begin
                TESTFIELD("Investment Start Date");
                "Investment End Date" := CALCDATE("Investment Duration", "Investment Start Date")
            end;
        }
        field(13; "Investment Rollover Status"; Option)
        {
            Caption = 'Investment Rollover Status';
            OptionMembers = ,"First Rollover",Closed;
        }
        field(14; "Interest Earned"; Decimal)
        {
            caption = 'Interest Earned';
            FieldClass = FlowField;
            CalcFormula = sum ("Investment Interest Buffer"."Interest Amount" where ("Document No." = field ("No.")));
            Editable = false;
        }
        field(15; "No. Series"; Code[50])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }

        field(16; Status; Option)
        {
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            Caption = 'Status';
            Editable = false;
        }
        field(17; "Paying Document No."; Code[50])
        {
            caption = 'Paying Document No.';
        }
        field(18; "Expected Interest"; Decimal)
        {
            caption = 'Expected Interest';
        }
        field(19; "Withholding Tax Rate"; Decimal)
        {
            caption = 'Withholding Tax Rate';
            TableRelation = "Investment Rates".Rate WHERE (Type = FILTER ("Withholding Tax"));

        }
        field(20; "Archived Versions"; Integer)
        {
            caption = 'Archived Versions';
        }
        field(21; "Global Dimension 1 Code"; code[20])
        {
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (1));


        }
        field(22; "Global Dimension 2 Code"; code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (2));


        }
        field(23; "No of days elapsed"; Integer)
        {
            caption = 'No of days elapsed';
        }
        field(24; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = "User Setup";
        }
        field(25; "Investment Category"; Option)
        {
            caption = 'Investment Category';
            OptionMembers = FDR;
        }
        field(26; "Destination Bank Account"; code[20])
        {
            Caption = 'Destination Bank Account';
            TableRelation = "Bank Account"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Destination Bank Account" <> '' then begin
                    if BankCodes.Get("Destination Bank Account") then
                        "Destination Bank Acc Name" := bankcodes.Name;
                end else begin
                    "Destination Bank Acc Name" := '';
                end;
            end;

        }
        field(27; "Destination Bank Acc Name"; Text[150])
        {
            Caption = 'Destination Bank Name';
            Editable = false;

        }
        field(28; "Maturity Instructions"; Option)
        {
            Caption = 'Maturity Instructions';
            OptionMembers = "Roll Over Principle","Transfer To Other Bank","";

        }
        field(29; Posted; Boolean)
        {
            Editable = false;
        }
        field(30; "Posted By"; code[20])
        {
            Editable = false;
        }
        field(31; "Date Posted"; Date)
        {
            Editable = false;
        }
        field(32; "Currency Code"; Code[20])
        {
            TableRelation = Currency.Code;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    //GetCurrency;
                    IF ("Currency Code" <> xRec."Currency Code") OR
                       ("Document Date" <> xRec."Document Date") OR
                       (CurrFieldNo = FIELDNO("Currency Code")) OR
                       ("Currency Factor" = 0)
                    THEN
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate("Document Date", "Currency Code");
                END ELSE
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");
            end;
        }
        field(33; "Currency Factor"; Decimal)
        {
            Editable = false;
            MinValue = 0;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF ("Currency Code" = '') AND ("Currency Factor" <> 0) THEN
                    FIELDERROR("Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION("Currency Code")));
                VALIDATE("Investment Principal");
            end;
        }
        field(34; "Investment Principle(LCY)"; Decimal)
        {
            Editable = false;
        }
        field(35; "Interest Calculation Method"; Option)
        {
            Caption = 'Interest Calculation Method';
            OptionMembers = Monthly,Quarterly,"Bi-Annualy",Annually;
        }
        field(36; "Last Interest Date"; date)
        {
            caption = 'Last Interest Date';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = max ("Investment Interest Buffer"."Interest Date" where ("Document No." = field ("No.")));

        }
        field(37; "FD Status"; Option)
        {
            Caption = 'Fixed Deposit Status';
            Editable = false;
            OptionMembers = " ",Active,Terminated,Matured;
        }
        field(38; Closed; Boolean)
        {
            Editable = false;
        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        "Investment Setup": Record "Investment Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CurrExchRate: Record "Currency Exchange Rate";
        BankCodes: Record "Bank Account";
        Text002: TextConst ENU = 'cannot be specified without %1';

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            IF "Investment Category" = "Investment Category"::FDR THEN BEGIN
                "Investment Setup".GET;
                "Investment Setup".TESTFIELD("Investment Setup"."Investment Nos");
                NoSeriesMgt.InitSeries("Investment Setup"."Investment Nos", xRec."No. Series", 0D, "No.", "No. Series");
                "Document Date" := TODAY;
                "USER ID" := USERID;
            end;
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

    var


}