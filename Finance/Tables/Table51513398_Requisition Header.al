table 51513398 "Requisition Header"
{
    DataClassification = CustomerContent;
    Caption = 'Requisition Header';
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase No.';

            trigger OnValidate()

            begin

                IF "No." <> xRec."No." THEN BEGIN

                    IF "Requisition Type" = "Requisition Type"::"Purchase Requisition" THEN BEGIN
                        PurchSetup.GET;
                        NoSeriesMgt.TestManual(PurchSetup."Purchase Req No");
                        "No. Series" := '';
                    END;

                    IF "Requisition Type" = "Requisition Type"::"Store Requisition" THEN BEGIN
                        PurchSetup.GET;
                        NoSeriesMgt.TestManual(PurchSetup."Store Requisition Nos.");
                        "No. Series" := '';
                    END;

                END;

            end;

        }
        field(2; "Employee Code"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Employee Code';
            Editable = false;
            TableRelation = Employee;

            trigger Onvalidate()

            begin

                IF Empl.GET("Employee Code") THEN
                    "Employee Name" := Empl."First Name" + ' ' + Empl."Last Name"
                ELSE
                    "Employee Name" := '';
                MODIFY;
            end;
        }
        field(3; "Employee Name"; Text[50])
        {
            DataClassification = CustomerContent;
            caption = 'Employee Name';
            Editable = false;
        }
        field(5; "Purchase Description"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason';
        }
        field(6; "Requisition Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Requisition Date';
        }
        field(7; Status; option)
        {
            DataClassification = CustomerContent;
            caption = 'Status';
            Editable = false;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected,,Closed;
        }
        field(10; "Raised by"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Raised by';
            Editable = false;
        }
        field(14; "No. Series"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(16; "Request Generated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Request Generated';
        }
        field(18; Purchase; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase';
        }
        field(20; "MA Approval"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'MA Approval';
        }
        field(21; Rejected; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Rejected';
        }
        field(22; "Process Type"; Option)
        {
            Caption = 'Process Type';
            DataClassification = CustomerContent;
            OptionMembers = ,Direct,RFQ,RFP,Tender;
        }
        field(23; "Global Dimension 1 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(37; Ordered; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Ordered';
        }
        field(38; User; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'User';
            TableRelation = "User Setup";
        }
        field(39; "Global Dimension 2 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(40; "Global Dimension 3 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Global Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (3));
        }
        field(41; "Procurement Plan"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Procurement Plan';
        }
        field(42; "Purchaser Code"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Purchaser Code';
        }
        field(43; "Issue Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Issue Type';
            OptionMembers = Returnable,"Non-Returnable";
        }
        field(44; "Currency Code"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(45; "Date of Use"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Date of Use';
        }
        field(46; "Requisition Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Requisition Type';
            OptionMembers = "Purchase Requisition","Imprest Requisitioning",Imprest,"Imprest Surrender","Store Requisition";
        }
        field(47; Posted; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Posted';
        }
        field(48; "No of Approvals"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count ("Approval Entry" WHERE ("Table ID" = CONST (51513398), "Document No." = FIELD ("No.")));
            Caption = 'No of Approvals';
        }
        field(49; Attachment; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Attachment';
        }
        field(50; Amount; Decimal)
        {
            FieldClass = FlowField;
            Caption = 'Amount';
            CalcFormula = Sum ("Requisition Lines".Amount WHERE ("Requisition No" = FIELD ("No.")));
        }
        field(51; "Vendor No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor No';
        }
        field(52; "Creation Time"; Time)
        {

        }
        field(53; "Purchase Name"; Text[50])
        {

        }
        field(54; "Responsibility Center"; Code[20])
        {
            Caption = 'Department';
            TableRelation = "Responsibility Center".Code;
            trigger OnValidate()
            var

            begin
                if RCenter.Get("Responsibility Center") then
                    "Department Name" := RCenter.Name
                else
                    "Department Name" := '';
            end;
        }
        field(55; "Department Name"; Text[50])
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
        Empl: Record Employee;
        PurchSetup: Record "Purchases & Payables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UsersRec: Record "User Setup";
        WindowsUserRec: Record User;
        PurchLine: Record "Requisition Lines";
        RCenter: Record "Responsibility Center";
        DimMgt: Codeunit DimensionManagement;



    trigger OnInsert()
    begin

        IF "No." = '' THEN BEGIN
            IF "Requisition Type" = "Requisition Type"::"Purchase Requisition" THEN BEGIN
                PurchSetup.GET;
                PurchSetup.TESTFIELD("Purchase Req No");
                NoSeriesMgt.InitSeries(PurchSetup."Purchase Req No", xRec."No.", 0D, "No.", "No. Series");
                //NoSeriesMgt.InitSeries(SalesSetup."File Movement Numbers",xRec."File Movement Code",0D,"File Movement Code","No. Series");
            END;

            IF "Requisition Type" = "Requisition Type"::"Store Requisition" THEN BEGIN
                PurchSetup.GET;
                PurchSetup.TESTFIELD(PurchSetup."Store Requisition Nos.");
                NoSeriesMgt.InitSeries(PurchSetup."Store Requisition Nos.", xRec."No.", 0D, "No.", "No. Series");
                //NoSeriesMgt.InitSeries(SalesSetup."File Movement Numbers",xRec."File Movement Code",0D,"File Movement Code","No. Series");
            END;


        END;

        "Raised by" := USERID;

        IF UsersRec.GET(USERID) THEN BEGIN
            IF Empl.GET(UsersRec."Employee No.") THEN BEGIN
                "Employee Code" := Empl."No.";
                "Employee Name" := Empl."First Name" + ' ' + Empl."Last Name";
                "Global Dimension 1 Code" := Empl."Global Dimension 1 Code";
                "Global Dimension 2 Code" := Empl."Global Dimension 2 Code";
                "Procurement Plan" := PurchSetup."Effective Procurement Plan";
            END;
        END;

        "Requisition Date" := TODAY;
        "Creation Time" := Time;
        "Procurement Plan" := PurchSetup."Effective Procurement Plan";
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        ERROR('You cannot delete data');
    end;

    trigger OnRename()
    begin

    end;

    procedure PurchLinesExist(): Boolean

    begin

        PurchLine.RESET;
        PurchLine.SETRANGE("Requisition No", "No.");
        EXIT(PurchLine.FINDFIRST);
    end;

    procedure CheckLines()

    begin

        PurchLine.RESET;
        PurchLine.SETRANGE("Requisition No", "No.");
        IF PurchLine.FIND('-') THEN BEGIN
            REPEAT
                PurchLine.TESTFIELD(Quantity);
            UNTIL
            PurchLine.NEXT = 0;
        END;
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