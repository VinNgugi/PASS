page 51513026 "Ownership Requirements"
{
    Caption = 'Business Ownership Requirements';
    PageType = ListPart;

    SourceTable = "Required Documents";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {

                }
                field(Mandatory; Mandatory)
                {

                }
            }
        }

    }
}