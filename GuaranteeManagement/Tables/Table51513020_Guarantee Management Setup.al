table 51513020 "Guarantee Management Setup"
{
    DataClassification = CustomerContent;
    Caption = 'Guarantee Management Setup';

    fields
    {
        field(1; "Primary Key"; code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;

        }
        field(2; "Guarantee Application Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Guarantee Application Nos.';
            TableRelation = "No. Series";
        }
        field(3; "Restructuring Memo Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Restructuring Memo Nos.';
            TableRelation = "No. Series";
        }
        field(4; "Gen. Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";
        }
        field(5; "Customer Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Posting Group';
            TableRelation = "Customer Posting Group";
        }
        field(6; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(7; "CGF SIDA %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CGF SIDA %';
        }
        field(8; "CGC Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'CGC No.';
            TableRelation = "No. Series";
        }
        field(26; "CGC No. Format"; Text[50])
        {
            DataClassification = CustomerContent;
            caption = 'CGC No. Format';
        }
        field(27; "Risk Sharing fee %"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Risk Sharing fee %';
        }
        field(28; "Loan Amount Limit"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Loan Amount Limit';
        }
        field(29; "Claim Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Claim Nos.';
            TableRelation = "No. Series";
        }
        field(30; "Loan Amount Limit(USD)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Loan Amount Limit(USD)';
        }
        field(31; "Waiver Application Nos."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Waiver Application Nos.';
            TableRelation = "No. Series";
        }
        field(32; "SIDA Guarantee fee"; Decimal)
        {
            DecimalPlaces = 3;
            DataClassification = ToBeClassified;

        }

        field(33; "Youth End Age"; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(34; "Youth Start Age"; Integer)
        {
            DataClassification = CustomerContent;

        }
        field(35; "SIDA Guarantee Limit(USD)"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(36; "LO Batch Nos."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'LO Batch Nos.';
            TableRelation = "No. Series";
        }
        field(37; "Change Request No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Change Request No';
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key("Primary Key"; "Primary Key")
        {
            Clustered = true;
        }
    }



}