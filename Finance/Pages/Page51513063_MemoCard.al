page 51513063 "Memo Card"
{
    PageType = Card;
    SourceTable = "Memo Request Header";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Editable = EditableData;
                field("Request No."; "Request No.")
                {
                    ApplicationArea = All;

                }
                field("Creation Date"; "Creation Date")
                {

                }
                field("Creation Time"; "Creation Time")
                {

                }
                field("Trip Name"; "Trip Name")
                {

                }
                field("Trip Description"; "Trip Description")
                {
                    MultiLine = true;
                }
                field("Trip Type"; "Trip Type")
                {

                }
                field("Start Date"; "Start Date")
                {

                }
                field("End Date"; "End Date")
                {

                }
                /*field("DSA Option"; "DSA Option")
                {

                }*/
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
                field("Approval Status"; "Approval Status")
                {

                }
                field("Created By"; "Created By")
                {

                }

            }
            group(ForeignDestDetails)
            {
                Caption = 'Foreign Travel Details';
                Editable = EditableData;
                Visible = ForeignVisible;
                field("Travel Destination"; "Travel Destination")
                {

                }
                field("Rate Per Day"; "Rate Per Day")
                {

                }
                field("Currency Code"; "Currency Code")
                {

                }
            }
            part(MemoLines; "Memo Lines")
            {
                SubPageLink = "Header No." = field("Request No.");
                Caption = 'Employees Attached to Memo';
                Editable = EditableData;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Approvals)
            {
                Caption = 'Documents Approvals';
                action("Send Approval Request")
                {
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;

                    trigger OnAction()
                    var
                        myInt: Integer;
                    begin
                        TestField("Responsibility Center");
                        TestField("Global Dimension 1 Code");

                        /*if "DSA Option" = "DSA Option"::" " then
                            Error('Please specify the DSA Option');*/

                        ObjMemoLines.Reset();
                        ObjMemoLines.SetRange("Header No.", Rec."Request No.");
                        if not ObjMemoLines.FindFirst() then
                            Error('There are no lines to be approved.')
                        else
                            repeat
                                if ObjMemoLines."DSA Option" = ObjMemoLines."DSA Option"::" " then
                                    Error('Please specify the DSA Option');
                            until ObjMemoLines.next = 0;

                        if ApprovalMgmt.CheckTravelMemoReqApprovalWorkflowEnabled(Rec) then begin
                            ApprovalMgmt.OnSendTravelMemoReqforApproval(Rec);
                        end;
                    end;
                }
                action("Cancel Approval Requests")
                {
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
                        if ApprovalMgmt.CheckTravelMemoReqApprovalWorkflowEnabled(Rec) then begin
                            ApprovalMgmt.OnCancelTravelMemoReqforApproval(Rec);
                        end;
                    end;
                }
                action("Document Approval Entries")
                {
                    Image = Approvals;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    PromotedOnly = true;
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
        ApprovalMgmt: Codeunit ApprovalMgtFM;
        EditableData: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        ForeignVisible: Boolean;
        ObjMemoLines: Record "Memo Request Lines";
        ShortcutDimCode: array[8] of Code[20];


    trigger OnOpenPage()
    var
        myInt: Integer;
    begin

    end;

    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        EditableData := true;
        ForeignVisible := false;
        OpenApprovalEntriesExist := ApprovalsMgmt.HasOpenApprovalEntries(RECORDID);
        CanCancelApprovalForRecord := ApprovalsMgmt.CanCancelApprovalForRecord(RECORDID);
        EnabledApprovalWorkflowsExist := TRUE;

        IF "Approval Status" = "Approval Status"::Approved then begin
            OpenApprovalEntriesExist := FALSE;
            CanCancelApprovalForRecord := FALSE;
            EnabledApprovalWorkflowsExist := FALSE;
            EditableData := false;
        end;

        IF "Approval Status" = "Approval Status"::"Pending Approval" then begin
            CurrPage.Editable := false;
            EditableData := false;
        end;
        if "Trip Type" = "Trip Type"::Foreign then
            ForeignVisible := true;


    end;
}