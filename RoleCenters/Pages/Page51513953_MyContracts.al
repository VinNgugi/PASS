page 51513953 "My Contracts"
{
    PageType = ListPart;
    Caption = 'My Contracts';
    SourceTable = "My Contracts";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Contract No."; "Contract No.")
                {

                }
                field(Name; Name)
                {

                }
                field("Phone No."; "Phone No.")
                {

                }
                field("CGC Expiry Date"; "CGC Expiry Date")
                {

                }
                field("CGC Amount"; "CGC Amount")
                {

                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(Open)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin
                    OpenContractCard();
                end;
            }
        }
    }
    var
        contract: Record "Guarantee Contracts";

    trigger OnOpenPage()
    begin
        SetRange("User ID", UserId);
    end;

    trigger OnAfterGetRecord()
    begin
        if contract.Get("Contract No.") then;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(contract);
    end;

    local procedure OpenContractCard()
    begin
        if contract."No." <> '' then
            Page.Run(Page::"Guarante Contract Card", contract);
    end;
}