page 51513079 "P.C Replenish List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    DeleteAllowed = false;
    CardPageId = "PC Replenish Card";
    SourceTable = "InterBank Transfer Header";
    SourceTableView = sorting ("No.") where ("Transaction Type" = filter ("Petty-Cash Request"), Posted = const (false), "Approval Status" = filter (New));

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
                    Caption = 'Petty Cash Till';
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
        SETRANGE("Created By", USERID);
        FILTERGROUP(0);
    end;
}