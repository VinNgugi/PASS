page 51513225 "Appraisal Form"
{
    PageType = Card;
    DeleteAllowed = false;
    SourceTable = "Employee Appraisals";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Appraisal No"; "Appraisal No")
                {
                    Editable = false;
                }
                field(Date; Date)
                {
                    Editable = false;
                }

                Field("Appraisal Period"; "Appraisal Period")
                {

                }

                Field("Employee No"; "Employee No")
                {
                    Editable = false;
                }
                Field("Appraisee Name"; "Appraisee Name")
                {
                    Editable = false;
                }
                Field("Appraisee's Job Title"; "Appraisee's Job Title")
                {
                    caption = 'Appraisees Job Title';
                    Editable = false;
                }

                Field("Job ID"; "Job ID")
                {
                    Caption = 'Appraisees Job ID';
                    Editable = false;
                }

                Field("Deapartment Code"; "Deapartment Code")
                {
                    Caption = 'Department Code';
                    Editable = false;
                }

                Field("Department Name"; "Department Name")
                {
                    Editable = false;
                }

                Field("Appraiser No"; "Appraiser No")
                {
                    Editable = false;
                }
                Field("Appraisers Name"; "Appraisers Name")
                {
                    Editable = false;
                }
            }
            part("Performance Rating Definitions"; "Performance Grade Definitions")
            {
                Caption = 'Performance Rating Definitions';
                Editable = false;

            }
            part("Financial Perspective Competencies"; "Financial Competencies")
            {
                Caption = 'Financial Perspective Competencies';
                SubPageLink = "Appraisal No" = field ("Appraisal No");
            }
            part("Stakeholder Perspective Competencies"; "Stakeholders Competencies")
            {
                Caption = 'Customer Perspective Competencies';
                SubPageLink = "Appraisal No" = field ("Appraisal No");
            }
            part("Internal Business Processs Competencies"; "IBP Competencies")
            {
                Caption = 'Internal Business Processs Competencies';
                SubPageLink = "Appraisal No" = field ("Appraisal No");
            }
            part("Learning & Growth Competencies"; "Learning & Growth Competencies")
            {
                SubPageLink = "Appraisal No" = field ("Appraisal No");
            }
            group("SCORE SUMMARY AND MITIGATING FACTORS (IF ANY)")
            {
                field("FP Weighting"; "FP Weighting")
                {
                    Caption = 'Financial Perspective Weighting';
                }
                field("FP  Weighted Ratings"; "FP  Weighted Ratings")
                {
                    Caption = 'Financial Perspective Weighted Rating';
                }
                field("Stakeholder Weighting"; "Stakeholder Weighting")
                {
                    Caption = 'Customer Perspective Weighting';
                }
                field("Stakeholder Weighted Ratings"; "Stakeholder Weighted Ratings")
                {
                    Caption = 'Customer Perspective Weighted Rating';
                }
                field("IBP Weighting"; "IBP Weighting")
                {

                }
                field("IBP Weighted Ratings"; "IBP Weighted Ratings")
                {

                }
                field("L&G Weighting"; "L&G Weighting")
                {
                    Caption = 'Learning & Growth Weighting';
                }
                field("L&G  Weighted Ratings"; "L&G  Weighted Ratings")
                {
                    Caption = 'Learning & Growth Weighted Rating';
                }
                field(OverallScore; OverallScore)
                {
                    Caption = 'Overall Rating(Weighing)';
                }
                field(OverallScore1; OverallScore1)
                {
                    Caption = 'Overall Rating(Weighted)';
                }
                field(Rating; Rating)
                {

                }
                field("Rating Description"; "Rating Description")
                {

                }
                field("General Comments"; "General Comments")
                {

                }

            }
            part("Development Plans"; "Appraisal Development Needs")
            {
                Caption = 'Development Plans';
                SubPageLink = "Appraisal No" = FIELD ("Appraisal No"), "Employee No." = FIELD ("Employee No");
            }
        }

    }

    actions
    {
        area(Processing)
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

                    trigger OnAction();
                    begin
                        IF ApprovalMgt.CheckAppraisalApprovalWorkflowEnabled(Rec) then
                            ApprovalMgt.OnSendAppraisalforApproval(Rec);
                    end;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                    Image = Cancel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction();
                    begin
                        ApprovalMgt.OnCancelAppraisalforApproval(Rec);
                    end;
                }
            }
        }
    }



    trigger OnAfterGetRecord()
    begin
        CalcFields("FP  Weighted Ratings", "FP Weighting", "IBP Weighted Ratings", "IBP Weighting", "Stakeholder Weighted Ratings", "Stakeholder Weighting", "L&G  Weighted Ratings", "L&G Weighting");
        OverallScore := "FP Weighting" + "Stakeholder Weighting" + "IBP Weighting" + "L&G Weighting";
        OverallScore1 := "FP  Weighted Ratings" + "Stakeholder Weighted Ratings" + "IBP Weighted Ratings" + "L&G  Weighted Ratings";
    end;

    var
        OverallScore: Decimal;
        OverallScore1: Decimal;
        ApprovalMgt: Codeunit "Approvals Mgmt. LV Ext";
}