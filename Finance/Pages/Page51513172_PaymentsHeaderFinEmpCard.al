page 51513172 "Payments HeaderFin Employee"
{
    PageType = Card;
    Caption = 'Employee Payments';
    DeleteAllowed = false;
    SourceTable = "Payments HeaderFin";
    SourceTableView = WHERE ("Payment Type" = CONST ("Payment Voucher"), Posted = CONST (false), Status = FILTER (<> Released), "Transactions Source" = filter ("Employee Transactions"));
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.")
                {

                }
                field(Date; Date)
                {

                }
                field("Paying Bank Account"; "Paying Bank Account")
                {

                }
                field(Payee; Payee)
                {

                }
                field(Currency; Currency)
                {
                    AssistEdit = true;
                }
                field("Total Amount"; "Total Amount")
                {

                }
                field("Pay Mode"; "Pay Mode")
                {

                }
                field("On behalf of"; "On behalf of")
                {

                }
                field("Cheque No"; "Cheque No")
                {

                }
                field("Cheque Date"; "Cheque Date")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field(Posted; Posted)
                {

                }
                field(Status; Status)
                {

                }

            }

            part(Lines; "PV Lines1 Employee")
            {
                //Editable = DataEditable;
                SubPageLink = No = FIELD ("No.");
            }
        }

        area(Factboxes)
        {
            systempart(link; Links)
            {

            }
            systempart(note; Notes)
            {

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(mportFuel)
            {
                Caption = 'Import Fuel/Transport';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;
                RunObject = xmlport "Employee Transactions";

                trigger OnAction()

                begin

                end;

            }

            action(Post)
            {
                Caption = 'Post';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Post;

                trigger OnAction()

                begin
                    PaymentMngt.PostPaymentVoucher(Rec);
                end;

            }
            group("Request Approval")
            {
                Caption = 'Request Approval';
                action(CancelApprovalRequest)
                {
                    Caption = 'Cancel Approval Re&quest';
                    Visible = CanCancelApprovalForRecord or CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Cancel the approval request.';

                    trigger OnAction()

                    begin
                        ApprovalsMgmtExt.OnCancelPaymentforApproval(Rec);

                    end;
                }
                action(SendApprovalRequest)
                {
                    Caption = 'Send A&pproval Request';
                    Visible = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                    ApplicationArea = "#Basic,#Suite";
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()
                    var
                        PVLines: Record "PV Lines1";
                    begin

                        TESTFIELD("Pay Mode");
                        //TESTFIELD("Total Amount");
                        TESTFIELD("Global Dimension 1 Code");
                        IF "Pay Mode" = 'CHEQUE' THEN BEGIN
                            TESTFIELD("Cheque No");
                            TESTFIELD("Cheque Date");
                        END;

                        PVLines.RESET;
                        PVLines.SETRANGE(PVLines.No, "No.");
                        IF PVLines.FIND('-') THEN BEGIN
                            REPEAT
                                PVLines.TESTFIELD("Global Dimension 1 Code");
                                PVLines.TESTFIELD(Description);
                                //PVLines.TESTFIELD(Amount);
                                //PVLines.TESTFIELD("Account Type");
                                PVLines.TESTFIELD("Account No");
                            UNTIL PVLines.NEXT = 0;
                        END;
                        if "Bank Call-Up " then begin
                            TestField("Claim No.");
                            CalcFields("Total Approved Claim Amount", "Total Amount");

                            if "Total Approved Claim Amount" <> "Total Amount" then
                                Error('Total approved claim amount must be equal to total amount');
                        end;
                        if ApprovalsMgmtExt.CheckPaymentApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendPaymentforApproval(Rec);
                    end;
                }
            }
        }
    }



    var
        OpenApprovalEntriesExist: Boolean;
        CanRequestApprovalForFlow: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ApprovalsMgmtExt: Codeunit ApprovalMgtFM;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        PaymentMngt: Codeunit "Payment Management";
        claimPayment: Boolean;
        DataEditable: Boolean;

    trigger OnNewRecord(BelowxRec: Boolean)

    begin

        "Payment Type" := "Payment Type"::"Payment Voucher";
        "Transactions Source" := "Transactions Source"::"Employee Transactions";
        Cashier := USERID;
    end;


    trigger OnOpenPage()

    begin
        SetControlAppearance();
        Validate("Bank Call-Up ");
    end;

    trigger OnAfterGetRecord()

    begin
        SetControlAppearance;
        Validate("Bank Call-Up ");
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if Status <> Status::Open then begin
            CurrPage.Editable := false;
            DataEditable := false;
        end;

        if "Bank Call-Up " then
            claimPayment := true
        else
            claimPayment := false;

    end;

    local procedure SetControlAppearance()

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForRecord);

    end;
}



