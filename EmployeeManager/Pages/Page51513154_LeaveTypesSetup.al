page 51513154 "Leave Types Setup"
{
    // version HR

    Editable = true;
    PageType = List;
    SourceTable = "Leave Types";
    Caption = 'Leave Types Setup';
    DeleteAllowed = false;

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
                field("Days for Unconfirmed"; "Days for Unconfirmed")
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
                field("Annual Leave"; "Annual Leave")
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
                field("Eligible Staff"; "Eligible Staff")
                {
                }
                /*field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("Requires Attachment"; "Requires Attachment")
                {
                }*/
            }
        }
    }

    actions
    {
    }

    trigger OnInit();
    begin
        CurrPage.LOOKUPMODE := true;
    end;
}

