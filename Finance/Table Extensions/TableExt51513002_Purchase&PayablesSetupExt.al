tableextension 51513002 "Purchase & Payables Setup Ext" extends "Purchases & Payables Setup"
{
    fields
    {
        field(50000; "Purchase Req No"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Purchase Req No ';
            TableRelation = "No. Series";
        }
        field(50001; "Effective Procurement Plan"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Effective Procurement Plan';
            TableRelation = "G/L Budget Name";
        }
        field(50002; "Store Requisition Nos."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Store Requisition Nos.';
            TableRelation = "No. Series";
        }
    }


}