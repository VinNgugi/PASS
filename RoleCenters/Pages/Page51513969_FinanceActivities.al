page 51513969 "Finance Activities"
{
    PageType = ListPart;
    SourceTable = "Finance Role Cue";

    layout
    {
        area(Content)
        {
            cuegroup("Documents Pending Posting")
            {
                field("Approved Imprest"; "Approved Imprest")
                {
                    ApplicationArea = "#Suite";
                    DrillDownPageId = ApprovedImprestRequisitionList;
                    ToolTip = 'Specifies the number of approved imprest requests requests that require Posting.';
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}