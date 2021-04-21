table 51513500 "Investment Setup"
{
    DataClassification = CustomerContent;
    DrillDownPageId = "Investment Setup";
    LookupPageId = "Investment Setup";
    Caption = 'Investment Setup';
    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';

        }
        field(2; "Investment Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Investment No.';
            TableRelation = "No. Series";
        }
        field(3; "Investment Template"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Investment Template';
            TableRelation = "Gen. Journal Template".Name;
        }
        field(4; "Investment Batch"; code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Investment Batch';
            TableRelation = "Gen. Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Investment Template"));
        }
        field(5; "Investment G/L Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Investment G/L Account';
            TableRelation = "G/L Account";
        }
        field(6; "Interest Receivable"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Interest Receivable';
            TableRelation = "G/L Account";
        }
        field(7; "Interest Received"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Interest Received';
            TableRelation = "G/L Account";
        }
        field(8; "Withholding Tax G/L Account"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Withholding Tax G/L Account';
            TableRelation = "G/L Account";
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

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

}