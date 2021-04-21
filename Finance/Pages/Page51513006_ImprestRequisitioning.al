page 51513006 "Imprest Requisitioning"
{
    PageType = Card;
    Caption = 'Imprest Requisitioning';
    SourceTable = "Payments HeaderFin";
    DeleteAllowed = false;
    SourceTableView = WHERE("Payment Type" = CONST("Imprest Requisitioning"), Posted = CONST(false), Status = filter(<> Released));
    layout
    {
        area(Content)
        {
            group(Imprest)
            {
                field("No."; "No.")
                {

                }
                field(Date; Date)
                {

                }
                field("Cheque Date"; "Cheque Date")
                {

                }
                field("Account Type"; "Account Type")
                {
                    Editable = false;
                }
                field("Account No."; "Account No.")
                {
                    Editable = false;
                }
                field("Account Name"; "Account Name")
                {
                    Editable = false;
                }
                field(Payee; Payee)
                {

                }
                field(Cashier; Cashier)
                {

                }
                field(Posted; Posted)
                {
                    Editable = false;
                }
                field("Posted By"; "Posted By")
                {
                    Editable = false;

                }
                field(Status; Status)
                {
                    Editable = false;
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
                field("Imprest Deadline"; "Imprest Deadline")
                {

                }
                field(Currency; Currency)
                {

                }

            }
            group(MemoDetails)
            {
                Caption = 'Memo Reference Details';
                field("Memo Reference"; "Memo Reference")
                {
                    Caption = 'Travel Memo Number';
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
                    Editable = false;
                }
            }

            part(ImprestLines; "Imprest Lines")
            {
                SubPageLink = No = FIELD("No.");

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
                    var
                        ImprestLine: Record "Imprest Lines";
                    begin

                        ImprestLine.SETRANGE(ImprestLine.No, "No.");
                        IF NOT ImprestLine.FINDFIRST THEN
                            ERROR('Insert Line Entries before sending for approval');
                        IF ImprestLine.FIND('-') THEN BEGIN
                            REPEAT
                                ImprestLine.TESTFIELD(Description);
                            UNTIL ImprestLine.NEXT = 0;

                        END;

                        CALCFIELDS("Imprest Amount");
                        IF "Imprest Amount" = 0 THEN
                            ERROR('Amount Cannot be equal to Zero!');

                        TESTFIELD(Payee);
                        TESTFIELD("Global Dimension 1 Code");
                        TestField("Memo Reference");

                        if ApprovalsMgmtExt.CheckImprestApprovalWorkflowEnabled(Rec) then
                            ApprovalsMgmtExt.OnSendImprestforApproval(Rec);

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
                        ApprovalsMgmtExt.OnCancelImprestforApproval(Rec);

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
        ObjMemo: Record "Memo Request Header";
        ObjMemoLines: Record "Memo Request Lines";
        DocumentType: Option Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order"," ";
        WorkflowsEntriesBuffer: Record "Workflows Entries Buffer";
        ShortcutDimCode: array[8] of Code[20];


    trigger OnNewRecord(BelowxRec: Boolean)

    begin

        "Payment Type" := "Payment Type"::"Imprest Requisitioning";
        Cashier := USERID;
    end;

    trigger OnOpenPage()

    begin
        SetControlAppearance();

    end;

    trigger OnAfterGetRecord()

    begin
        ShowShortcutDimCode(ShortcutDimCode);
        SetControlAppearance;

    end;

    trigger OnAfterGetCurrRecord()
    begin
        if Status <> Status::Open then begin
            CurrPage.Editable := false;
            DataEditable := false;
        end;
    end;

    local procedure SetControlAppearance()

    begin
        OpenApprovalEntriesExistForCurrUser := ApprovalsMgmt.HasOpenApprovalEntriesForCurrentUser(RECORDID);
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        WorkflowWebhookMgt.GetCanRequestAndCanCancel(RecordId, CanRequestApprovalForFlow, CanCancelApprovalForRecord);

    end;

}