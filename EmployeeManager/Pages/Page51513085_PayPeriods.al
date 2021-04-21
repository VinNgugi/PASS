page 51513085 "Pay Periods"
{
    // version PAYROLL

    CardPageID = "Payroll Approval";
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Payroll Period";
    Caption = 'Pay Periods';
    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                field("Starting Date"; "Starting Date")
                {
                }
                field(Type; Type)
                {
                }
                field(Name; Name)
                {
                }
                field("New Fiscal Year"; "New Fiscal Year")
                {
                    Editable = true;
                }
                field("Pay Date"; "Pay Date")
                {
                }
                field("Closed By"; "Closed By")
                {
                    Editable = false;
                }
                field("Closed on Date"; "Closed on Date")
                {
                    Editable = false;
                }
                field(Closed; Closed)
                {
                    Editable = true;
                }
                field("CMS Starting Date"; "CMS Starting Date")
                {
                }
                field("CMS End Date"; "CMS End Date")
                {
                }
                field("Close Pay"; "Close Pay")
                {
                    Editable = true;
                }
                field("Market Interest Rate %"; "Market Interest Rate %")
                {
                }
                field("L.Allowance Cutoff Date"; "L.Allowance Cutoff Date")
                {
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("Close Period")
            {
                Caption = 'Close Period';
                action("Close Pay Period")
                {
                    Caption = 'Close Pay Period';

                    trigger OnAction();
                    begin
                        //Error('%1',PayrollPeriodX1.GETFILTER(PayrollPeriodX1."Pay Date"));
                        /*
                        CurrPage.SETSELECTIONFILTER(PayrollPeriod);
                        //Message('1. %1\2. %2',PayrollPeriodX1.GETFILTER("Starting Date"),PayrollPeriodX1.GETFILTER("Closed on Date"));
                        IF PayrollPeriodX1.GETFILTER(PayrollPeriodX1."Pay Date")='' THEN BEGIN
                         //  Error('Pay Date is Not Filled. Please Fill it!!');
                        END;
                        PayrollPeriodX1.RESET;
                        PayrollPeriodX1.SETRANGE(Closed,FALSE);
                        IF PayrollPeriodX1.FINDFIRST THEN BEGIN
                          IF PayrollPeriodX1."Pay Date"=0D THEN BEGIN
                             ERROR('Pay Date is Not Filled. Please Fill it!!');
                            END;
                          END;
                        
                        //ERROR('STOP');*/
                        if not CONFIRM('You are about to close the current Pay period are you sure you want to do this?' + //
                        ' Make sure all reports are correct before closing the current pay period, Go ahead?', false) then
                            exit;



                        ClosingFunction.GetCurrentPeriod(Rec);
                        ClosingFunction.RUN;

                    end;
                }
            }
        }
        area(processing)
        {
            action("&Create Period")
            {
                Caption = '&Create Period';
                Ellipsis = true;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Report "Create Payroll Period";
            }
        }
    }

    var
        ClosingFunction: Report "Close Pay period";
}

