page 51513329 "Succession Requirements"
{
    // version HR

    PageType = ListPart;
    SourceTable = "HR Company or Other Training";
    Caption = 'Succession Requirements';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Need Source"; "Need Source")
                {
                }
                field(Description; Description)
                {
                }
                field(Competency; Competency)
                {
                }
                field("Date of re-assessment"; "Date of re-assessment")
                {
                }
                field(Approved; Approved)
                {
                    Editable = false;
                }
            }
        }
    }

    actions
    {
    }
}

