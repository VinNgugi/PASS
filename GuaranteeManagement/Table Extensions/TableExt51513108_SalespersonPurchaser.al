tableextension 51513108 "Salesperson/Purchaser Ext" extends "Salesperson/Purchaser"
{
    fields
    {
        field(50000; "CGC Signatory"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CGC Signatory';
        }
        field(50001; "Postal Address"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal Address';
        }
    }


}