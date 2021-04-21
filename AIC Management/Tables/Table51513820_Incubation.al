table 51513820 Incubation
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AICSetup.Get();
                    NoSeriesMgt.TestManual(AICSetup."Incubation Nos");
                    "No. Series" := '';

                end;
            end;

        }
        field(2; Name; Code[50])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()

            begin
                if ("Search Name" = UpperCase(xRec.Name)) or
                ("Search Name" = '') then
                    "Search Name" := Name;
            end;

        }
        field(3; "Search Name"; Code[50])
        {
            Caption = 'Search Name';
        }
        field(4; "Incubation Duration"; DateFormula)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Incubation End Date" := CalcDate("Incubation Duration", "Incubation Start Date");
            end;

        }
        field(5; "Incubation Start Date"; Date)
        {
            trigger OnValidate()
            begin
                "Incubation End Date" := CalcDate("Incubation Duration", "Incubation Start Date");
            end;
        }
        field(6; "Incubation End Date"; Date)
        {
            Editable = false;
        }
        field(7; "No. of Participants"; Integer)
        {
            Caption = 'No. of Participants';
        }
        field(8; Closed; Boolean)
        {
            Caption = 'Closed';
        }
        field(9; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(10; "Document Date"; Date)
        {
            Editable = false;
        }
        field(11; "Requested by"; Code[50])
        {
            Editable = false;
            TableRelation = "User Setup";


        }
        field(12; Status; Option)
        {
            Editable = false;
            DataClassification = CustomerContent;
            Caption = 'Approval Status';
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected;
        }
        field(13; "Requester Name"; text[70])
        {
            editable = false;
        }

        field(14; "Applications Start Date"; date)
        {

        }
        field(15; "Applications End Date"; Date)
        {

        }
        field(17; "Global Dimension 1 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
            CaptionClass = '1,1,1';

            trigger OnValidate()

            begin
                ValidateShotcutDemCode(1, "Global Dimension 1 Code");
            end;
        }
        field(18; "Global Dimension 2 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
            CaptionClass = '1,1,2';

            trigger OnValidate()

            begin
                ValidateShotcutDemCode(2, "Global Dimension 2 Code");
            end;
        }
        field(130; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";

        }
        field(50000; "Global Dimension 4 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (4));
            CaptionClass = '1,2,4';

            trigger OnValidate()

            begin
                ValidateShotcutDemCode(4, "Global Dimension 4 Code");
            end;
        }

        field(50001; "Incubation Status"; Option)
        {

            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = " ",Application,"Residential Selection","Ongoing",Closed;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key1; "Search Name")
        {

        }
    }

    var
        DimMgt: Codeunit DimensionManagement;
        UserSetup: Record "User Setup";
        EmployeeRec: Record Employee;
        AICSetup: Record "AIC Setup";
        IncubationRec: Record Incubation;
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        IF "No." = '' then begin
            AICSetup.get;
            AICSetup.TestField("Incubation Nos");
            AICSetup.TestField("Global Dimension 1 Code");
            "Global Dimension 1 Code" := AICSetup."Global Dimension 1 Code";
            NoSeriesMgt.InitSeries(AICSetup."Incubation Nos", xRec."No. Series"
            , 0D, "No.", "No. Series");
            "Document Date" := Today;
            "Requested by" := UserID;

            "Requested By" := USERID;
            IF UserSetup.GET(USERID) THEN BEGIN
                IF EmployeeRec.GET(UserSetup."Employee No.") THEN BEGIN
                    "Requester Name" := EmployeeRec.FullName;
                END;
            end;
        end;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
    end;

    procedure AssistEdit(): Boolean;

    begin

        with IncubationRec do begin
            IncubationRec := Rec;
            AICSetup.get;
            AICSetup.TestField("Incubation Nos");

            if NoSeriesMgt.SelectSeries(AICSetup."Incubation Nos", xRec."No. Series", "No. Series") then begin
                NoSeriesMgt.SetSeries("No.");
                Rec := IncubationRec;
                exit(true);
            end;
        end;
    end;

    procedure ValidateShotcutDemCode(FieldNumber: Integer; var ShortcutDimCode: Code[50])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        //DimMgt.SaveDefaultDim(DATABASE::"Recruitment Needs","No.",FieldNumber,ShortcutDimCode);
        MODIFY;
    end;
}