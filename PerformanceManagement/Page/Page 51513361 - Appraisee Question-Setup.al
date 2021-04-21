page 51513361 "Appraisee Question-Setup"
{
    // version HR

    PageType = List;
    SourceTable = "Appraisee's Questions-Setup";
    Caption = 'Appraisee Question-Setup';
    UsageCategory = Administration;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; "No.")
                {
                }
                field(Question; Question)
                {
                }
                field(Date; Date)
                {
                }
                field("User ID"; "User ID")
                {
                }
            }
        }
    }

    actions
    {
    }
}

