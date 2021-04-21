page 51513082 Deductions
{
    // version PAYROLL

    DataCaptionFields = "Code", Description;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = Deductions;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Code)
                {
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("Main Deduction Code"; "Main Deduction Code")
                {
                }
                field(Description; Description)
                {
                }
                field(Individual; Individual)
                {
                    Caption = 'Receivable(Personalised)';
                }
                field("Show on Payslip Information"; "Show on Payslip Information")
                {
                }
                field("Institution Code"; "Institution Code")
                {
                }
                field("Insurance Code"; "Insurance Code")
                {
                }
                field(vendor; vendor)
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
                field("Posting Account Type"; "Posting Account Type")
                {

                }
                field("Account No."; "Account No.")
                {
                    Visible = true;
                }
                field("PE Activity Code"; "PE Activity Code")
                {
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
                field("Maximun Amount Employer"; "Maximun Amount Employer")
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
                field("Pension Arrears"; "Pension Arrears")
                {
                }
                field("Gratuity Arrears"; "Gratuity Arrears")
                {
                }
                field(Gratuity; Gratuity)
                {
                }
                field(Percentage; Percentage)
                {
                }
                field("Percentage Employer"; "Percentage Employer")
                {
                }
                field("Voluntary Percentage"; "Voluntary Percentage")
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
                field(Month; Month)
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
                field("Salary Recovery"; "Salary Recovery")
                {
                }
                field(Informational; Informational)
                {
                }
                field(Board; Board)
                {
                }
                field("Voluntary Code"; "Voluntary Code")
                {
                }
                field(Voluntary; Voluntary)
                {
                }
                field("NHIF Deduction"; "NHIF Deduction")
                {
                }
                field("NSSF Deduction"; "NSSF Deduction")
                {
                }
                field("NITA Deduction"; "NITA Deduction")
                {
                }
                field("HELB Deduction"; "HELB Deduction")
                {
                }
                field("Severance Pay"; "Severance Pay")
                {
                }
                field("Flat Amount Core"; "Flat Amount Core")
                {
                }
                field("Flat Amount Projects"; "Flat Amount Projects")
                {
                }
                field("Medical Scheme"; "Medical Scheme")
                {
                }
                field("Employer Contribution Taxable"; "Employer Contribution Taxable")
                {
                }
                field("Substitute Earning"; "Substitute Earning")
                {
                }
                field(Provision; Provision)
                {
                }
                field("Vehicle Grant"; "Vehicle Grant")
                {
                }
                field("Default Cost Center"; "Default Cost Center")
                {
                }
                field("Default PA Account"; "Default PA Account")
                {
                }
                field("Tax Deduction"; "Tax Deduction")
                {
                }
                field("WCF Deduction"; "WCF Deduction")
                {

                }

            }
        }
    }

    actions
    {
    }

    var
        Axion: Option Add,Edit,Delete;
}

