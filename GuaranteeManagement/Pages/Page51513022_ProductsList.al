page 51513022 "Products List"
{
    PageType = List;
    UsageCategory = Administration;
    SourceTable = Products;
    CardPageId = 51513021;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Code; Code)
                {


                }
                field("Product Description"; "Product Description")
                {

                }
            }
        }

    }
}