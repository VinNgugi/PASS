report 51513416 "Approved Associated to Youth"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Approved Associated to Youth';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/ApprovedAssociatedtoYouth.rdl';
    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            DataItemTableView = sorting ("Primary Key");

            column(Name_; Name)
            {

            }
            column(Picture; Picture)
            {

            }
            column(E_Mail; "E-Mail")
            {

            }
            column(Home_Page; "Home Page")
            {

            }
            column(Address; Address)
            {

            }
            column(Phone_No_; "Phone No.")
            {

            }
            dataitem("Guarantee Contracts"; "Guarantee Contracts")
            {
                DataItemTableView = sorting ("No.") where ("Contract Status" = filter (>= "Loan Granted"));

                column(No_; "No.")
                {

                }
                column(Receivables_Acc__No_; "Receivables Acc. No.")
                {

                }
                column(Receivables_Acc__Name; "Receivables Acc. Name")
                {

                }
                column(Loan_Amount; "Approved Loan Amount(LCY)")
                {

                }
                column(CGC_Committed_Funds; "CGC Committed Funds")
                {

                }

                column(No_BP; No_BP)
                {

                }
                column(PercNumber; PercNumber)
                {

                }
                column(PercValue; PercValue)
                {

                }
                column(YouthNo; YouthNo)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    GuaranteeSetup.Get();
                    Validate("Date of Birth");

                    LoansTotals := LoansTotals + "Approved Loan Amount(LCY)";
                    GuaranteeTotals := GuaranteeTotals + "CGC Committed Funds";
                    No_BP := No_BP + 1;

                    if ((Age >= GuaranteeSetup."Youth Start Age") and (Age <= GuaranteeSetup."Youth End Age")) then begin

                        YouthGuaranteeTotals := YouthGuaranteeTotals + "CGC Committed Funds";
                        YouthLoansTotals := YouthLoansTotals + "Approved Loan Amount(LCY)";
                        YouthNo := YouthNo + 1;

                        IF LoansTotals <> 0 then
                            PercValue := (YouthLoansTotals / LoansTotals) * 100;

                        IF No_BP <> 0 then
                            PercNumber := (YouthNo / No_BP) * 100;

                    end else
                        CurrReport.Skip();
                end;


            }
        }


    }

    var
        GuaranteeSetup: Record "Guarantee Management Setup";
        No_BP: Integer;
        PercValue: Decimal;
        PercNumber: Decimal;
        GuaranteeTotals: Decimal;
        LoansTotals: Decimal;
        YouthGuaranteeTotals: Decimal;
        YouthLoansTotals: Decimal;
        YouthNo: Integer;
}