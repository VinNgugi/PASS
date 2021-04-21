tableextension 51513001 "Gen. Journal Line Ext1" extends "Gen. Journal Line"
{
    fields
    {
        field(50001; "Pay Mode"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pay Mode';
            TableRelation = "Pay Modes";
        }
        field(50002; "Cheque Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Cheque Date';
        }
    }
    [IntegrationEvent(false, false)]
    procedure OnAttachDocuments(var GenJnlLine: Record "Gen. Journal Line")
    var
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnViewAttachedDocuments(var GenJnlLine: Record "Gen. Journal Line")
    var
    begin

    end;
}
