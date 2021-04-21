page 51513451 "Training Financial Year"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "G/L Budget Name";
    InsertAllowed = false;
    Editable = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action("Training Plans For the Year")
            {
                ApplicationArea = All;
                RunObject = page "Training Plan List";
                RunPageLink = "Budget Name" = field (Name);
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = List;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}