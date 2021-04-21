table 51513036 "Memo Request Header"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Memo List";
    LookupPageId = "Memo List";

    fields
    {
        field(1; "Request No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var

            begin
                if "Request No." <> xRec."Request No." then begin
                    MemoSetup.Get();
                    NoSeriesMgt.TestManual(MemoSetup."Memo Request Nos");
                end;
            end;

        }
        field(2; "Creation Date"; Date)
        {
            Editable = false;
        }
        field(3; "Creation Time"; Time)
        {
            Editable = false;
        }
        field(4; "Created By"; Code[20])
        {
            TableRelation = User;
            Editable = false;
        }
        field(5; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(6; "Trip Name"; Text[30])
        {

        }
        field(7; "Trip Description"; Text[500])
        {
            Description = 'Give an outline of what you are going to do on this visit, in less 500 words.';

        }
        field(8; "Start Date"; Date)
        {

        }
        field(9; "End Date"; Date)
        {

        }
        field(10; "Responsibility Center"; Code[20])
        {
            Caption = 'Department';
            TableRelation = "Responsibility Center".Code;

            trigger OnValidate()
            var
                ObjResCenter: Record "Responsibility Center";
            begin
                if ObjResCenter.Get("Responsibility Center") then
                    "Department Name" := ObjResCenter.Name
                else
                    "Department Name" := '';
            end;
        }
        field(11; "Department Name"; Text[30])
        {
            Editable = false;
        }
        field(12; "Approval Status"; Option)
        {
            OptionMembers = New,"Pending Approval",Approved,Rejected;
            Editable = false;
        }
        field(13; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));

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
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        /*field(15; "DSA Option"; Option)
        {
            OptionMembers = " ","Full DSA","60% DSA","50% DSA";
        }*/
        field(16; "Trip Type"; Option)
        {
            OptionMembers = local,Foreign;
        }
        field(17; "Travel Destination"; Code[20])
        {
            TableRelation = "Foreign Destination"."Destination Code";

            trigger OnValidate()
            var

            begin
                ForeignDest.Reset();
                ForeignDest.SetRange("Destination Code", "Travel Destination");
                if ForeignDest.Find('-') then begin
                    "Rate Per Day" := ForeignDest.Amount;
                end;
            end;
        }
        field(18; "Rate Per Day"; Decimal)
        {
            Editable = false;
        }
        field(19; "Currency Code"; Code[20])
        {
            TableRelation = Currency.Code;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Currency Code" <> '' then begin

                    if ("Currency Code" <> xRec."Currency Code") or
                       ("Creation Date" <> xRec."Creation Date") or
                       (CurrFieldNo = FIELDNO("Currency Code")) or
                       ("Currency Factor" = 0)
                    then
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate("Creation Date", "Currency Code");
                end else
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");
            end;
        }
        field(20; "Currency Factor"; Decimal)
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
        key(PK; "Request No.")
        {
            Clustered = true;
        }
    }

    var
        UserSetup: Record "User Setup";
        ObjEmployee: Record Employee;
        MemoSetup: Record "Memo Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ForeignDest: Record "Foreign Destination";
        CurrExchRate: Record "Currency Exchange Rate";
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin
        if "Request No." = '' then begin
            MemoSetup.GET;
            MemoSetup.TESTFIELD(MemoSetup."Memo Request Nos");
            NoSeriesMgt.InitSeries(MemoSetup."Memo Request Nos", xRec."No. Series", 0D, "Request No.", "No. Series");
        end;

        "Creation Date" := Today;
        "Creation Time" := Time;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            if ObjEmployee.Get(UserSetup."Employee No.") then begin
                //Department:=ObjEmployee.
                "Global Dimension 1 Code" := ObjEmployee."Global Dimension 1 Code";
                "Global Dimension 2 Code" := ObjEmployee."Global Dimension 2 Code";
            end;
        end;


        OnAfterInsertRequestNo(Rec);

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

    [IntegrationEvent(false, false)]
    procedure OnAfterInsertRequestNo(var TravelH: Record "Memo Request Header")
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

    [IntegrationEvent(false, false)]
    procedure OnAttachDocuments(var MemoRequest: Record "Memo Request Header")
    var
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnViewAttachedDocuments(var MemoRequest: Record "Memo Request Header")
    var
    begin

    end;
}