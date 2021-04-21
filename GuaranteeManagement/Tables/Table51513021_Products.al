table 51513021 Products
{
    DataClassification = CustomerContent;
    Caption = 'Products';
    DrillDownPageId = "Products List";
    LookupPageId = "Products List";

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Product Description"; Text[30])
        {
            Caption = 'Product Description';
            DataClassification = CustomerContent;
        }
        field(3; Type; option)
        {
            DataClassification = CustomerContent;
            caption = 'Product Type';
            OptionMembers = " ",Traditional,"Lenders Option";
        }
        field(4; "Portfolio Guarantee %"; Decimal)
        {
            DataClassification = CustomerContent;

        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

}