page 51513091 "Loan Product Type setup"
{
    // version PAYROLL

    PageType = Card;
    SourceTable = "Loan Product Type";
    Caption = 'Loan Product Type setup';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Interest Calculation Method"; "Interest Calculation Method")
                {
                }
                field("Interest Rate"; "Interest Rate")
                {
                }
                field("No of Instalment"; "No of Instalment")
                {
                }
                field("Loan No Series"; "Loan No Series")
                {
                }
                field(Rounding; Rounding)
                {
                }
                field("Rounding Precision"; "Rounding Precision")
                {
                }
                field("Loan Category"; "Loan Category")
                {
                    Visible = false;
                }
                field("Calculate Interest"; "Calculate Interest")
                {
                }
                field("Interest Deduction Code"; "Interest Deduction Code")
                {
                }
                field("Deduction Code"; "Deduction Code")
                {
                }
                field("Principal Deduction Code"; "Principal Deduction Code")
                {
                }
                field(Internal; Internal)
                {
                }
                field("Fringe Benefit Code"; "Fringe Benefit Code")
                {
                }
                field("Calculate On"; "Calculate On")
                {
                }
                field(Mortgage; Mortgage)
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Loan)
            {
                Caption = 'Loan';
                action("Loan Application List")
                {
                    Image = ApplicationWorksheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Loan List";
                    RunPageLink = "Loan Product Type" = FIELD (Code);
                }
                action("Loan Application")
                {
                    Caption = 'Loan Application';
                    Image = Apply;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    //RunObject = Page "Loan Application Form";
                    //RunPageLink = "Loan Product Type" = FIELD (Code);
                }
                action("Bulk Issue")
                {
                    Caption = 'Bulk Issue';
                    /*RunObject = Page "Loan Application Grid";
                    RunPageLink = "Loan Product Type" = FIELD (Code),
                                  "Loan Status" = FILTER (<> Issued);*/
                }
            }
        }
    }
}

