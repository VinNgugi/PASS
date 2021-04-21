page 51513134 "HR Leave Period List"
{
    // version HR

    PageType = List;
    SourceTable = "HR Leave Periods";
    Caption = 'HR Leave Period List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Starting Date"; "Starting Date")
                {
                }
                field("Period Code"; "Period Code")
                {
                }
                field("Period Description"; "Period Description")
                {
                }
                field("Ending Date"; "Ending Date")
                {
                }
                field(Name; Name)
                {
                }
                field("New Fiscal Year"; "New Fiscal Year")
                {
                    Editable = false;
                }
                field(Closed; Closed)
                {
                    Editable = false;
                }
                field("Date Locked"; "Date Locked")
                {
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1102755008; Outlook)
            {
            }
            systempart(Control1102755009; Notes)
            {
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("<Report 51516233>")
            {
                Caption = '&Create Year';
                Ellipsis = true;
                Image = CreateYear;
                Promoted = true;
                PromotedCategory = Process;
                //RunObject = Report Report51516233;
            }
            action("C&lose Year")
            {
                Caption = 'C&lose Year';
                Image = CloseYear;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Codeunit "Leave Year-Close";
            }
        }
    }
}

