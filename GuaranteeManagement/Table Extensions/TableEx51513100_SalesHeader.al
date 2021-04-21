tableextension 51513100 "Sales Header Ext" extends "Sales Header"
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
        field(50856; "Customer TIN"; Code[20])
        {
            trigger OnValidate()
            var

            begin
                if ObjCust.Get("Sell-to Customer No.") then begin
                    if ObjCust."Customer TIN" = '' then begin
                        ObjCust."Customer TIN" := "Customer TIN";
                        ObjCust.Modify();
                    end;
                end;
            end;
        }
        field(50857; "Customer VRN"; Code[20])
        {
            trigger OnValidate()
            var

            begin
                if ObjCust.Get("Sell-to Customer No.") then begin
                    if ObjCust."VAT Registration No." = '' then begin
                        ObjCust."VAT Registration No." := "Customer VRN";
                        ObjCust.Modify();
                    end;
                end;
            end;
        }

    }
    trigger OnInsert()
    var

    begin
        if ObjCust.Get("Sell-to Customer No.") then begin
            "Customer TIN" := ObjCust."Customer TIN";
            "Customer VRN" := ObjCust."VAT Registration No.";

        end;
    end;

    var
        ObjCust: Record Customer;
}