table 51513028 "Receipts Header"
{
    // version FINANCE

    Caption = 'Receipts Header';
    LookupPageId = "Receipt List";
    DrillDownPageId = "Receipt List";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[20])
        {

            trigger OnValidate();
            begin
                GLSetup.GET;
                if "No." <> xRec."No." then begin
                    NoSeriesMgt.TestManual(GLSetup."Receipt No");
                end;
            end;
        }
        field(2; Date; Date)
        {
        }
        field(3; "Pay Mode"; Code[20])
        {
            TableRelation = "Pay Modes";
        }
        field(4; "Cheque No"; Code[20])
        {
        }
        field(5; "Cheque Date"; Date)
        {
        }
        field(6; "Total Amount"; Decimal)
        {
            CalcFormula = Sum ("Receipt Lines".Amount WHERE ("Receipt No." = FIELD ("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "Amount(LCY)"; Decimal)
        {
            CalcFormula = Sum ("Receipt Lines"."Amount(LCY)" WHERE ("Receipt No." = FIELD ("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Bank Code"; Code[50])
        {
            TableRelation = "Bank Account";
        }
        field(9; "Received From"; Text[70])
        {
        }
        field(10; "On Behalf Of"; Text[70])
        {
        }
        field(11; Cashier; Code[50])
        {
            Editable = false;
        }
        field(12; Posted; Boolean)
        {
            Editable = false;
        }
        field(13; "Posted Date"; Date)
        {
            Editable = false;
        }
        field(14; "Posted Time"; Time)
        {
            Editable = false;
        }
        field(15; "Posted By"; Code[50])
        {
            Editable = false;
        }
        field(16; "No. Series"; Code[50])
        {
            TableRelation = "No. Series";
        }
        field(17; "Currency Code"; Code[50])
        {
            TableRelation = Currency.Code;
        }
        field(18; "Global Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(19; "Global Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(20; Status; Option)
        {
            OptionCaption = 'Open,Pending Approval,Pending Prepayment,Released,Closed,Rejected';
            OptionMembers = Open,"Pending Approval","Pending Prepayment",Released,Closed,Rejected;
        }
        field(21; Amount; Decimal)
        {
        }
        field(22; Banked; Boolean)
        {
        }
        field(23; "Procurement Method"; Option)
        {
            OptionCaption = '" ,Direct,RFQ,RFP,Tender,Low Value,Specially Permitted,EOI"';
            OptionMembers = " ",Direct,RFQ,RFP,Tender,"Low Value","Specially Permitted",EOI;
        }
        field(24; "Procurement Request"; Code[30])
        {

            trigger OnValidate();
            begin
                //IF (Procurement Method=CONST(Direct)) "Procurement Request1" WHERE (Process Type=CONST(Direct)) ELSE IF (Procurement Method=CONST(RFP)) "Procurement Request1" WHERE (Process Type=CONST(RFP)) ELSE IF (Procurement Method=CONST(RFQ)) "Procurement Re
            end;
        }
        field(25; "Global Dimension 3 Code"; Code[50])
        {
            CaptionClass = '1,1,3';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (3));
        }
        field(26; "Imprest Receipt"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Imprest Receipt';
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
        field(50000; "Guarantee Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Guarantee Application No.';
            TableRelation = "Guarantee Application"."No." where ("Application fee Invoiced" = const (true));



        }
        field(50001; "Guarantee Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Transaction Type';
            OptionMembers = " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee";
        }

        field(50002; "Application No."; Code[50])
        {
            DataClassification = CustomerContent;
            //TableRelation = "Job Applicants" where ("Job Function" = filter ("AIC Job"));

            trigger OnLookup()
            begin
                case "AIC fee Type" of
                    "AIC fee Type"::"Wall Application fee":
                        begin
                            if Page.RunModal(51513804, Wall) = Action::LookupOK then
                                "Application No." := Wall."No."

                        end;
                    "AIC fee Type"::"Nonwall Application fee":
                        begin
                            if Page.RunModal(51513830, NonWall) = Action::LookupOK then
                                "Application No." := NonWall."Application ID"
                        end;
                end;
            end;
        }
        field(50003; "AIC fee Type"; Option)
        {
            OptionMembers = " ","Wall Application fee","Nonwall Application fee";

        }
        field(50004; "AIC fee"; Boolean)
        {

        }

    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLSetup: Record "General Ledger Setup";
        CashMmtSetup: Record "Cash Management Setup";
        ReceiptLines: Record "Receipt Lines";
        NonWall: Record "Non-Wall Applications";
        Wall: Record "Incubation Applicants";
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert();
    begin
        if "No." = '' then begin
            CashMmtSetup.GET;
            CashMmtSetup.TESTFIELD(CashMmtSetup."Receipt No");
            NoSeriesMgt.InitSeries(CashMmtSetup."Receipt No", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        GLSetup.GET;
        Cashier := USERID;
    end;


    [Scope('Personalization')]
    procedure ReqLinesExist(): Boolean;
    begin
        ReceiptLines.RESET;
        ReceiptLines.SETRANGE("Receipt No.", "No.");
        exit(ReceiptLines.FINDFIRST);
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

