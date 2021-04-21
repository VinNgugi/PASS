page 51514000 "Claim Card"
{
    PageType = Card;
    SourceTable = Claim;
    Caption = 'Claim';
    SourceTableView = sorting("No.") where(Status = filter(<> Close));
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {
                    Caption = 'No.';
                }
                field("Claim Type"; "Claim Type")
                {
                    Caption = 'Claim Type';
                    Visible = false;
                }
                field("Document Date"; "Document Date")
                {
                    ShowCaption = true;
                }
                field("Claim Date"; "Claim Date")
                {
                    Caption = 'Claim Date';
                    ShowMandatory = true;
                }
                field("Customer No."; "Customer No.")
                {
                    Caption = 'Claiming Bank';
                    ShowMandatory = true;
                }
                field("Customer Name"; "Customer Name")
                {
                    Caption = 'Claiming Bank Name';
                    Editable = false;
                }
                field("Claiming Bank Amount"; "Claiming Bank Amount")
                {
                    ShowMandatory = true;
                }
                field("Claiming Bank Amount(LCY)"; "Claiming Bank Amount(LCY)")
                {

                }
                field("Currency Code"; "Currency Code")
                {
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    var
                        myInt: Integer;
                    begin
                        ChangeExchangeRate.SetParameter("Currency Code", "Currency Factor", "Document Date");
                        IF ChangeExchangeRate.RUNMODAL = ACTION::OK THEN
                            VALIDATE("Currency Factor", ChangeExchangeRate.GetParameter);

                        CLEAR(ChangeExchangeRate);
                    end;
                }
                field("Reference No."; "Reference No.")
                {
                    ShowMandatory = true;
                }
                field("SalesPerson Code"; "SalesPerson Code")
                {
                    Caption = 'BDO/BM';
                }
                field(Status; Status)
                {
                    Caption = 'Status';
                }
                field("Approval Status"; "Approval Status")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Total No. of Clients"; "Total No. of Clients")
                {

                }
                field("Approved Clients"; "Approved Clients")
                {

                }
                field("Total Amount"; "Total Amount")
                {

                }
                field("Total Approved Claim Amount"; "Total Approved Claim Amount")
                {

                }
                field(Description; Description)
                {
                    Caption = 'Claim Description';
                    MultiLine = true;
                    ShowMandatory = true;
                }
            }
            part("Claim Lines"; "Guarantee Claim Lines")
            {
                Caption = 'Open Claims';
                SubPageLink = "Claim No." = field("No.");
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

        area(Processing)
        {
            action("Send Approval Request")
            {
                Caption = 'Send for Approval';
                Image = SendApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;

                trigger OnAction()
                begin
                    TestField("Claiming Bank Amount");
                    TestField("Claiming Bank Amount");
                    TestField("Claim Date");
                    TestField("Global Dimension 1 Code");
                    CalcFields("Total Approved Claim Amount", "Approved Clients");

                    if Approvals.CheckClaimRecWorkflowEnabled(rec) then
                        Approvals.OnSendClaimRecForApproval(rec);

                end;
            }
            action("Cancel Approval Request")
            {
                Caption = 'Cancel Approval Request';
                Image = CancelApprovalRequest;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = CanCancelApprovalForRecord;

                trigger OnAction()

                begin
                    TestField("Approval Status", "Approval Status"::"Pending Approval");
                    if Approvals.CheckClaimRecWorkflowEnabled(rec) then
                        Approvals.OnCancelClaimRecApprovalRequest(rec);

                end;
            }
            action("Import Claim Lines")
            {
                Caption = 'Import Claim Lines';
                Image = ImportDatabase;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = xmlport "Import Claim Lines";

                trigger OnAction()

                begin

                end;
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
        ClaimDescription: Text;
        ChangeExchangeRate: Page "Change Exchange Rate";
        EditableData: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Approvals: Codeunit "Approvals Mgmt. Claim Ext";


    trigger OnNewRecord(BelowRec: Boolean)

    begin
        "Document Date" := WorkDate();
    end;

    trigger OnAfterGetRecord()

    begin


    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        ClaimDescription := GetClaimDescription();
        EditableData := true;

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := TRUE;
        IF "Approval Status" = "Approval Status"::Released then begin
            OpenApprovalEntriesExist := FALSE;
            CanCancelApprovalForRecord := FALSE;
            EnabledApprovalWorkflowsExist := FALSE;
            EditableData := false;
        end;

        if "Approval Status" <> "Approval Status"::Open then begin
            CurrPage.Editable := false;
            EditableData := false;
        end;
    end;
}