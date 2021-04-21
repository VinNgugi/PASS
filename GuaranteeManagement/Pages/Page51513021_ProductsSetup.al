page 51513021 "Product Setup"
{
    PageType = Card;
    SourceTable = Products;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Code; Code)
                {
                    Caption = 'Code';

                }
                field("Product Description"; "Product Description")
                {

                }
                field(Type; Type)
                {

                }
                field("Portfolio Guarantee %"; "Portfolio Guarantee %")
                {

                }
            }
            part("ProductCharges"; "Product Charges")
            {
                Caption = 'Charges';
                SubPageLink = "Product Code" = field (Code);

            }
        }
    }

}
