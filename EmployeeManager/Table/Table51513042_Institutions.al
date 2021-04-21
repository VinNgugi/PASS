table 51513042 Institutions
{
    // version FINANCE

    //DrillDownPageID = 51515526;
    //LookupPageID = 51515526;
    DataClassification = CustomerContent;
    Caption = 'Institutions';
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Purchase Link"; Code[30])
        {
            Caption = 'Purchase Link';
            DataClassification = CustomerContent;
            //TableRelation = "Receipts and Payment Types" WHERE (Type = CONST (Payment));
        }
        field(4; "Sale Link"; Code[30])
        {
            Caption = 'Sale Link';
            DataClassification = CustomerContent;
            //TableRelation = "Receipts and Payment Types" WHERE (Type = CONST (Receipt));
        }
        field(5; "Interest Link"; Code[30])
        {
            Caption = 'Interest Link';
            DataClassification = CustomerContent;
            //TableRelation = "Receipts and Payment Types" WHERE (Type = CONST (Receipt));
        }
        field(6; "Divident Link"; Code[30])
        {
            Caption = 'Divident Link';
            DataClassification = CustomerContent;
            //TableRelation = "Receipts and Payment Types" WHERE (Type = CONST (Receipt));
        }
        field(7; "Investment Posting Group"; Code[30])
        {
            Caption = 'Investment Posting Group';
            DataClassification = CustomerContent;
            //TableRelation = "Investment Posting Groups".Code;
        }
        field(9; "Investment type"; Text[30])
        {
            // TableRelation = "Investment Types";
            Caption = 'Investment type';
            DataClassification = CustomerContent;
            trigger OnValidate();
            begin
                //if InvestmentType.GET("Investment type") then
                //    "Investment Type Name" := InvestmentType.Description;
            end;
        }
        field(10; "Investment Type Name"; Text[30])
        {
            Caption = 'Investment Type Name';
            DataClassification = CustomerContent;
        }
        field(11; "Asset Type"; Option)
        {
            Caption = 'Asset Type';
            DataClassification = CustomerContent;
            OptionCaption = ',Equity,Money Market';
            OptionMembers = ,Equity,"Money Market";
        }
        field(12; "Search Name"; Text[30])
        {
            Caption = 'Search Name';
            DataClassification = CustomerContent;
        }
        field(13; "Current Mkt Price"; Decimal)
        {
            Caption = 'Current Mkt Price';
            DataClassification = CustomerContent;
        }
        field(14; "Mkt Price date"; Date)
        {
            Caption = 'Mkt Price date';
            DataClassification = CustomerContent;
        }
        field(15; Address; Text[50])
        {
            Caption = 'Address';
            DataClassification = CustomerContent;
        }
        field(16; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = 'Open,1st Approval,2nd Approval,Approved';
            OptionMembers = Open,"1st Approval","2nd Approval",Approved;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
    //InvestmentType: Record "Investment Types";
}

