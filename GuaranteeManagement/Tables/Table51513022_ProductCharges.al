table 51513022 "Product Charges"
{
    DataClassification = CustomerContent;
    Caption = 'Product Charges';
    fields
    {
        field(1; Code; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            NotBlank = true;
            TableRelation = Charges.Code;

            trigger OnValidate()
            var
                ChargeCode: Record Charges;

            begin
                IF ChargeCode.Get(Code) then begin

                    Description := ChargeCode.Description;
                    Amount := ChargeCode.Amount;
                    Percentage := ChargeCode.Percentage;
                    "G/L Account" := ChargeCode."G/L Account";
                    "Use Perc" := ChargeCode."Use Perc";
                    "Minimum Amount" := ChargeCode."Minimum Amount";
                    "Maximum Amount" := ChargeCode."Maximum Amount";
                    "Minimum Charge" := ChargeCode."Minimum Charge";
                    "Maximum Charge" := ChargeCode."Maximum Charge";
                    "Currency Code" := ChargeCode."Currency Code";
                    "Charge Type" := ChargeCode."Charge Type";
                    "Product Type" := ChargeCode."Product Type";
                end;

            end;

        }
        field(2; "Product Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Product Code';
            NotBlank = true;
            TableRelation = Products;
        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            NotBlank = true;
            Editable = false;
        }
        field(4; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            AutoFormatType = 2;
            MinValue = 0;
            Editable = false;

        }
        field(5; "Use Perc"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Use Perc';
            Editable = false;
        }
        field(6; "Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage';
            AutoFormatType = 2;
            MinValue = 0;
            Editable = false;
        }
        field(7; "Minimum Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Amount';
            AutoFormatType = 2;
            MinValue = 0;
            Editable = false;
        }
        field(8; "Maximum Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Amount';
            AutoFormatType = 2;
            MinValue = 0;
            Editable = false;
        }
        field(9; "Minimum Charge"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Charge';
            AutoFormatType = 2;
            MinValue = 0;
            Editable = false;
        }
        field(10; "Maximum Charge"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Amount';
            AutoFormatType = 2;
            MinValue = 0;
            Editable = false;
        }
        field(11; "G/L Account"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'G/L Account';
            TableRelation = "G/L Account"."No.";
            Editable = false;

        }
        field(12; Stage; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Stage';
            TableRelation = "Guarantee Application Stages";
        }
        field(13; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency;
            Editable = false;
        }
        field(14; "Charge Type"; Option)
        {
            OptionMembers = " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee","Restructuring Fee";
            OptionCaption = ' ,Consultancy,Risk-Sharing Fee,Other,Guarantee Fees,Lenders Option,Booked Fee,Application Fee,Restructuring Fee';
            DataClassification = CustomerContent;
            Caption = 'Charge Type';
            Editable = false;
        }
        field(15; "Charge on Guarantee Amt"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Charge on Guarantee Amt';
        }

        field(500015; "Product Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Traditional,"Lenders Option",Both;

        }

    }

    keys
    {
        key(PK; Code, "Product Code")
        {

        }
    }

}