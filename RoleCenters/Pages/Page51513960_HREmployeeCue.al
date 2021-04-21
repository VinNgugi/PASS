page 51513960 "HR Employee Cue"
{
    PageType = ListPart;
    Caption = 'HR Employee Cue';
    SourceTable = "HR Cue";

    layout
    {
        area(Content)
        {

            cuegroup("Employees")
            {


                field("Employee-Active"; "Employee-Active")
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "HR Employee List";
                    ToolTip = 'Specifies the number of active employees';

                }
                field("Employee-Female"; "Employee-Female")
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "HR Employee List";
                    ToolTip = 'Specifies the number of female employees';

                }
                field("Employee-Male"; "Employee-Male")
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "HR Employee List";
                    ToolTip = 'Specifies the number of male employees';

                }
                field("Employee-InActive"; "Employee-InActive")
                {
                    ApplicationArea = "#Basic,#Suite";
                    DrillDownPageId = "HR Employee List";
                    ToolTip = 'Specifies the number of Inactive employees';

                }


                actions
                {
                    action(New)
                    {
                        Caption = 'New';
                        RunObject = page "HR Employee";
                        RunPageMode = Create;
                    }
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