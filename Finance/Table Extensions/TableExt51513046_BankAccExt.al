tableextension 51513045 "Bank Account Extension" extends "Bank Account"
{
    fields
    {
        field(50000; "Bank Acc Type"; Option)
        {
            OptionMembers = " ",Normal,"Petty Cash","Fixed Deposit";
        }
        field(50001; "Cashier ID"; Code[20])
        {
            TableRelation = "User Setup"."User ID";
        }
        field(50002; "Last Replenish Date"; Date)
        {

        }
    }
}