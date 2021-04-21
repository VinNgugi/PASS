page 51513606 Investment
{
    PageType = Card;

    SourceTable = "Investment Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = EditableData;
                field("No."; "No.")
                {

                }
                field(Description; Description)
                {

                }
                field("Document Date"; "Document Date")
                {

                }
                field("Investment Start Date"; "Investment Start Date")
                {

                }
                field("Investment Duration"; "Investment Duration")
                {

                }
                field("Investment End Date"; "Investment End Date")
                {

                }
                field("Investment Type"; "Investment Type")
                {

                }
                field("Withholding Tax Rate"; "Withholding Tax Rate")
                {

                }
                field("Investment Rate"; "Investment Rate")
                {

                }
                field("Interest Calculation Method"; "Interest Calculation Method")
                {

                }
                field("Investment Withholding Tax"; "Investment Withholding Tax")
                {

                }
                field("Investment Principal"; "Investment Principal")
                {

                }
                field("Investment Principle(LCY)"; "Investment Principle(LCY)")
                {

                }
                field("Interest Earned"; "Interest Earned")
                {

                }
                field("Last Interest Date"; "Last Interest Date")
                {

                }
                field(Status; Status)
                {

                }
                field("FD Status"; "FD Status")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field(Closed; Closed)
                {

                }
            }
            group("Source Details")
            {
                Editable = EditableData;
                field("Source Bank"; "Source Bank")
                {

                }
                field("Source Bank Name"; "Source Bank Name")
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
                field("Maturity Instructions"; "Maturity Instructions")
                {

                }

            }
            group("Destination Details")
            {
                Editable = EditableData;

                field("Destination Bank Account"; "Destination Bank Account")
                {

                }
                field("Destination Bank Acc Name"; "Destination Bank Acc Name")
                {

                }
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
                    TestField("Destination Bank Account");
                    TestField("Source Bank");
                    if Approvals.CheckInvestmentAppWorkflowEnabled(rec) then
                        Approvals.OnSendInvestmentAppForApproval(rec);

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
                var
                    myInt: Integer;
                begin
                    TestField(Status, Status::"Pending Approval");
                    if Approvals.CheckInvestmentAppWorkflowEnabled(rec) then
                        Approvals.OnCancelInvestmentAppApprovalRequest(rec);

                end;
            }
            action("Post Investment")
            {
                Caption = 'Post Investment';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = PostEnabled AND (not Posted);

                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    InvMgmt.FnPostFixedDeposits(Rec);
                end;
            }
            action("Close Investment")
            {
                Caption = 'Close Investment';
                Image = Close;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Enabled = posted and (not Closed);

                trigger OnAction()
                var
                    InvMgmt: Codeunit "Investment Management";
                begin
                    InvMgmt.FnMaturityInstructionsTrigger(Rec);
                end;
            }
        }
    }

    var
        EditableData: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ChangeExchangeRate: Page "Change Exchange Rate";
        Approvals: Codeunit "Approvals Mgmt. Inv Ext";
        PostEnabled: Boolean;
        InvMgmt: Codeunit "Investment Management";

    trigger OnAfterGetCurrRecord()
    var


    begin
        EditableData := true;
        PostEnabled := false;

        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := TRUE;
        IF Status = Status::Released then begin
            OpenApprovalEntriesExist := FALSE;
            CanCancelApprovalForRecord := FALSE;
            EnabledApprovalWorkflowsExist := FALSE;
            EditableData := false;
        end;

        if Status <> Status::Open then begin
            CurrPage.Editable := false;
            EditableData := false;
        end;
        if Status = Status::Released then
            PostEnabled := true;

    end;
}