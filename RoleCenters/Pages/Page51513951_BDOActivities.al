page 51513951 "BDO Activities"
{
    PageType = ListPart;
    Caption = 'BDO Activites';
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

            cuegroup("Contracts Preparation")
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
                    ToolTip = 'Contracts signing stage';
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