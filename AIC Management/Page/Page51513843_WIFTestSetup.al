page 51513843 "WIF Test Setup"
{
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "WIF Test";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {

                }
                field(Category; Category)
                {

                }
                field(Question; Question)
                {
                    MultiLine = true;
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