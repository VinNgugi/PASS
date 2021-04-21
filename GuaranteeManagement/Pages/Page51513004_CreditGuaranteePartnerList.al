page 51513004 "Credit Guarantee Partner List"
{
    PageType = List;
    Caption = 'Credit Guarantee Partner List';
    UsageCategory = Administration;
    SourceTable = "Credit Guarantee Partner";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {

                }
                field(Description; Description)
                {

                }
                field("Guarantee %"; "Guarantee %")
                {

                }
                field("PASS Guarantee %"; "PASS Guarantee %")
                {

                }
                field(Blocked;Blocked)
                {
                    
                }
            }
        }

    }

}