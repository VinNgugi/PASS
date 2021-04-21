page 51513591 "CGC Preparation Card"
{
    Caption = 'CGC Preparation Card';
    PageType = Card;
    InsertAllowed = false;
    DeleteAllowed = false;
    SourceTable = "Guarantee Contracts";
    SourceTableView = sorting("No.") where("Contract Status" = FILTER("Loan Granted"));
    PromotedActionCategories = 'New,Process,Report,New Document,Approve,Request Approval,Navigate,Applicant';
    layout
    {
        area(Content)
        {
            group(General)
            {

                field("No."; "No.")
                {
                    Editable = false;
                }
                field("Application Date"; "Application Date")
                {
                    Editable = false;

                }
                field(Name; Name)
                {
                    Editable = false;
                }

                field(Address; Address)
                {
                    Editable = false;
                }
                field(City; City)
                {
                    Editable = false;
                }
                field(Gender; Gender)
                {
                    Editable = false;
                }
                field("Phone No."; "Phone No.")
                {
                    Editable = false;
                }

                field("E-Mail"; "E-Mail")
                {
                    Editable = false;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    Editable = false;
                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Global Dimension 3 Code"; "Global Dimension 3 Code")
                {
                    Visible = false;
                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
                {
                    Visible = false;
                }
                field("Receivables Acc. No."; "Receivables Acc. No.")
                {
                    Editable = false;
                }
                field("Bank Branch"; "Bank Branch")
                {
                    Editable = false;
                }
                field("Submit to Bank Date"; "Submit to Bank Date")
                {
                    Editable = false;
                }
                field("Pct. Guarantee Applied"; "Pct. Guarantee Applied")
                {
                    Editable = false;
                }
                field("Contract Status"; "Contract Status")
                {
                    Editable = false;
                }
                field("Linkage fee Invoiced"; "Linkage fee Invoiced")
                {
                    Editable = false;
                }
                field("Linkage fee Invoice Amount"; "Linkage fee Invoice Amount")
                {
                    Editable = false;
                }
                field("Linkage fee Paid"; "Linkage fee Paid")
                {
                    Editable = false;
                }

            }
            group("Loan Details")
            {
                Editable = DataEditable;
                field("Type of Facility"; "Type of Facility")
                {
                    Editable = false;
                }
                field(Product; Product)
                {
                    Editable = false;
                }
                field("Loan No."; "Loan No.")
                {
                    // Editable = false;
                }
                field("Loan Amount"; "Loan Amount")
                {
                    Caption = 'Requested Loan Amount';
                    Editable = false;
                }
                field("Approved Loan Amount"; "Approved Loan Amount")
                {
                    Editable = false;
                }
                field("Loan Issued Date"; "Loan Issued Date")
                {
                    //Editable = false;
                }
                field("Pct. Guarantee Approved"; "Pct. Guarantee Approved")
                {
                    Editable = false;
                }

            }

            group("CGC Details")
            {
                field("Guarantee Source"; "Guarantee Source")
                {

                }
                field("CGC No."; "CGC No.")
                {
                    Editable = false;
                }
                field("CGC Amount"; "CGC Amount")
                {

                }
                field("CGC Date"; "CGC Date")
                {

                }
                field("CGC Seq.No."; "CGC Seq.No.")
                {

                }
                field("CGC Start Date"; "CGC Start Date")
                {

                }
                fielD("Loan Maturity Date"; "Loan Maturity Date")
                {

                }
                field("CGF %"; "CGF %")
                {
                    Editable = false;
                }
                field("SIDA Guarantee Amount"; "SIDA Guarantee Amount")
                {
                    Editable = false;
                }
                field("PASS Guarantee Amount"; "PASS Guarantee Amount")
                {
                    Editable = false;
                }
                field("IFC Guarantee Amount"; "IFC Guarantee Amount")
                {
                    Editable = false;
                }
                field("Risk Sharing Fee %"; "Risk Sharing Fee %")
                {

                }
                field("Signatory 1 (CGC)"; "Signatory 1 (CGC)")
                {

                }
                field("Signatory 2 (CGC)"; "Signatory 2 (CGC)")
                {

                }

            }
            part(Subsctor; "Subsector & Line of Business")
            {
                Caption = 'Subsector & Line of Business';
                SubPageLink = "Client No." = field("No.");
            }

        }
        area(FactBoxes)
        {
            systempart(Notes; Notes)
            {

            }
            systempart(Links; Links)
            {

            }
        }
    }
    actions
    {
        area(Navigation)
        {
            action(Dimensions)
            {
                Caption = 'Dimensions';
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortcutKey = 'Shift+Ctrl+D';
                RunObject = page "Default Dimensions";
                RunPageLink = "Table ID" = CONST(51513000), "No." = FIELD("No.");
            }
        }

        area(Processing)
        {
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Visible = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()

                    begin
                        GetLinkageInv;
                        GuaranteeMngt.PrepareCGC(Rec);
                        "Previous Status" := "Contract Status";
                        if ApprovalsMgmtExt.CheckCGCApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendCGCforApproval(Rec);
                    end;
                }
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Visible = CanCancelApprovalForRecord or CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Category6;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()

                    begin
                        ApprovalsMgmtExt.OnCancelCGCforApproval(Rec);

                    end;
                }
                action("Undo Prepare CGC")
                {

                    Image = Undo;
                    Promoted = true;
                    PromotedCategory = Report;
                    // ToolTip = 'Cancel the approval request.';

                    trigger OnAction()

                    begin
                        TestField(Status, Status::Open);
                        Testfield("Product Type", "Product Type"::Traditional);
                        IF CONFIRM('Are you sure you want to take %1 to previous status', FALSE, "No.") THEN
                            "Contract Status" := "Contract Status"::"BP with Bank";
                        Modify;

                    end;
                }
                action("Fee Waiver Aapplication")
                {

                    Caption = 'Fee Waiver Aapplication';
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Category4;
                    RunObject = page "Fee Waiver Application";
                    RunPageLink = "Client No." = field("No.");
                }

                action("Preview CGC")
                {

                    Image = PreviewChecks;
                    Promoted = true;
                    PromotedCategory = Report;
                    // ToolTip = 'Cancel the approval request.';

                    trigger OnAction()

                    begin
                        if "Contract Status" = "Contract Status"::"CGC Issued" then begin
                            if "Product Type" = "Product Type"::"Lenders Option" then
                                Validate("Receivables Acc. No.");
                            GuaranteeMngt.PrintCGC(Rec, false);
                        end else
                            Error('You can only Print Certificates for Applications with status %1', "Contract Status"::"CGC Issued");


                    end;
                }
            }
            group(AttachmentstoEDMS)
            {
                action("Attach Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Add a file as an attachment to EDMS. You can attach images as well as documents.';
                    Image = Attach;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                    begin
                        OnAttachDocuments(Rec);
                    end;
                }
                action("View Attached Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'View attached files in EDMS.';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var

                    begin
                        OnViewAttachedDocuments(Rec);
                    end;
                }
            }
        }
    }
    var
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmtExt: Codeunit "Approval Management";
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        GuaranteeMngt: Codeunit "Guarantee Management";
        DataEditable: Boolean;
        ProductType: Record Products;

    trigger OnOpenPage()

    begin
        SetControlAppearance();
        Validate("Date of Birth");
        GetLinkageInv();

    end;

    trigger OnAfterGetCurrRecord()
    begin
        if ProductType.Get(Product) then begin
            if ProductType.Type = ProductType.Type::"Lenders Option" then
                DataEditable := true
            else
                DataEditable := false;
        end;
    end;


    trigger OnAfterGetRecord()

    begin
        SetControlAppearance;
        Validate("Date of Birth");
    end;

    local procedure SetControlAppearance()

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForRecord);

    end;

    var
        ChangeExchangeRate: Page "Change Exchange Rate";



    procedure GetLinkageInv()
    var
        Appfeeinv: Record "Sales Invoice Header";
        AppfeeInvLines: Record "Sales Invoice Line";
    begin
        if "Linkage fee Invoice Amount" = 0 then begin
            Appfeeinv.Reset;
            Appfeeinv.SetRange("Guarantee Application No.", "No.");
            Appfeeinv.SetRange("Guarantee Entry Type", Appfeeinv."Guarantee Entry Type"::"Linkage Banking");
            if Appfeeinv.FindFirst then begin
                AppfeeInvLines.Reset();
                AppfeeInvLines.SetRange("Document No.", Appfeeinv."No.");
                if AppfeeInvLines.FindFirst then begin
                    "Linkage fee Invoice Amount" := AppfeeInvLines."Amount Including VAT";
                    Modify();
                end;
            end;
        end;
    end;


}






