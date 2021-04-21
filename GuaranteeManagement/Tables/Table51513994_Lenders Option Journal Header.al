table 51513994 "Lenders Option Journal Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Reference No."; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Financial Institution Code"; Code[20])
        {
            TableRelation = Customer where ("Customer Posting Group" = filter ('BANKS'));
        }
        field(3; "Bank Branch Name"; Text[20])
        {

        }
        field(4; Description; Text[50])
        {

        }
        field(5; "Reference Date"; Date)
        {

        }
        field(6; "Signatory 1 (CGC)"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser" where ("CGC Signatory" = const (true));
        }
        field(7; "Signatory 2 (CGC)"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser" where ("CGC Signatory" = const (true));
        }
        field(8; "Guarantee Source"; Code[20])
        {
            TableRelation = "Credit Guarantee Partner" where (Blocked = const (false));
        }
        field(9; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            DataClassification = CustomerContent;
            Caption = 'Status';
        }
        field(10; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()

            begin
                IF "No." <> xRec."No." then begin
                    GuaranteeSetup.Get;
                    NoSeriesMgt.TestManual(GuaranteeSetup."LO Batch Nos.");
                    "No. Series" := ''
                end;
            end;

        }
        field(11; "Last Date Modified"; Date)
        {
            editable = false;
        }
        field(12; "Last Modified Date Time"; datetime)
        {
            editable = false;
        }
        field(14; "Date Created"; date)
        {
            editable = false;
        }
        field(15; "Modified By"; code[50])
        {
            editable = false;
            TableRelation = "User Setup";
        }
        field(16; "Created By"; code[50])
        {
            editable = false;
            TableRelation = "User Setup";
        }
        field(17; "Global Dimension 1 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (1));

            trigger Onvalidate()

            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(18; "CGC Prepared"; Boolean)
        {

        }
        field(19; "No. of Clients"; Integer)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Count ("Lenders Option Journal Line" WHERE (Code = FIELD ("No.")));
        }
        field(20; "Total Principal Loan"; decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            Caption = 'Total Principal Loan';
            CalcFormula = Sum ("Lenders Option Journal Line"."Loan Amount" WHERE (Code = FIELD ("No.")));
        }

        field(21; "CGC Issued"; Boolean)
        {

        }

        field(107; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(50006; Product; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Product';
            NotBlank = true;
            TableRelation = Products.Code where (Type = field ("Product Type"));
        }
        field(500015; "Product Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Traditional,"Lenders Option";

        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(PK2; "Reference No.")
        {
            Unique = true;
        }
    }

    var
        GuaranteeSetup: Record "Guarantee Management Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        GuaranteeApp: Record "Guarantee Application";
        ContractRec: Record "Guarantee Contracts";

    trigger OnInsert()
    begin
        IF "No." = '' THEN begin
            GuaranteeSetup.Get;
            NoSeriesMgt.InitSeries(GuaranteeSetup."LO Batch Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "Last Date Modified" := Today;
        "Last Modified Date Time" := CurrentDateTime;
        "Modified By" := UserId;
        "Created By" := UserId;
        "Date Created" := Today;

    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
        "Last Modified Date Time" := CurrentDateTime;
        "Modified By" := UserId;

        ContractRec.Reset();
        ContractRec.SetRange("Reference No.", "Reference No.");
        if ContractRec.FindFirst() then begin
            repeat
                ContractRec."Signatory 1 (CGC)" := "Signatory 1 (CGC)";
                ContractRec."Signatory 2 (CGC)" := "Signatory 2 (CGC)";
                ContractRec.Modify();
            until ContractRec.Next() = 0;
        end;

        GuaranteeApp.Reset();
        GuaranteeApp.SetRange("Reference No.", "Reference No.");
        if GuaranteeApp.FindFirst() then begin
            repeat
                GuaranteeApp."Signatory 1 (CGC)" := "Signatory 1 (CGC)";
                GuaranteeApp."Signatory 2 (CGC)" := "Signatory 2 (CGC)";
                GuaranteeApp.Modify();
            until GuaranteeApp.Next() = 0;
        end;
    end;

    trigger OnDelete()
    begin
        Error('Delete data not allowed');
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        "Last Modified Date Time" := CurrentDateTime;
        "Modified By" := UserId;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])

    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Lenders Option Journal Header", "No.", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;

}