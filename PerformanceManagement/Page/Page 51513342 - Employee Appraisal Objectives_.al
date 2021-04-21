page 51513342 "Employee Appraisal Objectives_"
{
    // version HR

    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Employee Appraisal Objectives";

    layout
    {
        area(content)
        {
            group("Section 1: Personal Details")

            {

                Caption = 'Section 1: Personal Details';
                Editable = false;
                field("Objective No"; "Objective No")
                {
                }
                field(Date; Date)
                {
                    Editable = false;
                }
                field("Employee No"; "Employee No")
                {
                    Caption = 'Employee No(Appraisee)';
                }
                field("Appraisee Name"; "Appraisee Name")
                {
                }
                field("Appraisee ID"; "Appraisee ID")
                {
                }
                field("Job ID"; "Job ID")
                {
                    Caption = 'Appraisee Job ID';
                }
                field("Appraisee's Job Title"; "Appraisee's Job Title")
                {
                }
                field("Department Code"; "Department Code")
                {
                }
                field("Department Name"; "Department Name")
                {
                }

                field("Appraiser No"; "Appraiser No")
                {
                }
                field("Appraisers Name"; "Appraisers Name")
                {
                }
                field("Appraiser's Job Title"; "Appraiser's Job Title")
                {
                }
                field(Status; Status)
                {
                    Editable = true;
                }

            }
            field("Appraisal Period"; "Appraisal Period")
            {
                Editable = EditableData;
            }
            group("FINANCIAL (Key Result Areas)")
            {
                Caption = 'FINANCIAL (Key Result Areas)';
                part("Financial Objectives"; "Financial Objectives")
                {
                    Caption = 'Financial Objectives';
                    SubPageLink = "Appraisal No" = field ("Objective No");
                }
            }
            group("CUSTOMER PERSPECTIVE (Key Result Areas)")
            {

                part("Customer Perspective"; "Customer Perspective")
                {
                    Caption = 'Customer Perspective';
                    SubPageLink = "Appraisal No" = field ("Objective No");
                }
            }
            group("INTERNAL BUSINESS PROCESSES (Key Result Areas)")
            {
                Caption = 'INTERNAL BUSINESS PROCESSES (Key Result Areas)';
                part("Internal Business Process"; "Internal Business Process")
                {
                    //Caption = 'Objectives Behavioural';
                    SubPageLink = "Appraisal No" = field ("Objective No");
                }
            }
            group("LEARNING & GROWTH (Key Result Areas)")
            {

                Caption = 'LEARNING & GROWTH (Key Result Areas)';
                part("Learning & Growth"; "Learning & Growth")
                {
                    //Caption = 'Objectives Behavioural';
                    SubPageLink = "Appraisal No" = field ("Objective No");
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Appraisal Objective")
            {
                Caption = 'Appraisal Objective';
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = (NOT OpenApprovalEntriesExist) AND EnabledApprovalWorkflowsExist;
                    trigger OnAction();
                    begin
                        IF ApprovalMgt.CheckApprObjApprovalWorkflowEnabled(Rec) then
                            ApprovalMgt.OnSendApprObjforApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = CancelApprovalRequest;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Enabled = CanCancelApprovalForRecord;
                    trigger OnAction();
                    begin
                        TestField(Status, Status::"Pending Approval");
                        ApprovalMgt.OnCancelApprObjforApproval(Rec);
                    end;
                }
            }
        }
    }
    var
        ApprovalMgt: Codeunit "Approvals Mgmt. LV Ext";
        ApprovalsMgmt: Codeunit "Approvals Mgmt.";
        EditableData: Boolean;
        OpenApprovalEntriesExist: Boolean;
        CanCancelApprovalForRecord: Boolean;
        EnabledApprovalWorkflowsExist: Boolean;


    trigger OnAfterGetCurrRecord()



    begin
        EditableData := true;


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


    end;









}

