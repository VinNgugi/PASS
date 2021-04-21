page 51513325 "Document Link"
{
    // version HR

    PageType = ListPart;
    SourceTable = "Document Link";
    Caption = 'Document Link';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Document Description"; "Document Description")
                {
                }
                field(Attachement; Attachement)
                {
                }
            }
        }
    }

    actions
    {
    }

    procedure GetDocument() Document: Text[200];
    begin
        Document := "Document Description";
    end;
}

