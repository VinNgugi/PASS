page 51513121 "Workdone Lines"
{
    // version PAYROLL

    Editable = true;
    PageType = ListPart;
    SourceTable = "Workdone Lines";
    Caption = 'Workdone Lines';
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Code"; Code)
                {
                    Visible = false;
                }
                field("Payroll Period"; "Payroll Period")
                {
                }
                field("Employee No"; "Employee No")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                }
                field(Amount; Amount)
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Bonus Menu")
            {
                Caption = 'Bonus Menu';
                Image = CashFlow;
                action("Suggest Staff")
                {
                    Image = SalesInvoice;

                    trigger OnAction();
                    var
                        OvertimeHeader: Record "Overtime Header";
                        OvertimePayrollComputation: Codeunit "Overtime Payroll Computation";
                    begin
                        OvertimeHeader.RESET;
                        OvertimeHeader.SETFILTER(Code, Code);
                        if OvertimeHeader.FINDSET then begin
                            OvertimePayrollComputation.Overtimetemplate(OvertimeHeader);
                            OvertimePayrollComputation.RUN;
                        end;
                    end;
                }
            }
        }
    }
}

