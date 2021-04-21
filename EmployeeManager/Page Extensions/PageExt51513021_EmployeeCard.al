pageextension 51513021 "Employee Card Ext" extends "Employee Card"
{
    layout
    {
        addafter("Alt. Address End Date")
        {
            field("Global Dimension 1 Code"; "Global Dimension 1 Code")
            {

            }
            field("Global Dimension 2 Code"; "Global Dimension 2 Code")
            {

            }

        }

        addafter("Bank Account No.")
        {
            field("Bank Account Number"; "Bank Account Number")
            {

            }
        }
        addlast(Payments)
        {

            field("Customer Acc No."; "Customer Acc No.")
            {

            }
            field("Pays tax"; "Pays tax")
            {

            }
            field("Posting Group"; "Posting Group")
            {

            }
            field("Pays SSF"; "Pays SSF")
            {

            }
            field("Pension Rate"; "Pension Rate")
            {

            }
            field("Tax Rate Percentage"; "Tax Rate Percentage")
            {

            }
            field("PIN Number"; "PIN Number")
            {

            }
            field("No of Dependants"; "No of Dependants")
            {

            }
            field("NSSF No."; "NSSF No.")
            {

            }
            field("NHIF No."; "NHIF No.")
            {
                Caption = 'Medical Insurance No.';
            }
            field("WCF Number"; "WCF Number")
            {

            }
            field("HELB No"; "HELB No")
            {

            }
            field("Co-Operative No"; "Co-Operative No")
            {

            }
            field("Pay Mode"; "Pay Mode")
            {

            }
            field("Payroll Subcategory"; "Payroll Subcategory")
            {

            }
            field("Salary Scale"; "Salary Scale")
            {

            }
            field(Present; Present)
            {

            }
            field(Previous; Previous)
            {

            }
            field(Halt; Halt)
            {

            }
            field("Pro-Rata Calculated"; "Pro-Rata Calculated")
            {

            }
            field("Taxable Allowance"; "Taxable Allowance")
            {

            }
            field("Total Allowances"; "Total Allowances")
            {

            }
            field("Total Deductions"; "Total Deductions")
            {

            }
            field("Tax Deductible Amount"; "Tax Deductible Amount")
            {

            }
            field("Cumm. PAYE"; "Cumm. PAYE")
            {

            }
            field("Cumm. Net Pay"; "Cumm. Net Pay")
            {

            }
            field("Benefits-Non Cash"; "Benefits-Non Cash")
            {

            }
            field("No. of Hours"; "No. of Hours")
            {

            }
            field(Overtime; Overtime)
            {

            }
            field("No. Of Days Worked"; "No. Of Days Worked")
            {

            }
            field("No. Of Hours Weekend"; "No. Of Hours Weekend")
            {
                Caption = 'Overtime Hours (Weekend  Holiday)';
            }
            field(Basic; Basic)
            {

            }
            field("Imprest Code"; "Imprest Code")
            {

            }


        }
        addlast(Administration)
        {
            field("Retirement Date"; "Retirement Date")
            {

            }
            field("Base Calendar Code"; "Base Calendar Code")
            {

            }
        }
    }

    actions
    {
        addafter("E&mployee")
        {
            group(Earnings)
            {
                action("Assign Earnings")
                {
                    Image = Payment;
                    RunObject = page "Payment & Deductions";
                    RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Payment), Closed = CONST(false);
                }
                action("Earning List")
                {
                    Image = List;
                    RunObject = page Earnings;
                }
                action("Display Recurring Earnings List")
                {
                    Image = List;
                    RunObject = page "Payment & Deductions";
                    RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Payment), Closed = CONST(true);
                }
            }
            group(Deductions)
            {
                action("Assign Deductions")
                {
                    Image = TaxPayment;
                    RunObject = page "Payment & Deductions";
                    RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Closed = CONST(false);
                }
                action("Deductions List")
                {
                    Image = List;
                    RunObject = page Deductions;
                }
                action("Display Recurring  Deductions  List")
                {
                    Image = List;
                    RunObject = page "Payment & Deductions";
                    RunPageLink = "Employee No" = FIELD("No."), Type = CONST(Deduction), Closed = CONST(true);
                }
            }

            action(Payslip)
            {
                Image = DepositSlip;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    EmpRec: Record Employee;
                begin
                    EmpRec.RESET;
                    EmpRec.SETRANGE(EmpRec."No.", "No.");
                    IF EmpRec.FIND('-') THEN
                        REPORT.RUN(51513117, TRUE, TRUE, EmpRec);
                end;

            }

        }
    }

    var
        ShortcutDimCode: array[8] of Code[20];
}