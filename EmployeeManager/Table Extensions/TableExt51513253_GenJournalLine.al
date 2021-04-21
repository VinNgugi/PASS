tableextension 51513253 "Gen. Journal Line Ext" extends "Gen. Journal Line"
{
    fields
    {
        // Add changes to table fields here
        field(50018; "Employee Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee Code';
            TableRelation = Employee;
        }
    }

    var
        myInt: Integer;
}