page 51513972 "EDMS Integration Docs List"
{

    //ApplicationArea = All;
    Caption = 'EDMS Integration Docs';
    PageType = List;
    SourceTable = "EDMS Integration Docs";
    //UsageCategory = None;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(DocFile; Rec.DocFile)
                {
                    ApplicationArea = All;
                }
                field(DocID; Rec.DocID)
                {
                    ApplicationArea = All;
                }
                field(DocLink; Rec.DocLink)
                {
                    ApplicationArea = All;
                }
                field(DocLinkID; Rec.DocLinkID)
                {
                    ApplicationArea = All;
                }
                field(DocSource; Rec.DocSource)
                {
                    ApplicationArea = All;
                }
                field(DocumentNo; Rec.DocumentNo)
                {
                    ApplicationArea = All;
                }
                field(EntryDate; Rec.EntryDate)
                {
                    ApplicationArea = All;
                }
                field(FolderLink; Rec.FolderLink)
                {
                    ApplicationArea = All;
                }
                field(InstanceID; Rec.InstanceID)
                {
                    ApplicationArea = All;
                }
                field(PFNumber; Rec.PFNumber)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("View Document")
            {
                Caption = 'Open Attachments';
                //Visible = NOT OpenApprovalEntriesExist AND CanRequestApprovalForFlow;
                ApplicationArea = "#Basic,#Suite";
                Image = Open;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ToolTip = 'Open the attached documents in EDMS.';
                trigger OnAction()
                var
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    OpenDocument(Rec);
                    Rec.Reset();
                    Setfilters(DocumentNo);
                end;
            }
        }
    }
    procedure Setfilters(DocumentNo: Code[20])
    var
        myInt: Integer;
    begin
        if DocumentNo <> '' then begin
            FILTERGROUP(2);
            SETRANGE(DocumentNo, DocumentNo);
            //SETRANGE("Document Type", DocumentType);
            FILTERGROUP(0);
        end;
    end;

    local procedure OpenDocument(var EDMSDocs: Record "EDMS Integration Docs")
    var
    begin
        if EDMSDocs.FindSet(true) then
            repeat
                Hyperlink(EDMSDocs.DocLink);
            until EDMSDocs.Next() = 0;
    end;

}
