page 51513637 "LO General Journal Header"
{
    PageType = Card;
    UsageCategory = Tasks;
    SourceTable = "Lenders Option Journal Header";
    RefreshOnActivate = true;

    PromotedActionCategories = 'New,Process,Report,Documents,Approve,Request Approval,Navigate,Applicant';

    layout
    {
        area(Content)
        {
            group(General)
            {
                //Editable = ActionVisibility;

                field("Financial Institution Code"; "Financial Institution Code")
                {

                }
                field("Product Type"; "Product Type")
                {

                }
                field(Product; Product)
                {

                }
                field("Bank Branch Name"; "Bank Branch Name")
                {

                }
                field("Reference No."; "Reference No.")
                {

                }
                field("Reference Date"; "Reference Date")
                {

                }
                field(Description; Description)
                {
                    MultiLine = true;
                }

                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Guarantee Source"; "Guarantee Source")
                {

                }
                field("No. of Clients"; "No. of Clients")
                {

                }
                field("Total Principal Loan"; "Total Principal Loan")
                {

                }
                field(Status; Status)
                {

                }

            }
            group(Signatories)
            {
                Editable = not "CGC Issued";
                field("Signatory 1 (CGC)"; "Signatory 1 (CGC)")
                {

                }
                field("Signatory 2 (CGC)"; "Signatory 2 (CGC)")
                {

                }
            }
            part("LO General Journal Lines"; "LO General Journal")
            {
                Editable = not "CGC Prepared";
                Caption = 'LO General Journal Lines';
                SubPageLink = Code = field("No.");

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Import From Excel")
            {
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = ActionVisibility;
                trigger OnAction();
                var
                    JournalImport: Report "LO Journal Import";
                begin
                    TestField("Product Type");
                    TestField(Product);
                    JournalImport.GetRecHeader(Rec);
                    JournalImport.RUN;

                    CurrPage.UPDATE(TRUE);

                end;
            }
            action("Prepare Individual CGCs")
            {
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;
                Enabled = Prepare and NOT "CGC Prepared";
                trigger OnAction();

                begin

                    PrepareCGCs(TRUE);

                end;
            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;
                    ;
                    ApplicationArea = "#Basic,#Suite";
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        LOBatch: Record "Lenders Option Journal Line";
                    begin
                        TestField("Financial Institution Code");
                        TestField("Bank Branch Name");
                        TestField("Reference Date");
                        TestField("Reference No.");
                        TestField(Description);
                        TestField("Signatory 1 (CGC)");
                        TestField("Signatory 2 (CGC)");
                        TestField("Global Dimension 1 Code");
                        TestField("Guarantee Source");

                        LOBatch.Reset();
                        LOBatch.SetRange(Code, rec."No.");
                        if LOBatch.FindFirst() then begin
                            repeat
                                GuaranteeMngt.ValidateImportedApplications(LOBatch);
                            until LOBatch.Next() = 0;
                        end;
                        if ApprovalsMgmtExt.CheckLOHeaderApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendLOHeaderforApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Enabled = CanCancelApprovalForRecord;
                    ApplicationArea = "#Basic,#Suite";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()

                    begin
                        ApprovalsMgmtExt.OnCancelLOHeaderforApproval(Rec);

                    end;
                }
            }
        }
    }


    var
        GuaranteeSetup: Record "Guarantee Management Setup";
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmtExt: Codeunit "Approval Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        GuaranteeMngt: Codeunit "Guarantee Management";
        EnabledApprovalWorkflowsExist: Boolean;
        ActionVisibility: Boolean;
        dataedit: Boolean;
        Prepare: Boolean;

    trigger OnOpenPage()
    begin

    end;

    trigger OnAfterGetCurrRecord()
    begin
        ActionVisibility := true;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := TRUE;
        if Status <> Status::Open then begin
            // CurrPage.Editable := false;
            ActionVisibility := false;
            if Status = Status::Released then begin
                Prepare := true;
                OpenApprovalEntriesExist := FALSE;
                CanCancelApprovalForRecord := FALSE;
                EnabledApprovalWorkflowsExist := FALSE;
            end else
                Prepare := false;

        end;

    end;

    trigger OnAfterGetRecord()
    begin

        if Status <> Status::Open then;
        // CurrPage.Editable := false;
    end;

    procedure PrepareCGCs(SingleCertificate: Boolean)
    var
        LendersOptionSingleCGC: Record "Lenders Option Single CGC";
        LOBatch: Record "Lenders Option Journal Line";
        GuaranteeContract: Record "Guarantee Contracts";
        ProductCodes: Record Products;
        ProductRec: Code[20];

    begin
        IF CONFIRM('Are you sure you want to proceed ?', TRUE) THEN BEGIN

            ProductCodes.Reset();
            ProductCodes.SetRange(Type, ProductCodes.Type::"Lenders Option");
            if ProductCodes.FindFirst() then
                ProductRec := ProductCodes.Code;

            GuaranteeContract.Reset();
            GuaranteeContract.SetRange("Reference No.", "Reference No.");
            if GuaranteeContract.FindFirst() then
                Error('This batch is already imported');

            if LendersOptionSingleCGC.Get("Reference No.") then
                Error('This batch is already imported');



            LOBatch.Reset();
            LOBatch.SetRange(Code, rec."No.");
            if LOBatch.FindFirst() then begin

                GuaranteeMngt.CreateImportedContracts(LOBatch, SingleCertificate, LendersOptionSingleCGC, "Reference No.", "Guarantee Source", "Bank Branch Name", "Financial Institution Code", "Signatory 1 (CGC)", "Signatory 2 (CGC)", "Global Dimension 1 Code", ProductRec, ProductCodes.Type);


                IF SingleCertificate AND (LendersOptionSingleCGC."No. of Loans" > 0) THEN BEGIN

                    //Insert Lenders Option Single Credit Guarantee record for the imported loans

                    LendersOptionSingleCGC."Financial Institution Code" := "Financial Institution Code";
                    LendersOptionSingleCGC."Reference No." := "Reference No.";
                    LendersOptionSingleCGC."Reference Date" := "Reference Date";
                    LendersOptionSingleCGC.Description := Description;
                    LendersOptionSingleCGC."Global Dimension 1 Code" := "Global Dimension 1 Code";
                    LendersOptionSingleCGC.INSERT(TRUE);
                    "CGC Prepared" := true;
                    Modify();
                END;

                CurrPage.UPDATE(TRUE);
                //LOBatch.DELETEALL;
                MESSAGE('Process completed successfully');

            end;
        END ELSE
            MESSAGE('Cancelled');
    end;
}