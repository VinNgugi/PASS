table 51513106 "Loans transactions"
{
    // version PAYROLL
    Caption = 'Loans transactions';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            NotBlank = true;
            TableRelation = Deductions WHERE (Loan = CONST (true));

            trigger OnValidate();
            begin
                if Deductions.GET(Code) then begin
                    Name := Deductions.Description;
                    "Maximum limit" := Deductions."Maximum Amount";
                    "Repayment Grace period" := Deductions."Grace period";
                    "Repayment Period" := Deductions."Repayment Period";
                end;
                if EmpRec.GET(Employee) then;
                //"Debtor Code" := EmpRec."Customer Code";
            end;
        }
        field(2; Name; Text[30])
        {
        }
        field(3; Employee; Code[20])
        {
            TableRelation = Employee;
        }
        field(4; "Maximum limit"; Decimal)
        {
        }
        field(5; "Loan Amount"; Decimal)
        {
        }
        field(6; "Repayment Grace period"; DateFormula)
        {
        }
        field(7; "Repayment Period"; DateFormula)
        {
        }
        field(8; "Outstanding Amount"; Decimal)
        {
        }
        field(9; "Amount Paid"; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE ("Employee No" = FIELD (Employee),
                                                                Type = CONST (Deduction),
                                                                Code = FIELD (Code),
                                                                "Payroll Period" = FIELD ("Date Filter")));
            FieldClass = FlowField;
        }
        field(10; "Period Repayments"; Decimal)
        {

            trigger OnValidate();
            begin
                if "Period Repayments" <> 0 then begin
                    "No. of Repayments Period" := ROUND("Loan Amount" / "Period Repayments", 1);

                end;
            end;
        }
        field(11; "Repayment Begin Date"; Date)
        {
        }
        field(12; "Repayment End Date"; Date)
        {
        }
        field(13; "Loan Date"; Date)
        {

            trigger OnValidate();
            begin
                "Repayment Begin Date" := CALCDATE("Repayment Grace period", "Loan Date");
                "Repayment End Date" := CALCDATE("Repayment Period", "Repayment Begin Date");
            end;
        }
        field(14; "No. of Repayments Period"; Integer)
        {
            InitValue = 1;

            trigger OnValidate();
            begin
                if "No. of Repayments Period" <> 0 then
                    "Period Repayments" := "Loan Amount" / "No. of Repayments Period";
                "Period Repayments" := ROUND("Period Repayments", 1, '>');
            end;
        }
        field(15; "Interest Rate"; Decimal)
        {
        }
        field(16; "Opening Balance"; Decimal)
        {
        }
        field(17; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
        }
        field(18; "Interest Type"; Option)
        {
            OptionMembers = Compound,Simple,"Simple Reducing Balance";
        }
        field(19; "Interest Repaid to Date"; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix"."Interest Amount" WHERE ("Employee No" = FIELD (Employee),
                                                                           Type = CONST (Deduction),
                                                                           Code = FIELD (Code),
                                                                           "Payroll Period" = FIELD (UPPERLIMIT ("Date Filter"))));
            FieldClass = FlowField;
        }
        field(20; "Cumm. Period Repayments"; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix"."Period Repayment" WHERE ("Employee No" = FIELD (Employee),
                                                                            Type = CONST (Deduction),
                                                                            Code = FIELD (Code),
                                                                            "Payroll Period" = FIELD ("Date Filter")));
            FieldClass = FlowField;
        }
        field(21; "Bal Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset";
        }
        field(22; "Bal Account No"; Code[10])
        {
            TableRelation = IF ("Bal Account Type" = CONST ("G/L Account")) "G/L Account"
            ELSE
            IF ("Bal Account Type" = CONST ("Bank Account")) "Bank Account";
        }
        field(23; "Interest Account"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(24; "Debt Updated"; Boolean)
        {
        }
        field(25; "Debtor Code"; Code[20])
        {
            TableRelation = Customer;
        }
        field(26; "External Interest Rate"; Decimal)
        {
        }
        field(27; "Cumm. Period Repayments1"; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix"."Period Repayment" WHERE ("Employee No" = FIELD (Employee),
                                                                            Type = CONST (Deduction),
                                                                            Code = FIELD (Code),
                                                                            "Payroll Period" = FIELD ("Date Filter"),
                                                                            Closed = CONST (true)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Code", Employee)
        {
            SumIndexFields = "Loan Amount";
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        if "Amount Paid" <> 0 then
            ERROR('Cannot delete a loan with repayments');
    end;

    var
        Deductions: Record Deductions;
        EmpRec: Record Employee;
}

