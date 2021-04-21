page 51513848 "WIF Test Entry"
{
    PageType = ListPart;
    SourceTable = "WIF Test Entry";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Category; Category)
                {

                }
                field(Question; Question)
                {
                    MultiLine = true;

                }
                field(Score; Score)
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