page 51513167 "Pending PC Replenish List"
{
    PageType = List;
    ApplicationArea = All;
    Editable = false;
    DeleteAllowed = false;
    UsageCategory = Lists;
    CardPageId = "PC Replenish Card";
    SourceTable = "InterBank Transfer Header";
    SourceTableView = sorting ("No.") where ("Transaction Type" = filter ("Petty-Cash Request"), Posted = const (false), "Approval Status" = filter ("Pending Approval"));

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;

                }
                field("Creation Date"; "Creation Date")
                {

                }
                field("Bank Account"; "Bank Account")
                {

                }
                field("Bank Account Name"; "Bank Account Name")
                {

                }
                field(Amount; Amount)
                {

                }
                field("Amount (LCY)"; "Amount (LCY)")
                {

                }
                field("Created By"; "Created By")
                {

                }
                field(Posted; Posted)
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        FILTERGROUP(2);
        if UserId <> 'PASS\NUHU' then
            SETRANGE("Created By", USERID);
        FILTERGROUP(0);
    end;
}