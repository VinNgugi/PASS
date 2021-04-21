tableextension 51513250 "Human Resource Setup Ext_2" extends "Human Resources Setup"
{
    fields
    {
        field(50016; "General Payslip Message"; Text[100])
        {
        }
        field(50122; "Overtime No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50124; "Deduction Import No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50125; "Tax Table"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Table';
            TableRelation = "Bracket Tables";
        }
        field(50028; "Leave Application Nos."; Code[10])
        {
            TableRelation = "No. Series".Code;
        }
        field(50034; "Qualification Days (Leave)"; Decimal)
        {
        }
        field(50035; "Leave Allowance Code"; Code[10])
        {
            TableRelation = Earnings;
        }
        field(50038; "Leave Recall Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50044; "Leave Plan Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50061; "Vehicle Filling No"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50083; "Email Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50085; "Payroll Administrator Email"; Text[50])
        {
            DataClassification = CustomerContent;
            caption = 'Payroll Administrator Email';
            ExtendedDatatype = EMail;
        }
        field(50090; "Casuals Payment Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50052; "Employee Absentism"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50065; "Appraisal Objective Nos"; Code[10])
        {
            TableRelation = "No. Series";
        }
        field(50111; "HR HOD"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(50117; "Time Sheet Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50119; "Leave Template"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Leave Journal Template".Name;
        }
        field(50120; "Leave Batch"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HR Leave Journal Batch".Name where ("Journal Template Name" = field ("Leave Template"));
        }
        field(50115; "Intern Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50116; "Employee On Contract Nos"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(50121; "Gratuity Validity Period"; DateFormula)
        {
            DataClassification = ToBeClassified;

        }
        field(50022; "Payroll Template"; code[20])
        {
            TableRelation = "Gen. Journal Template" where (Type = filter (General));
        }
        field(50023; "Payroll Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name" = field ("Payroll Template"));
        }
        field(50024; "Training Need Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50025; "Training Evaluation Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }

        field(50043; "Appraisal Nos"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50045; "Intern/Temp Batch"; Code[20])
        {
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name" = field ("Payroll Template"));
        }
        field(50046; "Leave Deduction Code"; Code[20])
        {
            TableRelation = Deductions.Code where (Block = const (false));
        }
        field(50123; "Finance Emails"; Text[100])
        {

        }
        field(50126; "L.Allowance Days Setup"; DateFormula)
        {
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                PayrollPeriod.Reset();
                PayrollPeriod.SetRange(Closed, false);
                if PayrollPeriod.FindSet() then
                    repeat
                        PayrollPeriod."L.Allowance Cutoff Date" := CalcDate(("L.Allowance Days Setup"), PayrollPeriod."Starting Date");
                        PayrollPeriod.Modify();
                    until PayrollPeriod.Next() = 0;
            end;
        }
    }
    var
        PayrollPeriod: Record "Payroll Period";
}