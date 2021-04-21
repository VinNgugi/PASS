page 51513132 "HR Leave Batches"
{
    // version HR

    PageType = List;
    SourceTable = "HR Leave Journal Batch";
    Caption = 'HR Leave Batches';
    layout
    {
        area(content)
        {
            repeater(Control1102755000)
            {
                field("Journal Template Name"; "Journal Template Name")
                {

                }
                field(Name; Name)
                {
                }
                field(Description; Description)
                {
                }
                field("Posting Description"; "Posting Description")
                {
                }
                field(Type; Type)
                {
                }
            }
        }
    }


}

