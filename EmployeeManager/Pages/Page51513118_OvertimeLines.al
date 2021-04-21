page 51513118 "Overtime Lines"
{
    // version PAYROLL

    Editable = true;
    PageType = ListPart;
    SourceTable = "Overtime Line";
    Caption = 'Overtime Lines';
    layout
    {
        area(content)
        {
            repeater(Control2)
            {
                field("Code"; Code)
                {
                    Visible = false;
                }
                field("Line No"; "Line No")
                {
                    Visible = false;
                }
                field("Employee No"; "Employee No")
                {
                }
                field("Employee Name"; "Employee Name")
                {
                    Editable = false;
                }
                field(Date; Date)
                {
                }
                field(Hours; Hours)
                {
                }
                field("Hours Normal"; "Hours Normal")
                {
                    Caption = 'Weekday';
                }
                field("Hours Double"; "Hours Double")
                {
                    Caption = 'Weekend and Holidays';
                }
                field(Amount; Amount)
                {
                    Editable = false;
                }
                field(Paid; Paid)
                {
                    Editable = false;
                }
                field("Payroll Period"; "pay period")
                {
                }
                field("Overttime Code"; "Overttime Code")
                {
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("Overtime Menu")
            {
                Caption = 'Overtime Menu';
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

