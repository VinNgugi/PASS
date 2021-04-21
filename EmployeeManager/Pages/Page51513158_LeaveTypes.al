page 51513158 "Leave Types"
{
    // version HR

    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Leave Types";
    SourceTableView = WHERE (Status = CONST (Active));
    Caption = 'Leave Types';
    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field(Days; Days)
                {
                }
                field("Unlimited Days"; "Unlimited Days")
                {
                }
                field(Gender; Gender)
                {
                }
                field(Balance; Balance)
                {
                }
                field("Max Carry Forward Days"; "Max Carry Forward Days")
                {
                }
                field("Inclusive of Holidays"; "Inclusive of Holidays")
                {
                }
                field("Inclusive of Saturday"; "Inclusive of Saturday")
                {
                }
                field("Inclusive of Sunday"; "Inclusive of Sunday")
                {
                }
                field("Off/Holidays Days Leave"; "Off/Holidays Days Leave")
                {
                }
                field(Status; Status)
                {
                }
            }
        }
    }

    trigger OnInit();
    begin
        CurrPage.LOOKUPMODE := true;
    end;
}

