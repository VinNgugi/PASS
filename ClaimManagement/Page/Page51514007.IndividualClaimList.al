page 51514007 "Individual Claim List"
{

    PageType = List;
    SourceTable = "Guarantee Claim Line";
    Caption = 'Individual Claim List';
    //ApplicationArea = All;
    //UsageCategory = Lists;
    CardPageId = "Individual Claim Card";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Claim No."; "Claim No.")
                {
                    ApplicationArea = All;
                }
                field("Loan No."; "Loan No.")
                {
                    ApplicationArea = All;
                }
                field(Product; Product)
                {
                    ApplicationArea = All;
                }
                field("Contract No."; "Contract No.")
                {
                    ApplicationArea = All;
                }
                field("CGC No."; "CGC No.")
                {
                    ApplicationArea = All;
                }
                field("Approval Status"; "Approval Status")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
