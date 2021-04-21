page 51513009 "Imprest Surrender"
{
    PageType = Card;
    Caption = 'Imprest Retirement';
    SourceTable = "Payments HeaderFin";
    SourceTableView = WHERE("Surrender Type" = filter(Surrender), Surrendered = CONST(false), Status = filter(<> Released));
    layout
    {
        area(Content)
        {
            group(General)
            {
                Editable = DataEditable;
                field("No.";
                "No.")
                {

                }
                field("Imprest Surrender Date"; "Imprest Surrender Date")
                {

                }
                field("Surrender Imprest No"; "Surrender Imprest No")
                {

                }

                field(Cashier; Cashier)
                {

                }
                field(Posted; Posted)
                {

                }
                field(Status; Status)
                {

                }
                field("Paying Bank Account"; "Paying Bank Account")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field(ShortcutDimCode3; ShortcutDimCode[3])
                {
                    //Visible = false;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                    end;
                }
                field(ShortcutDimCode4; ShortcutDimCode[4])
                {
                    Visible = false;
                    CaptionClass = '1,2,4';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                    end;
                }
                field(ShortcutDimCode5; ShortcutDimCode[5])
                {
                    Visible = false;
                    CaptionClass = '1,2,5';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                    end;
                }
                field(ShortcutDimCode6; ShortcutDimCode[6])
                {
                    Visible = false;
                    CaptionClass = '1,2,6';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                    end;
                }
                field(ShortcutDimCode7; ShortcutDimCode[7])
                {
                    Visible = false;
                    CaptionClass = '1,2,7';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                    end;
                }
                field(ShortcutDimCode8; ShortcutDimCode[8])
                {
                    Visible = false;
                    CaptionClass = '1,2,8';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8), Blocked = const(false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field("Imprest Amount"; "Imprest Amount")
                {

                }
                field("Remaining Amount"; "Remaining Amount")
                {

                }
                field(Currency; Currency)
                {

                }
                field("Pay Mode"; "Pay Mode")
                {

                }
                /*field("Cheque No"; "Cheque No")
                {

                }
                field("Cheque Date"; "Cheque Date")
                {

                }*/
                field("Payment Type"; "Payment Type")
                {
                    Visible = false;
                }
            }
            group(MemoDetails)
            {
                Caption = 'Memo Reference Details';
                field("Memo Reference"; "Memo Reference")
                {
                    Caption = 'Memo Reference Number';
                    Editable = false;
                }
                field("Employee No"; "Employee No")
                {
                    Editable = false;
                }
                field("Imprest Rate"; "Imprest Rate")
                {
                    Editable = false;
                }
                field("No. of Days"; "No. of Days")
                {
                    Caption = 'Approved Days';
                    Editable = false;
                }
                field("Total Days Spent"; "Total Days Spent")
                {

                }
            }

            part(ImprestLine; "Surrender Lines")
            {
                Editable = DataEditable;
                SubPageLink = No = FIELD("No.");
            }
        }

        area(Factboxes)
        {
            systempart(Link; Links)
            {

            }
            systempart(Notes; Notes)
            {

            }
        }
    }

    actions
    {
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
                    PromotedCategory = Process;
                    ToolTip = 'Request approval of the document.';

                    trigger OnAction()

                    begin
                        //Validate("Surrender Imprest No");
                        TESTFIELD("Imprest Surrender Date");
                        TestField("Surrender Imprest No");

                        IF "Pay Mode" = 'CHEQUE' THEN begin
                            //TestField("Cheque Date");
                            //TestField("Cheque No");
                        END;

                        //********************Check for comments
                        ImprestLines.Reset();
                        ImprestLines.SetRange(No, "No.");
                        if ImprestLines.FindSet() then
                            repeat
                                if ImprestLines."Remaining Amount" < 0 then begin
                                    if ImprestLines."Reason for Overspending" = '' then
                                        Error('Please fill in the reason for overspending in line %1, transaction type %2', ImprestLines."Line No", ImprestLines."Transaction Type");
                                end;
                                if ImprestLines."Actual Spent" = 0 then
                                    Error('Please enter the actual spent amount');
                            until ImprestLines.Next() = 0;


                        if ApprovalsMgmtExt.CheckSurrenderApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendSurrenderforApproval(Rec);
                    end;
                }
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
                        ApprovalsMgmtExt.OnCancelSurrenderforApproval(Rec);

                    end;
                }
                action(Approvals)
                {
                    Caption = 'Approvals';
                    ApplicationArea = "#Basic,#Suite";
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    ToolTip = 'See document Approvers';

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        DocumentType := DocumentType::" ";
                        WorkflowsEntriesBuffer.RunWorkflowEntriesPage(RECORDID, DATABASE::"Payments HeaderFin", DocumentType, "No.");
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
        ApprovalsMgmtExt: Codeunit ApprovalMgtFM;
        OpenApprovalEntriesExistForCurrUser: Boolean;
        CanCancelApprovalForRecord: Boolean;
        WorkflowWebhookMgt: Codeunit "Workflow Webhook Management";
        DataEditable: Boolean;
        ImprestLines: Record "Imprest Lines";
        DocumentType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order"," ";
        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
        ShortcutDimCode: array[8] of Code[20];

    trigger OnOpenPage()

    begin
        SetControlAppearance();

    end;

    trigger OnNewRecord(BelowRec: Boolean)

    begin
        "Payment Type" := "Payment Type"::"Imprest Surrender";
        "Surrender Type" := "Surrender Type"::Surrender;
        Cashier := USERID;

    end;

    trigger OnAfterGetRecord()

    begin
        ShowShortcutDimCode(ShortcutDimCode);
        SetControlAppearance;

    end;


    trigger OnAfterGetCurrRecord()
    begin
        DataEditable := true;

        if Status <> Status::Open then begin
            CurrPage.Editable := false;
            DataEditable := false;
        end;
        SetControlAppearance;
    end;

    local procedure SetControlAppearance()

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForRecord);


    end;


}