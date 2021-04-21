table 51513023 Charges
{
    DataClassification = CustomerContent;
    Caption = 'Charges';
    DrillDownPageId = "Charges";
    LookupPageId = "Charges";

    fields
    {
        field(1; Code; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            NotBlank = true;

        }
        field(3; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            NotBlank = true;
        }

        field(4; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Amount';
            AutoFormatType = 2;
            MinValue = 0;


        }
        field(5; "Use Perc"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Use Perc';

        }
        field(6; "Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Percentage';
            AutoFormatType = 2;
            MinValue = 0;

            trigger OnValidate()

            begin
                IF Percentage > 100 then
                    Error('You cannot exceed 100%');
            end;

        }
        field(7; "Minimum Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Amount';
            AutoFormatType = 2;
            MinValue = 0;

            trigger OnValidate()

            begin
                IF "Maximum Amount" <> 0 THEN begin
                    IF "Maximum Amount" < "Minimum Amount" then
                        Error('Maximum Amount cannot be less than minimum amount');
                end;
            end;

        }
        field(8; "Maximum Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Amount';
            AutoFormatType = 2;
            MinValue = 0;

            trigger OnValidate()

            begin
                IF "Minimum Amount" <> 0 THEN begin
                    IF "Minimum Amount" > "Maximum Amount" then
                        Error('Minimum Amount cannot be more than maximum amount');
                end;
            end;

        }
        field(9; "Minimum Charge"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Minimum Charge';
            AutoFormatType = 2;
            MinValue = 0;

        }
        field(10; "Maximum Charge"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Charge';
            AutoFormatType = 2;
            MinValue = 0;

        }
        field(11; "G/L Account"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'G/L Account';
            TableRelation = "G/L Account"."No.";


        }
        field(12; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency;
        }
        field(14; "Charge Type"; Option)
        {
            OptionMembers = " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee","Restructuring Fee";
            OptionCaption = ' ,Consultancy,Risk-Sharing Fee,Other,Guarantee Fees,Lenders Option,Booked Fee,Application Fee,Restructuring Fee';
            DataClassification = CustomerContent;
            Caption = 'Charge Type';
        }
        field(500015; "Product Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Traditional,"Lenders Option",Both;

        }

    }

    keys
    {
        key(Code; Code)
        {
            Clustered = true;
        }
    }


}