page 51513323 "Medical Info"
{
    // version HR

    PageType = ListPart;
    SourceTable = "Medical History";
    Caption = 'Medical Info';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(Description; Description)
                {
                }
                field(Results; Results)
                {
                }
                field(Date; Date)
                {
                }
                field(Remarks; Remarks)
                {
                }
            }
        }
    }


}

