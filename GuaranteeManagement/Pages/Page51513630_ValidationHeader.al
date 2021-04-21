page 51513630 "Validation List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Validation Table";
    CardPageId = "Validation Card";

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
                field(Banks; Banks)
                {

                }
                field("Bank Name"; "Bank Name")
                {

                }
                field(Quarter; Quarter)
                {

                }
                field("Total Entries"; "Total Entries")
                {

                }
                field("Validated Entries"; "Validated Entries")
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
}