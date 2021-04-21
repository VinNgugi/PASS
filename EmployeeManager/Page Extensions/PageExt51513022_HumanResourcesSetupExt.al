pageextension 51513022 "Human Resource Setup Ext_1" extends "Human Resources Setup"
{
    layout
    {
        addafter(Numbering)
        {
            group("Leave Details")
            {
                field("Leave Application Nos."; "Leave Application Nos.")
                {

                }
                field("Base Calender Code"; "Base Calender Code")
                {

                }
                field("Leave Template"; "Leave Template")
                {

                }
                field("Leave Batch"; "Leave Batch")
                {

                }
                field("Leave Recall Nos"; "Leave Recall Nos")
                {

                }
                field("Cover Selection Nos"; "Cover Selection Nos")
                {

                }
                field("Leave Allowance Code"; "Leave Allowance Code")
                {

                }
                field("Leave Deduction Code"; "Leave Deduction Code")
                {

                }
                field("L.Allowance Days Setup"; "L.Allowance Days Setup")
                {

                }

            }

            group(Payroll)
            {
                field("Gratuity Validity Period"; "Gratuity Validity Period")
                {

                }
                field("Payroll Template"; "Payroll Template")
                {

                }
                field("Payroll Batch"; "Payroll Batch")
                {

                }
                field("Intern/Temp Batch"; "Intern/Temp Batch")
                {

                }
                field("Payroll Rounding Type"; "Payroll Rounding Type")
                {

                }
                field("Payroll Rounding Precision"; "Payroll Rounding Precision")
                {

                }
                field("Payroll Administrator Email"; "Payroll Administrator Email")
                {

                }
                field("Finance Emails"; "Finance Emails")
                {

                }
            }
            group(Training)
            {
                field("Training Need Nos"; "Training Need Nos")
                {

                }
                field("Training Evaluation Nos"; "Training Evaluation Nos")
                {

                }
            }
            group(Appraisal)
            {
                field("Appraisal Objective Nos"; "Appraisal Objective Nos")
                {

                }
                field("Appraisal Nos"; "Appraisal Nos")
                {

                }
            }
        }
    }

    actions
    {
        addafter("Employee Statistics Groups")
        {
            group("HR Templates")
            {
                action("Leave Journal Template")
                {
                    Image = Journal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = page "Hr Leave Journal Template Name";


                }
            }
        }


    }


}