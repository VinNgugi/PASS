page 51513050 "Pay Modes"
{
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Pay Modes";
    Caption = 'Pay Modes';
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
            }
        }


    }
}