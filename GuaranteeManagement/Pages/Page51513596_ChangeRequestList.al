page 51513596 "Change Request List"
{
    Caption = 'Change Request List';
    PageType = List;
    Editable = false;
    UsageCategory = Lists;
    SourceTable = "Change Request";
    PromotedActionCategories = 'New,Process,Report,Approve,New Document,Request Approval,Customer';
    CardPageId = "Change Request Card";

    //SourceTableView = sorting("No.") where(Status = FILTER(Open), Source = const(Office));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Request No"; Rec."Request No")
                {
                    ApplicationArea = All;
                }
                field("Requested Date"; Rec."Requested Date")
                {
                    ApplicationArea = All;
                }
                field("Contract No"; Rec."Contract No")
                {
                    ApplicationArea = All;
                }
                field("Client No"; Rec."Client No")
                {
                    ApplicationArea = All;
                }
                field("Client Name"; Rec."Client Name")
                {
                    ApplicationArea = All;
                }
                field("Change Type"; Rec."Change Type")
                {
                    ApplicationArea = All;
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
