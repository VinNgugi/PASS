codeunit 51513013 "Page Management FM Ext"
{
    trigger OnRun()
    begin

    end;

    var
        PaymentRec: Record "Payments HeaderFin";
        PurchaseReq: Record "Requisition Header";

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Page Management", 'OnAfterGetPageID', '', true, true)]
    local procedure OnAfterGetPageID(RecordRef: RecordRef; var PageID: Integer)
    begin
        if PageID = 0 then
            PageID := GetConditionalCardPageID(RecordRef)
    end;

    local procedure GetConditionalCardPageID(RecordRef: RecordRef): Integer
    begin

        CASE RecordRef.Number of
            Database::"Payments HeaderFin":
                exit(GetPaymentsHeaderFinPageID(RecordRef));
            Database::"Requisition Header":
                exit(GetRequisitionHeaderPageID(RecordRef));
            Database::"Memo Request Header":
                exit(Page::"Memo Card");
            Database::"Hotel Request Header":
                exit(Page::"Hotel Application Card");
            Database::"InterBank Transfer Header":
                exit(GetInterBankTransferPageID(RecordRef));
        end;
        exit(0);
    end;

    local procedure GetPaymentsHeaderFinPageID(RecordRef: RecordRef): Integer
    var
        PaymentHeader: Record "Payments HeaderFin";
    begin
        RecordRef.SETTABLE(PaymentHeader);
        case PaymentHeader."Payment Type" OF
            PaymentHeader."Payment Type"::"Petty Cash":
                exit(Page::"Petty Cash");
            PaymentHeader."Payment Type"::"Imprest Requisitioning":
                exit(Page::"Imprest Requisitioning");
            PaymentHeader."Payment Type"::"Imprest Surrender":
                exit(Page::"Imprest Surrender");
            PaymentHeader."Payment Type"::"Payment Voucher":
                exit(Page::"Payments HeaderFin");
        end;

        /*case PaymentHeader."Surrender Type" of
            PaymentHeader."Surrender Type"::Surrender:
                exit(Page::"Imprest Surrender")
    end;*/
        exit(0);
    end;

    local procedure GetRequisitionHeaderPageID(RecordRef: RecordRef): Integer
    var
        RequisitionHeader: Record "Requisition Header";
    begin
        RecordRef.SETTABLE(RequisitionHeader);
        case RequisitionHeader."Requisition Type" OF
            RequisitionHeader."Requisition Type"::"Purchase Requisition":
                exit(Page::"Requisition Header");
        end;
        exit(0);
    end;

    local procedure GetInterBankTransferPageID(RecordRef: RecordRef): Integer
    var
        ObjInterBank: Record "InterBank Transfer Header";
    begin
        RecordRef.SETTABLE(ObjInterBank);
        case ObjInterBank."Transaction Type" OF
            ObjInterBank."Transaction Type"::"InterBank Transfer":
                exit(Page::"InterBank Transfer Card");
            ObjInterBank."Transaction Type"::"Petty-Cash Request":
                exit(Page::"PC Replenish Card");

        end;
        exit(0);
    end;
}