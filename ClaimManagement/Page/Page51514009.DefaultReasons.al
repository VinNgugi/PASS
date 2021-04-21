page 51514009 "Default Reasons"
{

    PageType = List;
    SourceTable = "Default Reasons";
    Caption = 'Default Reasons';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Reasons For Default"; "Reasons For Default")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
