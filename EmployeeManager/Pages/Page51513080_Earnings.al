page 51513080 Earnings
{
    // version PAYROLL

    DeleteAllowed = false;
    PageType = List;
    SourceTable = Earnings;

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
                field("Country/Region Code"; "Country/Region Code")
                {
                }
                field("Show on Master Roll"; "Show on Master Roll")
                {
                }
                field("Basic Pay Arrears"; "Basic Pay Arrears")
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
                field(Recurs; Recurs)
                {
                }
                field("Earning Type"; "Earning Type")
                {
                }
                field("Applies to All"; "Applies to All")
                {
                }
                field("Posting Account Type"; "Posting Account Type")
                {

                }
                field("Account No."; "Account No.")
                {
                }
                field("PE Activity Code"; "PE Activity Code")
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
                field("Cons Relief %"; "Cons Relief %")
                {
                }
                field("Max Cons. Relief(Monthly)"; "Max Cons. Relief(Monthly)")
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
                field("Reduces Taxable Amount"; "Reduces Taxable Amount")
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
                field(Fringe; Fringe)
                {
                }
                field("Market Rate"; "Market Rate")
                {
                }
                field("Company Rate"; "Company Rate")
                {
                }
                field("Basic Salary Code"; "Basic Salary Code")
                {
                }
                field("Gratuity Pay"; "Gratuity Pay")
                {

                }
                field("Time Sheet"; "Time Sheet")
                {
                }
                field("Salary Recovery"; "Salary Recovery")
                {
                }
                field(Board; Board)
                {
                }
                field("Fringe Benefit"; "Fringe Benefit")
                {
                }
                field("Morgage Relief"; "Morgage Relief")
                {
                }
                field(Bonus; Bonus)
                {
                }
                field("Leave Allowance Code"; "Leave Allowance Code")
                {
                }
                field("Gross Pay Entry"; "Gross Pay Entry")
                {
                }
                field("Full Month Tax"; "Full Month Tax")
                {
                }
                field("Amount Per Dependant"; "Amount Per Dependant")
                {
                }
                field("Percentage to Pension"; "Percentage to Pension")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Earnings Mass update")
            {
                Caption = 'Earnings Mass update';
                action("Mass Update Earnings")
                {
                    Caption = 'Mass Update Earnings';
                    RunPageOnRec = true;

                    trigger OnAction();
                    begin
                        // EarningsMassUpdate.GetEarnings(Rec);
                        //EarningsMassUpdate.RUN;





                        /*Actions:=Actions::Add;
                        Sources:=Sources::Payment;
                        AssignReport.UsePayment(Rec,Actions,Sources);
                        AssignReport.RUN;
                        */

                    end;
                }
                action("Import Payroll data")
                {
                    Image = ImportExcel;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                }
            }
        }
    }

    var
        Payment: Record Earnings temporary;
        PaymentCode: Code[10];
        "Actions": Option Add,edit,Delete;
        Sources: Option Payment,Deduction,Saving;
}

