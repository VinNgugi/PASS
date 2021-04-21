page 51513120 "Consultancy Payment Card"
{
    // version PAYROLL

    SourceTable = "Overtime Header";
    Caption = 'Consultancy Payment Card';
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Code)
                {
                    Enabled = false;
                }
                field("Pay Period"; "Pay Period")
                {
                }
                field(Month; Month)
                {
                    Editable = false;
                }
                field("Overtime Paid"; Computed)
                {
                    Editable = false;
                }
                field(Unit; Unit)
                {
                }
                field("Unit Name"; "Unit Name")
                {
                }
                field(Paid; Paid)
                {
                }
                field(Description; Description)
                {
                }
                field("User ID"; "User ID")
                {
                }
                field(Status; Status)
                {
                }
                field("Date Prepared"; "Date Prepared")
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
            }
            part(Control7; "Workdone Lines")
            {
                SubPageLink = Code = FIELD (Code),
                              "Payroll Period" = FIELD ("Pay Period");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Run Payroll")
            {
                Image = RollUpCosts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    OvertimeComputation: Codeunit "Overtime Payroll Computation";
                begin
                    if CONFIRM('Are You Sure You Want to Run Bonus Payroll for the Payroll Period ' + FORMAT("Pay Period") + ' ?', false) = true then begin
                        OvertimeComputation.BonusPayroll(Rec);
                    end;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Types := Types::Bonus;
    end;
}

