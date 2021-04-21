page 51513098 "Deductions listing"
{
    // version PAYROLL

    //DataCaptionFields = "Code", Description;
    Editable = false;
    PageType = List;
    SourceTable = Deductions;
    Caption = 'Deductions listing';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Code)
                {
                }
                field("Main Deduction Code"; "Main Deduction Code")
                {
                }
                field(Description; Description)
                {
                }
                field("Institution Code"; "Institution Code")
                {
                }
                field("Insurance Code"; "Insurance Code")
                {
                }
                field(Block; Block)
                {
                }
                field("Pension Limit Percentage"; "Pension Limit Percentage")
                {
                }
                field("Pension Limit Amount"; "Pension Limit Amount")
                {
                }
                field("Applies to All"; "Applies to All")
                {
                }
                field("Show on Master Roll"; "Show on Master Roll")
                {
                }
                field("Account No.";"Account No.")
                {
                    Visible = true;
                }
                field("G/L Account Employer"; "G/L Account Employer")
                {
                    Visible = true;
                }
                field("Total Amount Employer"; "Total Amount Employer")
                {
                }
                field(Type; Type)
                {
                }
                field("Calculation Method"; "Calculation Method")
                {
                }
                field("PAYE Code"; "PAYE Code")
                {
                }
                field("Main Loan Code"; "Main Loan Code")
                {
                    Visible = false;
                }
                field("Maximum Amount"; "Maximum Amount")
                {
                }
                field("Total Amount"; "Total Amount")
                {
                }
                field("Flat Amount"; "Flat Amount")
                {
                }
                field("Flat Amount Employer"; "Flat Amount Employer")
                {
                }
                field("Pension Scheme"; "Pension Scheme")
                {
                }
                field(Percentage; Percentage)
                {
                }
                field("Percentage Employer"; "Percentage Employer")
                {
                }
                field("Tax deductible"; "Tax deductible")
                {
                    Caption = 'Reduces Taxable Amt';
                }
                field("Deduction Table"; "Deduction Table")
                {
                }
                field(Shares; Shares)
                {
                }
                field(Loan; Loan)
                {
                }
                field("Non-Interest Loan"; "Non-Interest Loan")
                {
                }
                field("Loan Type"; "Loan Type")
                {
                }
                field("Show Balance"; "Show Balance")
                {
                }
                field("Exclude when on Leave"; "Exclude when on Leave")
                {
                }
                field(CoinageRounding; CoinageRounding)
                {
                }
                field("Show on report"; "Show on report")
                {
                }
                field("Co-operative"; "Co-operative")
                {
                }
                field(Board; Board)
                {
                }
                field("NHIF Deduction"; "NHIF Deduction")
                {
                }
            }
        }
    }



    var
        Axion: Option Add,Edit,Delete;
}

