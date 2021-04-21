tableextension 51513261 "Human Resource Setup Ext" extends "Human Resources Setup"
{
    fields
    {
        field(50000; "Recruitment Needs Nos."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Recruitment Needs Nos.';
            TableRelation = "No. Series";
        }
        field(50001; "Applicants Nos."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Applicants Nos.';
            TableRelation = "No. Series";

        }
        field(50008; "Payroll Rounding Precision"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Payroll Rounding Precision';
        }
        field(50009; "Payroll Rounding Type"; Option)
        {
            OptionMembers = Nearest,Up,Down;
            DataClassification = CustomerContent;
            Caption = 'Payroll Rounding Type';
        }
        field(50031; "No. Of Days in Month"; Decimal)
        {
            Caption = 'No. Of Days in Month';
            DataClassification = CustomerContent;
        }
        field(50033; "Cover Selection Nos"; Code[10])
        {
            DataClassification = customercontent;
            Caption = 'Cover Selection Nos';
            TableRelation = "No. Series";
        }
        field(50037; "Training Request Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50040; "Account No (Training)"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(50067; "Retirement Age"; DateFormula)
        {
            DataClassification = customercontent;
            Caption = 'Retirement Age';
        }
        field(50091; "Disciplinary Cases File"; Text[240])
        {
        }
        field(50092; "Disciplinary Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50105; "Employee Transfer Nos"; Code[10])
        {
            TableRelation = "No. Series";
            Caption = 'Employee Transfer Nos';
            DataClassification = CustomerContent;
        }
        field(50114; "Exit Interview Nos."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50049; "Base Calender Code"; Code[20])
        {
            TableRelation = "Base Calendar".Code;
        }
        field(50130; "AIC Job Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50131; "AIC Applicant Nos."; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50132; "Non-Wall Numbers"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
        field(50153; "Residential Selection Nos"; Code[20])
        {
            TableRelation = "No. Series".Code;
        }
    }
}