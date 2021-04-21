report 51513412 "Issued CGC"
{
    UsageCategory = ReportsAndAnalysis;
    Caption = 'Issued CGC';
    DefaultLayout = RDLC;
    RDLCLayout = './Layout/Issued CGC.rdl';
    dataset
    {

        DataItem("PASS Contract"; "Guarantee Contracts")
        {
            //DataItemTableView = sorting ("No.") where ("Contract Status" =filter ("CGC Issued;CGC Cancelled,"));
            RequestFilterFields = "Global Dimension 1 Code", "Global Dimension 2 Code", "CGC Start Date";

            Column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {

            }
            Column(COMPANYNAME; COMPANYNAME)
            {

            }
            Column(CurrReport_PAGENO; CurrReport.PAGENO)
            {

            }
            Column(USERID; USERID)
            {

            }
            Column(FilterPeriod; FilterPeriod)
            {

            }
            Column(FilterDim1Text; FilterDim1Text)
            {

            }
            Column(FilterDim2Text; FilterDim2Text)
            {

            }
            Column(FilterBDO; FilterBDO)
            {

            }
            Column(FilterBank; FilterBank)
            {

            }
            Column(FilterBankBranch; FilterBankBranch)
            {

            }
            Column(PASS_Contract__No__; "No.")
            {

            }
            Column(PASS_Contract_Name; Name)
            {

            }
            Column(PASS_Contract__BDS_BDO_; "BDS/BDO")
            {

            }
            Column(PASS_Contract__Loan_Amount_; "Approved Loan Amount")
            {

            }
            Column(PASS_Contract__Loan_Issued_Date_; "Loan Issued Date")
            {

            }
            Column(PASS_Contract__CGF___; "CGF %")
            {

            }
            Column(Loan_Amount___CGF____100; CGFAmt)
            {

            }
            Column(PASS_Contract_Bank; Bank)
            {

            }
            Column(PASS_Contract__Loan_Currency_; "Approved Loan Currency")
            {

            }
            Column(PASS_Contract__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {

            }
            Column(PASS_Contract__CGC_No__; "CGC No.")
            {

            }
            Column(PASS_Contract__Loan_No__; "Loan No.")
            {

            }
            Column(PASS_Contract__CGC_Start_Date_; "CGC Start Date")
            {

            }
            Column(PASS_Contract__Loan_Maturity_Date_; "Loan Maturity Date")
            {

            }
            Column(PASS_Contract__Loan_Amount_LCY_; "Approved Loan Amount(LCY)")
            {

            }
            Column(CGFAmountLCY; CGFAmountLCY)
            {

            }
            Column(PASS_Contract__Loan_Amount_LCY__Control1000000039; "Approved Loan Amount(LCY)")
            {

            }
            Column(TotalCGFAmountLCY; TotalCGFAmountLCY)
            {

            }
            Column(TotalCGFAmountLCY__Loan_Amount_LCY__100; CGFTotal)
            {

            }
            Column(Issued_CGCsCaption; Issued_CGCsCaptionLbl)
            {

            }
            Column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {

            }
            Column(FilterPeriodCaption; FilterPeriodCaptionLbl)
            {

            }
            Column(FilterDim1TextCaption; FilterDim1TextCaptionLbl)
            {

            }
            Column(FilterDim2TextCaption; FilterDim2TextCaptionLbl)
            {

            }
            Column(FilterBDOCaption; FilterBDOCaptionLbl)
            {

            }
            Column(FilterBankCaption; FilterBankCaptionLbl)
            {

            }
            Column(FilterBankBranchCaption; FilterBankBranchCaptionLbl)
            {

            }
            Column(PASS_Contract__No__Caption; FIELDCAPTION("No."))
            {

            }
            Column(PASS_Contract_NameCaption; FIELDCAPTION(Name))
            {

            }
            Column(PASS_Contract__BDS_BDO_Caption; FIELDCAPTION("BDS/BDO"))
            {

            }
            Column(PASS_Contract__Loan_Amount_Caption; FIELDCAPTION("Loan Amount"))
            {

            }
            Column(PASS_Contract__Loan_Issued_Date_Caption; FIELDCAPTION("Loan Issued Date"))
            {

            }
            Column(PASS_Contract__CGF___Caption; FIELDCAPTION("CGF %"))
            {

            }
            Column(PASS_Contract_BankCaption; FIELDCAPTION(Bank))
            {

            }
            Column(PASS_Contract__Loan_Currency_Caption; PASS_Contract__Loan_Currency_CaptionLbl)
            {

            }
            Column(PASS_Contract__Global_Dimension_1_Code_Caption; FIELDCAPTION("Global Dimension 1 Code"))
            {

            }
            Column(PASS_Contract__CGC_No__Caption; FIELDCAPTION("CGC No."))
            {

            }
            Column(PASS_Contract__Loan_No__Caption; FIELDCAPTION("Loan No."))
            {

            }
            Column(PASS_Contract__CGC_Start_Date_Caption; FIELDCAPTION("CGC Start Date"))
            {

            }
            Column(PASS_Contract__Loan_Maturity_Date_Caption; FIELDCAPTION("Loan Maturity Date"))
            {

            }
            Column(PASS_Contract__Loan_Amount_LCY_Caption; PASS_Contract__Loan_Amount_LCY_CaptionLbl)
            {

            }
            Column(CGFAmountLCYCaption; CGFAmountLCYCaptionLbl)
            {

            }
            Column(Loan_Amount___CGF____100Caption; Loan_Amount___CGF____100CaptionLbl)
            {

            }
            Column(TOTALCaption; TOTALCaptionLbl)
            {

            }
            Column(CGC_Commited_Funds; "CGC Committed Funds")
            {

            }
            Column(PASS_G_Amount; "PASS Guarantee Amount")
            {

            }
            Column(IFC_G_Amount; "IFC Guarantee Amount")
            {

            }
            Column(SIDA_G_Amount; "SIDA Guarantee Amount")
            {

            }
            Column(No_Of_Emp_Created; "No. Of Employment Created")
            {

            }



            trigger OnAfterGetRecord()
            begin
                CGFAmountLCY := 0;
                CGFAmt := 0;
                CGFTotal := 0;

                IF ("Approved Loan Amount(LCY)" <> 0) AND ("CGF %" <> 0) THEN
                    CGFAmountLCY := "Approved Loan Amount(LCY)" * "CGF %" / 100;

                IF ("Loan Amount" <> 0) AND ("CGF %" <> 0) THEN
                    CGFAmt := "Loan Amount" * "CGF %" / 100;


                TotalCGFAmountLCY += CGFAmountLCY;

                IF "Approved Loan Amount(LCY)" <> 0 THEN
                    CGFTotal := TotalCGFAmountLCY / "Approved Loan Amount(LCY)" * 100;
            end;
        }





    }

    var

        CGFAmountLCY: Decimal;
        TotalCGFAmountLCY: Decimal;
        FilterPeriod: Text[30];
        FilterDim1: Text[100];
        FilterDim2: Text[100];
        FilterBDO: Text[100];
        FilterBank: Text[30];
        FilterBankBranch: Text[100];
        FilterDim1Text: Text[50];
        FilterDim2Text: Text[50];
        CGFAmt: Decimal;
        CGFTotal: Decimal;

        "No. Of Employment Created": Integer;

        Issued_CGCsCaptionLbl: Label 'Issued CGCs';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        FilterPeriodCaptionLbl: Label 'CGC Start Date Period';
        FilterDim1TextCaptionLbl: Label 'PASS Branch';
        FilterDim2TextCaptionLbl: Label 'Region';
        FilterBDOCaptionLbl: Label 'BDO';
        FilterBankCaptionLbl: Label 'Bank';
        FilterBankBranchCaptionLbl: Label 'Bank Branch';
        PASS_Contract__Loan_Currency_CaptionLbl: Label 'Curr.';
        PASS_Contract__Loan_Amount_LCY_CaptionLbl: Label 'Loan Amount TZS';
        CGFAmountLCYCaptionLbl: Label 'CGF Amount TZS';
        Loan_Amount___CGF____100CaptionLbl: Label 'CGF Amount';
        TOTALCaptionLbl: Label 'TOTAL';

    trigger OnPreReport()
    begin
        GetContractFilters("PASS Contract");
    end;

    procedure GetContractFilters(var Contract: Record "Guarantee Contracts")
    var

        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        LineOfBusiness: Record "Line Of Business";
    begin
        GLSetup.GET;

        FilterPeriod := Contract.GETFILTER("CGC Start Date");
        FilterDim1 := Contract.GETFILTER("Global Dimension 1 Code");
        FilterDim2 := Contract.GETFILTER("Global Dimension 2 Code");
        FilterBDO := Contract.GETFILTER("BDS/BDO");
        FilterBank := Contract.GETFILTER(Bank);
        FilterBankBranch := Contract.GETFILTER("Bank Branch");

        IF (FilterDim1 <> '') THEN BEGIN
            IF DimensionValue.GET(GLSetup."Global Dimension 1 Code", FilterDim1) THEN
                FilterDim1Text := DimensionValue.Name
            ELSE
                FilterDim1Text := FilterDim1;
        END;

        IF (FilterDim2 <> '') THEN BEGIN
            IF DimensionValue.GET(GLSetup."Global Dimension 2 Code", FilterDim2) THEN
                FilterDim2Text := DimensionValue.Name
            ELSE
                FilterDim2Text := FilterDim2;
        END;

    end;
}