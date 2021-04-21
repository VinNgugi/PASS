tableextension 51513000 "General Ledger Setup Ext" extends "General Ledger Setup"
{
    fields
    {
        field(50000; "PV Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'PV Nos';
            TableRelation = "No. Series";
        }
        field(50001; "Imprest Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Imprest Nos';
            TableRelation = "No. Series";
        }
        field(50002; "Imprest Surrender No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Imprest Surrender No';
            TableRelation = "No. Series";
        }
        field(50003; "Petty Cash Nos"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Petty Cash Nos';
            TableRelation = "No. Series";
        }
        field(50067; "Receipt No"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt No';
            TableRelation = "No. Series";
        }
        field(50068; "EDMS Document Link"; Text[100])
        {

        }
    }
}