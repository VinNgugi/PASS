tableextension 51513351 "G/L Budget Name Ext" extends "G/L Budget Name"
{
    fields
    {
        field(50002; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
        }
        field(50003; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
        }
    }

    var
        myInt: Integer;
}