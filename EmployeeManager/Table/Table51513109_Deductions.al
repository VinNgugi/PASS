table 51513109 Deductions
{
    // version PAYROLL

    DataCaptionFields = "Code", Description;
    DrillDownPageID = "Deductions listing";
    LookupPageID = "Deductions listing";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionMembers = Recurring,"Non-recurring";
        }
        field(6; "Tax deductible"; Boolean)
        {
            Caption = 'Tax deductible';
            DataClassification = CustomerContent;
        }
        field(7; Advance; Boolean)
        {
            Caption = 'Advance';
            DataClassification = CustomerContent;
        }
        field(8; "Start date"; Date)
        {
            Caption = 'Start date';
            DataClassification = CustomerContent;
        }
        field(9; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(10; Percentage; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = CustomerContent;
        }
        field(11; "Calculation Method"; Option)
        {
            Caption = 'Calculation Method';
            DataClassification = CustomerContent;
            OptionCaption = 'Flat Amount,% of Basic Pay,Based on Table,Based on Hourly Rate,Based on Daily Rate ,% of Gross Pay,% of Basic Pay+Hse Allowance,% of Salary Recovery,% of Basic+House+Transport,Based on Age,% of Gross Pay Entries';
            OptionMembers = "Flat Amount","% of Basic Pay","Based on Table","Based on Hourly Rate","Based on Daily Rate ","% of Gross Pay","% of Basic Pay+Hse Allowance","% of Salary Recovery","% of Basic+House+Transport","Based on Age","% of Gross Pay Entries";
        }
        field(12; "Account No."; Code[10])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
            TableRelation = if ("Posting Account Type" = filter ("G/L Account")) "G/L Account"
            else
            if ("Posting Account Type" = filter ("Vendor")) Vendor."No."
            else
            if ("Posting Account Type" = filter ("Customer")) customer."No.";
        }
        field(13; "Flat Amount"; Decimal)
        {
            Caption = 'Flat Amount';
            DataClassification = CustomerContent;
        }
        field(14; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE (Type = FILTER (Deduction | "Saving Scheme"),
                                                                Code = FIELD (Code),
                                                                "Posting Group Filter" = FIELD ("Posting Group Filter"),
                                                                "Payroll Period" = FIELD ("Pay Period Filter"),
                                                                "Employee No" = FIELD ("Employee Filter"),
                                                                "Global Dimension 2 Code" = FIELD ("Global Dimension 2 Filter"),
                                                                "Reference No" = FIELD ("Reference Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(15; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            DataClassification = CustomerContent;
        }
        field(16; "Posting Group Filter"; Code[20])
        {
            Caption = 'Posting Group Filter';
            FieldClass = FlowFilter;
            TableRelation = "Staff Posting Group";
        }
        field(17; Loan; Boolean)
        {
            Caption = 'Loan';
            DataClassification = CustomerContent;
        }
        field(18; "Maximum Amount"; Decimal)
        {
            Caption = 'Maximum Amount';
            DataClassification = CustomerContent;
        }
        field(19; "Grace period"; DateFormula)
        {
            Caption = 'Grace period';
            DataClassification = CustomerContent;
        }
        field(20; "Repayment Period"; DateFormula)
        {
            Caption = 'Repayment Period';
            DataClassification = CustomerContent;
        }
        field(21; "Pay Period Filter"; Date)
        {
            Caption = 'Pay Period Filter';
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
        }
        field(26; "Pension Scheme"; Boolean)
        {
            Caption = 'Pension Scheme';
            DataClassification = CustomerContent;
        }
        field(27; "Deduction Table"; Code[10])
        {
            Caption = 'Deduction Table';
            DataClassification = CustomerContent;
            TableRelation = "Bracket Tables";
        }
        field(28; "G/L Account Employer"; Code[10])
        {
            Caption = 'G/L Account Employer';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(29; "Percentage Employer"; Decimal)
        {
            Caption = 'Percentage Employer';
            DataClassification = CustomerContent;
        }
        field(30; "Minimum Amount"; Decimal)
        {
            Caption = 'Minimum Amount';
            DataClassification = CustomerContent;
        }
        field(31; "Flat Amount Employer"; Decimal)
        {
            Caption = 'Flat Amount Employer';
            DataClassification = CustomerContent;
        }
        field(32; "Total Amount Employer"; Decimal)
        {
            Caption = 'Total Amount Employer';
            CalcFormula = Sum ("Assignment Matrix"."Employer Amount" WHERE (Type = CONST (Deduction),
                                                                           Code = FIELD (Code),
                                                                           "Employee No" = field ("Employee Filter"),
                                                                           "Payroll Period" = FIELD ("Pay Period Filter"),
                                                                           "Posting Group Filter" = FIELD ("Posting Group Filter")));
            FieldClass = FlowField;
        }
        field(33; "Loan Type"; Option)
        {
            Caption = 'Loan Type';
            DataClassification = CustomerContent;
            OptionMembers = " ","Low Interest Benefit","Fringe Benefit";
        }
        field(34; "Show Balance"; Boolean)
        {
            Caption = 'Show Balance';
            DataClassification = CustomerContent;
        }
        field(35; CoinageRounding; Boolean)
        {
            Caption = 'CoinageRounding';
            DataClassification = CustomerContent;
        }
        field(36; "Employee Filter"; Code[10])
        {
            Caption = 'Employee Filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(37; "Opening Balance"; Decimal)
        {
            Caption = 'Opening Balance';
            CalcFormula = Sum ("Assignment Matrix"."Opening Balance" WHERE (Type = CONST (Deduction),
                                                                           Code = FIELD (Code),
                                                                           "Employee No" = FIELD ("Employee Filter")));
            FieldClass = FlowField;
        }
        field(38; "Global Dimension 2 Filter"; Code[10])
        {
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(39; "Balance Mode"; Option)
        {
            Caption = 'Balance Mode';
            FieldClass = FlowFilter;
            OptionMembers = Increasing," Decreasing";
        }
        field(40; "Main Loan Code"; Code[20])
        {
            Caption = 'Main Loan Code';
            DataClassification = CustomerContent;
        }
        field(41; Shares; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Shares';
        }
        field(42; "Show on report"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Show on report';
        }
        field(43; "Non-Interest Loan"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Non-Interest Loan';
        }
        field(44; "Exclude when on Leave"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Exclude when on Leave';
        }
        field(45; "Co-operative"; Boolean)
        {
            Caption = 'Co-operative';
            DataClassification = CustomerContent;
        }
        field(46; "Total Shares"; Decimal)
        {
            Caption = 'Total Shares';

            CalcFormula = Sum ("Assignment Matrix".Amount WHERE (Type = CONST (Deduction),
                                                                Code = FIELD (Code),
                                                                "Employee No" = FIELD ("Employee Filter"),
                                                                Shares = CONST (true)));
            FieldClass = FlowField;
        }
        field(47; Rate; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Rate';
        }
        field(48; "PAYE Code"; Boolean)
        {
        }
        field(49; "Total Days"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50; "Housing Earned Limit"; Decimal)
        {
        }
        field(51; "Pension Limit Percentage"; Decimal)
        {
        }
        field(52; "Pension Limit Amount"; Decimal)
        {
        }
        field(53; "Applies to All"; Boolean)
        {
        }
        field(54; "Show on Master Roll"; Boolean)
        {
        }
        field(55; "Pension Scheme Code"; Boolean)
        {
        }
        field(56; "Main Deduction Code"; Code[10])
        {
        }
        field(57; "Insurance Code"; Boolean)
        {
        }
        field(58; Block; Boolean)
        {
        }
        field(59; "Institution Code"; Code[20])
        {
            TableRelation = Institutions;
        }
        field(60; "Reference Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(61; "Show on Payslip Information"; Boolean)
        {
        }
        field(62; "Voluntary Percentage"; Decimal)
        {
        }
        field(63; "Salary Recovery"; Boolean)
        {
            Description = 'For Paye manual calculation';
        }
        field(64; Gratuity; Boolean)
        {
        }
        field(65; "Gratuity Arrears"; Boolean)
        {
        }
        field(66; Informational; Boolean)
        {
        }
        field(67; Board; Boolean)
        {
        }
        field(68; "Pension Arrears"; Boolean)
        {
        }
        field(69; Voluntary; Boolean)
        {
        }
        field(70; "Voluntary Amount"; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE (Code = FIELD ("Voluntary Code"),
                                                                "Payroll Period" = FIELD ("Pay Period Filter"),
                                                                "Employee No" = FIELD ("Employee Filter"),
                                                                Type = CONST (Deduction)));
            FieldClass = FlowField;
        }
        field(71; "Voluntary Code"; Code[20])
        {
            TableRelation = Deductions WHERE (Voluntary = CONST (true));
        }
        field(50000; "PE Activity Code"; Code[20])
        {
            // TableRelation = "Procurement Plan Header"."PE Activity Code";
        }
        field(50001; vendor; Code[20])
        {
            TableRelation = Vendor;
        }
        field(50002; Individual; Boolean)
        {
        }
        field(50003; "NHIF Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "NSSF Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "NITA Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "HELB Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Country/Region Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(50008; "Severance Pay"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Flat Amount Core"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Flat Amount Projects"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Medical Scheme"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Maximun Amount Employer"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Employer Contribution Taxable"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Show on A4"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; Month; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',January,February,March,April,May,June,July,August,September,October,November,December';
            OptionMembers = ,January,February,March,April,May,June,July,August,September,October,November,December;
        }
        field(50016; "Substitute Earning"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Earnings.Code;
        }
        field(50017; Provision; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "Vehicle Grant"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Default Cost Center"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Tax Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50021; "Default PA Account"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; "WCF Deduction"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50023; "Posting Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
    }

    keys
    {
        key(Key1; "Code", "Country/Region Code")
        {
        }
        key(Key2; "Show on report")
        {
        }
        key(Key3; "Exclude when on Leave")
        {
        }
        key(Key4; "Co-operative")
        {
        }
        key(Key5; Rate)
        {
        }
        key(Key6; Shares)
        {
        }
        key(Key7; Loan)
        {
        }
        key(Key8; "Pension Scheme Code")
        {
        }
        key(Key9; "Institution Code")
        {
        }
        key(Key10; "Main Deduction Code")
        {
        }
    }

    fieldgroups
    {
    }
}

