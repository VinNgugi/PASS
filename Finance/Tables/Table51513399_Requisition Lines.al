table 51513399 "Requisition Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Requisition Lines';
    fields
    {
        field(1; "Requisition No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Requisition No';
            TableRelation = "Requisition Header";

            trigger OnValidate()

            begin
                IF ReqHeader.GET("Requisition No") THEN BEGIN
                    "Procurement Plan" := ReqHeader."Procurement Plan";
                    "Global Dimension 1 Code" := ReqHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := ReqHeader."Global Dimension 2 Code";
                END;
            end;

        }
        field(2; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            caption = 'Line No';

            trigger Onvalidate()

            begin

                IF ReqHeader.GET("Requisition No") THEN BEGIN
                    "Procurement Plan" := ReqHeader."Procurement Plan";
                    "Global Dimension 1 Code" := ReqHeader."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := ReqHeader."Global Dimension 2 Code";

                END;
            end;
        }
        field(3; Type; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Type';
            OptionMembers = " ",Item,Asset,Service;
        }
        field(4; No; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'No';
            TableRelation = IF (Type = CONST(Asset)) "Fixed Asset" WHERE(Blocked = FILTER(false)) ELSE
            IF (Type = CONST(Item)) "Transaction Types" WHERE("Transaction Ref" = filter("Petty Cash" | Both)) else
            if (Type = const(Service)) "Transaction Types" where("Transaction Ref" = filter(Service));

            trigger OnValidate()

            begin

                IF (Type = Type::Item) or (Type = Type::Service) THEN BEGIN
                    if TransTypes.Get(No) then begin
                        Description := TransTypes."Transaction Name";
                        "Account Type" := TransTypes."Account Type";
                        "Account No." := TransTypes."Account No.";
                        Validate("Account No.");
                    end;
                end else
                    if Type = Type::Asset then begin
                        if FAsset.Get(No) then begin

                            Description := FAsset.Description;
                            "Account Type" := "Account Type"::"Fixed Asset";
                            "Account No." := No;
                            Validate("Account No.");
                        end
                        else
                            Description := '';
                    end;
                /*IF ItemRec.GET(No) THEN BEGIN
                    Description := ItemRec.Description;
                    "Unit of Measure" := ItemRec."Base Unit of Measure";

                    ItemRec.CALCFIELDS(ItemRec.Inventory);
                    "Quantity in Store" := ItemRec.Inventory;
                    "Unit Price" := ItemRec."Unit Cost";

                END;*/
            END;


        }
        field(5; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(6; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Quantity';

            trigger Onvalidate()

            begin

                /*IF ReqHeader.GET("Requisition No") THEN BEGIN
                    //IF ReqHeader."Requisition Type"=ReqHeader."Requisition Type"::"Cheque Requisition" THEN
                    IF ReqHeader."Requisition Type" = ReqHeader."Requisition Type"::"Store Requisition" THEN BEGIN
                        IF Type = Type::Item THEN BEGIN
                            IF ItemRec.GET(No) THEN BEGIN
                                Description := ItemRec.Description;
                                ItemRec.CALCFIELDS(ItemRec.Inventory);
                                "Quantity in Store" := ItemRec.Inventory;
                                IF "Quantity in Store" < Quantity THEN
                                    ERROR('Your Request for Item %1 cannot proceed because of no stock quantity', Description);

                            END;

                        END;
                    END;
                END;*/
                "Quantity Approved" := Quantity;

                VALIDATE("Unit Price");
                VALIDATE(Amount);
            end;
        }
        field(7; "Unit of Measure"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(8; "Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Unit Price';

            trigger Onvalidate()

            begin

                Amount := Quantity * "Unit Price";
                VALIDATE(Amount);
            end;
        }
        field(9; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Amount';

            trigger OnValidate()
            begin
                IF "Currency Code" = '' THEN
                    "Amount LCY" := Amount
                ELSE
                    "Amount LCY" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          Today, "Currency Code",
                          Amount, "Currency Factor"));
            end;
        }
        field(10; "Procurement Plan"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Procurement Plan';
            TableRelation = "G/L Budget Name";
        }
        field(11; "Procurement Plan Item"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Procurement Plan Item';
            // TableRelation="Procurement Plan"."Plan Item No" WHERE ("Plan Year"=FIELD("Procurement Plan"),"Department Code"=FIELD("Global Dimension 1 Code"));
        }
        field(12; "Budget Line"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Budget Line';
            TableRelation = "G/L Account";
        }
        field(13; "Global Dimension 1 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(14; "Amount LCY"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Amount LCY';
            Editable = false;
        }
        field(15; Select; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Select';
        }
        field(16; "Request Generated"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Request Generated';
        }
        field(22; "Process Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Process Type';
            OptionMembers = ,Direct,RFQ,RFP,Tender;
        }
        field(23; "Quantity Approved"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Quantity Approved';

        }
        field(24; "Quantity in Store"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Quantity in Store';
            Editable = false;
        }
        field(25; "Approved Budget Amount"; Decimal)
        {
            FieldClass = Normal;
            caption = 'Approved Budget Amount';
            //CalcFormula=Sum("Procurement Plan"."Estimated Cost" WHERE ("No."=FIELD(No),"Plan Year"=FIELD("Procurement Plan"),"Department Code"=FIELD("Global Dimension 1 Code"),"Plan Item No"=FIELD("Procurement Plan Item")));

        }
        field(26; "Commitment Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Commitment Amount';
            Editable = false;
            //CalcFormula=Sum("Commitment Entries"."Committed Amount" WHERE (Account=FIELD("Budget Line"),"Global Dimension 1"=FIELD("Global Dimension 1 Code")));
        }
        field(27; "Actual Expense"; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Actual Expense';
            Editable = false;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No." = FIELD("Budget Line"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Code")));
        }
        field(28; "Available amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Available amount';
        }
        field(29; "Requisition Status"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Requisition Status';
            OptionMembers = ,Approved,Rejected;
        }
        field(30; Remarks; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(31; "Global Dimension 2 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(32; "Account Type"; Option)
        {
            Editable = false;
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(33; "Account No."; Code[20])
        {
            Editable = false;
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
                Customer: Record Customer;
                GLAccount: Record "G/L Account";
                Vendor: Record Vendor;
                Bank: Record "Bank Account";
                FixedAsset: Record "Fixed Asset";
            begin
                case "Account Type" of
                    "Account Type"::Customer:
                        begin
                            /*if Customer.Get("Account No.") then begin
                                "Account Name" := Customer.Name;
                            end else
                                "Account Name" := '';*/
                        end;
                    "Account Type"::"G/L Account":
                        begin
                            if GLAccount.Get("Account No.") then begin
                                if GLAccount.Blocked then
                                    Error('The GL Account Number %1 is blocked. Contact the finance team for assistance', GLAccount."No.");
                            end;
                        end;
                    "Account Type"::"Bank Account":
                        begin
                            /*if Bank.Get("Account No.") then begin
                                "Account Name" := Bank.Name;
                            end else
                                "Account Name" := '';*/
                        end;
                    "Account Type"::Vendor:
                        begin
                            /*if Vendor.Get("Account No.") then begin
                                "Account Name" := Vendor.Name;
                            end else
                                "Account Name" := '';*/
                        end;
                    "Account Type"::"Fixed Asset":
                        begin
                            /*if FixedAsset.Get("Account No.") then begin
                                "Account Name" := FixedAsset.Description;
                            end else
                                "Account Name" := '';*/
                        end;

                end;
            end;

        }
        field(34; "Currency Code"; Code[20])
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
        field(35; "Currency Factor"; Decimal)
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
        key(PK; "Requisition No", "Line No")
        {
            Clustered = true;
            SumIndexFields = Amount, "Amount LCY";
        }
    }

    var
        CurrExchRate: Record "Currency Exchange Rate";
        ReqHeader: Record "Requisition Header";
        ItemRec: Record Item;
        TransTypes: Record "Transaction Types";
        FAsset: Record "Fixed Asset";
        Text002: TextConst ENU = 'cannot be specified without %1';
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin

        IF ReqHeader.GET("Requisition No") THEN BEGIN
            "Procurement Plan" := ReqHeader."Procurement Plan";
            "Global Dimension 1 Code" := ReqHeader."Global Dimension 1 Code";
            IF ReqHeader.Status <> ReqHeader.Status::Open THEN
                ERROR('You cannot add more lines at this stage');
        END;

        IF ReqHeader.GET("Requisition No") THEN BEGIN
            "Global Dimension 1 Code" := ReqHeader."Global Dimension 1 Code";
        END;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

        IF ReqHeader.GET("Requisition No") THEN
            IF ReqHeader.Status <> ReqHeader.Status::Open THEN
                ERROR('You cannot add more lines at this stage');
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