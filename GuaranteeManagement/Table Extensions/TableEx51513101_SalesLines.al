tableextension 51513101 "Sales Line Ext" extends "Sales Line"
{
    fields
    {
        field(50000; "Guarantee Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Guarantee Application No.';
            TableRelation = "Guarantee Application";
        }
        field(50010; "Guarantee Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Transaction Type';
            OptionMembers = " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee","Restructuring Fee";
            OptionCaption = ' ,Consultancy,Risk-Sharing Fee,Other,Guarantee Fees,Lenders Option,Booked Fee,Application Fee,Restructuring Fee';
        }
    }


}