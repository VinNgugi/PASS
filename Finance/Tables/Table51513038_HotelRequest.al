table 51513038 "Hotel Request Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Request No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate()
            var

            begin
                if "Request No" <> xRec."Request No" then begin
                    MemoSetup.Get();
                    NoSeriesMgt.TestManual(MemoSetup."Memo Request Nos");
                end;
            end;

        }
        field(2; "Created Date"; Date)
        {
            Editable = false;
        }
        field(3; "Created Time"; Time)
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
        field(6; "Staff No."; Code[20])
        {
            TableRelation = Employee."No." where(Status = filter(Active));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if ObjEmployee.Get("Staff No.") then
                    "Staff Name" := ObjEmployee."First Name" + ' ' + ObjEmployee."Middle Name" + ' ' + ObjEmployee."Last Name"
                else
                    "Staff Name" := '';
            end;
        }
        field(7; "Staff Name"; Text[50])
        {
            Editable = false;
        }
        field(8; "Department"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(9; "Global Dimension 1 Code"; Code[20])
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
        field(10; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(11; "Destination"; Text[30])
        {

        }
        field(12; "Approval Status"; Option)
        {
            OptionMembers = New,"Pending Approval",Approved,Rejected;
            Editable = false;
        }
        field(13; "Travel Date"; Date)
        {

        }
        field(14; "Number of Nights"; Decimal)
        {

        }
        field(15; "Memo Reference"; Code[20])
        {
            TableRelation = "Memo Request Lines"."Header No." where("Employee No" = field("Staff No."), Released = const(true), "Attached to Imprest" = filter(false));
            trigger OnValidate()
            var

            begin
                if ObjMemo.Get("Memo Reference") then begin
                    ObjMemoLines.Reset();
                    ObjMemoLines.SetRange("Header No.", ObjMemo."Request No.");
                    ObjMemoLines.SetRange("Employee No", "Staff No.");
                    if ObjMemoLines.Find('-') then begin
                        "Travel Date" := ObjMemoLines."Travel Start Date";
                        "Check In Date" := ObjMemoLines."Travel Start Date";
                        "Check Out Date" := ObjMemoLines."Travel End Date";
                        "Number of Nights" := ObjMemoLines."Number of Days";
                    end;
                    Department := ObjMemo."Responsibility Center";
                    //Destination:=ObjTrvMemo.
                end;
            end;
        }
        field(16; "Check In Date"; Date)
        {

        }
        field(17; "Check Out Date"; Date)
        {

        }
        field(18; "Room Type"; Option)
        {
            OptionMembers = Single,Double,Executive,Suite;
        }
        field(19; "Prefered Hotel(1)"; Code[20])
        {
            TableRelation = "Hotels List"."No." where(Blocked = filter(false));

            trigger OnValidate()
            var
                Hotellist: Record "Hotels List";
            begin
                if Hotellist.Get("Prefered Hotel(1)") then
                    "Prefered Hotel Name(1)" := Hotellist."Hotel Name"
                else
                    "Prefered Hotel Name(1)" := '';

            end;
        }
        field(20; "Prefered Hotel Name(1)"; Text[30])
        {
            Editable = false;
        }
        field(21; "Prefered Hotel(2)"; Code[20])
        {
            TableRelation = "Hotels List"."No." where(Blocked = filter(false));

            trigger OnValidate()
            var
                Hotellist: Record "Hotels List";
            begin
                if Hotellist.Get("Prefered Hotel(2)") then
                    "Prefered Hotel Name(2)" := Hotellist."Hotel Name"
                else
                    "Prefered Hotel Name(2)" := '';

            end;
        }
        field(22; "Prefered Hotel Name(2)"; Text[30])
        {
            Editable = false;
        }
        field(23; "Approved Hotel"; Code[20])
        {
            TableRelation = "Hotels List"."No." where(Blocked = filter(false));
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
        key(PK; "Request No")
        {
            Clustered = true;
        }
    }

    var
        ObjEmployee: Record Employee;
        ObjMemo: Record "Memo Request Header";
        ObjMemoLines: Record "Memo Request Lines";
        MemoSetup: Record "Memo Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin
        if "Request No" = '' then begin
            MemoSetup.GET;
            MemoSetup.TESTFIELD(MemoSetup."Memo Request Nos");
            NoSeriesMgt.InitSeries(MemoSetup."Memo Request Nos", xRec."No. Series", 0D, "Request No", "No. Series");
        end;

        "Created Date" := Today;
        "Created Time" := Time;
        "Created By" := UserId;

        if UserSetup.Get(UserId) then begin
            if ObjEmployee.Get(UserSetup."Employee No.") then begin
                //Department:=ObjEmployee.
                "Global Dimension 1 Code" := ObjEmployee."Global Dimension 1 Code";
                "Global Dimension 2 Code" := ObjEmployee."Global Dimension 2 Code";
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