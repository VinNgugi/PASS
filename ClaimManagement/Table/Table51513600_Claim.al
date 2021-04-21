table 51513600 Claim
{
    DataClassification = CustomerContent;
    Caption = 'Claim';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            Editable = false;

        }
        field(2; "Claim Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Claim Type';
            OptionMembers = " ";
        }
        field(3; "Claim Desscrition"; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Claim Descrition';


        }
        field(4; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer where("Customer Posting Group" = filter('BANKS'));

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                Customer.get("Customer No.");
                "Customer Name" := Customer.Name;
                "Customer Phone" := Customer."Phone No."
            end;
        }
        field(5; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            DataClassification = CustomerContent;
        }
        field(6; "Customer Phone"; Text[30])
        {
            Caption = 'Customer Phone';
            DataClassification = CustomerContent;
            ExtendedDatatype = PhoneNo;
        }
        field(7; "Claim Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Claim Date';
        }
        field(8; "SalesPerson Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'BDO';
            TableRelation = "Salesperson/Purchaser";
        }
        field(9; Status; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Status';
            OptionMembers = Open,Pending,Close;
            Editable = false;
        }
        field(15; "No. Series"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(20; "Total Amount"; Decimal)
        {
            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            caption = 'Total Amount';
            CalcFormula = sum("Guarantee Claim Line"."Claim Amount" where("Claim No." = field("No.")));
            Editable = false;
        }
        field(21; "Reference No."; Code[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Reference No.';
        }
        field(22; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date';
        }
        field(32; "Total No. of Clients"; Integer)
        {
            Caption = 'Total No. of Clients';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Guarantee Claim Line" where("Claim No." = field("No.")));
        }
        field(33; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = CustomerContent;
        }
        field(34; "Created By"; Code[20])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
        }
        field(35; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            TableRelation = "User Setup";
        }
        field(36; "Last Modified Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(37; "Last Date Modified"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(38; "Claiming Bank Amount"; decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Claiming Bank Amount';

            trigger OnValidate()

            begin
                IF "Currency Code" = '' THEN
                    "Claiming Bank Amount(LCY)" := "Claiming Bank Amount"
                ELSE
                    "Claiming Bank Amount(LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Document Date", "Currency Code",
                          "Claiming Bank Amount", "Currency Factor"));

            end;
        }
        field(39; "Approval Status"; Option)
        {
            OptionMembers = Open,Released,"Pending Approval","Rejected";
            DataClassification = CustomerContent;
            Caption = 'Approval Status';
            Editable = false;
        }
        field(40; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()

            begin
                IF "Currency Code" <> '' THEN BEGIN
                    //GetCurrency;
                    IF ("Currency Code" <> xRec."Currency Code") OR
                       ("Document Date" <> xRec."Document Date") OR
                       (CurrFieldNo = FIELDNO("Currency Code")) OR
                       ("Currency Factor" = 0)
                    THEN
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate("Document Date", "Currency Code");
                END ELSE
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");
            end;
        }
        field(41; "Currency Factor"; Decimal)
        {
            Editable = false;
            MinValue = 0;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF ("Currency Code" = '') AND ("Currency Factor" <> 0) THEN
                    FIELDERROR("Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION("Currency Code")));
                VALIDATE("Claiming Bank Amount");
            end;
        }
        field(42; "Claiming Bank Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Claiming Bank Amount(LCY)';
            Editable = false;
        }
        field(43; "Approved Clients"; Integer)
        {
            Caption = 'Approved Clients';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count("Guarantee Claim Line" where("Claim No." = field("No."), "Approval Status" = filter(Approved)));
        }

        field(44; "Total Approved Claim Amount"; Decimal)
        {
            Caption = 'Total Approved Claim Amount';
            FieldClass = FlowField;
            CalcFormula = sum("Guarantee Claim Line"."Claim Amount" where("Claim No." = field("No."), "Approval Status" = filter(Approved)));
            Editable = false;
        }

        field(45; "PV No."; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'PV No.';
            Editable = false;
        }

        field(46; "PV Amount"; Decimal)

        {
            DataClassification = CustomerContent;
            Caption = 'PV Amount';
            Editable = false;
        }
        field(47; Description; Text[100])
        {
            DataClassification = ToBeClassified;
            //FieldPropertyName = FieldPropertyValue;
        }
        field(48; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
            Editable = false;
        }
        field(49; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2), Blocked = const(false));
            Editable = false;
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
        myInt: Integer;
        CurrExchRate: Record "Currency Exchange Rate";
        Text002: TextConst ENU = 'cannot be specified without %1';
        GuaranteeSetup: Record "Guarantee Management Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";

    trigger OnInsert()
    begin
        IF "No." = '' THEN begin
            GuaranteeSetup.Get;
            GuaranteeSetup.TestField("Claim Nos.");
            NoSeriesMgt.InitSeries(GuaranteeSetup."Claim Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "Last Date Modified" := Today;
        "Last Modified Date Time" := CurrentDateTime;
        "Modified By" := UserId;
        "Created By" := UserId;
        "Date Created" := Today;

        if UserSetup.Get(UserId) then
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code"
        else
            Error('Please Assign user %1 a Bramch under user setup.');
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



    procedure SetClaimDescription(NewClaimDescription: text)
    var
        TempBlob: Record TempBlob temporary;
    begin
        Clear("Claim Desscrition");
        if NewClaimDescription = '' then
            exit;
        TempBlob.Blob := "Claim Desscrition";
        TempBlob.WriteAsText(NewClaimDescription, TextEncoding::Windows);
        "Claim Desscrition" := TempBlob.Blob;
        Modify();
    end;

    procedure GetClaimDescription(): Text
    var
        CR: Text[2];
        TempBlob: Record TempBlob temporary;
    begin
        CalcFields("Claim Desscrition");
        if not "Claim Desscrition".HasValue then
            exit('');
        CR[1] := 10;
        TempBlob.Blob := "Claim Desscrition";
        exit(TempBlob.ReadAsText(CR, TextEncoding::Windows));
    end;

    [IntegrationEvent(false, false)]
    procedure OnAttachDocuments(var ClaimApp: Record Claim)
    var
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnViewAttachedDocuments(var ClaimApp: Record Claim)
    var
    begin

    end;
}