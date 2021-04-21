page 51513396 "Appraisal Page"
{
    // version HR

    PageType = Card;
    SourceTable = "Employee Appraisals";
    Caption = 'Appraisal Page';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                Editable = false;
                field("Appraisal Period"; "Appraisal Period")
                {
                }
                field("Appraisal Type"; "Appraisal Type")
                {
                }
                field("Employee No"; "Employee No")
                {
                    Caption = 'Appraisee''s No.';
                }
                field("Appraisee ID"; "Appraisee ID")
                {
                }
                field("Appraisee Name"; "Appraisee Name")
                {
                }
                field("Appraisee's Job Title"; "Appraisee's Job Title")
                {
                }
                field("Job ID"; "Job ID")
                {
                    Caption = 'Appraisee''s Job ID';
                }
                field("Department Name"; "Department Name")
                {
                }
                field("Directorate Name"; "Directorate Name")
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
                }
            }
            part(Control1000000008; "Appraiser and Appraisee Narrat")
            {
                SubPageLink = "Appraisal No" = FIELD ("Appraisal No"),
                              "Appraisal Type" = FIELD ("Appraisal Type");
            }
            field("General Comments"; "General Comments")
            {
            }
            field(Rating; Rating)
            {
                Caption = 'Overall Rating';
            }
            field("Agreement With Rating"; "Agreement With Rating")
            {
                Caption = 'Appraisee Agreement With Rating';
            }
            field("Rating Description"; "Rating Description")
            {
                Editable = false;
            }
            field(Control1000000035; '')
            {
                CaptionClass = Text19016900;
                Style = Strong;
                StyleExpr = TRUE;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Performance Appraisal")
            {
                Caption = 'Performance Appraisal';
                action("Send Approval Request")
                {
                    Caption = 'Send Approval Request';
                    Image = SendApprovalRequest;
                }
                action("Cancel Approval Re&quest")
                {
                    Caption = 'Cancel Approval Re&quest';
                }
            }
        }
        area(processing)
        {
            action("<<Back")
            {
                Caption = '<<Back';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    if EmployeeAppraisals.GET("Appraisal No") then
                        PAGE.RUNMODAL(51511409, EmployeeAppraisals);
                end;
            }
            action(Preview)
            {
                Caption = 'Preview';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                begin
                    EmployeeAppraisals.RESET;
                    EmployeeAppraisals.SETRANGE(EmployeeAppraisals."Employee No", "Employee No");
                    EmployeeAppraisals.SETRANGE(EmployeeAppraisals."Appraisal Period", "Appraisal Period");
                    EmployeeAppraisals.SETRANGE(EmployeeAppraisals."Appraisal Category", "Appraisal Category");
                    EmployeeAppraisals.SETRANGE(EmployeeAppraisals."Appraisal No", "Appraisal No");
                    if EmployeeAppraisals.FIND('-') then begin
                        if EmployeeAppraisals."Appraisal Type" = 'Annual' then
                            REPORT.RUNMODAL(51511181, true, false, EmployeeAppraisals)
                        else
                            if EmployeeAppraisals."Appraisal Type" = 'Mid Year' then
                                REPORT.RUNMODAL(51511188, true, false, EmployeeAppraisals);
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if Employee.GET("Employee No") then
            //IF Employee.Position<>'' THEN
            if Jobs.GET(Employee.Position) then
                ;
    end;

    var
        EmployeeAppraisals: Record "Employee Appraisals";
        Employee: Record Employee;
        Jobs: Record "Company Jobs";
        Text19016900: Label 'Overall Rating';
}

