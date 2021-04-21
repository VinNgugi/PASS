codeunit 51513910 "Approvals Portal"
{
    trigger OnRun()
    begin

    end;

    procedure Sendapproval(EntryNo: Code[20]) Response: Boolean;
    var
        VarVariant: Variant;
    begin
        Response := false;
        if approvalEntry.GET(EntryNo) then;
        VarVariant := approvalEntry;
        approvalEntry.VALIDATE(Status, approvalEntry.Status::Approved);
        approvalEntry.MODIFY(true);

    end;

    procedure Sendreject(EntryNo: Code[20]) Response: Boolean;
    var
        VarVariant: Variant;
    begin
        Response := false;
        if approvalEntry.GET(EntryNo) then;
        VarVariant := approvalEntry;
        approvalEntry.VALIDATE(Status, approvalEntry.Status::Rejected);
        approvalEntry.MODIFY(true);

    end;

    procedure ApproveDocument(AppEntry: Record "Approval Entry") Response: Boolean;
    var
        EntryNo: Code[10];
    begin
        Response := false;
        Approvals.ApproveApprovalRequests(AppEntry);
        Response := true;
    end;

    procedure ApproveEntry(EntryNo: Integer) Response: Boolean;
    var
        AppEntry: Record "Approval Entry";
        Variantt: Variant;
    begin
        Response := false;
        AppEntry.RESET;
        AppEntry.SETFILTER("Entry No.", FORMAT(EntryNo));
        Approvals.ApproveApprovalRequests(AppEntry);
        Response := true;
    end;

    procedure RejectEntry(EntryNo: Integer) Response: Boolean;
    var
        AppEntry: Record "Approval Entry";
        Variantt: Variant;
    begin
        Response := false;
        AppEntry.RESET;
        AppEntry.SETFILTER("Entry No.", FORMAT(EntryNo));
        Approvals.RejectApprovalRequests(AppEntry);
        Response := true;
    end;

    procedure SendApprovalRequests(ApplicationCode: Code[20]; RequestType: Option Leave,Recruitment,Loan,Benefit,"Leave Recall","NOK Update",Imprest,"Imprest Surrender","Purchase Req","Travel Memo","Hotel Request","Performance Appraisal") Response: Boolean;
    var
        VariantRec: Variant;
        RecruitmentNeeds: Record "Recruitment Needs";
        LeaveApp: Record "Employee Leave Application";
        LeaveRecall: Record "Leave Recall";
        UserSetup: Record "User Setup";
        Inserted: Integer;
        Updated: Integer;
        Deleted: Integer;
        LVApproval: Codeunit "Approvals Mgmt. LV Ext";
        PaymentHeader: Record "Payments HeaderFin";
        ApprovalMgtFM: Codeunit ApprovalMgtFM;
        ApprovalMgt: Codeunit "Approvals Mgmt. LV Ext";
        ReqHeader: Record "Requisition Header";
        ObjTrvMemo: Record "Memo Request Header";
        ObjHotelReq: Record "Hotel Request Header";
        EmpAppraisal: Record "Employee Appraisals";

    begin
        Response := false;
        case RequestType of
            RequestType::Leave:
                begin
                    if LeaveApp.GET(ApplicationCode) then begin
                        if LeaveApp.Status <> LeaveApp.Status::Open then
                            ERROR('Only documents with status open can be sent for approval');

                        VariantRec := LeaveApp;
                        if LVApproval.CheckLeaveApplicationApprovalWorkflowEnabled(VariantRec) then begin
                            LVApproval.OnSendLeaveApplicationforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;
            RequestType::Recruitment:
                begin

                end;



            RequestType::"Leave Recall":
                begin
                    if LeaveRecall.GET(ApplicationCode) then begin
                        if LeaveRecall.Status <> LeaveRecall.Status::Open then
                            ERROR('Only documents with status open can be sent for approval');

                        VariantRec := LeaveRecall;
                        if LVApproval.CheckLeaveRecallWorkflowEnabled(VariantRec) then begin
                            LVApproval.OnSendLeaveRecallForApproval(VariantRec);
                            Response := true;
                        end;
                        //**********************User Validation
                        /*UserSetup.RESET;
                        UserSetup.SETRANGE("Employee No.", LeaveRecall."Employee No");
                        if UserSetup.FIND('-') then begin
                            if UserSetup."User ID" = LeaveRecall."Recaller User Name" then begin

                                VariantRec := LeaveRecall;
                                if LVApproval.CheckLeaveRecallWorkflowEnabled(VariantRec) then begin
                                    LVApproval.OnSendLeaveRecallForApproval(VariantRec);
                                    Response := true;
                                end;
                            end
                            else begin
                                if UserSetup."Immediate Supervisor" = LeaveRecall."Recaller User Name" then begin

                                    //*************Approve and post******
                                    LeaveRecall.Status := LeaveRecall.Status::Released;
                                    LeaveRecall.MODIFY;

                                    LeaveRecall.VALIDATE(Status);
                                    Response := true;
                                end
                                else
                                    ERROR('You are not %1 Supervisor hence cannot recall the leave application', LeaveRecall."Employee Name");
                            end;
                        end;*/
                    end;
                end;
            RequestType::Imprest:
                begin
                    if PaymentHeader.GET(ApplicationCode) then begin
                        if PaymentHeader.Status <> PaymentHeader.Status::Open then
                            ERROR('Only documents with status open can be sent for approval');

                        VariantRec := PaymentHeader;
                        if ApprovalMgtFM.CheckImprestApprovalWorkflowEnabled(VariantRec) then begin
                            ApprovalMgtFM.OnSendImprestforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;
            RequestType::"Imprest Surrender":
                begin
                    if PaymentHeader.GET(ApplicationCode) then begin
                        if PaymentHeader.Status <> PaymentHeader.Status::Open then
                            ERROR('Only documents with status open can be sent for approval');

                        VariantRec := PaymentHeader;
                        if ApprovalMgtFM.CheckSurrenderApprovalWorkflowEnabled(VariantRec) then begin
                            ApprovalMgtFM.OnSendSurrenderforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;
            RequestType::"Purchase Req":
                begin
                    if ReqHeader.GET(ApplicationCode) then begin
                        if ReqHeader.Status <> ReqHeader.Status::Open then
                            ERROR('Only documents with status open can be sent for approval');

                        VariantRec := ReqHeader;
                        if ApprovalMgtFM.CheckPurchaseReqApprovalWorkflowEnabled(VariantRec) then begin
                            ApprovalMgtFM.OnSendPurchaseReqforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;
            RequestType::"Travel Memo":
                begin
                    if ObjTrvMemo.GET(ApplicationCode) then begin
                        if ObjTrvMemo."Approval Status" <> ObjTrvMemo."Approval Status"::New then
                            ERROR('Only documents with status open can be sent for approval');

                        VariantRec := ObjTrvMemo;
                        if ApprovalMgtFM.CheckTravelMemoReqApprovalWorkflowEnabled(VariantRec) then begin
                            ApprovalMgtFM.OnSendTravelMemoReqforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;
            RequestType::"Hotel Request":
                begin
                    if ObjHotelReq.GET(ApplicationCode) then begin
                        if ObjHotelReq."Approval Status" <> ObjHotelReq."Approval Status"::New then
                            ERROR('Only documents with status open can be sent for approval');

                        VariantRec := ObjHotelReq;
                        if ApprovalMgtFM.CheckHotelReqApprovalWorkflowEnabled(VariantRec) then begin
                            ApprovalMgtFM.OnSendHotelReqforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;
            RequestType::"Performance Appraisal":
                begin
                    if EmpAppraisal.GET(ApplicationCode) then begin
                        if EmpAppraisal.Status <> EmpAppraisal.Status::Open then
                            ERROR('Only documents with status open can be sent for approval');

                        VariantRec := EmpAppraisal;
                        IF ApprovalMgt.CheckAppraisalApprovalWorkflowEnabled(VariantRec) then
                            ApprovalMgt.OnSendAppraisalforApproval(VariantRec);
                        Response := true;
                    end;
                end;
        end;
    end;


    procedure CancelApprovalRequests(ApplicationCode: Code[20]; RequestType: Option Leave,Recruitment,Loan,Benefit,"Leave Recall","NOK Update",Imprest,"Imprest Surrender","Purchase Req","Travel Memo","Hotel Request","Performance Appraisal") Response: Boolean;
    var
        VariantRec: Variant;
        RecruitmentNeeds: Record "Recruitment Needs";
        LeaveApp: Record "Employee Leave Application";
        LeaveRecall: Record "Leave Recall";
        LVApproval: Codeunit "Approvals Mgmt. LV Ext";
        PaymentHeader: Record "Payments HeaderFin";
        ApprovalMgtFM: Codeunit ApprovalMgtFM;
        ApprovalMgt: Codeunit "Approvals Mgmt. LV Ext";
        ReqHeader: Record "Requisition Header";
        ObjTrvMemo: Record "Memo Request Header";
        ObjHotelReq: Record "Hotel Request Header";
        EmpAppraisal: Record "Employee Appraisals";
    begin
        Response := false;

        case RequestType of
            RequestType::Leave:
                begin
                    if LeaveApp.GET(ApplicationCode) then begin
                        if LeaveApp.Status <> LeaveApp.Status::"Pending Approval" then
                            ERROR('Only documents with status Pending Approval can be cancelled');

                        VariantRec := LeaveApp;
                        if LVApproval.CheckLeaveApplicationApprovalWorkflowEnabled(VariantRec) then begin
                            LVApproval.OnCancelLeaveApplicationforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;
            RequestType::Recruitment:
                begin

                end;
            RequestType::Loan:
                begin

                end;
            RequestType::Benefit:
                begin

                end;
            RequestType::"Leave Recall":
                begin

                end;
            RequestType::"NOK Update":
                begin

                end;
            RequestType::Imprest:
                begin
                    if PaymentHeader.GET(ApplicationCode) then begin
                        if PaymentHeader.Status <> PaymentHeader.Status::"Pending Approval" then
                            ERROR('Only documents with status Pending Approval can be cancelled');

                        VariantRec := PaymentHeader;
                        if ApprovalMgtFM.CheckImprestApprovalWorkflowEnabled(VariantRec) then begin
                            ApprovalMgtFM.OnCancelImprestforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;

            RequestType::"Imprest Surrender":
                begin
                    if PaymentHeader.GET(ApplicationCode) then begin
                        if PaymentHeader.Status <> PaymentHeader.Status::"Pending Approval" then
                            ERROR('Only documents with status Pending Approval can be cancelled');

                        VariantRec := PaymentHeader;
                        if ApprovalMgtFM.CheckSurrenderApprovalWorkflowEnabled(VariantRec) then begin
                            ApprovalMgtFM.OnCancelSurrenderforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;

            RequestType::"Purchase Req":
                begin
                    if ReqHeader.GET(ApplicationCode) then begin
                        if ReqHeader.Status <> ReqHeader.Status::"Pending Approval" then
                            ERROR('Only documents with status Pending Approval can be cancelled');

                        VariantRec := ReqHeader;
                        if ApprovalMgtFM.CheckPurchaseReqApprovalWorkflowEnabled(VariantRec) then begin
                            ApprovalMgtFM.OnCancelPurchaseReqforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;
            RequestType::"Travel Memo":
                begin
                    if ObjTrvMemo.GET(ApplicationCode) then begin
                        if ObjTrvMemo."Approval Status" <> ObjTrvMemo."Approval Status"::"Pending Approval" then
                            ERROR('Only documents with status Pending Approval can be cancelled');

                        VariantRec := ObjTrvMemo;
                        if ApprovalMgtFM.CheckTravelMemoReqApprovalWorkflowEnabled(VariantRec) then begin
                            ApprovalMgtFM.OnCancelTravelMemoReqforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;
            RequestType::"Hotel Request":
                begin
                    if ObjHotelReq.GET(ApplicationCode) then begin
                        if ObjHotelReq."Approval Status" <> ObjHotelReq."Approval Status"::"Pending Approval" then
                            ERROR('Only documents with status Pending Approval can be cancelled');

                        VariantRec := ObjHotelReq;
                        if ApprovalMgtFM.CheckHotelReqApprovalWorkflowEnabled(VariantRec) then begin
                            ApprovalMgtFM.OnCancelHotelReqforApproval(VariantRec);
                            Response := true;
                        end;
                    end;
                end;
            RequestType::"Performance Appraisal":
                begin
                    if EmpAppraisal.GET(ApplicationCode) then begin
                        if EmpAppraisal.Status <> EmpAppraisal.Status::"Pending Approval" then
                            ERROR('Only documents with status Pending Approval can be cancelled');

                        VariantRec := EmpAppraisal;
                        IF ApprovalMgt.CheckAppraisalApprovalWorkflowEnabled(VariantRec) then
                            ApprovalMgt.OnCancelAppraisalforApproval(VariantRec);
                    end;
                end;
        end;
    end;

    var
        UserSetup: Record "User Setup";
        Reqheader: Record "Bracket Tables";
        Approvals: Codeunit "Approvals Mgmt.";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        Addr: array[10, 100] of Text[250];
        leaveApplication: Record "Employee Leave Application";
        approvalEntry: Record "Approval Entry";
        RecruitmentNeeds: Record "Recruitment Needs";
        Emp: Record Employee;
        LeaveBuffer: Record "Leave Balance Buffer";
        LeSetup: Record "Additional Leave Set-Up";
}