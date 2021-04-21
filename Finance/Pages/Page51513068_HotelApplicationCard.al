page 51513068 "Hotel Application Card"
{
    PageType = Card;
    SourceTable = "Hotel Request Header";
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Editable = EditableData;
                field("Request No"; "Request No")
                {
                    ApplicationArea = All;

                }
                field("Created Date"; "Created Date")
                {

                }
                field("Staff No."; "Staff No.")
                {

                }
                field("Staff Name"; "Staff Name")
                {

                }
                field("Memo Reference"; "Memo Reference")
                {

                }
                field("Travel Date"; "Travel Date")
                {

                }

                field(Department; Department)
                {

                }
                field(Destination; Destination)
                {

                }
                field("Check In Date"; "Check In Date")
                {

                }
                field("Number of Nights"; "Number of Nights")
                {

                }
                field("Check Out Date"; "Check Out Date")
                {

                }
                field("Room Type"; "Room Type")
                {

                }
                field("Prefered Hotel(1)"; "Prefered Hotel(1)")
                {

                }
                field("Prefered Hotel Name(1)"; "Prefered Hotel Name(1)")
                {

                }
                field("Prefered Hotel(2)"; "Prefered Hotel(2)")
                {

                }
                field("Prefered Hotel Name(2)"; "Prefered Hotel Name(2)")
                {

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
                        //TestField("Responsibility Center");
                        //TestField("Global Dimension 1 Code");
                        if ApprovalMgmt.CheckHotelReqApprovalWorkflowEnabled(Rec) then begin
                            ApprovalMgmt.OnSendHotelReqforApproval(Rec);
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
                        if ApprovalMgmt.CheckHotelReqApprovalWorkflowEnabled(Rec) then begin
                            ApprovalMgmt.OnCancelHotelReqforApproval(Rec);
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

        }
    }

    var
        ApprovalMgmt: Codeunit ApprovalMgtFM;
        EditableData: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
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


    end;
}