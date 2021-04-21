xmlport 51513023 "Aging Report New"
{
    Format = VariableText;
    Caption = 'Import Aging Report';
    Direction = Import;

    schema
    {
        textelement(Aging)
        {
            tableelement(LoanAccountJournalLine; "Validation Lines")
            {
                fieldattribute(HeaderNo; LoanAccountJournalLine."Header No")
                {

                }
                fieldattribute(ReportingDate; LoanAccountJournalLine."Reporting Date")
                {

                }
                fieldattribute(NodeName3; LoanAccountJournalLine."Contract No.")
                {

                }
                fieldattribute(LoanNo; LoanAccountJournalLine."Loan No")
                {

                }
                fieldattribute(CustName; LoanAccountJournalLine."Customer Name")
                {

                }
                fieldattribute(AccNo; LoanAccountJournalLine."Account No.")
                {

                }
                fieldattribute(ApprovedAmnt; LoanAccountJournalLine."Approved Amount")
                {

                }
                fieldattribute(DisbursedAmt; LoanAccountJournalLine."Disbursed Amount")
                {

                }
                fieldattribute(RepaymentInstallmentAmt; LoanAccountJournalLine."Repayment Installment Amt")
                {

                }
                fieldattribute(TotalExposure; LoanAccountJournalLine."Total Exposure")
                {

                }
                fieldattribute(TotalPrincipalAmtPaid; LoanAccountJournalLine."Total Principal Amt Paid ")
                {

                }
                fieldattribute(OutstandingPrincipalAmt; LoanAccountJournalLine."Outstanding Principal Amt")
                {

                }
                fieldattribute(InterestAmtAccrued; LoanAccountJournalLine."Interest Amt Accrued")
                {

                }
                fieldattribute(PrincipalAmtInArrears; LoanAccountJournalLine."Principal Amt In Arrears")
                {

                }
                fieldattribute(InterestAmtInArrears; LoanAccountJournalLine."Interest Amt In Arrears")
                {

                }
                fieldattribute(TotalNoofInstallments; LoanAccountJournalLine."Total No. of Installments")
                {

                }
                fieldattribute(NoofInstallmentsInArrears; LoanAccountJournalLine."No. of Installments In Arrears")
                {

                }
                fieldattribute(DaysPastDue; LoanAccountJournalLine."Days Past Due")
                {

                }
                fieldattribute(Guarantee; LoanAccountJournalLine.Guarantee)
                {

                }
                fieldattribute(GuaranteeAmt; LoanAccountJournalLine."Guarantee Amt")
                {

                }
                fieldattribute(SystemClassification; LoanAccountJournalLine."System Classification")
                {

                }
                fieldattribute(LoanValueDate; LoanAccountJournalLine."Loan Value Date")
                {

                }
                fieldattribute(LoanMaturityDate; LoanAccountJournalLine."Loan Maturity Date")
                {

                }
                trigger OnBeforeInsertRecord()

                begin


                end;
            }

        }
    }

    requestpage
    {
        layout
        {

        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }
    trigger OnPreXmlport()

    begin
        Columnheader := true;
        CountVar := 0;
    end;

    var
        CountVar: Integer;
        Columnheader: Boolean;
}