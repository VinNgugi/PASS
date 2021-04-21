codeunit 51513911 "EDMS Integration CU"
{




    /// <summary> 
    /// Description for FnGetGuaranteeApplicationData.
    /// </summary>
    /// <param name="ClientCode">Parameter of type Text[20].</param>
    /// <param name="ClientName">Parameter of type Text[150].</param>
    /// <param name="BranchCode">Parameter of type Text[20].</param>
    /// <param name="BDOName">Parameter of type Text[150].</param>
    procedure FnGetGuaranteeClientData(ProcessType: Option GuaranteeApp,"Imprest App","Imprest Surr","Memo app","PettyCash App","Journal Voucher","Claim Mgmt"; DocumentNo: Code[20]) Res: Text
    var
        GuarrApplication: Record "Guarantee Application";
        ObjPaymentsH: Record "Payments HeaderFin";
        ObjMemoReq: Record "Memo Request Header";
        ObjClaim: Record Claim;
        ObjGenJnl: record "Gen. Journal Line";
    begin

        case ProcessType of
            ProcessType::GuaranteeApp:
                begin
                    GuarrApplication.Reset();
                    if DocumentNo <> '' then
                        GuarrApplication.SetRange("No.", DocumentNo);
                    if GuarrApplication.FindSet() then begin
                        Res := '{"success":true,"Client Data":[';
                        repeat
                            if GuarrApplication."Customer No." <> '' then begin
                                Res += '{"PO_Number":' + '"' + GuarrApplication."No." + '",';
                                Res += '"BDO":' + '"' + GuarrApplication."BDS/BDO" + '",';
                                Res += '"Client_No":' + '"' + GuarrApplication."Customer No." + '",';
                                Res += '"Client_Name":' + '"' + (DELCHR(FORMAT(GuarrApplication.Name), '=', DELCHR(FORMAT(GuarrApplication.Name), '=', txtCharsToKeep))) + '",';
                                Res += '"Branch_Code":' + '"' + GuarrApplication."Global Dimension 1 Code" + '",';
                                Res += '"Application_Status":' + '"' + format(GuarrApplication.Status) + '",';
                                Res += '"Customer _Category":' + '"' + GuarrApplication."Business Ownership Type" + '"},';
                            end;
                        until GuarrApplication.Next() = 0;
                        Res := CopyStr(Res, 1, StrLen(Res) - 1);
                        Res := Res + ']}';
                    end;
                end;

            ProcessType::"Imprest App":
                begin
                    ObjPaymentsH.Reset();
                    if DocumentNo <> '' then
                        ObjPaymentsH.SetRange("No.", DocumentNo);
                    ObjPaymentsH.SetRange("Payment Type", ObjPaymentsH."Payment Type"::"Imprest Requisitioning");
                    if ObjPaymentsH.FindSet() then begin
                        Res := '{"success":true,"Imprest Application Data":[';
                        repeat
                            Res += '{"Imprest_Number":' + '"' + ObjPaymentsH."No." + '",';
                            Res += '"Employee_No":' + '"' + ObjPaymentsH."Employee No" + '",';
                            Res += '"Employee_Name":' + '"' + ObjPaymentsH."Account Name" + '",';
                            Res += '"CL_Number":' + '"' + ObjPaymentsH."Account No." + '",';
                            Res += '"Imprest_Date":' + '"' + format(ObjPaymentsH.Date) + '",';
                            Res += '"Memo_No":' + '"' + ObjPaymentsH."Memo Reference" + '",';
                            Res += '"Imprest_Amt":' + '"' + format(ObjPaymentsH.calcfields("Imprest Amount")) + '"},';
                        until ObjPaymentsH.Next() = 0;
                        Res := CopyStr(Res, 1, StrLen(Res) - 1);
                        Res := Res + ']}';
                    end;

                end;
            ProcessType::"Imprest Surr":
                begin
                    ObjPaymentsH.Reset();
                    if DocumentNo <> '' then
                        ObjPaymentsH.SetRange("No.", DocumentNo);
                    ObjPaymentsH.SetRange("Surrender Type", ObjPaymentsH."Surrender Type"::Surrender);
                    if ObjPaymentsH.FindSet() then begin
                        Res := '{"success":true,"Imprest Retirement Data":[';
                        repeat
                            Res += '{"Retirement_Number":' + '"' + ObjPaymentsH."No." + '",';
                            Res += '"Employee_No":' + '"' + ObjPaymentsH."Employee No" + '",';
                            Res += '"Employee_Name":' + '"' + ObjPaymentsH."Account Name" + '",';
                            Res += '"CL_Number":' + '"' + ObjPaymentsH."Account No." + '",';
                            Res += '"Retirement_Date":' + '"' + format(ObjPaymentsH.Date) + '",';
                            Res += '"Memo_No":' + '"' + ObjPaymentsH."Memo Reference" + '",';
                            Res += '"Retirement_Amt":' + '"' + format(ObjPaymentsH.calcfields("Imprest Amount")) + '"},';
                        until ObjPaymentsH.Next() = 0;
                        Res := CopyStr(Res, 1, StrLen(Res) - 1);
                        Res := Res + ']}';
                    end;
                end;
            ProcessType::"Memo app":
                begin
                    ObjMemoReq.Reset();
                    if DocumentNo <> '' then
                        ObjMemoReq.SetRange("Request No.", DocumentNo);
                    if ObjMemoReq.FindSet() then begin
                        Res := '{"success":true,"Memo App Data":[';
                        repeat
                            Res += '{"Memo_Number":' + '"' + ObjMemoReq."Request No." + '",';
                            Res += '"Memo_Date":' + '"' + Format(ObjMemoReq."Creation Date") + '",';
                            Res += '"Trip_Name":' + '"' + ObjMemoReq."Trip Name" + '",';
                            Res += '"Trip_Description":' + '"' + ObjMemoReq."Trip Description" + '",';
                            Res += '"Trip_Type":' + '"' + format(ObjMemoReq."Trip Type") + '",';
                            Res += '"Start_Date":' + '"' + format(ObjMemoReq."Start Date") + '",';
                            Res += '"End_Date":' + '"' + format(ObjMemoReq."End Date") + '"},';
                        until ObjMemoReq.Next() = 0;
                        Res := CopyStr(Res, 1, StrLen(Res) - 1);
                        Res := Res + ']}';
                    end;
                end;
            ProcessType::"PettyCash App":
                begin
                    ObjPaymentsH.Reset();
                    if DocumentNo <> '' then
                        ObjPaymentsH.SetRange("No.", DocumentNo);
                    ObjPaymentsH.SetRange("Payment Type", ObjPaymentsH."Payment Type"::"Petty Cash");
                    if ObjPaymentsH.FindSet() then begin
                        Res := '{"success":true,"Petty Cash Data":[';
                        repeat
                            Res += '{"Petty_Cash_No":' + '"' + ObjPaymentsH."No." + '",';
                            Res += '"Employee_No":' + '"' + ObjPaymentsH."Employee No" + '",';
                            Res += '"Employee_Name":' + '"' + ObjPaymentsH."Account Name" + '",';
                            Res += '"Transaction_Description":' + '"' + ObjPaymentsH."Transaction Description" + '",';
                            Res += '"Document_Date":' + '"' + format(ObjPaymentsH.Date) + '",';
                            Res += '"Memo_No":' + '"' + ObjPaymentsH."Memo Reference" + '",';
                            Res += '"Petty_Cash_Amt":' + '"' + format(ObjPaymentsH.calcfields("Petty Cash Amount")) + '"},';
                        until ObjPaymentsH.Next() = 0;
                        Res := CopyStr(Res, 1, StrLen(Res) - 1);
                        Res := Res + ']}';
                    end;
                end;
            ProcessType::"Journal Voucher":
                begin
                    ObjGenJnl.Reset();
                    if DocumentNo <> '' then
                        ObjGenJnl.SetRange("Document No.", DocumentNo);
                    if ObjGenJnl.FindSet() then begin
                        Res := '{"success":true,"Journal Voucher Data":[';
                        repeat
                            Res += '{"JV_Number":' + '"' + ObjGenJnl."Document No." + '",';
                            Res += '"JV_Template":' + '"' + ObjGenJnl."Journal Template Name" + '",';
                            Res += '"JV_Batch":' + '"' + ObjGenJnl."Journal Batch Name" + '",';
                            Res += '"Line_No":' + '"' + format(ObjGenJnl."Line No.") + '",';
                            Res += '"JV_Date":' + '"' + Format(ObjGenJnl."Document Date") + '",';
                            Res += '"JV_Posting_Date":' + '"' + format(ObjGenJnl."Posting Date") + '",';
                            Res += '"JV_Description":' + '"' + ObjGenJnl.Description + '"},';

                        until ObjGenJnl.Next() = 0;
                        Res := CopyStr(Res, 1, StrLen(Res) - 1);
                        Res := Res + ']}';
                    end;
                end;
            ProcessType::"Claim Mgmt":
                begin
                    ObjClaim.Reset();
                    if DocumentNo <> '' then
                        ObjClaim.SetRange("No.", DocumentNo);
                    if ObjClaim.FindSet() then begin
                        Res := '{"success":true,"Memo App Data":[';
                        repeat
                            Res += '{"Claim_Number":' + '"' + ObjClaim."No." + '",';
                            Res += '"Claim_Date":' + '"' + Format(ObjClaim."Claim Date") + '",';
                            Res += '"Claim_Description":' + '"' + format(ObjClaim."Claim Desscrition") + '",';
                            Res += '"Customer_No":' + '"' + ObjClaim."Customer No." + '",';
                            Res += '"Customer_Name":' + '"' + format(ObjClaim."Customer Name") + '",';
                            Res += '"Claim_Reference_No":' + '"' + format(ObjClaim."Reference No.") + '",';
                            Res += '"Total_Amount":' + '"' + format(ObjClaim.CalcFields("Total Amount")) + '"},';
                        until ObjClaim.Next() = 0;
                        Res := CopyStr(Res, 1, StrLen(Res) - 1);
                        Res := Res + ']}';
                    end;
                end;
        end;



    end;

    procedure FnGetLastDocumentID() DocID: Integer;
    var
        myInt: Integer;
    begin
        DocID := 0;
        EDMSDocs.Reset();
        EDMSDocs.SetCurrentKey(DocID);
        if EDMSDocs.FindLast() then
            DocID := EDMSDocs.DocID
        else
            DocID := 0;
    end;

    procedure FnInsertDocumentRecord(var DocLinkID: Integer; var DocumentNo: Code[20]; var DocID: Integer; var DocSource: Text[50]; var DocFile: Code[30]; var DocLink: Text[150]; var EntryDate: DateTime; var InstanceID: Integer; var FolderLink: Text[150]; var PFNumber: Code[20]) Ok: Boolean
    var

    begin
        Ok := false;

        EDMSDocs.Reset();
        EDMSDocs.SetRange(DocID, DocID);
        if not EDMSDocs.Find('-') then begin
            EDMSDocs1.Init();
            EDMSDocs1.DocLinkID := DocLinkID;
            EDMSDocs1.DocumentNo := DocumentNo;
            EDMSDocs1.DocID := DocID;
            EDMSDocs1.DocSource := DocSource;
            EDMSDocs1.DocFile := DocFile;
            EDMSDocs1.DocLink := DocLink;
            EDMSDocs1.EntryDate := EntryDate;
            EDMSDocs1.InstanceID := InstanceID;
            EDMSDocs1.FolderLink := FolderLink;
            EDMSDocs1.PFNumber := PFNumber;
            if EDMSDocs1.Insert() then
                Ok := true;
            exit(Ok);
        end
        else begin
            EDMSDocs.DocLinkID := DocLinkID;
            EDMSDocs.DocumentNo := DocumentNo;
            EDMSDocs.DocID := DocID;
            EDMSDocs.DocSource := DocSource;
            EDMSDocs.DocFile := DocFile;
            EDMSDocs.DocLink := DocLink;
            EDMSDocs.EntryDate := EntryDate;
            EDMSDocs.InstanceID := InstanceID;
            EDMSDocs.FolderLink := FolderLink;
            EDMSDocs.PFNumber := PFNumber;
            if EDMSDocs.Insert() then
                Ok := true;
            exit(Ok);
        end;

    end;

    [EventSubscriber(ObjectType::Table, Database::"Guarantee Application", 'OnAttachDocuments', '', true, true)]
    local procedure "Guarantee Application_OnAttachDocuments"(var GuarrApplication: Record "Guarantee Application")
    begin
        GLSetup.Get();
        GLSetup.TestField("EDMS Document Link");
        AttachmentLink := GLSetup."EDMS Document Link" + '?process=GuaranteeApplication&identifier=' + GuarrApplication."No.";
        Message('Hyperlink is %1', AttachmentLink);
        Hyperlink(AttachmentLink);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Guarantee Application", 'OnViewAttachedDocuments', '', true, true)]
    local procedure "Guarantee Application_OnViewAttachedDocuments"(var GuarrApplication: Record "Guarantee Application")
    begin
        EDMSDocs.Reset();
        EDMSDocs.SetRange(DocumentNo, GuarrApplication."No.");
        if EDMSDocs.FindFirst() then begin
            EDMSIntDocs.Setfilters(EDMSDocs.DocumentNo);
            EDMSIntDocs.Run();
        end else
            Message('There are no attachments to view');

    end;

    [EventSubscriber(ObjectType::Table, Database::"Payments HeaderFin", 'OnAttachDocuments', '', true, true)]
    local procedure "Payments HeaderFin_OnAttachDocuments"(var PanmentsH: Record "Payments HeaderFin")
    begin
        GLSetup.Get();
        GLSetup.TestField("EDMS Document Link");
        case PanmentsH."Payment Type" of
            PanmentsH."Payment Type"::"Imprest Requisitioning":
                begin
                    AttachmentLink := GLSetup."EDMS Document Link" + '?process=ImprestApplication&identifier=' + PanmentsH."No.";
                end;
            PanmentsH."Payment Type"::Imprest:
                begin
                    AttachmentLink := GLSetup."EDMS Document Link" + '?process=ImprestApplication&identifier=' + PanmentsH."No.";
                end;
            PanmentsH."Payment Type"::"Imprest Surrender":
                begin
                    AttachmentLink := GLSetup."EDMS Document Link" + '?process=ImprestRetirement&identifier=' + PanmentsH."No.";
                end;
            PanmentsH."Payment Type"::"Petty Cash":
                begin
                    AttachmentLink := GLSetup."EDMS Document Link" + '?process=PettyCash&identifier=' + PanmentsH."No.";
                end;
        end;
        case PanmentsH."Surrender Type" of
            PanmentsH."Surrender Type"::Surrender:
                begin
                    AttachmentLink := GLSetup."EDMS Document Link" + '?process=ImprestRetirement&identifier=' + PanmentsH."No.";
                end;
        end;
        if AttachmentLink <> '' then
            Hyperlink(AttachmentLink);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Payments HeaderFin", 'OnViewAttachedDocuments', '', true, true)]
    local procedure "Payments HeaderFin_OnViewAttachedDocuments"(var PanmentsH: Record "Payments HeaderFin")
    begin
        EDMSDocs.Reset();
        EDMSDocs.SetRange(DocumentNo, PanmentsH."No.");
        if EDMSDocs.FindFirst() then begin
            EDMSIntDocs.Setfilters(EDMSDocs.DocumentNo);
            EDMSIntDocs.Run();
        end else
            Message('There are no attachments to view');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Memo Request Header", 'OnAttachDocuments', '', true, true)]
    local procedure "Memo Request Header_OnAttachDocuments"(var MemoRequest: Record "Memo Request Header")
    begin
        GLSetup.Get();
        GLSetup.TestField("EDMS Document Link");
        AttachmentLink := GLSetup."EDMS Document Link" + '?process=TravelMemo&identifier=' + MemoRequest."Request No.";
        Hyperlink(AttachmentLink);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Memo Request Header", 'OnViewAttachedDocuments', '', true, true)]
    local procedure "Memo Request Header_OnViewAttachedDocuments"(var MemoRequest: Record "Memo Request Header")
    begin
        EDMSDocs.Reset();
        EDMSDocs.SetRange(DocumentNo, MemoRequest."Request No.");
        if EDMSDocs.FindFirst() then begin
            EDMSIntDocs.Setfilters(EDMSDocs.DocumentNo);
            EDMSIntDocs.Run();
        end else
            Message('There are no attachments to view');
    end;

    [EventSubscriber(ObjectType::Table, Database::"Claim", 'OnAttachDocuments', '', true, true)]
    local procedure "Claim_OnAttachDocuments"(var ClaimApp: Record "Claim")
    begin
        GLSetup.Get();
        GLSetup.TestField("EDMS Document Link");
        AttachmentLink := GLSetup."EDMS Document Link" + '?process=Claim&identifier=' + ClaimApp."No.";
        Hyperlink(AttachmentLink);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Claim", 'OnViewAttachedDocuments', '', true, true)]
    local procedure "Claim_OnViewAttachedDocuments"(var ClaimApp: Record "Claim")
    begin
        EDMSDocs.Reset();
        EDMSDocs.SetRange(DocumentNo, ClaimApp."No.");
        if EDMSDocs.FindFirst() then begin
            EDMSIntDocs.Setfilters(EDMSDocs.DocumentNo);
            EDMSIntDocs.Run();
        end else
            Message('There are no attachments to view');
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAttachDocuments', '', true, true)]
    local procedure "Gen. Journal Line Ext1_OnAttachDocuments"(var GenJnlLine: Record "Gen. Journal Line")
    begin
        GLSetup.Get();
        GLSetup.TestField("EDMS Document Link");
        AttachmentLink := GLSetup."EDMS Document Link" + '?process=JournalVoucher&identifier=' + GenJnlLine."Document No.";
        Hyperlink(AttachmentLink);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnViewAttachedDocuments', '', true, true)]
    local procedure "Gen. Journal Line Ext1_OnViewAttachedDocuments"(var GenJnlLine: Record "Gen. Journal Line")
    begin
        EDMSDocs.Reset();
        EDMSDocs.SetRange(DocumentNo, GenJnlLine."Document No.");
        if EDMSDocs.FindFirst() then begin
            EDMSIntDocs.Setfilters(EDMSDocs.DocumentNo);
            EDMSIntDocs.Run();
        end else
            Message('There are no attachments to view');
    end;


    var
        EDMSDocs: Record "EDMS Integration Docs";
        EDMSDocs1: Record "EDMS Integration Docs";
        EDMSIntDocs: Page "EDMS Integration Docs List";
        GLSetup: Record "General Ledger Setup";
        AttachmentLink: Text;
        txtCharsToKeep: TextConst ENU = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

}
