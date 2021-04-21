page 51513084 "Payment & Deductions"
{
    // version PAYROLL

    DataCaptionFields = "Employee No", Type, "Code";
    PageType = Card;
    SourceTable = "Assignment Matrix";
    Caption = 'Payment & Deductions';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Employee No"; "Employee No")
                {
                    Visible = false;
                }
                field(Closed; Closed)
                {
                    Editable = false;
                    Visible = false;
                }
                field(Type; Type)
                {
                    Visible = FALSE;
                }
                field("Code"; Code)
                {

                    trigger OnValidate();
                    begin
                        /* IF Type=Type::Deduction THEN
                         BEGIN
                         IF Deductions.GET(Code) THEN
                         IF Deductions.Loan=TRUE THEN
                         ERROR('You cannot enter loans through this screen');
                         END; */

                    end;
                }
                field(Batch; Batch)
                {
                }
                field("Policy No./Loan No."; "Policy No./Loan No.")
                {
                }
                field("Loan Product Type"; "Loan Product Type")
                {
                    Visible = false;
                }
                field("Payroll Period"; "Payroll Period")
                {
                    Visible = true;
                }
                field("Insurance Code"; "Insurance Code")
                {
                    Visible = false;
                }
                field("Gratuity PAYE"; "Gratuity PAYE")
                {
                    Visible = false;
                }
                field("Effective Start Date"; "Effective Start Date")
                {
                    Visible = true;
                }
                field("Effective End Date"; "Effective End Date")
                {
                    Visible = true;
                }
                field("Main Deduction Code"; "Main Deduction Code")
                {
                    Visible = false;
                }
                field(Description; Description)
                {
                }
                field("Basic Salary Code"; "Basic Salary Code")
                {
                    Visible = false;
                }
                field("No. of Units"; "No. of Units")
                {
                    Visible = false;
                }
                field(Frequency; Frequency)
                {
                    Visible = false;
                }
                field(CFPay; CFPay)
                {
                    Visible = false;
                }
                field("Period Repayment"; "Period Repayment")
                {
                    Visible = false;
                }
                field(Amount; Amount)
                {

                    trigger OnValidate();
                    begin
                        "Manual Entry" := true;
                    end;
                }
                field("Amount(LCY)"; "Amount(LCY)")
                {
                }
                field("Global Dimension 1 code"; "Global Dimension 1 code")
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 3 Code")
                {

                }
                field("No of Months"; "No of Months")
                {
                }
                field("Voluntary Percentage"; "Voluntary Percentage")
                {
                }
                field("Employee Voluntary"; "Employee Voluntary")
                {
                }
                field("Outstanding Amount"; "Outstanding Amount")
                {
                    Visible = false;
                }
                field("Employer Amount"; "Employer Amount")
                {
                }
                field("Employer Amount(LCY)"; "Employer Amount(LCY)")
                {
                }
                field("Next Period Entry"; "Next Period Entry")
                {
                }
                field("Opening Balance Company"; "Opening Balance Company")
                {
                }
                field("Opening Balance"; "Opening Balance")
                {
                    Visible = true;
                }
                field(Cost; Cost)
                {
                }
                field("Loan Repay"; "Loan Repay")
                {
                    Visible = false;
                }
                field("Non-Cash Benefit"; "Non-Cash Benefit")
                {
                    Visible = false;
                }
                field(Taxable; Taxable)
                {
                    Visible = true;
                }
                field(Retirement; Retirement)
                {
                    Visible = false;
                }
                field("Tax Deductible"; "Tax Deductible")
                {
                    Visible = false;
                }
                field("Taxable amount"; "Taxable amount")
                {
                    Editable = false;
                    Visible = false;
                }
                field(Quarters; Quarters)
                {
                    Visible = false;
                }
                field("Loan Interest"; "Loan Interest")
                {
                }
                field("Interest Amount"; "Interest Amount")
                {
                    Visible = false;
                }
                field("Normal Earnings"; "Normal Earnings")
                {
                }
                field("Posting Group Filter"; "Posting Group Filter")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean;
    begin
        /*  IF Type=Type::Deduction THEN
          BEGIN
          IF Deductions.GET(Code) THEN
          IF Deductions.Loan=TRUE THEN
          ERROR('You cannot delete loans through this screen');
          END;*/

    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        /* IF Type=Type::Deduction THEN
         BEGIN
         IF Deductions.GET(Code) THEN
         IF Deductions.Loan=TRUE THEN
         ERROR('You cannot enter loans through this screen');
         END;*/

    end;

    trigger OnModifyRecord(): Boolean;
    begin
        /*if Type = Type::Deduction then begin
            if Deductions.GET(Code) then
                ;*/
        //IF Deductions.Loan=TRUE THEN
        //ERROR('You cannot modify loans through this screen');
        //end;
    end;

    var
    /* GetGroup: Codeunit "Payment- Post";
     GroupCode: Code[20];
     CUser: Code[20];
     Deductions: Record Deductions;*/
}

