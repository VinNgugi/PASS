tableextension 51513255 "Employee Posting Group Ext" extends "Employee Posting Group"
{
    fields
    {
        field(50000; "Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(50001; "Posting Acc No."; Code[20])
        {
            TableRelation = if ("Account Type" = filter ("G/L Account")) "G/L Account"."No."
            else
            if ("Account Type" = filter ("Vendor")) Vendor."No."
            else
            if ("Account Type" = filter ("Customer")) customer."No.";
        }
    }
}