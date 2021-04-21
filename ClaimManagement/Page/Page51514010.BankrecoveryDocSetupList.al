page 51514010 "Bank recovery Doc Setup List"
{

    PageType = List;
    SourceTable = "Bank Recovery Doc Setup";
    Caption = 'Bank recovery Doc Setup List';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = All;
                }
                field("Required Document"; "Required Document")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
