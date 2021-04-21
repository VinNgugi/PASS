table 51513045 "InterBank Transfer Lines"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Bank Account"; Code[20])
        {
            TableRelation = "Bank Account"."No.";
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ObjBank.Get("Bank Account") then begin
                    "Bank Acc. Name" := ObjBank.Name;
                end
                else begin
                    "Bank Acc. Name" := '';
                end;
            end;
        }
        field(3; "Bank Acc. Name"; Text[50])
        {
            Editable = false;
        }
        field(4; "Account Balance"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum("Bank Account Ledger Entry".Amount where("Bank Account No." = field("Bank Account")));
        }
        field(5; Amount; Decimal)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ObjTransH.Get("Header No.") then begin
                    IF ObjTransH."Currency Code" = '' THEN
                        "Amount (LCY)" := Amount
                    ELSE
                        "Amount (LCY)" := ROUND(
                            CurrExchRate.ExchangeAmtFCYToLCY(
                              ObjTransH."Creation Date", ObjTransH."Currency Code",
                              Amount, ObjTransH."Currency Factor"));
                end;

            end;
        }
        field(6; "Amount (LCY)"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Name where("Global Dimension No." = filter(1), Blocked = const(false));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(8; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Name where("Global Dimension No." = filter(2), Blocked = const(false));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
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
        key(PK; "Header No.", "Bank Account")
        {
            Clustered = true;
        }
    }

    var
        ObjTransH: Record "InterBank Transfer Header";
        CurrExchRate: Record "Currency Exchange Rate";
        ObjBank: Record "Bank Account";
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