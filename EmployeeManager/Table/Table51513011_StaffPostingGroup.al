table 51513011 "Staff Posting Group"
{
    // version FINANCE

    DataCaptionFields = "Code", Description;
    DrillDownPageID = "Staff Posting Group";
    LookupPageID = "Staff Posting Group";
    Caption = 'Staff Posting Group';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[10])
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
        field(3; "Salary Account"; Code[10])
        {
            Caption = 'Salary Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(4; "Income Tax Account"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Income Tax Account';
            TableRelation = "G/L Account";
        }
        field(5; "SSF Employer Account"; Code[10])
        {
            Caption = 'SSF Employer Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(6; "SSF Employee Account"; Code[10])
        {
            Caption = 'SSF Employee Account';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(7; "Net Salary Payable"; Code[10])
        {
            Caption = 'Net Salary Payable';
            DataClassification = CustomerContent;
            TableRelation = if ("Account Type" = filter ("G/L Account")) "G/L Account"."No."
            else
            if ("Account Type" = filter ("Vendor")) Vendor."No."
            else
            if ("Account Type" = filter ("Customer")) customer."No.";
        }
        field(8; "Operating Overtime"; Code[10])
        {
            Caption = 'Operating Overtime';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(9; "Tax Relief"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Relief';
            TableRelation = "G/L Account";
        }
        field(10; "Employee Provident Fund Acc."; Code[10])
        {
            Caption = 'Employee Provident Fund Acc.';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
        field(11; "Pay Period Filter"; Date)
        {
            Caption = 'Pay Period Filter';
            FieldClass = FlowFilter;
            TableRelation = "Payroll Period";
        }
        field(12; "Pension Employer Acc"; Code[10])
        {
        }
        field(13; "Pension Employee Acc"; Code[10])
        {
        }
        field(14; "Earnings and deductions"; Code[10])
        {
        }
        field(15; "Daily Salary"; Decimal)
        {
            FieldClass = Normal;
        }
        field(16; "Normal Overtime"; Decimal)
        {
            FieldClass = Normal;
        }
        field(17; "Weekend Overtime"; Decimal)
        {
            FieldClass = Normal;
        }
        field(18; "Enterprise Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(19; "Activity Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(20; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(21; Seasonals; Boolean)
        {
        }
        field(22; "Fringe benefits"; Code[10])
        {
            TableRelation = "G/L Account";
        }
        field(23; "Is Temporary"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Is Permanent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Is Intern"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Is Contract"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Increament Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Tax Percentage"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Allow Batches"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Run per Salary Group"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Salary Incre Month"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Dependant Tax relief Perc"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Tax Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Deductions.Code;
        }
        field(34; "Increase Basic Only PAR"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Basic Perc(On Gross)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Show Additional Info"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Prorate Salary"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Tax Relief Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Earnings.Code WHERE ("Earning Type" = CONST ("Tax Relief"));
        }
        field(39; "Personal Account Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Deductions.Code;
        }
        field(40; "Development levy Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            //  TableRelation = Deductions.Code WHERE (Month = FILTER (<> 0));
        }
        field(41; "Severance Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Deductions.Code WHERE (Provision = CONST (true));
        }
        field(42; "Medical Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Deductions.Code WHERE (Provision = CONST (true));
        }
        field(43; "Lunch Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Deductions.Code WHERE (Provision = CONST (true));
        }
        field(44; "Dep. Tax relief creteria"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '" ,Based on Table"';
            OptionMembers = " ","Based on Table";
        }
        field(45; "Round Down (1000)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Dependants based Tax"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Combine Pension"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Max No of Dependants"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Account Type"; Option)
        {
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }

    }

    keys
    {
        key(Key1; "Code")
        {
        }
        key(Key2; "Earnings and deductions")
        {
        }
    }

    fieldgroups
    {
    }
}

