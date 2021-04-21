page 51513986 "Loan Product Type list"
{
    // version PAYROLL

    CardPageID = "Loan Product Type list";
    Editable = false;
    PageType = List;
    SourceTable = "Loan Product Type";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
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
            }
        }
    }

    actions
    {
    }
}

