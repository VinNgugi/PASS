tableextension 51513003 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        field(50025; "Requisition No."; Code[20])
        {
            Caption = 'Requisition No.';
            DataClassification = CustomerContent;
            TableRelation = "Requisition Header" WHERE ("Requisition Type" = FILTER ("Purchase Requisition"), Status = FILTER (Released), Ordered = FILTER (false));

            trigger OnValidate()

            begin

                IF Req.GET("Requisition No.") THEN BEGIN

                    //Purchase Lines
                    ReqLine.RESET;
                    ReqLine.SETRANGE(ReqLine."Requisition No", "Requisition No.");
                    IF ReqLine.FINDFIRST THEN BEGIN
                        REPEAT
                            PurchaseLine.INIT;
                            PurchaseLine."Document Type" := "Document Type";
                            PurchaseLine."Document No." := "No.";
                            PurchaseLine."Buy-from Vendor No." := "Buy-from Vendor No.";
                            PurchaseLine.Type := ReqLine.Type;
                            PurchaseLine."No." := ReqLine.No;
                            PurchaseLine."Line No." := ReqLine."Line No";
                            PurchaseLine.VALIDATE(PurchaseLine."No.");
                            PurchaseLine.Description := ReqLine.Description;
                            PurchaseLine."Unit of Measure" := ReqLine."Unit of Measure";
                            PurchaseLine.Quantity := ReqLine.Quantity;
                            PurchaseLine."Direct Unit Cost" := ReqLine."Unit Price";
                            PurchaseLine.VALIDATE(PurchaseLine."Direct Unit Cost");
                            PurchaseLine."Shortcut Dimension 1 Code" := ReqLine."Global Dimension 1 Code";
                            PurchaseLine."Shortcut Dimension 2 Code" := ReqLine."Global Dimension 2 Code";
                            IF NOT PurchaseLine.GET(PurchaseLine."Document Type"::Order, "No.", ReqLine."Line No") THEN
                                PurchaseLine.INSERT(TRUE)
                            ELSE
                                PurchaseLine.MODIFY;
                        UNTIL ReqLine.NEXT = 0;
                        Req.Ordered := TRUE;
                        Req.MODIFY;

                    END;


                end;
            end;
        }
    }

    var
        Req: Record "Requisition Header";
        ReqLine: Record "Requisition Lines";
        PurchaseLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
}