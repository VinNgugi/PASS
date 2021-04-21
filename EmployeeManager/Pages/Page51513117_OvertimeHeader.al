page 51513117 "Overtime Header"
{
    // version PAYROLL
    PageType = Card;
    SourceTable = "Overtime Header";
    Caption = 'Overtime Header';
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
                field(Types; Types)
                {
                }
                field(Unit; Unit)
                {
                }
                field("Unit Name"; "Unit Name")
                {
                    Editable = false;
                }
                field(Paid; Paid)
                {
                }
                field(Description; Description)
                {
                }
                field("Date Prepared"; "Date Prepared")
                {
                }
                field("Prepared By"; "Prepared By")
                {
                }
                field(Status; Status)
                {
                    Editable = false;
                }
            }
            part(Control7; "Overtime Lines")
            {
                SubPageLink = Code = FIELD (Code),
                              "pay period" = FIELD ("Pay Period");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Compute Overtime")
            {
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction();
                var
                    OvertimeComputation: Codeunit "Overtime Payroll Computation";
                begin
                    if CONFIRM('Are You Sure You Want to Compute Overtime for the Month of ' + Month + ' ?', false) = true then begin
                        OvertimeComputation.ComputeOvertime(Rec);
                    end;
                end;
            }
            action("Run Payroll")
            {
                Image = RollUpCosts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction();
                var
                    OvertimeComputation: Codeunit "Overtime Payroll Computation";
                begin
                    if CONFIRM('Are You Sure You Want to Run Overtime Payroll for the Payroll Period ' + FORMAT("Pay Period") + ' ?', false) = true then begin
                        OvertimeComputation.OvertimePayroll(Rec);
                    end;
                end;
            }
            action("Import Overtime")
            {

                trigger OnAction();
                begin
                    Importer.GetRec(Rec);
                    Importer.RUN;
                end;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Types := Types::Overtime;
        "User ID" := USERID;
    end;

    var
        Importer: XMLport "Import Overtime1";
}

