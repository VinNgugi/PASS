pageextension 51513424 "General Journal Ext" extends "General Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addlast(Processing)
        {
            group(AttachmentstoEDMS)
            {
                // Add changes to page actions here
                action("Attach Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'Add a file as an attachment to EDMS. You can attach images as well as documents.';
                    Image = Attach;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var
                    begin
                        OnAttachDocuments(Rec);
                    end;
                }
                action("View Attached Documents")
                {
                    ApplicationArea = All;
                    ToolTip = 'View attached files in EDMS.';
                    Image = ViewDetails;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Category4;
                    trigger OnAction()
                    var

                    begin
                        OnViewAttachedDocuments(Rec);
                    end;
                }
            }
        }


    }

    var
        myInt: Integer;
}