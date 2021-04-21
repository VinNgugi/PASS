report 51513405 "SIDA Report"
{
    UsageCategory = ReportsAndAnalysis;

    DefaultLayout = RDLC;
    RDLCLayout = './Layout/SIDA.rdl';

    dataset
    {


        dataitem("Guarantee Contracts"; "Guarantee Contracts")
        {
            DataItemTableView = sorting ("No.") where (SIDA = filter (true));

            column(No_; "No.")
            {


            }
            Column(Loan_ID__;
            "Loan No.")
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
            Column(Guaranteed_Party__; "Receivables Acc. Name")
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
            Column(Loan__Amount; "Approved Loan Amount")
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

            Column(Removed_From_Coverage_date; RemovedFromCoverageGuarante)
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
            column(SIDAAccumulated; SIDAAccumulated)
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

            column(Disbursed__; Disbursed)
            {

            }

            Column(Payment__; Payment)
            {

            }

            Column(End__AMount; EndAmt)
            {

            }
            column(Arrears__Days; Arrears)
            {

            }

            trigger OnAfterGetRecord()
            begin
                Disbursed := 0;
                Payment := 0;
                EndAmt := 0;
                Arrears := 0;
                SIDAfeeQtr := 0;
                SIDACommitmentAmt := 0;
                SIDAAccumulated := 0;
                RemovedFromCoverageGuarante := '';

                ObjLoanAccEntries.Reset();
                ObjLoanAccEntries.SetRange("Contract No.", "No.");
                ObjLoanAccEntries.SetRange("Reporting Date", ReportingDate);
                if ObjLoanAccEntries.Find('-') then begin
                    Disbursed := ObjLoanAccEntries."Disbursed Amount";
                    Payment := ObjLoanAccEntries."Total Principal Amt Paid";
                    EndAmt := ObjLoanAccEntries."Outstanding Principal Amt";
                    Arrears := ObjLoanAccEntries."Days Past Due";
                end;

                if EndAmt = 0 then
                    RemovedFromCoverageGuarante := format(ReportingDate);


                GuaranteeSetup.Get();
                SIDAPerc := GuaranteeSetup."CGF SIDA %";
                SIDAfee := GuaranteeSetup."SIDA Guarantee fee";
                PassPerc := "Pct. Guarantee Approved";
                //SIDACommitmentAmt := (SIDAPerc * "Loan Account Entries"."Outstanding Principal Amt") / 100;
                SIDACommitmentAmt := ((SIDAPerc / 100) * (PassPerc / 100) * (EndAmt));
                SIDAfeeQtr := (SIDACommitmentAmt * SIDAfee) / 100;
                //SIDAAccumulated := ("Approved Loan Amount" * "Pct. Guarantee Approved" * SIDAPerc) / 100;
                if "Currency Code" <> '' then
                    SIDAAccumulated := ((SIDAPerc / 100) * (PassPerc / 100) * ("Loan Amount(LCY)"))
                else
                    SIDAAccumulated := ((SIDAPerc / 100) * (PassPerc / 100) * ("Approved Loan Amount"));


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
        myInt: Integer;
        RemovedFromCoverageGuarante: Text;
        SIDAPerc: Decimal;
        SIDACommitmentAmt: Decimal;
        SIDAAccumulated: Decimal;
        SIDAfeeQtr: Decimal;
        SIDAfee: Decimal;
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
        PassPerc: Decimal;
        ObjLoanAccEntries: Record "Loan Account Entries";
        Disbursed: Decimal;
        Payment: Decimal;
        EndAmt: Decimal;
        Arrears: Decimal;
}