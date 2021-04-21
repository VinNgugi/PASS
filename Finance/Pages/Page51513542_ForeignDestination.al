page 51513542 "Foreign Destination"
{
    CardPageID = "Foreign Destination Card";
    UsageCategory = Administration;
    PageType = List;
    SourceTable = "Foreign Destination";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Destination Code"; "Destination Code")
                {
                }
                field(Country; Country)
                {
                }
                field("Destination Name"; "Destination Name")
                {
                }
                field("Job Grade"; "Job Grade")
                {
                    Caption = 'Staff Grade';
                }
                field(Amount; Amount)
                {
                    Caption = 'Amount Per Night';
                }
            }
        }
    }

    actions
    {
    }
}

