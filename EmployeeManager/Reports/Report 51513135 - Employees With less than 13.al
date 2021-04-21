report 51513135 "Employees With less than 1/3"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Employees With less than 13.rdl';
    Caption = 'Employees With less than 1/3';

    dataset
    {
        dataitem(Employee; Employee)
        {
            RequestFilterFields = "No.", "Employee's Bank";
            column(CompRec_Picture; CompRec.Picture)
            {
            }
            column(No_Employee; Employee."No.")
            {
            }
            column(FirstName_Employee; Employee."First Name")
            {
            }
            column(MiddleName_Employee; Employee."Middle Name")
            {
            }
            column(LastName_Employee; Employee."Last Name")
            {
            }
            column(Grosspay_Employee; Employee.Basic)
            {
            }
            /*column(Netpay_Employee; Employee."Net pay")
            {
            }*/
            column(GrossPay; GrossPay)
            {
            }
            column(TotalDeduction; TotalDeduction)
            {
            }

            trigger OnAfterGetRecord();
            begin

                CALCFIELDS(Employee.Basic);
                GrossPay := 0;
                TotalDeduction := 0;
                Earn.RESET;
                Earn.SETRANGE(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SETRANGE(Earn."Non-Cash Benefit", false);
                if Earn.FIND('-') then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", PayrollPeriod);
                        AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(Code, Earn.Code);
                        if AssignMatrix.FIND('-') then begin
                            repeat
                                GrossPay := GrossPay + ROUND(AssignMatrix.Amount, 0.01);
                            until AssignMatrix.NEXT = 0;
                        end;
                    until Earn.NEXT = 0;
                end;
                //MESSAGE('%1',GrossPay);
                if GrossPay = 0 then begin
                    CurrReport.SKIP;
                end;

                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", PayrollPeriod);
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                // AssignMatrix.SETRANGE(AssignMatrix.Paye,TRUE);
                if AssignMatrix.FIND('-') then
                    repeat
                        TotalDeduction := TotalDeduction + ABS(AssignMatrix.Amount);
                    until AssignMatrix.NEXT = 0;
                // Message('%1', TotalDeduction);


                //Employee.CALCFIELDS(Employee."Net pay",Employee."Taxable Allowance");
                //Employee.CALCFIELDS(Employee."Gross pay");
                //Employee."Gross pay":=Employee."Taxable Allowance";
                //Message('%1..%2',Employee."Net pay",Employee."Gross pay");
                /*Employee."Gross pay" := GrossPay;
                Employee."Net pay" := GrossPay - TotalDeduction;
                if Employee."Net pay" > 1 / 3 * Employee.Basic then begin
                    if Showall = false then begin
                        CurrReport.SKIP;
                    end;
                end;*/ //Commented be Steve
                //MESSAGE('%1 %2',Employee."No.",Employee."First Name"+' '+Employee."Middle Name"+' '+Employee."Last Name");
            end;

            trigger OnPreDataItem();
            begin
                Employee.SETRANGE(Employee."Pay Period Filter", PayrollPeriod);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(PayrollPeriod; PayrollPeriod)
                {
                    Caption = 'Payroll Period';
                    TableRelation = "Payroll Period"."Starting Date" WHERE (Closed = CONST (true));
                }
                field(Showall; Showall)
                {
                    Caption = 'Show All?';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        CompRec.GET;
        CompRec.CALCFIELDS(Picture);
    end;

    var
        CompRec: Record "Company Information";
        PayrollPeriod: Date;
        Earn: Record Earnings;
        AssignMatrix: Record "Assignment Matrix";
        GrossPay: Decimal;
        TotalDeduction: Decimal;
        Showall: Boolean;
}

