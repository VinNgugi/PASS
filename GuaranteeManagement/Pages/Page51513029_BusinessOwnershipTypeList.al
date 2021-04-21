page 51513029 "Business Type List"
{
    Caption = 'Business Type List';
    PageType = List;
    UsageCategory = Administration;
    SourceTable = "Type of Business Owership";
    Editable = false;
    CardPageId = "Type of Business Ownership";

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
                field("Ownership Type"; "Ownership Type")
                {

                }
            }
        }

    }
}