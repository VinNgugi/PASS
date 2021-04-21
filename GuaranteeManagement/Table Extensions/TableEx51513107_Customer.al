tableextension 51513107 "Customer Ext" extends Customer
{
    fields
    {
        field(60000; "Linkage Risk Sharing fee %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Linkage Risk Sharing fee %';
        }
        field(60001; "Traditional Risk Sharing fee %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Traditional Risk Sharing fee %';
        }
        field(60002; "Total Contracts Value"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Guarantee Contracts"."Approved Loan Amount(LCY)" where("Receivables Acc. No." = field("No."),
                                                                                    "Application Date" = field("Date Filter")));
        }
        field(50856; "Customer TIN"; Code[20])
        {

        }
    }

    var
        myInt: Integer;
}