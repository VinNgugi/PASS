page 51513852 "Residential Assessment Lines"
{
    PageType = ListPart;
    SourceTable = "Residential Assessment";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Question; Question)
                {
                    MultiLine = true;

                }
                field(Selection; Selection)
                {
                    Caption = 'Assessment Type';
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