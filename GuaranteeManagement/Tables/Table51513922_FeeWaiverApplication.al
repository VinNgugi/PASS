table 51513922 "Fee Waiver Application"
{
    DataClassification = ToBeClassified;
    Caption = 'Fee Waiver Application';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()

            begin
                IF "No." <> xRec."No." then begin
                    GuaranteeSetup.Get;
                    NoSeriesMgt.TestManual(GuaranteeSetup."Waiver Application Nos.");
                    "No. Series" := '';
                end;
            end;

        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Application Date';
        }
        field(5; Reason; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason';
        }
        field(10; Status; Option)
        {
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
        }
        field(11; "Fee Type"; Option)
        {

            DataClassification = CustomerContent;
            caption = 'Fee Type';
            OptionMembers = " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee";
            OptionCaption = ' ,Consultancy,Risk-Sharing Fee,Other,Guarantee Fees,Lenders Option,Booked Fee,Application Fee';
        }
        field(12; "Client No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Client No.';
            TableRelation = IF ("Fee Type" = CONST("Application Fee")) "Guarantee Application"
            ELSE
            IF ("Fee Type" = CONST(Consultancy)) "Guarantee Application"
            ELSE
            IF ("Fee Type" = CONST("Lenders Option")) "Guarantee Contracts"
            ELSE
            IF ("Waive all fees" = const(true)) "Guarantee Application"
            ELSE
            IF ("Fee Type" = CONST("Linkage Banking")) "Guarantee Contracts";


            trigger onValidate()

            begin
                case "Fee Type" of
                    "Fee Type"::"Application Fee":
                        begin
                            if GuaranteeApp.GET("Client No.") then
                                "Client Name" := GuaranteeApp.Name;
                        end;
                    "Fee Type"::Consultancy:
                        begin
                            if GuaranteeApp.GET("Client No.") then
                                "Client Name" := GuaranteeApp.Name;
                        end;
                    "Fee Type"::"Lenders Option":
                        begin
                            if GuaranteeContract.GET("Client No.") then
                                "Client Name" := GuaranteeContract.Name;
                        end;
                    "Fee Type"::"Linkage Banking":
                        begin
                            if GuaranteeContract.GET("Client No.") then
                                "Client Name" := GuaranteeContract.Name;
                        end;
                end;
                if GuaranteeApp.GET("Client No.") then begin
                    "Project Description" := GuaranteeApp."Project Description";
                    "Requested Loan Amount" := GuaranteeApp."Loan Amount";
                    "Currency Code" := GuaranteeApp."Currency Code";
                    Product := GuaranteeApp.Product;
                    "Global Dimension 1 Code" := GuaranteeApp."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := GuaranteeApp."Global Dimension 2 Code";
                end;
                if ("Fee Type" = "Fee Type"::"Lenders Option") or ("Fee Type" = "Fee Type"::"Linkage Banking") then begin
                    if GuaranteeContract.Get("Client No.") then begin
                        "Project Description" := GuaranteeContract."Project Description";
                        "Requested Loan Amount" := GuaranteeContract."Approved Loan Amount";
                        "Currency Code" := GuaranteeContract."Currency Code";
                        Product := GuaranteeContract.Product;
                        "Global Dimension 1 Code" := GuaranteeContract."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := GuaranteeContract."Global Dimension 2 Code";
                    end;
                end;
            end;
        }
        field(13; "Client Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Client Name';
            Editable = false;

        }
        field(14; "Project Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Description';
            Editable = false;
        }
        field(15; "Requested Loan Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Requested Loan Amount';
            Editable = false;
        }

        field(16; "Global Dimension 1 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

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
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger Onvalidate()

            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(18; "Date Created"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Date Created';
            Editable = false;
        }
        field(19; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Created By';
            TableRelation = "User Setup";
            Editable = false;
        }
        field(20; "Last Date Modified"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Last Date Modified';
            Editable = false;
        }
        field(21; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Modified By';
            TableRelation = "User Setup";
            Editable = false;
        }
        field(22; "Last Modified Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(23; "Currency Code"; Code[20])
        {
            Caption = 'Currency Code';
            Editable = false;
            TableRelation = Currency;
        }
        field(24; "Product"; Code[50])
        {
            Caption = 'Product';
            Editable = false;
            TableRelation = Products;
        }
        field(25; "Waive all fees"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Waive all fees';

            trigger onvalidate()

            begin
                WaiveAllFess := "Waive all fees";
            end;
        }
        field(26; "Total Amount Waived"; Decimal)
        {

            DataClassification = ToBeClassified;

        }
        field(27; "Application fee Waived"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(28; "Consultancy fee Waived"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(29; "Linkage Banking fee Waived"; Decimal)
        {
            DataClassification = ToBeClassified;

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
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Fee Type", "Client No.")
        {
            Unique = true;
        }

    }

    var

        WaiveAllFess: Boolean;
        GuaranteeSetup: Record "Guarantee Management Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        DimMgt: Codeunit DimensionManagement;
        GuaranteeApp: Record "Guarantee Application";
        GuaranteeContract: Record "Guarantee Contracts";

    trigger OnInsert()
    begin
        IF "No." = '' THEN begin
            GuaranteeSetup.Get;
            GuaranteeSetup.TestField("Waiver Application Nos.");
            NoSeriesMgt.InitSeries(GuaranteeSetup."Waiver Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "Last Date Modified" := Today;
        "Last Modified Date Time" := CurrentDateTime;
        "Modified By" := UserId;
        "Created By" := UserId;
        "Date Created" := Today;
        DimMgt.UpdateDefaultDim(
        DATABASE::"Guarantee Application", "No.",
        "Global Dimension 1 Code", "Global Dimension 2 Code");
    end;

    trigger OnModify()
    begin
        GuaranteeSetup.Get;
        "Last Date Modified" := Today;
        "Last Modified Date Time" := CurrentDateTime;
        "Modified By" := UserId;
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
        DimMgt.SaveDefaultDim(DATABASE::"Fee Waiver Application", "No.", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;

}