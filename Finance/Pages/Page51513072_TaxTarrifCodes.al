page 51513072 "Tax Tarrif Codes"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Tax Tarriff Code";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;

                }
                field(Description; Description)
                {

                }
                field(Percentage; Percentage)
                {

                }
                field("Account No."; "Account No.")
                {

                }
                field("Account Type"; "Account Type")
                {

                }
                field(Type; Type)
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