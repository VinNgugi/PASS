page 51513817 "Resident Selection(TT)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Residential Selection Header";
    SourceTableView = sorting ("No.") order(ascending) where (Selection = filter ("Technical Training"));
    CardPageId = "Resident Selection Card(TT)";

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
                field("Document Date"; "Document Date")
                {

                }
                field(Selection; Selection)
                {

                }
                field("Trainer Name"; "Instructor Name")
                {

                }
                field("Incubation Code"; "Incubation Code")
                {

                }
                field("Selection Start Date"; "Selection Start Date")
                {

                }
                field("Selection End Date"; "Selection End Date")
                {

                }
                field("Created By"; "Created By")
                {

                }
                field("Global Dimension 4 Code"; "Global Dimension 4 Code")
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