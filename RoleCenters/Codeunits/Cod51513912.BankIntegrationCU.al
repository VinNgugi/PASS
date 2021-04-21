codeunit 51513912 "Bank Integration CU"
{
    trigger OnRun()
    var
        myInt: Integer;
    begin

    end;

    procedure FnGetInvoiceDetails(InvoiceNumber: Code[20]) Res: Text
    var
        ObjSalesH: Record "Sales Header";
        ObjSalesLines: Record "Sales Line";
        TotalInvoiceAmt: Decimal;
    begin
        ObjSalesH.Reset();
        ObjSalesH.SetRange("No.", InvoiceNumber);
        if ObjSalesH.FindSet() then
            Res := '{"success":true,"Invoice Data":[';
        repeat
            Res += '{"InvoiceNo":' + '"' + ObjSalesH."No." + '",';
            Res += '"CustomerNo":' + '"' + ObjSalesH."Sell-to Customer No." + '",';
            Res += '"CustomerName":' + '"' + ObjSalesH."Sell-to Customer Name" + '",';
            Res += '"ServiceName":' + '"' + ObjSalesH."Transaction Type" + '",';
            Res += '"InvoiceCurrency":' + '"' + ObjSalesH."Currency Code" + '",';
            Res += '"InvoiceDate":' + '"' + format(ObjSalesH."Document Date") + '",';
            ObjSalesLines.Reset();
            ObjSalesLines.SetRange("Document No.", ObjSalesH."No.");
            if ObjSalesLines.FindSet() then begin
                ObjSalesLines.CalcSums(Amount);
                TotalInvoiceAmt := ObjSalesLines.Amount;
            end;

            Res += '"BillAmount":' + '"' + format(TotalInvoiceAmt) + '"},';
        until ObjSalesH.Next() = 0;
        Res := CopyStr(Res, 1, StrLen(Res) - 1);
        Res := Res + ']}';
    end;

    procedure FnInsertPaymentConfirmation(var BankRef: Code[20]; var PaymentRef: Code[20]; var BillerRef: Code[20]; var TransDate: Date; var TransactionDescription: Text[200]; var Amountpaid: Decimal; var CurrencyCode: Code[20]; var PaymentChannel: Text[30]; var TransactionStatus: Text[30]) Ok: Boolean
    var
        ObjPaymentRec: Record "Payments Received Buffer";
        ObjPaymentRec1: Record "Payments Received Buffer";
    begin
        Ok := false;
        ObjPaymentRec.Reset();
        ObjPaymentRec.SetRange("Bank Ref", BankRef);
        if not ObjPaymentRec.Find('-') then begin
            ObjPaymentRec1.Init();
            ObjPaymentRec1."Bank Ref" := BankRef;
            ObjPaymentRec1."Biller Ref" := BillerRef;
            ObjPaymentRec1."Currency Code" := CurrencyCode;
            ObjPaymentRec1."Payment Channel" := PaymentChannel;
            ObjPaymentRec1."Payment Ref" := PaymentRef;
            ObjPaymentRec1."Transacted Amount" := Amountpaid;
            ObjPaymentRec1."Transaction Date" := TransDate;
            ObjPaymentRec1."Transaction Description" := TransactionDescription;
            ObjPaymentRec1."Transaction Status" := TransactionStatus;
            if (ObjPaymentRec1.Insert()) then
                Ok := true;
        end;

    end;
}
