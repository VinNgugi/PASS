table 51513037 "Memo Request Lines"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Memo Lines";
    LookupPageId = "Memo Lines";

    fields
    {
        field(1; "Header No."; Code[20])
        {
            DataClassification = ToBeClassified;


        }
        field(2; "Employee No"; Code[20])
        {
            TableRelation = Employee."No." where(Status = filter(Active));
            trigger OnValidate()
            var
                myInt: Integer;
            begin

                CUTripMgmt.CheckForOverLappingDays("Employee No", "Travel Start Date", "Travel End Date", "Header No.");

                if ObjEmployee.Get("Employee No") then begin
                    "Employee Name" := ObjEmployee."First Name" + ' ' + ObjEmployee."Middle Name" + ' ' + ObjEmployee."Last Name";
                    "Global Dimension 1 Code" := ObjEmployee."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := ObjEmployee."Global Dimension 2 Code";
                end
                else begin
                    "Employee Name" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                end;

            end;
        }
        field(3; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(4; "Travel Start Date"; Date)
        {

        }
        field(5; "Travel End Date"; Date)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Number of Days" := (("Travel End Date" - "Travel Start Date") + 0.5);
            end;
        }
        field(6; "Number of Days"; Decimal)
        {
            Editable = false;
        }
        field(7; "Global Dimension 1 Code"; Code[20])
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
        field(8; "Global Dimension 2 Code"; Code[20])
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
        field(9; Released; Boolean)
        {
            Editable = false;
        }
        field(10; "Attached to Imprest"; Boolean)
        {
            Editable = false;
        }
        field(11; "Trip Description"; Text[50])
        {
            Editable = false;
        }
        field(12; "Trip Type"; Option)
        {
            OptionMembers = local,Foreign;
        }
        field(13; "DSA Option"; Option)
        {
            OptionMembers = " ","Full DSA","60% DSA","50% DSA";
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
        key(PK; "Header No.", "Employee No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(Dropdown; "Header No.", "Employee No", "Trip Description")
        {

        }
        fieldgroup(Brick; "Header No.", "Employee No", "Trip Description")
        {

        }
    }

    var
        ObjEmployee: Record Employee;
        ObjMemo: Record "Memo Request Header";
        CUTripMgmt: Codeunit "Trip Request Management";
        DimMgt: Codeunit DimensionManagement;

    trigger OnInsert()
    begin
        if ObjMemo.Get("Header No.") then begin
            "Trip Description" := ObjMemo."Trip Name";
            "Travel Start Date" := ObjMemo."Start Date";
            "Travel End Date" := ObjMemo."End Date";
            Validate("Travel End Date");
            "Trip Type" := ObjMemo."Trip Type";
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