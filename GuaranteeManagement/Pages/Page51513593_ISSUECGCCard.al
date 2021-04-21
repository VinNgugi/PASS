page 51513593 "Issue CGC Card"
{
    Caption = 'CGC Preparation Card';
    PageType = Card;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    SourceTable = "Guarantee Contracts";
    SourceTableView = sorting ("No.") where ("Contract Status" = FILTER ("CGC Prepared"));
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
                field(Bank; Bank)
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

            }
            group("Loan Details")
            {
                field("Type of Facility"; "Type of Facility")
                {

                }
                field(Product; Product)
                {

                }
                field("Loan No."; "Loan No.")
                {

                }
                field("Loan Amount"; "Loan Amount")
                {
                    Caption = 'Requested Loan Amount';
                    Editable = false;
                }
                field("Approved Loan Amount"; "Approved Loan Amount")
                {

                }
                field("Loan Issued Date"; "Loan Issued Date")
                {

                }
                field("Pct. Guarantee Approved"; "Pct. Guarantee Approved")
                {

                }

            }

            group("CGC Details")
            {
                field("CGC No."; "CGC No.")
                {

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
                RunPageLink = "Table ID" = CONST (51513000), "No." = FIELD ("No.");
            }
        }

        area(Processing)
        {

            action("Issue CGC")
            {
                Caption = 'Issue CGC';
                ApplicationArea = "#Basic,#Suite";
                Image = IssueFinanceCharge;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Issue Credit Guarantee Certificate';

                trigger OnAction()

                begin
                    if CONFIRM(CONF_ISSUE_CGC, FALSE, "No.", "CGC No.",
                                    CurrencyAmountText("Approved Loan Currency", "CGC Amount"),
                                    "CGC Date", "CGC Start Date", "Loan Maturity Date",
                                    "CGF %", "Risk Sharing Fee %", "Signatory 1 (CGC)",
                                    "Signatory 2 (CGC)") then begin
                        GuaranteeMngt.IssueCGC(Rec);
                        "Contract Status" := "Contract Status"::"CGC Issued";
                        "Previous Status" := "Contract Status";
                        Modify;
                    end;
                end;
            }
            action("Print CGC")
            {

                Image = PrintDocument;
                Promoted = true;
                PromotedCategory = Report;
                // ToolTip = 'Cancel the approval request.';

                trigger OnAction()

                begin
                    GuaranteeMngt.PrintCGC(Rec, true);

                end;
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
        CONF_ISSUE_CGC: TextConst ENU = 'Do you want to confirm certificate %2 of %3 for contract %1?\\Issue Date: %4\Start Date %5\Expiry Date %6\CGF Pct. %7\Commission Pct. %8\\Signatory 1: %9\Signatory 2: %10';

    trigger OnOpenPage()

    begin
        SetControlAppearance();
        Validate("Date of Birth");
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

    procedure CurrencyAmountText(CurrencyCode: Code[10]; Amount: Decimal): Text[30]
    begin
        IF (CurrencyCode <> '') THEN
            EXIT(STRSUBSTNO('%1 %2', CurrencyCode, Amount));
        EXIT(STRSUBSTNO('%1', Amount))
    end;

}






