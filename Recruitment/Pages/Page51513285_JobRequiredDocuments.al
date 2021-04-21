page 51513285 "Job Required Documents"
{
    PageType = ListPart;

    SourceTable = "Job Required Documents";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Recruitment Req. No."; "Recruitment Req. No.")
                {
                    Visible = false;
                }
                field("Document Description"; "Document Description")
                {


                }
                field(Mandatory; Mandatory)
                {

                }
            }
        }

    }
}