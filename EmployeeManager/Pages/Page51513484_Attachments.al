page 51513484 Attachments
{
    // version PROC

    PageType = List;
    SourceTable = "Files Path Management";
    Caption = 'Attachments';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(No; No)
                {
                }
                field("Line No"; "Line No")
                {
                }
                field(Path; Path)
                {
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action(Open)
            {
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    HYPERLINK(Path);
                end;
            }
        }
    }
}

