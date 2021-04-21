page 51513815 "Resident Selection(BS)"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Residential Selection Header";
    SourceTableView = sorting ("No.") order(ascending) where (Selection = filter ("Business Skills"));
    CardPageId = "Resident Selection Card(BS)";

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
                field("Instructor Resource No."; "Instructor Resource No.")
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
                field(Status; Status)
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