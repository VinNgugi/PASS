page 51513954 "BM Activities"
{
    PageType = ListPart;
    Caption = 'BM Activities';
    SourceTable = "Credit Guarantee Cue";

    layout
    {
        area(Content)
        {

            cuegroup("Credit Guarantee Applications")
            {

                field(OpenGuaranteeApplications; OpenGuaranteeApplications)
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "Guarantee Application List";
                    ToolTip = 'Specifies the number of guarantee applications that are not yet send for approval.';

                }
                field(PendingGuaranteeApplications; PendingGuaranteeApplications)
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "Guarantee Application List";
                    ToolTip = 'Specifies the number of guarantee applications that are pending approval.';
                }
                field(PreAppraisalStage; PreAppraisalStage)
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "Application BDO Pre-Appraisal";
                    ToolTip = 'Specifies the number of guarantee applications under pre appraisal stage';
                }


                actions
                {
                    action(New)
                    {
                        Caption = 'New';
                        RunObject = page "Guarantee Application Card";
                        RunPageMode = Create;
                    }
                }
            }
            cuegroup("Contracts preparation & Signing")
            {
                field(ContractPreparationStage; ContractPreparationStage)
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "Contract Preparation";
                    ToolTip = 'Specifies the number of guarantee application contracts under preparation';
                }

                field(ContractSigningStage; ContractSigningStage)
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "Contract Signing";
                    ToolTip = 'Specifies the number of guarantee application contracts under signing stage';
                }
            }
            cuegroup("Ongoing Business Plans")
            {
                field(BusinessPlanStage; BusinessPlanStage)
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "Business Plan In Progress";
                    ToolTip = 'Specifies the number of business plans under preparation';
                }
                field(BPunderReview; BPunderReview)
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "Business Plan In Progress";
                    ToolTip = 'Specifies the number of business plans under review';
                }
                field(BPPendingQA; BPPendingQA)
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "Business Plan In Progress";
                    ToolTip = 'Specifies the number of business plans under quality assurance';
                }
                field(BPWithBank; BPWithBank)
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "Business Plan with Bank";
                    ToolTip = 'Specifies the number of business plans that are still with the banks';
                }


            }
            cuegroup("Ongoing & Issued CGCs")
            {

                field(CGCPrepared; CGCPrepared)
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "CGC Preparation";
                    ToolTip = 'Specifies the number of credit guarantee certificates under preparation';
                }
                field(IssuedCGC; IssuedCGC)
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "Guarantee Contracts";
                    ToolTip = 'Specifies the number of issued credit guarantee certificates';
                }
            }
            CueGroup(Approvals)
            {

                Field("Requests to Approve"; "Requests to Approve")
                {
                    ApplicationArea = "#Suite";
                    DrillDownPageId = "Requests to Approve";
                    ToolTip = 'Specifies the number of approval requests that require your approval.';
                }
                field("My Approval Requests"; "My Approval Requests")
                {
                    ApplicationArea = "#Suite";
                    DrillDownPageId = "Approval Entries";
                    ToolTip = 'Specifies the number of your approval requests pending approval.';

                }

            }
        }

    }

    trigger OnOpenPage()
    begin

        SETFILTER("User Filter", USERID);
        SETFILTER("Date Filter", FORMAT(WORKDATE));
        if not Get then begin
            Init();
            Insert();
        end;
    end;
}
