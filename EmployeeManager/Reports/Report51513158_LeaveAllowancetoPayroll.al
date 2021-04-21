report 51513158 "Leave Allowance to Payroll"
{
    // version PAYROLL
    Caption = 'Leave Allowance to Payroll';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Leave Allowance to Payroll.rdl';

    dataset
    {
        dataitem(Employee; Employee)
        {
            column(EmployeeNo; Employee."No.")
            {
            }
            column(Name; Name)
            {
            }
            column(LengthOfService; LengthOfService)
            {
            }
            column(Grade; Employee."Salary Scale")
            {
            }
            column(AmountPayable; AmountPayable)
            {
            }

            trigger OnAfterGetRecord();
            begin
                EmployeeLeaves.RESET;
                EmployeeLeaves.SETRANGE(EmployeeLeaves."Employee No", Employee."No.");
                EmployeeLeaves.SETRANGE(EmployeeLeaves."Maturity Date", TODAY, CALCDATE('1Y', TODAY));
                EmployeeLeaves.SETRANGE(EmployeeLeaves."Leave  Allowance Paid", true);
                if EmployeeLeaves.FIND('-') then
                    CurrReport.SKIP;

                if (TODAY - Employee."Date Of Join") < 180 then
                    CurrReport.SKIP;

                LengthOfService := '';
                AmountPayable := 0;

                Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";

                if (Employee."Date Of Join" <> 0D) then
                    LengthOfService := Dates.DetermineAge(Employee."Date Of Join", TODAY);


                if (Employee."Salary Scale" >= '1') and (Employee."Salary Scale" <= '4') then
                    AmountPayable := 50000
                else
                    if (Employee."Salary Scale" >= '5') and (Employee."Salary Scale" <= '6') then
                        AmountPayable := 45000
                    else
                        if (Employee."Salary Scale" >= '7') and (Employee."Salary Scale" <= '8') then
                            AmountPayable := 35000
                        else
                            if (Employee."Salary Scale" >= '9') then
                                AmountPayable := 30000
                            else
                                AmountPayable := 0;

                HRSetup.GET;

                PayrollPeriod.RESET;
                PayrollPeriod.SETRANGE(PayrollPeriod."Close Pay", false);
                if PayrollPeriod.FIND('-') then
                    PayPeriodStart := PayrollPeriod."Starting Date";


                AssignmentMatrix.RESET;
                AssignmentMatrix."Employee No" := Employee."No.";
                AssignmentMatrix.Type := AssignmentMatrix.Type::Payment;
                AssignmentMatrix.Code := HRSetup."Leave Allowance Code";
                AssignmentMatrix.VALIDATE(Code);
                AssignmentMatrix.Taxable := true;
                AssignmentMatrix."Next Period Entry" := false;
                AssignmentMatrix.Amount := AmountPayable;
                AssignmentMatrix."Global Dimension 1 code" := Employee."Global Dimension 2 Code";
                AssignmentMatrix."Payroll Period" := PayPeriodStart;
                AssignmentMatrix.VALIDATE("Payroll Period");
                if not AssignmentMatrix.GET(AssignmentMatrix."Employee No", AssignmentMatrix.Type, AssignmentMatrix.Code, AssignmentMatrix."Payroll Period") then
                    AssignmentMatrix.INSERT;

                EmployeeLeaves.RESET;
                EmployeeLeaves.SETRANGE(EmployeeLeaves."Employee No", Employee."No.");
                EmployeeLeaves.SETRANGE(EmployeeLeaves."Maturity Date", TODAY, CALCDATE('1Y', TODAY));
                if EmployeeLeaves.FIND('-') then begin
                    EmployeeLeaves."Leave  Allowance Paid" := true;
                    EmployeeLeaves.MODIFY;
                end;
            end;

            trigger OnPreDataItem();
            begin
                EmployeeLeaves.RESET;
                EmployeeLeaves.SETRANGE(EmployeeLeaves."Employee No", Employee."No.");
                EmployeeLeaves.SETRANGE(EmployeeLeaves."Maturity Date", TODAY, CALCDATE('1Y', TODAY));
                EmployeeLeaves.SETRANGE(EmployeeLeaves."Leave  Allowance Paid", true);
                if EmployeeLeaves.FIND('-') then
                    CurrReport.SKIP;

                if (TODAY - Employee."Date Of Join") < 180 then
                    CurrReport.SKIP;
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Name: Text[80];
        LengthOfService: Text[150];
        Grades: Record "Salary Scales";
        AmountPayable: Decimal;
        AssignmentMatrix: Record "Assignment Matrix";
        Dates: Codeunit "HR Datesss";
        HRSetup: Record "Human Resources Setup";
        PayrollPeriod: Record "Payroll Period";
        PayPeriodStart: Date;
        EmployeeLeaves: Record "Employee Leaves";
}

