page 51513097 "Earnings Listing"
{
    // version PAYROLL

    Editable = false;
    PageType = List;
    SourceTable = Earnings;
    Caption = 'Earnings Listing';


    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Code"; Code)
                {
                }
                field(Description; Description)
                {
                }
                field("Show on Master Roll"; "Show on Master Roll")
                {
                }
                field("Responsibility Allowance Code"; "Responsibility Allowance Code")
                {
                }
                field("Commuter Allowance Code"; "Commuter Allowance Code")
                {
                }
                field("House Allowance Code"; "House Allowance Code")
                {
                }
                field("Earning Type"; "Earning Type")
                {
                }
                field("Applies to All"; "Applies to All")
                {
                }
                field("Account No."; "Account No.")
                {
                }
                field(Block; Block)
                {
                }
                field("Pay Type"; "Pay Type")
                {
                }
                field(Weekend; Weekend)
                {
                }
                field(Weekday; Weekday)
                {
                }
                field("ProRata Leave"; "ProRata Leave")
                {
                }
                field("Start Date"; "Start Date")
                {
                }
                field("End Date"; "End Date")
                {
                }
                field("Calculation Method"; "Calculation Method")
                {
                }
                field("Flat Amount"; "Flat Amount")
                {
                }
                field(Percentage; Percentage)
                {
                }
                field(Taxable; Taxable)
                {
                }
                field("Reduces Tax"; "Reduces Tax")
                {
                }
                field("Non-Cash Benefit"; "Non-Cash Benefit")
                {
                }
                field(Months; Months)
                {
                }
                field(Quarters; Quarters)
                {
                }
                field("Overtime Factor"; "Overtime Factor")
                {
                }
                field(OverTime; OverTime)
                {
                }
                field("Low Interest Benefit"; "Low Interest Benefit")
                {
                }
                field("Minimum Limit"; "Minimum Limit")
                {
                }
                field("Maximum Limit"; "Maximum Limit")
                {
                }
                field("Total Amount"; "Total Amount")
                {
                }
                field(CoinageRounding; CoinageRounding)
                {
                }
                field("Show on Report"; "Show on Report")
                {
                }
                field("Show Balance"; "Show Balance")
                {
                }
                field("Total Days"; "Total Days")
                {
                }
                field(OverDrawn; OverDrawn)
                {
                }
                field("Basic Salary Code"; "Basic Salary Code")
                {
                }
                field("Time Sheet"; "Time Sheet")
                {
                }
                field(Board; Board)
                {
                }
            }
        }
    }

    actions
    {
    }

    var
        Payment: Record Earnings temporary;
        PaymentCode: Code[10];
        "Actions": Option Add,edit,Delete;
        Sources: Option Payment,Deduction,Saving;
}

