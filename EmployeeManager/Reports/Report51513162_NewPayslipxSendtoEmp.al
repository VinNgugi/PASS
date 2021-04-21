report 51513162 "New Payslipx Send to Emp"
{
    // version PAYROLL

    // ArrEarnings[1,1]
    // ArrEarningsAmt[1,1]
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/New Payslipx Send to Emp.rdl';
    Caption = 'New Payslipx Send to Emp';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING ("Global Dimension 1 Code") ORDER(Ascending);
            RequestFilterFields = "No.", "Global Dimension 1 Code";
            column(Addr_1__1_; Addr[1] [1])
            {
            }
            column(Addr_1__2_; Addr[1] [2])
            {
            }
            column(DeptArr_1_1_; DeptArr[1, 1])
            {
            }
            column(ArrEarnings_1_1_; ArrEarnings[1, 1])
            {
            }
            column(ArrEarnings_1_2_; ArrEarnings[1, 2])
            {
            }
            column(ArrEarnings_1_3_; ArrEarnings[1, 3])
            {
            }
            column(ArrEarningsAmt_1_1_; ArrEarningsAmt[1, 1])
            {
                //DecimalPlaces = 2 : 2;
            }
            column(ArrEarningsAmt_1_2_; ArrEarningsAmt[1, 2])
            {
                // DecimalPlaces = 2 : 2;
            }
            column(ArrEarningsAmt_1_3_; ArrEarningsAmt[1, 3])
            {
                //DecimalPlaces = 2 : 2;
            }
            column(ArrEarnings_1_4_; ArrEarnings[1, 4])
            {
            }
            column(ArrEarningsAmt_1_4_; ArrEarningsAmt[1, 4])
            {
                //DecimalPlaces = 2 : 2;
            }
            column(ArrEarnings_1_5_; ArrEarnings[1, 5])
            {
            }
            column(ArrEarningsAmt_1_5_; ArrEarningsAmt[1, 5])
            {
                //DecimalPlaces = 2 : 2;
            }
            column(ArrEarnings_1_6_; ArrEarnings[1, 6])
            {
            }
            column(ArrEarningsAmt_1_6_; ArrEarningsAmt[1, 6])
            {
            }
            column(ArrEarnings_1_7_; ArrEarnings[1, 7])
            {
            }
            column(ArrEarningsAmt_1_7_; ArrEarningsAmt[1, 7])
            {
            }
            column(ArrEarnings_1_8_; ArrEarnings[1, 8])
            {
            }
            column(ArrEarningsAmt_1_8_; ArrEarningsAmt[1, 8])
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(CoName; CoName)
            {
            }
            column(ArrEarningsAmt_1_9_; ArrEarningsAmt[1, 9])
            {
            }
            column(ArrEarningsAmt_1_10_; ArrEarningsAmt[1, 10])
            {
            }
            column(ArrEarningsAmt_1_11_; ArrEarningsAmt[1, 11])
            {
            }
            column(ArrEarningsAmt_1_12_; ArrEarningsAmt[1, 12])
            {
            }
            column(ArrEarningsAmt_1_13_; ArrEarningsAmt[1, 13])
            {
            }
            column(ArrEarningsAmt_1_14_; ArrEarningsAmt[1, 14])
            {
            }
            column(ArrEarningsAmt_1_15_; ArrEarningsAmt[1, 15])
            {
            }
            column(ArrEarningsAmt_1_16_; ArrEarningsAmt[1, 16])
            {
            }
            column(ArrEarnings_1_9_; ArrEarnings[1, 9])
            {
            }
            column(ArrEarnings_1_10_; ArrEarnings[1, 10])
            {
            }
            column(ArrEarnings_1_11_; ArrEarnings[1, 11])
            {
            }
            column(ArrEarnings_1_12_; ArrEarnings[1, 12])
            {
            }
            column(ArrEarnings_1_13_; ArrEarnings[1, 13])
            {
            }
            column(ArrEarnings_1_14_; ArrEarnings[1, 14])
            {
            }
            column(ArrEarnings_1_15_; ArrEarnings[1, 15])
            {
            }
            column(ArrEarnings_1_16_; ArrEarnings[1, 16])
            {
            }
            column(ArrEarningsAmt_1_17_; ArrEarningsAmt[1, 17])
            {
            }
            column(ArrEarnings_1_17_; ArrEarnings[1, 17])
            {
            }
            column(ArrEarnings_1_18_; ArrEarnings[1, 18])
            {
            }
            column(ArrEarnings_1_19_; ArrEarnings[1, 19])
            {
            }
            column(ArrEarnings_1_20_; ArrEarnings[1, 20])
            {
            }
            column(ArrEarnings_1_21_; ArrEarnings[1, 21])
            {
            }
            column(ArrEarnings_1_22_; ArrEarnings[1, 22])
            {
            }
            column(ArrEarnings_1_23_; ArrEarnings[1, 23])
            {
            }
            column(ArrEarnings_1_25_; ArrEarnings[1, 25])
            {
            }
            column(ArrEarnings_1_26_; ArrEarnings[1, 26])
            {
            }
            column(ArrEarnings_1_34_; ArrEarnings[1, 34])
            {
            }
            column(ArrEarnings_1_33_; ArrEarnings[1, 33])
            {
            }
            column(ArrEarnings_1_32_; ArrEarnings[1, 32])
            {
            }
            column(ArrEarnings_1_31_; ArrEarnings[1, 31])
            {
            }
            column(ArrEarnings_1_30_; ArrEarnings[1, 30])
            {
            }
            column(ArrEarnings_1_29_; ArrEarnings[1, 29])
            {
            }
            column(ArrEarnings_1_28_; ArrEarnings[1, 28])
            {
            }
            column(ArrEarnings_1_27_; ArrEarnings[1, 27])
            {
            }
            column(ArrEarnings_1_41_; ArrEarnings[1, 41])
            {
            }
            column(ArrEarnings_1_40_; ArrEarnings[1, 40])
            {
            }
            column(ArrEarnings_1_39_; ArrEarnings[1, 39])
            {
            }
            column(ArrEarnings_1_38_; ArrEarnings[1, 38])
            {
            }
            column(ArrEarnings_1_37_; ArrEarnings[1, 37])
            {
            }
            column(ArrEarnings_1_36_; ArrEarnings[1, 36])
            {
            }
            column(ArrEarnings_1_35_; ArrEarnings[1, 35])
            {
            }
            column(ArrEarningsAmt_1_33_; ArrEarningsAmt[1, 33])
            {
            }
            column(ArrEarningsAmt_1_32_; ArrEarningsAmt[1, 32])
            {
            }
            column(ArrEarningsAmt_1_31_; ArrEarningsAmt[1, 31])
            {
            }
            column(ArrEarningsAmt_1_30_; ArrEarningsAmt[1, 30])
            {
            }
            column(ArrEarningsAmt_1_29_; ArrEarningsAmt[1, 29])
            {
            }
            column(ArrEarningsAmt_1_28_; ArrEarningsAmt[1, 28])
            {
            }
            column(ArrEarningsAmt_1_27_; ArrEarningsAmt[1, 27])
            {
            }
            column(ArrEarningsAmt_1_26_; ArrEarningsAmt[1, 26])
            {
            }
            column(ArrEarningsAmt_1_25_; ArrEarningsAmt[1, 25])
            {
            }
            column(ArrEarningsAmt_1_24_; ArrEarningsAmt[1, 24])
            {
            }
            column(ArrEarningsAmt_1_23_; ArrEarningsAmt[1, 23])
            {
            }
            column(ArrEarningsAmt_1_22_; ArrEarningsAmt[1, 22])
            {
            }
            column(ArrEarningsAmt_1_21_; ArrEarningsAmt[1, 21])
            {
            }
            column(ArrEarningsAmt_1_20_; ArrEarningsAmt[1, 20])
            {
            }
            column(ArrEarningsAmt_1_19_; ArrEarningsAmt[1, 19])
            {
            }
            column(ArrEarningsAmt_1_18_; ArrEarningsAmt[1, 18])
            {
            }
            column(ArrEarnings_1_24_; ArrEarnings[1, 24])
            {
            }
            column(ArrEarningsAmt_1_39_; ArrEarningsAmt[1, 39])
            {
            }
            column(ArrEarningsAmt_1_38_; ArrEarningsAmt[1, 38])
            {
            }
            column(ArrEarningsAmt_1_37_; ArrEarningsAmt[1, 37])
            {
            }
            column(ArrEarningsAmt_1_36_; ArrEarningsAmt[1, 36])
            {
            }
            column(ArrEarningsAmt_1_35_; ArrEarningsAmt[1, 35])
            {
            }
            column(ArrEarningsAmt_1_34_; ArrEarningsAmt[1, 34])
            {
            }
            column(ArrEarningsAmt_1_41_; ArrEarningsAmt[1, 41])
            {
            }
            column(ArrEarningsAmt_1_40_; ArrEarningsAmt[1, 40])
            {
            }
            column(Message1; Message1)
            {
            }
            column(Message2_1_1_; Message2[1, 1])
            {
            }
            column(ArrEarningsAmt_1_43_; ArrEarningsAmt[1, 43])
            {
            }
            column(ArrEarningsAmt_1_42_; ArrEarningsAmt[1, 42])
            {
            }
            column(ArrEarningsAmt_1_45_; ArrEarningsAmt[1, 45])
            {
            }
            column(ArrEarningsAmt_1_44_; ArrEarningsAmt[1, 44])
            {
            }
            column(ArrEarnings_1_45_; ArrEarnings[1, 45])
            {
            }
            column(ArrEarnings_1_44_; ArrEarnings[1, 44])
            {
            }
            column(ArrEarnings_1_43_; ArrEarnings[1, 43])
            {
            }
            column(ArrEarnings_1_42_; ArrEarnings[1, 42])
            {
            }
            column(ArrEarningsAmt_1_48_; ArrEarningsAmt[1, 48])
            {
            }
            column(ArrEarningsAmt_1_46_; ArrEarningsAmt[1, 46])
            {
            }
            column(ArrEarningsAmt_1_47_; ArrEarningsAmt[1, 47])
            {
            }
            column(ArrEarnings_1_48_; ArrEarnings[1, 48])
            {
            }
            column(ArrEarnings_1_47_; ArrEarnings[1, 47])
            {
            }
            column(ArrEarnings_1_46_; ArrEarnings[1, 46])
            {
            }
            column(ArrEarningsAmt_1_49_; ArrEarningsAmt[1, 49])
            {
            }
            column(ArrEarningsAmt_1_50_; ArrEarningsAmt[1, 50])
            {
            }
            column(ArrEarningsAmt_1_51_; ArrEarningsAmt[1, 51])
            {
            }
            column(ArrEarningsAmt_1_52_; ArrEarningsAmt[1, 52])
            {
            }
            column(ArrEarningsAmt_1_53_; ArrEarningsAmt[1, 53])
            {
            }
            column(ArrEarningsAmt_1_54_; ArrEarningsAmt[1, 54])
            {
            }
            column(ArrEarningsAmt_1_55_; ArrEarningsAmt[1, 55])
            {
            }
            column(ArrEarningsAmt_1_56_; ArrEarningsAmt[1, 56])
            {
            }
            column(ArrEarningsAmt_1_57_; ArrEarningsAmt[1, 57])
            {
            }
            column(ArrEarningsAmt_1_58_; ArrEarningsAmt[1, 58])
            {
            }
            column(ArrEarningsAmt_1_59_; ArrEarningsAmt[1, 59])
            {
            }
            column(ArrEarningsAmt_1_60_; ArrEarningsAmt[1, 60])
            {
            }
            column(ArrEarnings_1_49_; ArrEarnings[1, 49])
            {
            }
            column(ArrEarnings_1_50_; ArrEarnings[1, 50])
            {
            }
            column(ArrEarnings_1_51_; ArrEarnings[1, 51])
            {
            }
            column(ArrEarnings_1_52_; ArrEarnings[1, 52])
            {
            }
            column(ArrEarnings_1_53_; ArrEarnings[1, 53])
            {
            }
            column(ArrEarnings_1_54_; ArrEarnings[1, 54])
            {
            }
            column(ArrEarnings_1_55_; ArrEarnings[1, 55])
            {
            }
            column(ArrEarnings_1_56_; ArrEarnings[1, 56])
            {
            }
            column(ArrEarnings_1_57_; ArrEarnings[1, 57])
            {
            }
            column(ArrEarnings_1_58_; ArrEarnings[1, 58])
            {
            }
            column(ArrEarnings_1_59_; ArrEarnings[1, 59])
            {
            }
            column(ArrEarnings_1_60_; ArrEarnings[1, 60])
            {
            }
            column(CoRec_Picture; CoRec.Picture)
            {
            }
            column(BalanceArray_1_1_; BalanceArray[1, 1])
            {
            }
            column(BalanceArray_1_2_; BalanceArray[1, 2])
            {
            }
            column(BalanceArray_1_3_; BalanceArray[1, 3])
            {
            }
            column(BalanceArray_1_4_; BalanceArray[1, 4])
            {
            }
            column(BalanceArray_1_5_; BalanceArray[1, 5])
            {
            }
            column(BalanceArray_1_6_; BalanceArray[1, 6])
            {
            }
            column(BalanceArray_1_7_; BalanceArray[1, 7])
            {
            }
            column(BalanceArray_1_8_; BalanceArray[1, 8])
            {
            }
            column(BalanceArray_1_9_; BalanceArray[1, 9])
            {
            }
            column(BalanceArray_1_10_; BalanceArray[1, 10])
            {
            }
            column(BalanceArray_1_11_; BalanceArray[1, 11])
            {
            }
            column(BalanceArray_1_12_; BalanceArray[1, 12])
            {
            }
            column(BalanceArray_1_13_; BalanceArray[1, 13])
            {
            }
            column(BalanceArray_1_14_; BalanceArray[1, 14])
            {
            }
            column(BalanceArray_1_15_; BalanceArray[1, 15])
            {
            }
            column(BalanceArray_1_16_; BalanceArray[1, 16])
            {
            }
            column(BalanceArray_1_17_; BalanceArray[1, 17])
            {
            }
            column(BalanceArray_1_19_; BalanceArray[1, 19])
            {
            }
            column(BalanceArray_1_18_; BalanceArray[1, 18])
            {
            }
            column(BalanceArray_1_20_; BalanceArray[1, 20])
            {
            }
            column(BalanceArray_1_22_; BalanceArray[1, 22])
            {
            }
            column(BalanceArray_1_21_; BalanceArray[1, 21])
            {
            }
            column(BalanceArray_1_23_; BalanceArray[1, 23])
            {
            }
            column(BalanceArray_1_26_; BalanceArray[1, 26])
            {
            }
            column(BalanceArray_1_25_; BalanceArray[1, 25])
            {
            }
            column(BalanceArray_1_24_; BalanceArray[1, 24])
            {
            }
            column(BalanceArray_1_28_; BalanceArray[1, 28])
            {
            }
            column(BalanceArray_1_27_; BalanceArray[1, 27])
            {
            }
            column(BalanceArray_1_30_; BalanceArray[1, 30])
            {
            }
            column(BalanceArray_1_29_; BalanceArray[1, 29])
            {
            }
            column(BalanceArray_1_32_; BalanceArray[1, 32])
            {
            }
            column(BalanceArray_1_31_; BalanceArray[1, 31])
            {
            }
            column(BalanceArray_1_34_; BalanceArray[1, 34])
            {
            }
            column(BalanceArray_1_33_; BalanceArray[1, 33])
            {
            }
            column(BalanceArray_1_36_; BalanceArray[1, 36])
            {
            }
            column(BalanceArray_1_35_; BalanceArray[1, 35])
            {
            }
            column(BalanceArray_1_38_; BalanceArray[1, 38])
            {
            }
            column(BalanceArray_1_37_; BalanceArray[1, 37])
            {
            }
            column(BalanceArray_1_40_; BalanceArray[1, 40])
            {
            }
            column(BalanceArray_1_39_; BalanceArray[1, 39])
            {
            }
            column(BalanceArray_1_41_; BalanceArray[1, 41])
            {
            }
            column(BalanceArray_1_42_; BalanceArray[1, 42])
            {
            }
            column(BalanceArray_1_43_; BalanceArray[1, 43])
            {
            }
            column(BalanceArray_1_44_; BalanceArray[1, 44])
            {
            }
            column(BalanceArray_1_46_; BalanceArray[1, 46])
            {
            }
            column(BalanceArray_1_45_; BalanceArray[1, 45])
            {
            }
            column(BalanceArray_1_48_; BalanceArray[1, 48])
            {
            }
            column(BalanceArray_1_47_; BalanceArray[1, 47])
            {
            }
            column(STRSUBSTNO__Date__1__2__TODAY_TIME_; STRSUBSTNO('Date %1 %2', TODAY, TIME))
            {
            }
            column(Age_CaptionLbl; Age_CaptionLbl)
            {
            }
            column(Age_; DAge)
            {
            }
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(EarningsCaption; EarningsCaptionLbl)
            {
            }
            column(Employee_No_Caption; Employee_No_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(Dept_Caption; Dept_CaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(Pay_slipCaption; Pay_slipCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Employee_No_; "No.")
            {
            }
            column(Loan_Balance; LoanBalance)
            {
            }

            trigger OnAfterGetRecord();
            var
                loanType: Record "Loan Product Type";
                RepSchedule: Record "Repayment Schedule";
                TotalBulkRepayments: Decimal;
                TotalRepayments: Decimal;
                LineAmt: Decimal;
                TotalPensionInactive: Decimal;
                PensionArrs: Decimal;
            begin
                if ("Date Of Birth" <> 0D) then
                    DAge := Dates.DetermineAge("Date Of Birth", TODAY);


                CLEAR(Addr);
                CLEAR(DeptArr);
                CLEAR(BasicPay);
                CLEAR(EmpArray);
                CLEAR(ArrEarnings);
                CLEAR(ArrEarningsAmt);
                CLEAR(BalanceArray);
                GrossPay := 0;
                TotalDeduction := 0;
                Totalcoopshares := 0;
                Totalnssf := 0;
                NetPay := 0;
                Addr[1] [1] := Employee."No.";
                Addr[1] [2] := Employee."First Name" + ' ' + Employee."Last Name";
                // get Department Name
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code, Employee."Global Dimension 1 Code");
                DimVal.SETRANGE("Global Dimension No.", 1);
                if DimVal.FIND('-') then
                    DeptArr[1, 1] := DimVal.Name;

                // Get Basic Salary
                Earn.RESET;
                Earn.SETRANGE(Earn."Basic Salary Code", true);
                if Earn.FIND('-') then begin
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                    AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                    AssignMatrix.SETRANGE(AssignMatrix.Code, Earn.Code);
                    AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                    /*IF AssignMatrix.FIND('-') THEN BEGIN
                     BasicPay[1,1]:=Earn.Description;
                     EmpArray[1,1]:=AssignMatrix.Amount;
                     GrossPay:=GrossPay+AssignMatrix.Amount;
                    END;*/
                end;
                i := 1;
                Earn.RESET;
                Earn.SETRANGE(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SETRANGE(Earn."Non-Cash Benefit", false);
                if Earn.FIND('-') then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        // AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",FALSE);
                        AssignMatrix.SETRANGE(Code, Earn.Code);
                        if AssignMatrix.FIND('-') then begin
                            repeat
                                ArrEarnings[1, i] := AssignMatrix.Description;
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(PayrollRounding(AssignMatrix.Amount)));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                GrossPay := GrossPay + PayrollRounding(AssignMatrix.Amount);
                                i := i + 1;
                            until AssignMatrix.NEXT = 0;
                        end;
                    until Earn.NEXT = 0;
                end;

                ArrEarnings[1, i] := 'GROSS PAY';
                EVALUATE(ArrEarningsAmt[1, i], FORMAT(GrossPay));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                i := i + 1;

                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '************************************************';

                i := i + 1;

                // taxation
                ArrEarnings[1, i] := 'Taxations';

                i := i + 1;

                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';

                i := i + 1;
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                AssignMatrix.SETRANGE(AssignMatrix.Paye, true);
                if AssignMatrix.FIND('-') then begin
                    ArrEarnings[1, i] := 'Less Pension contribution benefit';
                    EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(AssignMatrix."Less Pension Contribution"))));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);


                    TaxableAmt := 0;
                    PAYE := 0;

                    TaxableAmt := AssignMatrix."Taxable amount";
                    PAYE := AssignMatrix.Amount;

                end;

                i := i + 1;
                Earn.RESET;
                Earn.SETRANGE(Earn."Earning Type", Earn."Earning Type"::"Owner Occupier");
                if Earn.FIND('-') then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code", false);
                        AssignMatrix.SETRANGE(Code, Earn.Code);
                        if AssignMatrix.FIND('-') then begin
                            repeat
                                ArrEarnings[1, i] := AssignMatrix.Description;
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(PayrollRounding(AssignMatrix.Amount)));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                i := i + 1;
                            until AssignMatrix.NEXT = 0;
                        end;
                    until Earn.NEXT = 0;
                end;

                // Taxable amount
                ArrEarnings[1, i] := 'Taxable Amount';
                EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TaxableAmt))));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                i := i + 1;
                // Tax Charged + Relief
                Earn.RESET;
                Earn.SETFILTER(Earn."Earning Type", '%1|%2', Earn."Earning Type"::"Tax Relief",
                Earn."Earning Type"::"Insurance Relief");
                if Earn.FIND('-') then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code", false);
                        AssignMatrix.SETRANGE(Code, Earn.Code);
                        if AssignMatrix.FIND('-') then begin
                            repeat

                                ArrEarnings[1, i] := 'Tax Charged';
                                TaxCharged := ABS(PayrollRounding(PAYE)) + ABS(PayrollRounding(AssignMatrix.Amount));
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(TaxCharged));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                i := i + 1;
                            until AssignMatrix.NEXT = 0;
                        end;
                    until Earn.NEXT = 0;
                end;

                i := i + 1;

                // Relief
                Earn.RESET;
                Earn.SETFILTER(Earn."Earning Type", '%1|%2', Earn."Earning Type"::"Tax Relief",
                Earn."Earning Type"::"Insurance Relief");
                if Earn.FIND('-') then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code", false);
                        AssignMatrix.SETRANGE(Code, Earn.Code);
                        if AssignMatrix.FIND('-') then begin
                            repeat
                                ArrEarnings[1, i] := AssignMatrix.Description;
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(AssignMatrix.Amount))));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                i := i + 1;
                            until AssignMatrix.NEXT = 0;
                        end;
                    until Earn.NEXT = 0;
                end;

                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';


                i := i + 1;

                // Deductions
                ArrEarnings[1, i] := 'Deductions';

                i := i + 1;

                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';

                i := i + 1;

                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                AssignMatrix.SETRANGE(AssignMatrix.Paye, true);
                if AssignMatrix.FIND('-') then begin
                    ArrEarnings[1, i] := AssignMatrix.Description;
                    EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(AssignMatrix.Amount))));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                    TotalDeduction := TotalDeduction + ABS(AssignMatrix.Amount);
                end;

                i := i + 1;

                Deduct.RESET;
                Deduct.SETFILTER(Deduct."Calculation Method", '<>%1', Deduct."Calculation Method"::"% of Salary Recovery");
                Deduct.SETRANGE(Deduct.Informational, false);
                if Deduct.FIND('-') then begin
                    repeat

                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(AssignMatrix.Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        // AssignMatrix.SETRANGE(AssignMatrix.Shares,FALSE);
                        // AssignMatrix.SETRANGE(AssignMatrix."Insurance Code",FALSE);

                        if AssignMatrix.FIND('-') then begin
                            repeat
                                ArrEarnings[1, i] := AssignMatrix.Description;
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(AssignMatrix.Amount))));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                TotalDeduction := TotalDeduction + ABS(PayrollRounding(AssignMatrix.Amount));

                                if Deduct.GET(AssignMatrix.Code) then begin
                                    //
                                    /*
                                    IF Deduct."Show Balance" THEN
                                    BEGIN
                                    LoanBalances.RESET;
                                    LoanBalances.SETRANGE(LoanBalances."Loan No",AssignMatrix."Reference No");
                                    LoanBalances.SETRANGE(LoanBalances."Deduction Code",AssignMatrix.Code);
                                   IF LoanBalances.FIND('-') THEN
                                   BEGIN

                                   LoanBalances.SETRANGE(LoanBalances."Date filter",0D,DateSpecified);
                                   LoanBalances.CALCFIELDS(LoanBalances."Total Repayment");
                                   // MESSAGE('%1 Loan amount=%2',LoanBalances."Total Repayment",LoanBalances."Approved Amount");
                                   BalanceArray[1,i]:=LoanBalances."Approved Amount"+LoanBalances."Total Repayment";
                                   END
                                   ELSE
                                   BEGIN
                                    Deduct.SETRANGE(Deduct."Employee Filter",Employee."No.");
                                    Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                                    Deduct.CALCFIELDS(Deduct."Total Amount");
                                    BalanceArray[1,i]:=ChckRound(ABS(Deduct."Total Amount"));
                                    //MESSAGE('Balance=%1',Deduct."Total Amount");
                                    END;
                                   END;
                                     */
                                    //
                                end;


                                i := i + 1;
                            until AssignMatrix.NEXT = 0;
                        end;
                        //i:=i+1;
                    until Deduct.NEXT = 0;
                end;
                //For PAYE Manual

                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Calculation Method", Deduct."Calculation Method"::"% of Salary Recovery");
                if Deduct.FIND('-') then begin
                    repeat

                        LoanBalance := 0;

                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        // AssignMatrix.SETRANGE(AssignMatrix.Shares,FALSE);
                        // AssignMatrix.SETRANGE(AssignMatrix."Insurance Code",FALSE);

                        if AssignMatrix.FIND('-') then begin
                            //  REPEAT
                            AssignMatrix.CALCSUMS(Amount);
                            ArrEarnings[1, i] := AssignMatrix.Description;

                            PositivePAYEManual := 0;

                            Earn.RESET;
                            Earn.SETRANGE(Earn."Calculation Method", Earn."Calculation Method"::"% of Salary Recovery");
                            if Earn.FIND('-') then begin
                                // REPEAT
                                PayDeduct.RESET;
                                PayDeduct.SETRANGE(PayDeduct."Payroll Period", DateSpecified);
                                PayDeduct.SETFILTER(Type, '%1', PayDeduct.Type::Payment);
                                PayDeduct.SETRANGE(Code, Earn.Code);
                                PayDeduct.SETRANGE(PayDeduct."Employee No", Employee."No.");
                                PayDeduct.SETRANGE(PayDeduct."Manual Entry", true);
                                // AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                                if PayDeduct.FIND('-') then begin
                                    repeat
                                        PositivePAYEManual := PositivePAYEManual + PayDeduct.Amount;

                                    until PayDeduct.NEXT = 0;
                                end;
                            end;
                            //  MESSAGE('negative paye manual=%1',AssignMatrix.Amount);
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(PayrollRounding(AssignMatrix.Amount) + PayrollRounding(PositivePAYEManual)));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                            TotalDeduction := TotalDeduction + PayrollRounding(AssignMatrix.Amount) + PayrollRounding(PositivePAYEManual);
                            // END;
                            i := i + 1;
                            //  i:=i+1;
                            //  UNTIL AssignMatrix.NEXT=0;
                        end;
                    until Deduct.NEXT = 0;
                end;



                /*AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                AssignMatrix.SETRANGE(AssignMatrix."Insurance Code",TRUE);
                AssignMatrix.SETRANGE(AssignMatrix."Main Deduction Code",'842');

                IF AssignMatrix.FIND('-') THEN BEGIN
                 REPEAT
                // MESSAGE('HAPO');
                //  ArrEarnings[1,i]:=AssignMatrix.Description;
                 // EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix.Amount)));
                  Totalcoopshares:=Totalcoopshares+ABS(AssignMatrix.Amount);
                 // MESSAGE('%1',Totalcoopshares);
                  TotalDeduction:=TotalDeduction+ABS(AssignMatrix.Amount);
                 // i:=i+1;
                 UNTIL AssignMatrix.NEXT=0;
                 END;

             // i:=i+1;
            IF   Totalcoopshares>0 THEN BEGIN

                   ArrEarnings[1,i]:='INSURANCES';
                  EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(Totalcoopshares)));
                  ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];

                  Totalcoopshares:=0;
                    i:=i+1;
            END;

            //i:=i+1;
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                AssignMatrix.SETRANGE(AssignMatrix.Shares,TRUE);
                AssignMatrix.SETRANGE(AssignMatrix."Main Deduction Code",'853');

                IF AssignMatrix.FIND('-') THEN BEGIN
                 REPEAT
                // MESSAGE('HAPO');
                //  ArrEarnings[1,i]:=AssignMatrix.Description;
                 // EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix.Amount)));
                  Totalcoopshares:=Totalcoopshares+ABS(AssignMatrix.Amount);
                 // MESSAGE('%1',Totalcoopshares);
                  TotalDeduction:=TotalDeduction+ABS(AssignMatrix.Amount);
                 // i:=i+1;
                 UNTIL AssignMatrix.NEXT=0;
                 END;

             // i:=i+1;
            IF   Totalcoopshares>0 THEN BEGIN

                   ArrEarnings[1,i]:='COOP. SOCIETY SHARES';
                  EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(Totalcoopshares)));
                  ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];

                  Totalcoopshares:=0;
                    i:=i+1;
            END;


            //i:=i+1;
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                AssignMatrix.SETRANGE(AssignMatrix.Shares,TRUE);
                AssignMatrix.SETRANGE(AssignMatrix."Main Deduction Code",'854');

                IF AssignMatrix.FIND('-') THEN BEGIN
                 REPEAT
                // MESSAGE('HAPO');
                //  ArrEarnings[1,i]:=AssignMatrix.Description;
                 // EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix.Amount)));
                  Totalcoopshares:=Totalcoopshares+ABS(AssignMatrix.Amount);
                 // MESSAGE('%1',Totalcoopshares);
                  TotalDeduction:=TotalDeduction+ABS(AssignMatrix.Amount);
                 // i:=i+1;
                 UNTIL AssignMatrix.NEXT=0;
                 END;

             // i:=i+1;
             IF   Totalcoopshares>0 THEN BEGIN
                  ArrEarnings[1,i]:='COOP. SOCIETY INVESTMENTS';
                  EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(Totalcoopshares)));
                  ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];

                  Totalcoopshares:=0;
                  i:=i+1;
              END;

            //i:=i+1;
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                AssignMatrix.SETRANGE(AssignMatrix.Shares,TRUE);
                AssignMatrix.SETRANGE(AssignMatrix."Main Deduction Code",'866');

                IF AssignMatrix.FIND('-') THEN BEGIN
                 REPEAT
                  Totalcoopshares:=Totalcoopshares+ABS(AssignMatrix.Amount);

                  TotalDeduction:=TotalDeduction+ABS(AssignMatrix.Amount);

                 UNTIL AssignMatrix.NEXT=0;
                 END;

             // i:=i+1;
             IF   Totalcoopshares>0 THEN BEGIN
                  ArrEarnings[1,i]:='SACCO BBF/SINKING FUND';
                  EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(Totalcoopshares)));
                  ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];

                  Totalcoopshares:=0;
            i:=i+1;
            END;


            //i:=i+1;
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                AssignMatrix.SETRANGE(AssignMatrix.Shares,TRUE);
                AssignMatrix.SETRANGE(AssignMatrix."Main Deduction Code",'869');

                IF AssignMatrix.FIND('-') THEN BEGIN
                 REPEAT
                  Totalcoopshares:=Totalcoopshares+ABS(AssignMatrix.Amount);

                  TotalDeduction:=TotalDeduction+ABS(AssignMatrix.Amount);

                 UNTIL AssignMatrix.NEXT=0;
                 END;

             // i:=i+1;
             IF   Totalcoopshares>0 THEN BEGIN
                  ArrEarnings[1,i]:='COOP. INTEREST';
                  EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(Totalcoopshares)));
                  ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];

                  Totalcoopshares:=0;
            i:=i+1;
            END;


            //i:=i+1;
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                AssignMatrix.SETRANGE(AssignMatrix.Shares,TRUE);
                AssignMatrix.SETRANGE(AssignMatrix."Main Deduction Code",'832');

                IF AssignMatrix.FIND('-') THEN BEGIN
                 REPEAT
                  Totalcoopshares:=Totalcoopshares+ABS(AssignMatrix.Amount);

                  TotalDeduction:=TotalDeduction+ABS(AssignMatrix.Amount);

                 UNTIL AssignMatrix.NEXT=0;
                 END;

             // i:=i+1; BKK
             */

                if Totalcoopshares > 0 then begin
                    ArrEarnings[1, i] := 'SPORTS/SOCIAL WELFARE';
                    EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(Totalcoopshares)));
                    ArrEarningsAmt[1, i] := ArrEarningsAmt[1, i];

                    Totalcoopshares := 0;
                    i := i + 1;
                end;




                ArrEarnings[1, i] := 'TOTAL DEDUCTIONS';
                EVALUATE(ArrEarningsAmt[1, i], FORMAT(TotalDeduction));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                i := i + 1;

                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';

                i := i + 1;
                // Net Pay
                ArrEarnings[1, i] := 'NET PAY';
                NetPay := GrossPay - TotalDeduction;
                EVALUATE(ArrEarningsAmt[1, i], FORMAT(NetPay));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                i := i + 1;

                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';

                i := i + 1;
                //Information
                ArrEarnings[1, i] := 'Information';

                i := i + 1;

                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';

                i := i + 1;

                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                Deduct.SETRANGE(Loan, true);
                Deduct.SETFILTER(Deduct."Calculation Method", '<>%1', Deduct."Calculation Method"::"% of Basic Pay");
                Deduct.SETRANGE(Deduct.Shares, false);
                Deduct.SETRANGE(Deduct."Salary Recovery", false);
                if Deduct.FIND('-') then begin
                    repeat
                        // MESSAGE('DEDUCTIONCODE=%1',Deduct.Code);
                        LoanBalance := 0;
                        TotalBulkRepayments := 0;
                        TotalRepayments := 0;
                        //Balances

                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", 0D, DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE("Employee No", "No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        if AssignMatrix.FIND('-') then begin

                            AssignMatrix.CALCSUMS(Amount);
                            LoanBalances.RESET;
                            LoanBalances.SETRANGE(LoanBalances."Date filter", 0D, DateSpecified);
                            LoanBalances.SETRANGE(LoanBalances."Deduction Code", AssignMatrix.Code);
                            LoanBalances.SETRANGE("Employee No", "No.");
                            LoanBalances.SETRANGE("Stop Loan", false);
                            if LoanBalances.FIND('-') then begin
                                repeat
                                    if loanType.GET(LoanBalances."Loan Product Type") then begin
                                        if loanType."Interest Calculation Method" = loanType."Interest Calculation Method"::"Flat Rate" then begin
                                            LoanBalances.CALCFIELDS(LoanBalances."Total Repayment", LoanBalances."Total Loan");
                                            // ArrEarnings[1,i]:=AssignMatrix.Description;
                                            // add Total Loan/Approved Amount
                                            if LoanBalances."Total Loan" <> 0 then begin
                                                LoanTopUps.RESET;
                                                LoanTopUps.SETCURRENTKEY("Loan No", "Payroll Period");
                                                LoanTopUps.SETRANGE(LoanTopUps."Loan No", LoanBalances."Loan No");
                                                LoanTopUps.SETRANGE("Payroll Period", 0D, DateSpecified);
                                                LoanTopUps.CALCSUMS(Amount);
                                                LineAmt := LoanTopUps.Amount;
                                                LoanBalance := LoanBalance + LineAmt;

                                                // MESSAGE('%1  %2, %3 ,%4',LineAmt,LoanBalances."Total Repayment",(LineAmt+LoanBalances."Total Repayment"),LoanBalances."Employee No");
                                            end else
                                                LoanBalance := LoanBalance + LoanBalances."Approved Amount";

                                            LoanBalance := LoanBalance + LoanBalances."Total Repayment";
                                            //   MESSAGE('%1  %2, %3 ,%4',LoanBalances."Approved Amount",LoanBalances."Total Repayment",(LoanBalances."Approved Amount"+LoanBalances."Total Repayment"),LoanBalances."Employee No");
                                        end;
                                        if loanType."Interest Calculation Method" = loanType."Interest Calculation Method"::"Reducing Balance" then begin
                                            // ArrEarnings[1,i]:=AssignMatrix.Description;
                                            RepSchedule.RESET;
                                            RepSchedule.SETCURRENTKEY("Loan Category", "Employee No", "Repayment Date");
                                            RepSchedule.SETRANGE(RepSchedule."Loan Category", loanType.Code);
                                            RepSchedule.SETRANGE("Employee No", "No.");
                                            RepSchedule.SETRANGE(RepSchedule."Repayment Date", DateSpecified);
                                            RepSchedule.CALCSUMS(RepSchedule."Remaining Debt");
                                            LoanBalance := RepSchedule."Remaining Debt";
                                        end;
                                    end;

                                until LoanBalances.NEXT = 0;
                                LoanBalance := LoanBalance;
                                // MESSAGE('LoanBalance1=%1',LoanBalance);
                            end;
                        end;
                        if LoanBalance <> 0 then begin
                            ArrEarnings[1, i] := Deduct.Description + ' Balance';//AssignMatrix.Description;
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(PayrollRounding(LoanBalance)));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                            i := i + 1;
                        end;
                    until Deduct.NEXT = 0;
                end;
                TotalToDate := 0;
                loanType.RESET;
                //loanType.SETRANGE("Deduction Code",Deduct.Code);
                loanType.SETRANGE("Interest Calculation Method", loanType."Interest Calculation Method"::"Reducing Balance");
                if loanType.FIND('-') then begin
                    repeat

                        RepSchedule.RESET;
                        RepSchedule.SETCURRENTKEY("Loan No", "Repayment Date");
                        RepSchedule.SETRANGE("Loan Category", loanType.Code);
                        RepSchedule.SETRANGE("Employee No", "No.");
                        RepSchedule.SETRANGE(RepSchedule."Repayment Date", DateSpecified);
                        RepSchedule.CALCSUMS("Principal Repayment");
                        TotalToDate := RepSchedule."Principal Repayment";
                        if TotalToDate <> 0 then begin
                            ArrEarnings[1, i] := loanType.Description + ' Principal Repayment';
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                            i := i + 1;
                        end;

                    until loanType.NEXT = 0;
                end;


                //Pension Self Contribution to Date
                TotalToDate := 0;
                TotalPensionInactive := 0;
                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                // Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"Flat Amount");
                Deduct.SETRANGE(Deduct."Pension Scheme", true);
                if Deduct.FIND('-') then begin
                    repeat

                        Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");

                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", 0D, DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", "No.");
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        AssignMatrix.CALCSUMS(AssignMatrix.Amount, "Employer Amount", AssignMatrix."Opening Balance");
                        TotalToDate := AssignMatrix.Amount + AssignMatrix."Opening Balance";
                        if TotalToDate <> 0 then begin
                            ArrEarnings[1, i] := Deduct.Description + ' Bal. to Date';
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                            i := i + 1;
                        end;

                    until Deduct.NEXT = 0;
                end;




                //Gratuity Employer Contribution

                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                Deduct.SETRANGE(Deduct."Calculation Method", Deduct."Calculation Method"::"% of Basic Pay");
                Deduct.SETRANGE(Deduct.Gratuity, true);
                // Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                if Deduct.FIND('-') then begin
                    repeat
                        // MESSAGE('Gratuity PERIOD=%1',Deduct."Pay Period Filter");
                        //   LoanBalance:=0;
                        //Balances
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        if AssignMatrix.FIND('-') then begin

                            AssignMatrix.CALCSUMS(Amount, "Employer Amount");
                            if Deduct.GET(AssignMatrix.Code) then begin
                                Deduct.SETRANGE(Deduct."Pay Period Filter", 0D, DateSpecified);
                                Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");
                                //  IF (Deduct."Total Amount"<>0) OR (Deduct."Total Amount Employer"<>0) THEN BEGIN
                                ArrEarnings[1, i] := 'Gratuity Employer Contribution';
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(Deduct."Total Amount Employer"))));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                            end;
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(AssignMatrix."Employer Amount"))));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                            i := i + 1;
                            // END;
                            //END;
                        end;
                    until Deduct.NEXT = 0;
                end;
                TotalToDate := 0;
                //Gratuity Balance To Date
                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                Deduct.SETFILTER(Deduct."Calculation Method", '=%1|=%2', Deduct."Calculation Method"::"% of Basic Pay", Deduct."Calculation Method"::"Flat Amount");
                Deduct.SETRANGE(Deduct.Gratuity, true);
                // Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                if Deduct.FIND('-') then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", 0D, DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        AssignMatrix.CALCSUMS(Amount, "Employer Amount", "Opening Balance Company");
                        Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");

                        TotalToDate := AssignMatrix."Employer Amount" + AssignMatrix."Opening Balance Company";
                        if TotalToDate <> 0 then begin
                            ArrEarnings[1, i] := 'Gratuity Employer Contrib Bal. to Date';
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                            // MESSAGE('Opening Balance Company=%1',AssignMatrix."Opening Balance Company");
                            // MESSAGE('OpeningBalanceCompany+TotalGratuityDeduct=%1',TotalToDate);
                            i := i + 1;
                        end;
                        //UNTIL AssignMatrix.NEXT=0;
                    until Deduct.NEXT = 0;
                end;


                // Non Cash Benefits
                Earn.RESET;
                Earn.SETRANGE(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SETRANGE(Earn."Non-Cash Benefit", true);
                if Earn.FIND('-') then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code", false);
                        AssignMatrix.SETRANGE(Code, Earn.Code);
                        if AssignMatrix.FIND('-') then begin
                            repeat
                                // IF AssignMatrix.Amount<>0 THEN BEGIN
                                ArrEarnings[1, i] := AssignMatrix.Description;
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(PayrollRounding(AssignMatrix.Amount)));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                i := i + 1;
                                // END;

                            until AssignMatrix.NEXT = 0;
                        end;
                    until Earn.NEXT = 0;
                end;

                // end of non cash


                Ded.RESET;
                Ded.SETRANGE(Ded."Tax deductible", true);
                Ded.SETRANGE(Ded."Pay Period Filter", DateSpecified);
                Ded.SETRANGE(Ded."Employee Filter", Employee."No.");
                Ded.SETRANGE(Ded."Show on Payslip Information", true);
                if Ded.FIND('-') then
                    repeat
                        Ded.CALCFIELDS(Ded."Total Amount", Ded."Total Amount Employer");
                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(Ded."Total Amount Employer"))));
                        // IF Ded."Total Amount Employer"<> 0 THEN BEGIN
                        ArrEarnings[1, i] := Ded.Description + '(Employer)';
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                        i := i + 1;
                        //  END;
                    until Ded.NEXT = 0;


                //i:=i+1;
                /*//Balances
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                    IF AssignMatrix.FIND('-') THEN BEGIN
                     REPEAT
                        IF Deduct.GET(AssignMatrix.Code) THEN
                         BEGIN
                          IF Deduct."Show Balance" THEN
                           BEGIN
                            LoanBalances.RESET;
                            LoanBalances.SETRANGE(LoanBalances."Loan No",AssignMatrix."Reference No");
                            LoanBalances.SETRANGE(LoanBalances."Deduction Code",AssignMatrix.Code);
                         IF LoanBalances.FIND('-') THEN
                          BEGIN
                           LoanBalances.SETRANGE(LoanBalances."Date filter",0D,DateSpecified);
                           LoanBalances.CALCFIELDS(LoanBalances."Total Repayment");
                          // ArrEarnings[1,i]:=AssignMatrix.Description;
                           LoanBalance:=LoanBalances."Approved Amount"+LoanBalances."Total Repayment";
                           EVALUATE(ArrEarningsAmt[1,i],FORMAT(PayrollRounding(LoanBalance)));
                           ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                         END
                         ELSE
                         BEGIN
                          Deduct.SETRANGE(Deduct."Employee Filter",Employee."No.");
                          Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                          Deduct.CALCFIELDS(Deduct."Total Amount");
                         // BalanceArray[1,i]:=ABS(Deduct."Total Amount");
                          ArrEarnings[1,i]:=AssignMatrix.Description;
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(Deduct."Total Amount"))));
                          ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                
                          END;
                         END;
                       END;
                
                
                      i:=i+1;
                     UNTIL AssignMatrix.NEXT=0;
                     END;
                // i:=i+1;
                */


                //End balances

                i := i + 1;

                //

                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';






                i := i + 1;
                ArrEarnings[1, i] := 'Employee Details';
                // Employee details
                i := i + 1;

                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';
                i := i + 1;

                ArrEarnings[1, i] := 'P.I.N';
                ArrEarningsAmt[1, i] := Employee."PIN Number";

                i := i + 1;
                if EmpBank.GET("Employee's Bank", "Bank Branch") then begin
                    BankName := EmpBank.Name;

                    ArrEarnings[1, i] := 'Employee Bank';
                    ArrEarningsAmt[1, i] := BankName;

                    i := i + 1;
                    ArrEarnings[1, i] := 'Bank Branch';
                    ArrEarningsAmt[1, i] := EmpBank."Name 2";
                end;

                i := i + 1;
                ArrEarnings[1, i] := 'Acc No.';
                ArrEarningsAmt[1, i] := "Bank Account Number";

                i := i + 1;
                ArrEarnings[1, i] := 'NSSF No';
                ArrEarningsAmt[1, i] := Employee."NSSF No.";
                i := i + 1;
                ArrEarnings[1, i] := 'NHIF No';
                ArrEarningsAmt[1, i] := Employee."N.H.I.F No";
                i := i + 1;


                ArrEarnings[1, i] := 'Leave Balance';

                AccPeriod.RESET;
                AccPeriod.SETRANGE(AccPeriod."Starting Date", 0D, TODAY);
                AccPeriod.SETRANGE(AccPeriod."New Fiscal Year", true);
                if AccPeriod.FIND('+') then begin
                    FiscalStart := AccPeriod."Starting Date";
                    MaturityDate := CALCDATE('1Y', AccPeriod."Starting Date") - 1;

                    //   ArrEarnings[1,i]:='Leave Balance';
                    // MESSAGE('MATURITY DATE=%1',MaturityDate);
                    LeaveApplication.RESET;
                    LeaveApplication.SETRANGE(LeaveApplication."Employee No", Employee."No.");
                    LeaveApplication.SETRANGE(LeaveApplication."Maturity Date", MaturityDate);
                    LeaveApplication.SETRANGE(LeaveApplication.Status, LeaveApplication.Status::Approved);
                    if LeaveApplication.FIND('+') then
                        // BEGIN
                        ArrEarningsAmt[1, i] := FORMAT(LeaveApplication."Leave balance");
                    //      MESSAGE('EMPLOYEE=%1, LEAVE BALANCE=%2',Employee."No.",LeaveApplication."Leave balance");
                    //  END;
                end;

                i := i + 1;
                ArrEarnings[1, i] := '*******End of Payslip********';

                i := i + 1;
                CompRec.GET;
                ArrEarnings[1, i] := CompRec."General Payslip Message";

                i := i + 1;
                //ArrEarnings[1,i]:=USERID;

            end;

            trigger OnPreDataItem();
            begin
                CompRec.GET;
                Message2[1, 1] := CompRec."General Payslip Message";

                CoRec.CALCFIELDS(Picture);
                /*
               CUser:=USERID;
               GetGroup.GetUserGroup(CUser,GroupCode);
               SETRANGE(Employee."Posting Group",GroupCode);
                */

            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Month Begin Date"; MonthStartDate)
                {
                    Caption = 'Month Begin Date';
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        //Employee.SETFILTER("Pay Period Filter",'%1',DateSpecified);



        PayPeriodtext := Employee.GETFILTER("Pay Period Filter");

        // PayPeriodtext:=Employee.GETFILTER("Date Filter");
        EVALUATE(PayrollMonth, FORMAT(PayPeriodtext));
        PayrollMonthText := FORMAT(PayrollMonth, 1, 4);

        // IF PayPeriodtext='' THEN
        // ERROR('Pay period must be specified for this report');
        CoRec.GET;
        CoName := CoRec.Name;
        EVALUATE(DateSpecified, FORMAT(PayPeriodtext));
    end;

    var
        DAge: Text;
        Dates: Codeunit "HR Datesss";
        Addr: array[10, 100] of Text[250];
        NoOfRecords: Integer;
        RecordNo: Integer;
        NoOfColumns: Integer;
        ColumnNo: Integer;
        i: Integer;
        AmountRemaining: Decimal;
        IncomeTax: Decimal;
        PayPeriod: Record "Payroll Period";
        PayPeriodtext: Text[30];
        BeginDate: Date;
        DateSpecified: Date;
        EndDate: Date;
        EmpBank: Record "Staff  Bank Account";
        BankName: Text[250];
        BasicSalary: Decimal;
        TaxableAmt: Decimal;
        RightBracket: Boolean;
        NetPay: Decimal;
        PayPeriodRec: Record "Payroll Period";
        PayDeduct: Record "Assignment Matrix";
        EmpRec: Record Employee;
        EmpNo: Code[10];
        TaxableAmount: Decimal;
        PAYE: Decimal;
        ArrEarnings: array[3, 100] of Text[250];
        ArrDeductions: array[3, 100] of Text[250];
        Index: Integer;
        Index1: Integer;
        j: Integer;
        ArrEarningsAmt: array[3, 100] of Text[60];
        ArrDeductionsAmt: array[3, 100] of Decimal;
        Year: Integer;
        EmpArray: array[10, 15] of Decimal;
        HoldDate: Date;
        DenomArray: array[3, 12] of Text[50];
        NoOfUnitsArray: array[3, 12] of Integer;
        AmountArray: array[3, 12] of Decimal;
        PayModeArray: array[3] of Text[30];
        HoursArray: array[3, 60] of Decimal;
        CompRec: Record "Human Resources Setup";
        HseLimit: Decimal;
        ExcessRetirement: Decimal;
        CfMpr: Decimal;
        relief: Decimal;
        TaxCode: Code[10];
        HoursBal: Decimal;
        Pay: Record Earnings;
        Ded: Record Deductions;
        HoursArrayD: array[3, 60] of Decimal;
        BankBranch: Text[30];
        CoName: Text[30];
        retirecontribution: Decimal;
        EarngingCount: Integer;
        DeductionCount: Integer;
        EarnAmount: Decimal;
        GrossTaxCharged: Decimal;
        DimVal: Record "Dimension Value";
        Department: Text[60];
        LowInterestBenefits: Decimal;
        SpacePos: Integer;
        NetPayLength: Integer;
        AmountText: Text[30];
        DecimalText: Text[30];
        DecimalAMT: Decimal;
        InsuranceRelief: Decimal;
        InsuranceReliefText: Text[30];
        PayrollCodeunit: Codeunit PayrollRounding;
        IncometaxNew: Decimal;
        NewRelief: Decimal;
        TaxablePayNew: Decimal;
        InsuranceReliefNew: Decimal;
        TaxChargedNew: Decimal;
        finalTax: Decimal;
        TotalBenefits: Decimal;
        RetireCont: Decimal;
        TotalQuarters: Decimal;
        "Employee Payroll": Record Employee;
        PayMode: Text[30];
        Intex: Integer;
        NetPay1: Decimal;
        Principal: Decimal;
        Interest: Decimal;
        Desc: Text[50];
        dedrec: Record Deductions;
        RoundedNetPay: Decimal;
        diff: Decimal;
        CFWD: Decimal;
        Nssfcomptext: Text[30];
        Nssfcomp: Decimal;
        LoanDesc: Text[60];
        LoanDesc1: Text[60];
        Deduct: Record Deductions;
        OriginalLoan: Decimal;
        LoanBalance: Decimal;
        Message1: Text[250];
        Message2: array[3, 1] of Text[250];
        DeptArr: array[3, 1] of Text[60];
        BasicPay: array[3, 1] of Text[250];
        InsurEARN: Decimal;
        HasInsurance: Boolean;
        RoundedAmt: Decimal;
        TerminalDues: Decimal;
        Earn: Record Earnings;
        AssignMatrix: Record "Assignment Matrix";
        RoundingDesc: Text[60];
        BasicChecker: Decimal;
        CoRec: Record "Company Information";
        GrossPay: Decimal;
        TotalDeduction: Decimal;
        PayrollMonth: Date;
        PayrollMonthText: Text[30];
        GetPaye: Codeunit PayrollRounding;
        PayeeTest: Decimal;
        GetGroup: Codeunit PayrollRounding;
        GroupCode: Code[20];
        CUser: Code[20];
        Totalcoopshares: Decimal;
        LoanBal: Decimal;
        LoanBalances: Record "Loan Application";
        TotalRepayment: Decimal;
        Totalnssf: Decimal;
        Totalpension: Decimal;
        Totalprovid: Decimal;
        BalanceArray: array[3, 100] of Decimal;
        EarningsCaptionLbl: Label 'Earnings';
        Employee_No_CaptionLbl: Label 'Employee No:';
        Name_CaptionLbl: Label 'Name:';
        Dept_CaptionLbl: Label 'Dept:';
        AmountCaptionLbl: Label 'Amount';
        Pay_slipCaptionLbl: Label 'Pay slip';
        EmptyStringCaptionLbl: Label '*****************************************************';
        CurrReport_PAGENOCaptionLbl: Label 'Copy';
        TaxCharged: Decimal;
        LeaveApplication: Record "Employee Leave Application";
        EmpLeaves: Record "Employee Leaves";
        FiscalStart: Date;
        MaturityDate: Date;
        PositivePAYEManual: Decimal;
        TotalToDate: Decimal;
        LoanTopUps: Record "Loan Top-up";
        AccPeriod: Record "Accounting Period";
        MonthStartDate: Date;
        Age_CaptionLbl: Label 'Age';

    procedure GetTaxBracket(var TaxableAmount: Decimal);
    var
        TaxTable: Record Brackets;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
    end;

    procedure GetPayPeriod();
    begin
    end;

    procedure GetTaxBracket1(var TaxableAmount: Decimal);
    var
        TaxTable: Record Brackets;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
    begin
    end;

    procedure CoinageAnalysis(var NetPay: Decimal; var ColNo: Integer);
    var
        Index: Integer;
        Intex: Integer;
    begin
    end;

    procedure PayrollRounding(var Amount: Decimal) PayrollRounding: Decimal;
    var
        HRsetup: Record "Human Resources Setup";
    begin

        HRsetup.GET;
        if HRsetup."Payroll Rounding Precision" = 0 then
            ERROR('You must specify the rounding precision under HR setup');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Nearest then
            PayrollRounding := ROUND(Amount, HRsetup."Payroll Rounding Precision", '=');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Up then
            PayrollRounding := ROUND(Amount, HRsetup."Payroll Rounding Precision", '>');

        if HRsetup."Payroll Rounding Type" = HRsetup."Payroll Rounding Type"::Down then
            PayrollRounding := ROUND(Amount, HRsetup."Payroll Rounding Precision", '<');
    end;

    procedure ChckRound(var AmtText: Text[30]) ChckRound: Text[30];
    var
        LenthOfText: Integer;
        DecimalPos: Integer;
        AmtWithoutDec: Text[30];
        DecimalAmt: Text[30];
        Decimalstrlen: Integer;
    begin
        LenthOfText := STRLEN(AmtText);
        DecimalPos := STRPOS(AmtText, '.');
        if DecimalPos = 0 then begin
            AmtWithoutDec := AmtText;
            DecimalAmt := '.00';
        end else begin
            AmtWithoutDec := COPYSTR(AmtText, 1, DecimalPos - 1);
            DecimalAmt := COPYSTR(AmtText, DecimalPos + 1, 2);
            Decimalstrlen := STRLEN(DecimalAmt);
            if Decimalstrlen < 2 then begin
                DecimalAmt := '.' + DecimalAmt + '0';
            end else
                DecimalAmt := '.' + DecimalAmt
        end;
        ChckRound := AmtWithoutDec + DecimalAmt;
    end;
}

