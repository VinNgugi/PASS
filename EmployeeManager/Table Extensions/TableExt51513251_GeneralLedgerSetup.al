tableextension 51513251 "Generla Ledger Setup Ext" extends "General Ledger Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50006; "Current Budget"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Current Budget';
        }
        field(50017; "Current Budget Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Current Budget Start Date';
        }
        field(50018; "Current Budget End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Current Budget End Date';
        }
        field(50063; "HR Department"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'HR Department';
            TableRelation = "Dimension Value".Code WHERE ("Dimension Code" = CONST ('DEPARTMENT'));
        }
    }

    var
        myInt: Integer;
}