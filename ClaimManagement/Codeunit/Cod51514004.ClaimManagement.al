codeunit 51514004 "Claim Management"
{
    trigger OnRun()
    var
        myInt: Integer;
    begin

    end;

    procedure FnMoveClaimsToBoards(Var ClaimNo: Code[20]; Var LineNo: Integer)
    var
        ObjClaimLines: Record "Guarantee Claim Line";
    begin
        if ObjClaimLines.Get(ClaimNo, LineNo) then begin
            if ObjClaimLines."Claim Steps" = ObjClaimLines."Claim Steps"::"Mgmt Approval" then begin
                if ObjClaimLines.Completed then begin
                    if ObjClaimLines."Approval Status" = ObjClaimLines."Approval Status"::Approved then begin
                        //**************Move the claim step to Board Approval
                        ObjClaimLines."Claim Steps" := ObjClaimLines."Claim Steps"::"Board Approval";
                        ObjClaimLines.Modify();
                        Message('Succesfully moved to board for Approval');
                    end;
                end;
            end else
                Error('This claim Document has already been sent to the Board for further approval');

        end;
    end;

    procedure FnCreateClaimInvoice(var ObjClaimLine: Record "Guarantee Claim Line")
    var
        ObjGuarClaimLine: Record "Guarantee Claim Line";
        ObjPurchH: Record "Purchase Header";
        PurchH: Record "Purchase Header";
        ObjPurchLine: Record "Purchase Line";
        ObjClaimH: Record Claim;
        LinesRefNo: Code[20];
    begin
        ObjGuarClaimLine.Reset();
        ObjGuarClaimLine.SetRange("Claim No.", ObjClaimLine."Claim No.");
        ObjGuarClaimLine.SetRange("Client No.", ObjClaimLine."Client No.");
        if ObjGuarClaimLine.Find('-') then begin
            ObjPurchH.Reset();
            ObjPurchH.SetRange("Claim No.", ObjClaimLine."Claim No.");
            if not ObjPurchH.Find('-') then begin
                //**********Code to run if Purchase Document does not exists
                ObjClaimH.Get(ObjClaimLine."Claim No.");
                //*** Populate Header***//
                with PurchH do begin
                    Init();
                    "Document Type" := "Document Type"::Invoice;
                    "Buy-from Vendor No." := '117';
                    Validate("Buy-from Vendor No.");
                    "Claim No." := ObjClaimLine."Claim No.";
                    Insert(true);

                    LinesRefNo := "No.";
                end;
                //***Populate Lines***//
                with ObjPurchLine do begin
                    Init();
                    "Document Type" := "Document Type"::Invoice;
                    "Buy-from Vendor No." := '117';
                    Validate("Buy-from Vendor No.");
                    "Document No." := LinesRefNo;
                    Type := Type::"G/L Account";
                    Validate(Type);
                    "No." := '1114';
                    Validate("No.");
                    Quantity := 1;
                    "Direct Unit Cost" := ObjGuarClaimLine."Payable Amount";
                    Validate("Direct Unit Cost");
                    "Shortcut Dimension 1 Code" := '02';
                    Validate("Shortcut Dimension 1 Code");
                    Insert();
                end;
                Message('Claim Invoice Number %1 created succesfully.', LinesRefNo);
            end else begin
                //**********Code to run if Purchase Document exists
                with ObjPurchLine do begin
                    Init();
                    "Document Type" := "Document Type"::Invoice;
                    "Buy-from Vendor No." := ObjPurchH."Buy-from Vendor No.";
                    Validate("Buy-from Vendor No.");
                    "Document No." := ObjPurchH."No.";
                    Type := Type::"G/L Account";
                    Validate(Type);
                    "No." := '1114';
                    "Line No." := FnGetLastLineNo(ObjPurchLine);
                    Validate("No.");
                    Quantity := 1;
                    "Direct Unit Cost" := ObjGuarClaimLine."Payable Amount";
                    Validate("Direct Unit Cost");
                    "Shortcut Dimension 1 Code" := '02';
                    Validate("Shortcut Dimension 1 Code");
                    Insert();
                end;
                Message('Claim Invoice Number %1 updated succesfully.', ObjPurchH."No.");
            end;

        end;
    end;

    procedure FnGetLastLineNo(Var ObjLine: Record "Purchase Line") LineNo: Decimal;

    var
        Purchaseline: Record "Purchase Line";
    begin
        LineNo := 0;
        Purchaseline.Reset();
        Purchaseline.SetRange("Document No.", ObjLine."Document No.");
        if Purchaseline.FindLast() then
            LineNo := Purchaseline."Line No.";

        exit(LineNo + 1);

    end;
}
