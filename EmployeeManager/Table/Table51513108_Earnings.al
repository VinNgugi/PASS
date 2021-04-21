table 51513108 Earnings
{
    // version PAYROLL
    Caption = 'Earnings';
    DataClassification = CustomerContent;
    DataCaptionFields = "Code", Description;
    DrillDownPageID = "Earnings Listing";
    LookupPageID = "Earnings Listing";

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
        field(3; "Pay Type"; Option)
        {
            Caption = 'Pay Type';
            DataClassification = CustomerContent;
            OptionMembers = Recurring,"Non-recurring";
        }
        field(4; "Start Date"; Date)
        {
            Caption = 'Start Date';
            DataClassification = CustomerContent;
        }
        field(5; "End Date"; Date)
        {
            Caption = 'End Date';
            DataClassification = CustomerContent;
        }
        field(6; Taxable; Boolean)
        {
            Caption = 'Taxable';
            DataClassification = CustomerContent;
        }
        field(7; "Calculation Method"; Option)
        {
            Caption = 'Calculation Method';
            DataClassification = CustomerContent;
            OptionCaption = 'Flat amount,% of Basic pay,% of Gross pay,% of Insurance Amount,% of Taxable income,% of Basic after tax,Based on Hourly Rate,Based on Daily Rate,% of Salary Recovery,% of Loan Amount,% of Cost,Based on Age,No of Dependants';
            OptionMembers = "Flat amount","% of Basic pay","% of Gross pay","% of Insurance Amount","% of Taxable income","% of Basic after tax","Based on Hourly Rate","Based on Daily Rate","% of Salary Recovery","% of Loan Amount","% of Cost","Based on Age","No of Dependants";
        }
        field(8; "Flat Amount"; Decimal)
        {
            Caption = 'Flat Amount';
            DataClassification = CustomerContent;
        }
        field(9; Percentage; Decimal)
        {
            Caption = 'Percentage';
            DataClassification = CustomerContent;
            DecimalPlaces = 2 : 4;
        }
        field(10; "Account No."; Code[10])
        {
            Caption = 'Account No.';
            DataClassification = CustomerContent;
            TableRelation = if ("Posting Account Type" = filter ("G/L Account")) "G/L Account"
            else
            if ("Posting Account Type" = filter ("Vendor")) Vendor."No."
            else
            if ("Posting Account Type" = filter ("Customer")) customer."No.";
        }
        field(11;
        "Total Amount";
        Decimal)
        {
            Caption = 'Total Amount';
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE (Type = CONST (Payment),
                                                                Code = FIELD (Code),
                                                                "Posting Group Filter" = FIELD ("Posting Group Filter"),
                                                                "Payroll Period" = FIELD ("Pay Period Filter"),
                                                                "Employee No" = FIELD ("Employee Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Date Filter"; Date)
        {
        }
        field(13; "Posting Group Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Staff Posting Group";
        }
        field(14; "Pay Period Filter"; Date)
        {
            ClosingDates = false;
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
        }
        field(15; Quarters; Boolean)
        {
        }
        field(16; "Non-Cash Benefit"; Boolean)
        {
        }
        field(17; "Minimum Limit"; Decimal)
        {
        }
        field(18; "Maximum Limit"; Decimal)
        {
        }
        field(19; "Reduces Tax"; Boolean)
        {
        }
        field(20; "Overtime Factor"; Decimal)
        {
        }
        field(21; "Employee Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
        }
        field(22; Counter; Integer)
        {
            CalcFormula = Count ("Assignment Matrix" WHERE ("Payroll Period" = FIELD ("Pay Period Filter"),
                                                           "Employee No" = FIELD ("Employee Filter"),
                                                           Code = FIELD (Code)));
            FieldClass = FlowField;
        }
        field(23; NoOfUnits; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix"."No. of Units" WHERE (Code = FIELD (Code),
                                                                        "Payroll Period" = FIELD ("Pay Period Filter"),
                                                                        "Employee No" = FIELD ("Employee Filter")));
            FieldClass = FlowField;
        }
        field(24; "Low Interest Benefit"; Boolean)
        {
        }
        field(25; "Show Balance"; Boolean)
        {
        }
        field(26; CoinageRounding; Boolean)
        {
        }
        field(27; OverDrawn; Boolean)
        {
        }
        field(28; "Opening Balance"; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix"."Opening Balance" WHERE (Type = CONST (Payment),
                                                                           Code = FIELD (Code),
                                                                           "Employee No" = FIELD ("Employee Filter")));
            FieldClass = FlowField;
        }
        field(29; OverTime; Boolean)
        {
            FieldClass = Normal;
        }
        field(30; "Global Dimension 1 Filter"; Code[10])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(31; Months; Decimal)
        {
            Description = 'Used to cater for taxation based on annual bracket eg 1,12 months (the default is 1month) FOR NEPAL';
        }
        field(32; "Show on Report"; Boolean)
        {
        }
        field(33; "Time Sheet"; Boolean)
        {
        }
        field(34; "Total Days"; Decimal)
        {
            FieldClass = Normal;
        }
        field(35; "Total Hrs"; Decimal)
        {
            FieldClass = Normal;
        }
        field(36; Weekend; Boolean)
        {
        }
        field(37; Weekday; Boolean)
        {
        }
        field(38; "Basic Salary Code"; Boolean)
        {
        }
        field(39; "Default Enterprise"; Code[10])
        {
        }
        field(40; "Default Activity"; Code[10])
        {
        }
        field(41; "ProRata Leave"; Boolean)
        {
        }
        field(42; "Earning Type"; Option)
        {
            OptionMembers = "Normal Earning","Owner Occupier","Home Savings","Low Interest","Tax Relief","Insurance Relief","Disability Relief";
        }
        field(43; "Applies to All"; Boolean)
        {
        }
        field(44; "Show on Master Roll"; Boolean)
        {
        }
        field(45; "House Allowance Code"; Boolean)
        {
        }
        field(46; "Responsibility Allowance Code"; Boolean)
        {
        }
        field(47; "Commuter Allowance Code"; Boolean)
        {
        }
        field(48; Block; Boolean)
        {
        }
        field(49; "Basic Pay Arrears"; Boolean)
        {
        }
        field(50; "Market Rate"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(51; "Company Rate"; Decimal)
        {
            DecimalPlaces = 2 : 5;
        }
        field(52; Fringe; Boolean)
        {
        }
        field(53; "Salary Recovery"; Boolean)
        {
            Description = 'For PAYE Manual calculation';
        }
        field(54; "Loan Code"; Code[20])
        {
        }
        field(55; "Global Dimension 2 Filter"; Code[20])
        {
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(56; Board; Boolean)
        {
        }
        field(50000; "PE Activity Code"; Code[20])
        {
            //TableRelation = "Procurement Plan Header"."PE Activity Code";
        }
        field(50001; Recurs; Boolean)
        {
        }
        field(50002; "Fringe Benefit"; Boolean)
        {
        }
        field(50003; "Morgage Relief"; Boolean)
        {
        }
        field(50004; Bonus; Boolean)
        {
        }
        field(50005; "Leave Allowance Code"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Country/Region Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(50007; "Reduces Taxable Amount"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50008; "Max Cons. Relief(Monthly)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50009; "Cons Relief %"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; "Gross Pay Entry"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Show on A4"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Full Month Tax"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Amount Per Dependant"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50014; "Percentage to Pension"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "Gratuity Pay"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Accrue Net"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Posting Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
    }

    keys
    {
        key(Key1; "Code", "Country/Region Code")
        {
        }
        key(Key2; "Show on Report")
        {
        }
        key(Key3; OverTime)
        {
        }
        key(Key4; "Time Sheet")
        {
        }
        key(Key5; "Earning Type")
        {
        }
        key(Key6; "House Allowance Code")
        {
        }
        key(Key7; "Responsibility Allowance Code")
        {
        }
        key(Key8; "Commuter Allowance Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        AssignmentMat.RESET;
        AssignmentMat.SETRANGE(AssignmentMat.Type, AssignmentMat.Type::Payment);
        AssignmentMat.SETRANGE(AssignmentMat.Code, Code);
        if AssignmentMat.FIND('+') then
            ERROR('You cannot delete this earning because it has entries');
    end;

    var
        AssignmentMat: Record "Assignment Matrix";
}

