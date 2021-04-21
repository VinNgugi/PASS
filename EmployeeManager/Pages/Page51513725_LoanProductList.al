page 51513725 "Loan Product List"
{
    CardPageID = "Loan Product Type setup";
    InsertAllowed = false;
    PageType = List;
    SourceTable = "Loan Product Type";
    Caption = 'Loan Product Setup List';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Interest Rate"; "Interest Rate")
                {
                }
                field("Interest Calculation Method"; "Interest Calculation Method")
                {
                }
                field("No Series"; "No Series")
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
                field(Internal; Internal)
                {
                }
                field("Fringe Benefit Code"; "Fringe Benefit Code")
                {
                }
                field("Calculate On"; "Calculate On")
                {
                }
                field("Principal Deduction Code"; "Principal Deduction Code")
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
    }
}

