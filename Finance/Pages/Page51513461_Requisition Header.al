page 51513461 "Requisition Header"
{
    PageType = Card;
    SourceTable = "Requisition Header";
    Caption = 'Requisition Header';
    SourceTableView = WHERE ("Requisition Type" = CONST ("Purchase Requisition"));

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
                field("Requisition Date"; "Requisition Date")
                {
                    //Editable = false;
                }
                field("Creation Time"; "Creation Time")
                {
                    Editable = false;
                }
                field("Purchase Name"; "Purchase Name")
                {

                }
                field("Purchase Description"; "Purchase Description")
                {
                    MultiLine = true;
                }
                field("Responsibility Center"; "Responsibility Center")
                {

                }
                field("Department Name"; "Department Name")
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
                    Visible = true;
                    CaptionClass = '1,2,3';
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (3), Blocked = const (false));

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
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (4), Blocked = const (false));

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
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (5), Blocked = const (false));

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
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (6), Blocked = const (false));

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
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (7), Blocked = const (false));

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
                    TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (8), Blocked = const (false));

                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                    end;
                }
                field(Status; Status)
                {

                }
                field("No of Approvals"; "No of Approvals")
                {
                    Editable = false;
                }
                field("Employee Code"; "Employee Code")
                {
                    Editable = false;
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                }
                field("Raised by"; "Raised by")
                {

                }
            }
            part(Lines; "Requisition Line")
            {
                SubPageLink = "Requisition No" = FIELD ("No.");
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
                        ApprovalsMgmtExt.OnCancelPurchaseReqforApproval(Rec);

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

                    begin
                        PurchaseReqLines.RESET;
                        PurchaseReqLines.SETRANGE(PurchaseReqLines."Requisition No", "No.");
                        IF PurchaseReqLines.FIND('-') THEN BEGIN
                            REPEAT

                                PurchaseReqLines.TESTFIELD(PurchaseReqLines.Type);
                                PurchaseReqLines.TESTFIELD(PurchaseReqLines.No);
                                PurchaseReqLines.TESTFIELD(PurchaseReqLines.Description);
                                PurchaseReqLines.TESTFIELD(PurchaseReqLines.Quantity);
                                // PurchaseReqLines.TESTFIELD(PurchaseReqLines."Unit Price");
                                PurchaseReqLines.TESTFIELD(PurchaseReqLines."Global Dimension 1 Code");
                                //PurchaseReqLines.TESTFIELD(PurchaseReqLines."Global Dimension 2 Code");
                            UNTIL PurchaseReqLines.NEXT = 0;
                            if ApprovalsMgmtExt.CheckPurchaseReqApprovalWorkflowEnabled(Rec) then
                                ApprovalsMgmtExt.OnSendPurchaseReqforApproval(Rec);
                        END;


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
        PurchaseReqLines: Record "Requisition Lines";
        ShortcutDimCode: array[8] of Code[20];



    trigger OnOpenPage()

    begin
        SetControlAppearance();

    end;

    trigger OnAfterGetRecord()

    begin
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