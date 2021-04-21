page 51513850 "Residential Selection Test"
{
    PageType = ListPart;
    SourceTable = "Residential Selection Test";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {

                }
                field(Question; Question)
                {
                    MultiLine = true;

                }
                field(Selection; Selection)
                {

                }
                field("Maximum Score"; "Maximum Score")
                {

                }
                field(Comment; Comment)
                {
                    MultiLine = true;
                }


            }
        }

    }


}