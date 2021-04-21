table 51513928 "Restructuring Memo Header"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; code[10])
        {
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()

            begin
                IF "No." <> xRec."No." then begin
                    GuaranteeSetup.Get;
                    NoSeriesMgt.TestManual(GuaranteeSetup."Restructuring Memo Nos.");
                    "No. Series" := ''
                end;
            end;
        }
        field(2; "Contract No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Guarantee Contracts";

            trigger OnValidate()
            begin
                if ContractRec.Get("Contract No.") then begin
                    Name := ContractRec.Name;
                    "Search Name" := ContractRec."Search Name";
                    "Name 2" := ContractRec."Name 2";
                    "Global Dimension 1 Code" := ContractRec."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := ContractRec."Global Dimension 2 Code";
                    "Loan Amount" := ContractRec."Loan Amount";
                    "Product Type" := ContractRec."Product Type";
                    Product := ContractRec.Product;
                    "Customer No." := ContractRec."Customer No.";
                end else begin
                    Name := '';
                    "Search Name" := '';
                    "Name 2" := '';
                    "Global Dimension 1 Code" := '';
                    "Global Dimension 2 Code" := '';
                    "Loan Amount" := 0;
                    //"Product Type" := "Product Type"::" "
                    Product := '';
                    "Customer No." := '';
                end;
            end;
        }
        field(3; Name; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';
            Editable = false;
            trigger OnValidate()

            begin
                IF ("Search Name" = UpperCase(xRec.Name)) OR ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(4; "Search Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Search Name';
            Editable = false;
        }
        field(5; "Name 2"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Name 2';
            Editable = false;
        }
        field(6; "Document Date"; date)
        {
            Editable = false;
        }
        field(7; "Customer No."; code[20])
        {
            TableRelation = Customer;
        }
        field(16; "Global Dimension 1 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (1));
            Editable = false;
            trigger Onvalidate()

            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(17; "Global Dimension 2 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (2));
            Editable = false;
            trigger Onvalidate()

            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(107; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(8000; Id; Guid)
        {
            DataClassification = CustomerContent;
            Caption = 'Id';
        }
        field(50001; Status; Option)
        {
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
        }
        field(50002; "Loan Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Loan Amount';
            AutoFormatType = 1;
            NotBlank = true;
            Editable = false;
        }
        field(50003; "Created By"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50004; "Background"; Text[250])
        {

        }
        field(50005; "Reason of Restructure"; Text[250])
        {

        }
        field(50006; "Way Forward"; Text[250])
        {

        }
        field(50007; "Recommendations"; Text[250])
        {

        }
        field(50008; Product; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Product';
            NotBlank = true;
            TableRelation = Products;
            Editable = false;
        }
        field(50009; "Product Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Traditional,"Lenders Option";
            Editable = false;
        }
        field(50010; Subject; text[250])
        {

        }
        field(50011; "Restructturing Amount"; Decimal)
        {

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
        GuaranteeSetup: Record "Guarantee Management Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        ContractRec: Record "Guarantee Contracts";

    trigger OnInsert()
    begin
        IF "No." = '' THEN begin
            GuaranteeSetup.Get;
            GuaranteeSetup.TestField("Restructuring Memo Nos.");
            NoSeriesMgt.InitSeries(GuaranteeSetup."Restructuring Memo Nos.", xRec."No. Series", 0D, "No.", "No. Series");

        END;
        "Created By" := UserId;
        "Document Date" := Today;
        DimMgt.UpdateDefaultDim(
        DATABASE::"Restructuring Memo Header", "No.",
        "Global Dimension 1 Code", "Global Dimension 2 Code");
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

    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])

    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Guarantee Contracts", "No.", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;

}