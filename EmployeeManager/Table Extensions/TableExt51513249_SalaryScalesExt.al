tableextension 51513249 "Salary Scale Ext" extends "Salary Scales"
{
    fields
    {
        field(50005; "Payroll Category"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Payroll Category';
            TableRelation = "Payroll Subcategories"."Payroll Subcategory";
        }
    }
}