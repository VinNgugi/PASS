table 51513004 "Credit Guarantee Partner"
{
    DataClassification = CustomerContent;
    Caption = 'Credit Guarantee Partner';
    DrillDownPageId = "Credit Guarantee Partner List";
    LookupPageId = "Credit Guarantee Partner List";
    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';

        }
        field(2; "Description"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Guarantee %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Guarantee %';
        }
        field(4; "PASS Guarantee %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'PASS Guarantee %';
        }
field(5;Blocked;boolean)
{
    
}
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }



}