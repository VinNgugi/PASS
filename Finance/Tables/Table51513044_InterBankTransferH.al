table 51513044 "InterBank Transfer Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "No." <> xRec."No." then begin
                    CMSetup.Get();
                    if "Transaction Type" = "Transaction Type"::"InterBank Transfer" then
                        NoSeriesMgt.TestManual(CMSetup."Bank Transfer Nos")
                    else
                        if "Transaction Type" = "Transaction Type"::"Petty-Cash Request" then
                            NoSeriesMgt.TestManual(CMSetup."Petty Cash Replenishment Nos");

                end;
            end;
        }
        field(2; "Creation Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Creation Time"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(4; "Created By"; Code[20])
        {
            TableRelation = User."User Name";
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";

            trigger OnValidate()
            var

            begin
                if ObjBank.Get("Bank Account") then begin
                    "Bank Account Name" := ObjBank.Name;
                    "Currency Code" := ObjBank."Currency Code";
                    validate("Currency Code");
                end else begin
                    "Bank Account Name" := '';
                    "Currency Code" := '';
                    Validate("Currency Code");
                end;
            end;
        }
        field(7; "Bank Account Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Bank Acc Balance"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Bank Account Ledger Entry".Amount where ("Bank Account No." = field ("Bank Account")));
        }
        field(9; "Transaction Description"; Text[50])
        {

        }
        field(10; "Currency Code"; Code[20])
        {
            TableRelation = Currency.Code;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" <> '' THEN BEGIN
                    //GetCurrency;
                    IF ("Currency Code" <> xRec."Currency Code") OR
                       ("Creation Date" <> xRec."Creation Date") OR
                       (CurrFieldNo = FIELDNO("Currency Code")) OR
                       ("Currency Factor" = 0)
                    THEN
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate("Creation Date", "Currency Code");
                END ELSE
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");
            end;
        }
        field(11; "Currency Factor"; Decimal)
        {
            DataClassification = ToBeClassified;
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
        field(12; Amount; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" = '' THEN
                    "Amount (LCY)" := Amount
                ELSE
                    "Amount (LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Creation Date", "Currency Code",
                          Amount, "Currency Factor"));
            end;
        }
        field(13; "Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(14; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = filter (1), Blocked = const (false));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(15; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = filter (2), Blocked = const (false));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(16; Posted; Boolean)
        {
            Editable = false;
        }
        field(17; "Approval Status"; Option)
        {
            Editable = false;
            OptionMembers = New,"Pending Approval",Approved,Rejected;
        }
        field(18; Cashier; Code[20])
        {
            TableRelation = User;
            Editable = false;
        }
        field(19; "Transaction Type"; Option)
        {
            OptionMembers = " ","Petty-Cash Request","InterBank Transfer";
        }
        field(20; "Posted By"; Code[20])
        {
            TableRelation = User."User Name";
            Editable = false;
        }
        field(21; "Posted Date and Time"; DateTime)
        {

        }
        field(22; "Last Replenishment Date"; Date)
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
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CMSetup: Record "Cash Management Setup";
        ObjBank: Record "Bank Account";
        CurrExchRate: Record "Currency Exchange Rate";
        Text002: TextConst ENU = 'cannot be specified without %1';
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin
        case "Transaction Type" of
            "Transaction Type"::"InterBank Transfer":
                begin
                    if "No." = '' then begin
                        CMSetup.GET;
                        CMSetup.TESTFIELD(CMSetup."Bank Transfer Nos");
                        NoSeriesMgt.InitSeries(CMSetup."Bank Transfer Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    end;
                end;
            "Transaction Type"::"Petty-Cash Request":
                begin
                    if "No." = '' then begin
                        CMSetup.GET;
                        CMSetup.TESTFIELD(CMSetup."Petty Cash Replenishment Nos");
                        NoSeriesMgt.InitSeries(CMSetup."Petty Cash Replenishment Nos", xRec."No. Series", 0D, "No.", "No. Series");
                    end;
                    Cashier := UserId;
                    ObjBank.Reset();
                    ObjBank.SetRange("Cashier ID", UserId);
                    IF ObjBank.Find('-') then begin
                        "Bank Account" := ObjBank."No.";
                        "Last Replenishment Date" := ObjBank."Last Replenish Date";
                    end;
                end;
        end;
        "Created By" := UserId;
        "Creation Date" := Today;
        "Creation Time" := Time;
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