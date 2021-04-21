report 51513427 "SIDA Report 1"
{
    UsageCategory = ReportsAndAnalysis;

    DefaultLayout = RDLC;
    RDLCLayout = './Layout/SIDA Copy.rdl';

    dataset
    {
        dataitem("Guarantee Contracts";
        "Guarantee Contracts")
        {
            DataItemTableView = where (SIDA = filter (true));
            Column(Loan_ID__; "Loan No.")
            {

            }
            column(No_; "No.")
            {

            }
            Column(Borrower__Name; Name)
            {

            }
            column(Type_of_Facility; "Type of Facility")
            {

            }
            column(Gender; Gender)
            {

            }
            Column(Guaranteed_Party__; BankName)
            {

            }
            Column(Reporting__Date; ReportingDate)
            {

            }
            //Column(Type__;"Term")
            //{

            //}
            Column(Start__Date; "CGC Start Date")
            {

            }
            Column(Maturity_date_; "Loan Maturity Date")
            {

            }
            Column(Date__Guaranteed__; "CGC Start Date")
            {

            }
            Column(Loan__Amount; LoanAmt)
            {

            }
            Column(Currency__; "Currency Code")
            {
            }

            Column(Country__; County)
            {

            }
            Column(City_Town__; City)
            {

            }
            Column(State_Province_Region_; City)
            {

            }
            column(Business_Sector__; "Global Dimension 3 Code")
            {

            }
            column(Additional__Information_; Product)
            {

            }

            Column(Purpose__Of__Loan__; "Project Description")
            {

            }
            Column(Guarantee__Percent; "Pct. Guarantee Approved")
            {

            }


            column(PASS_Guarantee_Amount; "PASS Guarantee Amount")
            {

            }
            column(SIDAPerc; SIDAPerc)
            {

            }
            column(SIDAfee; SIDAfee)
            {

            }
            column(SIDACommitmentAmt; SIDACommitmentAmt)
            {

            }
            column(SIDAfeeQtr; SIDAfeeQtr)
            {

            }
            column(SIDAAccumulated; SIDACommitmentAmt)
            {

            }
            Column(Page_No_; CurrReport.PAGENO)
            {

            }

            Column(Loan_Id_Caption; Loan_Id_Caption)
            {

            }
            Column(Guaranteed_Party_Caption; Guaranteed_Party_Caption)
            {

            }
            Column(Borrower_Name_Caption; Borrower_Name_Caption)
            {

            }
            Column(Reporting_date_Caption; Reporting_date_Caption)
            {

            }
            Column(Type_caption; Type_caption)
            {

            }
            Column(Start_date_caption; Start_date_caption)
            {

            }
            Column(Maturity_date_caption; Maturity_date_caption)
            {

            }
            Column(Date_Guarantee_Caption; Date_Guarantee_Caption)
            {

            }
            Column(Laon_amount_caption; Laon_amount_caption)
            {

            }
            Column(Currency_caption; Currency_caption)
            {

            }
            Column(disbursed_caption; disbursed_caption)
            {

            }
            Column(payment_caption; payment_caption)
            {

            }

            Column(Arrears_days_caption; Arrears_days_caption)
            {

            }
            Column(Country_caption; Country_caption)
            {

            }
            Column(City_town_caption; City_town_caption)
            {

            }
            Column(State_province_region_caption; State_province_region_caption)
            {

            }
            Column(business_sector_caption; business_sector_caption)
            {

            }
            Column(additional_information_caption; additional_information_caption)
            {

            }
            Column(Purpose_of_loan_caption; Purpose_of_loan_caption)
            {

            }
            Column(Guarantee_Percenta_Caption; Guarantee_Percenta_Caption)
            {

            }
            Column(Removed_from_coverage_date_caption; Removed_from_coverage_date_caption)
            {

            }
            column(End_amount_caption; End_amount_caption)
            {

            }
            Column(Removed_From_Coverage_date; RemovedDate)
            {

            }
            dataitem("Loan Account Entries"; "Loan Account Entries")
            {
                DataItemLink = "Contract No." = field ("No.");
                DataItemTableView = sorting ("Contract No.");

                column(Disbursed__; "Disbursed Amount")
                {

                }

                Column(Payment__; "Total Principal Amt Paid")
                {

                }

                Column(End__AMount; EndAmt)
                {

                }
                column(Arrears__Days; "Days Past Due")
                {

                }



            }
            trigger OnAfterGetRecord()
            begin
                LoanAmt := 0;
                EndAmt := 0;

                Validate("Guarantee Source");
                GuaranteeSetup.Get();
                SIDAPerc := GuaranteeSetup."CGF SIDA %";
                SIDAfee := GuaranteeSetup."SIDA Guarantee fee";
                /*
                                LoanEntries.Reset();
                                LoanEntries.SetRange("Contract No.", "No.");
                                LoanEntries.SetRange("Reporting Date", ReportingDate);
                                if not LoanEntries.FindFirst() then
                                    //CurrReport.Skip()

                                else begin
                                    if LoanEntries."Outstanding Principal Amt" = 0 then
                                        RemovedDate := ReportingDate;
                                    if LoanEntries."Outstanding Principal Amt" <> 0 then
                                        if LoanEntries."Outstanding Principal Amt" > LoanAmt then
                                            EndAmt := LoanAmt
                                        else
                                            EndAmt := LoanEntries."Outstanding Principal Amt";



                                    if EndAmt <> 0 then begin
                                        SIDACommitmentAmt := (("Pct. Guarantee Approved" / 100) * (SIDAPerc / 100) * EndAmt);

                                        SIDAfeeQtr := (SIDACommitmentAmt * SIDAfee) / 100;
                                    end;


                                    if "Approved Loan Currency" <> '' THEN begin
                                        if "Approved Loan Amount(LCY)" = 0 THEN begin
                                            SIDAAccumulated := ("Loan Amount(LCY)" * ("Pct. Guarantee Approved" / 100) * (SIDAPerc / 100));
                                            LoanAmt := "Loan Amount(LCY)";
                                        end else begin
                                            SIDAAccumulated := ("Approved Loan Amount(LCY)" * ("Pct. Guarantee Approved" / 100) * (SIDAPerc / 100));
                                            LoanAmt := "Approved Loan Amount(LCY)";

                                        end;

                                    END ELSE
                                        if "Approved Loan Amount" = 0 THEN begin
                                            SIDAAccumulated := ("Loan Amount" * ("Pct. Guarantee Approved" / 100) * (SIDAPerc / 100));
                                            LoanAmt := "Loan Amount";
                                        end else begin
                                            SIDAAccumulated := ("Approved Loan Amount" * ("Pct. Guarantee Approved" / 100) * (SIDAPerc / 100));
                                            LoanAmt := "Approved Loan Amount";
                                        end;


                                    if "Receivables Acc. No." <> '' then begin
                                        Cust.get("Receivables Acc. No.");
                                        bankName := Cust.Name;
                                    end;
                                end;*/
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field("Reporting Period End Date"; ReportingDate)
                    {


                    }
                }
            }
        }


    }
    trigger OnPreReport()

    begin
        if ReportingDate = 0D THEN
            Error('Kindly specify reporting period end date');
    end;

    var
        LoanEntries: Record "Loan Account Entries";
        myInt: Integer;
        RemovedFromCoverageGuarante: Text;
        SIDAPerc: Decimal;
        SIDACommitmentAmt: Decimal;
        SIDAAccumulated: Decimal;
        SIDAfeeQtr: Decimal;
        SIDAfee: Decimal;
        LoanAmt: Decimal;
        EndAmt: Decimal;
        GuaranteeSetup: Record "Guarantee Management Setup";
        Loan_Id_Caption: TextConst ENU = 'Loan ID';
        Guaranteed_Party_Caption: TextConst ENU = 'Guaranteed Party';
        Borrower_Name_Caption: TextConst ENU = 'BORROWER NAME';
        Reporting_date_Caption: TextConst ENU = 'REPORTING DATE';
        Type_caption: TextConst ENU = 'TYPE';
        Start_date_caption: TextConst ENU = 'START DATE';
        Maturity_date_caption: TextConst ENU = 'Maturity Date';
        Date_Guarantee_Caption: TextConst ENU = 'DATE GUARANTEE';
        Laon_amount_caption: TextConst ENU = 'LOAN AMOUNT';
        Currency_caption: TextConst ENU = 'CURRENCY';
        disbursed_caption: TextConst ENU = 'DISBURSED';
        payment_caption: TextConst ENU = 'PAYMENT';
        End_amount_caption: TextConst ENU = 'END AMOUNT';
        Arrears_days_caption: TextConst ENU = 'ARREARS (DAYS)';
        Country_caption: TextConst ENU = 'COUNTRY';
        City_town_caption: TextConst ENU = 'CITY/TOWN';
        State_province_region_caption: TextConst ENU = 'STATE/PROVINCE/REGION';
        business_sector_caption: TextConst ENU = 'BUSINESS/SECTOR';
        additional_information_caption: TextConst ENU = 'ADDITIONAL INFORMATION';
        Purpose_of_loan_caption: TextConst ENU = 'PURPOSE OF LOAN';
        Guarantee_Percenta_Caption: TextConst ENU = 'GUARANTEE %';
        Removed_from_coverage_date_caption: TextConst ENU = 'REMOVED FROM COVERAGE DATE';
        ReportingDate: Date;
        RemovedDate: date;
        bankName: Text;
        Cust: Record Customer;
}