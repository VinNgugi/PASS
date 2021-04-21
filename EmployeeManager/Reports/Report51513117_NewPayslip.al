report 51513117 "New Payslip"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/New Payslip.rdl';
    Caption = 'New Payslip';

    dataset
    {
        dataitem(Employee; Employee)
        {
            //DataItemTableView = SORTI                        NG("Global Dimension 1 Code") ORDER(Ascending);
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
            column(CampArr_1_1_; CampArr[1, 1])
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
                //DecimalPlaces = 2 : 2;
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
            column(Age_CaptionLbl; Age_CaptionLbl)
            {
            }
            column(Age_; DAge)
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
            column(BalanceArray_1_1_; BalanceArrs[1, 1])
            {
            }
            column(BalanceArray_1_2_; BalanceArrs[1, 2])
            {
            }
            column(BalanceArray_1_3_; BalanceArrs[1, 3])
            {
            }
            column(BalanceArray_1_4_; BalanceArrs[1, 4])
            {
            }
            column(BalanceArray_1_5_; BalanceArrs[1, 5])
            {
            }
            column(BalanceArray_1_6_; BalanceArrs[1, 6])
            {
            }
            column(BalanceArray_1_7_; BalanceArrs[1, 7])
            {
            }
            column(BalanceArray_1_8_; BalanceArrs[1, 8])
            {
            }
            column(BalanceArray_1_9_; BalanceArrs[1, 9])
            {
            }
            column(BalanceArray_1_10_; BalanceArrs[1, 10])
            {
            }
            column(BalanceArray_1_11_; BalanceArrs[1, 11])
            {
            }
            column(BalanceArray_1_12_; BalanceArrs[1, 12])
            {
            }
            column(BalanceArray_1_13_; BalanceArrs[1, 13])
            {
            }
            column(BalanceArray_1_14_; BalanceArrs[1, 14])
            {
            }
            column(BalanceArray_1_15_; BalanceArrs[1, 15])
            {
            }
            column(BalanceArray_1_16_; BalanceArrs[1, 16])
            {
            }
            column(BalanceArray_1_17_; BalanceArrs[1, 17])
            {
            }
            column(BalanceArray_1_18_; BalanceArrs[1, 18])
            {
            }
            column(BalanceArray_1_19_; BalanceArrs[1, 19])
            {
            }
            column(BalanceArray_1_20_; BalanceArrs[1, 22])
            {
            }
            column(BalanceArray_1_21_; BalanceArrs[1, 21])
            {
            }
            column(BalanceArray_1_23_; BalanceArrs[1, 23])
            {
            }
            column(BalanceArray_1_24_; BalanceArrs[1, 24])
            {
            }
            column(BalanceArray_1_25_; BalanceArrs[1, 25])
            {
            }
            column(BalanceArray_1_26_; BalanceArrs[1, 26])
            {
            }
            column(BalanceArray_1_27_; BalanceArrs[1, 27])
            {
            }
            column(BalanceArray_1_28_; BalanceArrs[1, 28])
            {
            }
            column(BalanceArray_1_29_; BalanceArrs[1, 29])
            {
            }
            column(BalanceArray_1_30_; BalanceArrs[1, 30])
            {
            }
            column(BalanceArray_1_31_; BalanceArrs[1, 31])
            {
            }
            column(BalanceArray_1_32_; BalanceArrs[1, 32])
            {
            }
            column(BalanceArray_1_34_; BalanceArrs[1, 34])
            {
            }
            column(BalanceArray_1_33_; BalanceArrs[1, 33])
            {
            }
            column(BalanceArray_1_36_; BalanceArrs[1, 36])
            {
            }
            column(BalanceArray_1_35_; BalanceArrs[1, 35])
            {
            }
            column(BalanceArray_1_37_; BalanceArrs[1, 37])
            {
            }
            column(BalanceArray_1_38_; BalanceArrs[1, 38])
            {
            }
            column(BalanceArray_1_39_; BalanceArrs[1, 39])
            {
            }
            column(BalanceArray_1_40_; BalanceArrs[1, 40])
            {
            }
            column(BalanceArray_1_41_; BalanceArrs[1, 41])
            {
            }
            column(BalanceArray_1_42_; BalanceArrs[1, 42])
            {
            }
            column(BalanceArray_1_43_; BalanceArrs[1, 43])
            {
            }
            column(BalanceArray_1_44_; BalanceArrs[1, 44])
            {
            }
            column(BalanceArray_1_45_; BalanceArrs[1, 45])
            {
            }
            column(BalanceArray_1_46_; BalanceArrs[1, 46])
            {
            }
            column(BalanceArray_1_47_; BalanceArrs[1, 47])
            {
            }
            column(BalanceArray_1_48_; BalanceArrs[1, 48])
            {
            }
            column(STRSUBSTNO__Date__1__2__TODAY_TIME_; STRSUBSTNO('Date %1 %2', TODAY, TIME))
            {
            }
            column(USERID; USERID)
            {
            }
            /*column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }*/
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
            column(Camp_Caption; Camp_CaptionLbl)
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
            column(Water_Mark; CoRec.Picture)
            {
            }
            column(copy99; copy99)
            {
            }
            column(Balance_9; BalanceArrs[1, 9])
            {
            }
            column(Balance_10; BalanceArrs[1, 10])
            {
            }
            column(Balance_11; BalanceArrs[1, 11])
            {
            }
            column(Balance_12; BalanceArrs[1, 12])
            {
            }
            column(Balance_13; BalanceArrs[1, 13])
            {
            }
            column(Balance_14; BalanceArrs[1, 14])
            {
            }
            column(Balance_15; BalanceArrs[1, 15])
            {
            }
            column(Balance_16; BalanceArrs[1, 16])
            {
            }
            column(Balance_17; BalanceArrs[1, 17])
            {
            }
            column(Balance_18; BalanceArrs[1, 18])
            {
            }
            column(Balance_19; BalanceArrs[1, 19])
            {
            }
            column(Balance_20; BalanceArrs[1, 20])
            {
            }
            column(Balance_21; BalanceArrs[1, 21])
            {
            }
            column(Balance_22; BalanceArrs[1, 22])
            {
            }
            column(Balance_23; BalanceArrs[1, 23])
            {
            }
            column(Balance_24; BalanceArrs[1, 24])
            {
            }
            column(Balance_25; BalanceArrs[1, 25])
            {
            }
            column(Balance_26; BalanceArrs[1, 26])
            {
            }
            column(Balance_27; BalanceArrs[1, 27])
            {
            }
            column(Balance_28; BalanceArrs[1, 28])
            {
            }
            column(Balance_29; BalanceArrs[1, 29])
            {
            }
            column(Balance_30; BalanceArrs[1, 30])
            {
            }
            column(Balance_31; BalanceArrs[1, 31])
            {
            }
            column(Balance_32; BalanceArrs[1, 32])
            {
            }
            column(Balance_33; BalanceArrs[1, 33])
            {
            }
            column(Balance_34; BalanceArrs[1, 34])
            {
            }
            column(Balance_35; BalanceArrs[1, 35])
            {
            }
            column(Balance_36; BalanceArrs[1, 36])
            {
            }
            column(Balance_37; BalanceArrs[1, 37])
            {
            }
            column(Balance_38; BalanceArrs[1, 38])
            {
            }
            column(Balance_39; BalanceArrs[1, 39])
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

                CLEAR(Addr);
                CLEAR(DeptArr);
                CLEAR(BasicPay);
                CLEAR(EmpArray);
                CLEAR(ArrEarnings);
                CLEAR(ArrEarningsAmt);
                CLEAR(BalanceArray);
                CLEAR(Balance);
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
                //Earn.SETRANGE(Earn."Non-Cash Benefit", false);
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
                                if AssignMatrix.Amount <> 0 then begin
                                    ArrEarnings[1, i] := AssignMatrix.Description;
                                    EVALUATE(ArrEarningsAmt[1, i], FORMAT(AssignMatrix.Amount));
                                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                    GrossPay := GrossPay + AssignMatrix.Amount;
                                    i := i + 1;
                                end;
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
                                ArrEarnings[1, i] := AssignMatrix.Description;
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(AssignMatrix.Amount));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                i := i + 1;
                            until AssignMatrix.NEXT = 0;
                        end;
                    until Earn.NEXT = 0;
                end;
                /*
                   i:=i+1;
                
                // Club Membership Benefits
                    PayPeriod.RESET;
                    PayPeriod.SETRANGE(PayPeriod."Starting Date",0D,DateSpecified);
                    PayPeriod.SETRANGE(PayPeriod."New Fiscal Year",TRUE);
                    IF PayPeriod.FIND('+') THEN
                    BEGIN
                    // LastPayPeriod:=CALCDATE('11M',PayPeriod."Starting Date");
                
                     EarnRec.RESET;
                     //EarnRec.SETCURRENTKEY(EarnRec."Earning Type");
                     EarnRec.SETRANGE(EarnRec."Calculation Method",EarnRec."Calculation Method"::"Flat amount");
                     EarnRec.SETFILTER(EarnRec."Maximum Limit",'>%1',0);
                     IF EarnRec.FIND('-') THEN
                     BEGIN
                      REPEAT
                       AssignMatrix.RESET;
                       AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",PayPeriod."Starting Date",DateSpecified);
                       AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                       AssignMatrix.SETRANGE(AssignMatrix.Code,EarnRec.Code);
                       AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                       AssignMatrix.CALCSUMS(AssignMatrix.Amount);
                       IF AssignMatrix.Amount > EarnRec."Maximum Limit" THEN
                       //IF Assignmatrix.FIND('-') THEN
                        Excess:=AssignMatrix.Amount-EarnRec."Maximum Limit";
                         ArrEarnings[1,i]:='Taxable Club Membership Benefit';
                         EVALUATE(ArrEarningsAmt[1,i],FORMAT(Excess));
                         ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                
                        i:=i+1;
                
                    //    TaxableAmount:=TaxableAmount+Excess;
                      UNTIL EarnRec.NEXT=0;
                
                     END;
                
                    END;
                
                
                 //End of Club Membership benefits
                */

                // end of non cash
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                AssignMatrix.SETRANGE(AssignMatrix.Paye, true);
                if AssignMatrix.FIND('-') then begin
                    ArrEarnings[1, i] := 'Less Pension contribution benefit';
                    EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(AssignMatrix."Less Pension Contribution")));
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
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(AssignMatrix.Amount));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                i := i + 1;
                            until AssignMatrix.NEXT = 0;
                        end;
                    until Earn.NEXT = 0;
                end;

                // Taxable amount
                ArrEarnings[1, i] := 'Taxable Amount';
                EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(TaxableAmt)));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                i := i + 1;

                ArrEarnings[1, i] := 'Tax Charged';
                EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PAYE)));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                i := i + 1;

                // Relief
                Earn.RESET;
                Earn.SETFILTER(Earn."Earning Type", '%1|%2', Earn."Earning Type"::"Tax Relief", Earn."Earning Type"::"Insurance Relief");
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
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(AssignMatrix.Amount)));
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
                    EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(AssignMatrix.Amount)));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                    TotalDeduction := TotalDeduction + ABS(AssignMatrix.Amount);

                end;

                i := i + 1;


                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                // AssignMatrix.SETRANGE(AssignMatrix.Shares,FALSE);
                // AssignMatrix.SETRANGE(AssignMatrix."Insurance Code",FALSE);

                if AssignMatrix.FIND('-') then begin
                    repeat
                        if AssignMatrix.Amount <> 0 then begin
                            //MESSAGE('DEDUCTION %1, Amount=%2',AssignMatrix.Code,AssignMatrix.Amount);
                            ArrEarnings[1, i] := AssignMatrix.Description;
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(AssignMatrix.Amount)));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                            TotalDeduction := TotalDeduction + ABS(AssignMatrix.Amount);

                            if Deduct.GET(AssignMatrix.Code, Employee."Country/Region Code") then begin
                                if Deduct."Show Balance" then begin
                                    LoanBalances.RESET;
                                    LoanBalances.SETRANGE(LoanBalances."Loan No", AssignMatrix."Reference No");
                                    LoanBalances.SETRANGE(LoanBalances."Deduction Code", AssignMatrix.Code);
                                    if LoanBalances.FIND('-') then begin
                                        LoanBalances.SETRANGE(LoanBalances."Date filter", 0D, DateSpecified);
                                        LoanBalances.CALCFIELDS(LoanBalances."Total Repayment");
                                        PrincipalAmt := LoanBalances."Total Repayment";
                                        InterestCode := LoanBalances."Interest Deduction Code";
                                        LoanBalances.SETRANGE("Deduction Code");
                                        LoanBalances.SETRANGE("Deduction Code", InterestCode);
                                        LoanBalances.CALCFIELDS("Total Repayment");
                                        // MESSAGE('%1 Loan amount=%2',LoanBalances."Total Repayment",LoanBalances."Approved Amount");
                                        BalanceArrs[1, i] := LoanBalances."Approved Amount" + PrincipalAmt;//+LoanBalances."Interest Repayment"
                                                                                                           // MESSAGE(FORMAT(BalanceArray[1,i]));
                                    end
                                    else begin
                                        Deduct.SETRANGE(Deduct."Employee Filter", Employee."No.");
                                        Deduct.SETRANGE(Deduct."Pay Period Filter", 0D, DateSpecified);
                                        Deduct.CALCFIELDS(Deduct."Total Amount");
                                        TotalAmount := ABS(Deduct."Total Amount");
                                        BalanceArrs[1, i] := PayrollRounding(TotalAmount);
                                        // MESSAGE(FORMAT(Balance[1,i]));

                                    end;
                                end;
                            end;
                            i := i + 1;
                        end;




                    until AssignMatrix.NEXT = 0;
                end;
                //i:=i+1;
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
                  ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

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
                  ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

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
                  ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

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
                  ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

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
                  ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

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

             // i:=i+1; BKK*/

                if Totalcoopshares > 0 then begin
                    ArrEarnings[1, i] := 'SPORTS/SOCIAL WELFARE';
                    EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(Totalcoopshares)));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

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
                Ded.RESET;
                Ded.SETRANGE(Ded."Pay Period Filter", DateSpecified);
                Ded.SETRANGE(Ded."Employee Filter", Employee."No.");
                Ded.SETRANGE(Ded."Show on Payslip Information", true);
                if Ded.FIND('-') then
                    repeat
                        Ded.CALCFIELDS(Ded."Total Amount", Ded."Total Amount Employer");
                        ArrEarnings[1, i] := Ded.Description + '(Employer)';
                        if Ded."Total Amount Employer" <> 0 then begin
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(Ded."Total Amount Employer")));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                            i := i + 1;
                        end;


                        /* ArrEarnings[1,i]:=Ded.Description;
                         EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(Ded."Total Amount")));
                         ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                         i:=i+1;*/



                    until Ded.NEXT = 0;




                /*
                  AssignMatrix.RESET;
                   AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETFILTER(Type,'%1',AssignMatrix.Type::Deduction);
                   AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                   AssignMatrix.SETRANGE(AssignMatrix.Retirement,TRUE);
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                   IF AssignMatrix.FIND('-') THEN BEGIN
                   REPEAT
                         ArrEarnings[1,i]:=AssignMatrix.Description;
                         //+'  (Authority)';
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix."Employer Amount")));
                   ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                     i:=i+1;
                    UNTIL AssignMatrix.NEXT=0;
                   END;

                   //i:=i+1;

                   AssignMatrix.RESET;
                  // AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETFILTER(Type,'%1',AssignMatrix.Type::Deduction);
                   AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                   AssignMatrix.SETRANGE(AssignMatrix.Retirement,TRUE);
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                   AssignMatrix.SETRANGE(AssignMatrix.Description,'NSSF');

                   IF AssignMatrix.FIND('-') THEN BEGIN
                    REPEAT
                      Totalnssf:=Totalnssf+ABS(AssignMatrix."Opening Balance")+ABS(AssignMatrix.Amount);
                    UNTIL AssignMatrix.NEXT=0;
                    END;
                  IF  Totalnssf>0 THEN BEGIN
                    ArrEarnings[1,i]:='NSSF (YTD)';
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(Totalnssf));
                   ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                   i:=i+1;
                   Totalnssf:=0;
               END;


                   AssignMatrix.RESET;
                  // AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETFILTER(Type,'%1',AssignMatrix.Type::Deduction);
                   AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                   AssignMatrix.SETRANGE(AssignMatrix.Retirement,TRUE);
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                   IF AssignMatrix.FIND('-') THEN BEGIN
                    REPEAT
                    IF AssignMatrix.Description <> 'NSSF' THEN BEGIN

                      Totalpension:=Totalpension+ABS(AssignMatrix."Opening Balance")+ABS(AssignMatrix.Amount);

                     END;
                    UNTIL AssignMatrix.NEXT=0;
                    END;
                  IF  Totalpension>0 THEN BEGIN
                    ArrEarnings[1,i]:='PENSIONS (YTD)';
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(Totalpension));
                   ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                   i:=i+1;
                   Totalpension:=0;
               END;



                   AssignMatrix.RESET;
                  // AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETFILTER(Type,'%1',AssignMatrix.Type::Deduction);
                   AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                   AssignMatrix.SETRANGE(AssignMatrix.Retirement,TRUE);
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                   IF AssignMatrix.FIND('-') THEN BEGIN
                    REPEAT
                     Totalnssf:=Totalnssf+ABS(AssignMatrix."Opening Balance Company")+ABS(AssignMatrix."Employer Amount");
                    UNTIL AssignMatrix.NEXT=0;
                    END;
                  IF  Totalnssf>0 THEN BEGIN
                    ArrEarnings[1,i]:='NSSF (YTD);
                    // AUTHORITY';
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(Totalnssf));
                   ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                   i:=i+1;
                   Totalnssf:=0;
                  END;

                   //  MESSAGE ('HAPO POA');

                   AssignMatrix.RESET;
                  // AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETFILTER(Type,'%1',AssignMatrix.Type::Deduction);
                   AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                   AssignMatrix.SETRANGE(AssignMatrix.Retirement,TRUE);
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                   IF AssignMatrix.FIND('-') THEN BEGIN
                    REPEAT
                    IF AssignMatrix.Description <> 'PENSION' THEN BEGIN
                     Totalpension:=Totalpension+ABS(AssignMatrix."Opening Balance Company")+ABS(AssignMatrix."Employer Amount");
                       END;
                    UNTIL AssignMatrix.NEXT=0;
                    END;
                  IF  Totalpension>0 THEN BEGIN
                    ArrEarnings[1,i]:='PENSIONS (YTD);
                    // AUTHORITY';
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(Totalpension));
                   ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                   i:=i+1;
                   Totalpension:=0;
                  END;

                   AssignMatrix.RESET;
                  // AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                   AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                   AssignMatrix.SETRANGE(AssignMatrix.Shares,TRUE);
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                   AssignMatrix.SETRANGE(AssignMatrix."Main Deduction Code",'853');

                   IF AssignMatrix.FIND('-') THEN BEGIN
                    REPEAT
                    LoanBal:=LoanBal+ABS(AssignMatrix."Opening Balance")+ABS(AssignMatrix.Amount);
                   // MESSAGE('%1',LoanBal);
                    UNTIL AssignMatrix.NEXT=0;
                    END;
                IF   LoanBal>0 THEN BEGIN
                     ArrEarnings[1,i]:='COOP. SOCIETY SHARES';
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(LoanBal)));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                    LoanBal:=0;
                     i:=i+1;
                 END;

                   AssignMatrix.RESET;
                  // AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                   AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                   AssignMatrix.SETRANGE(AssignMatrix.Shares,TRUE);
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                   AssignMatrix.SETRANGE(AssignMatrix."Main Deduction Code",'866');

                   IF AssignMatrix.FIND('-') THEN BEGIN
                    REPEAT
                    LoanBal:=LoanBal+ABS(AssignMatrix."Opening Balance")+ABS(AssignMatrix.Amount);
                   // MESSAGE('%1',LoanBal);
                    UNTIL AssignMatrix.NEXT=0;
                    END;
                IF   LoanBal>0 THEN BEGIN
                     ArrEarnings[1,i]:='SACCO BBF/SINKING FUND';
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(LoanBal)));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                    LoanBal:=0;
                     i:=i+1;
                 END;



                   AssignMatrix.RESET;
                  // AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                   AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                   AssignMatrix.SETRANGE(AssignMatrix.Shares,TRUE);
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                   AssignMatrix.SETRANGE(AssignMatrix."Main Deduction Code",'854');

                   IF AssignMatrix.FIND('-') THEN BEGIN
                    REPEAT
                    LoanBal:=LoanBal+ABS(AssignMatrix."Opening Balance")+ABS(AssignMatrix.Amount);
                    UNTIL AssignMatrix.NEXT=0;
                    END;
                IF   LoanBal>0 THEN BEGIN
                     ArrEarnings[1,i]:='COOP. SOCIETY INVESTMENTS';
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(LoanBal)));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                    LoanBal:=0;
                     i:=i+1;
                 END;

                   AssignMatrix.RESET;
                  // AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                   AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                   AssignMatrix.SETRANGE(AssignMatrix.Shares,TRUE);
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                   AssignMatrix.SETRANGE(AssignMatrix."Main Deduction Code",'869');

                   IF AssignMatrix.FIND('-') THEN BEGIN
                    REPEAT
                    LoanBal:=LoanBal+ABS(AssignMatrix."Opening Balance")+ABS(AssignMatrix.Amount);
                    UNTIL AssignMatrix.NEXT=0;
                    END;
                IF   LoanBal>0 THEN BEGIN
                     ArrEarnings[1,i]:='COOP. INTEREST';
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(LoanBal)));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                    LoanBal:=0;
                     i:=i+1;
                 END;


                  // i:=i+1;

                  LoanBalances.RESET;
                  LoanBalances.SETRANGE(LoanBalances."Employee No",Employee."No.");
                 // AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                  // AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                  IF LoanBalances.FIND('-') THEN BEGIN
                   REPEAT
                  ArrEarnings[1,i]:=LoanBalances.Description;
                    LoanBal:=LoanBalances."Approved Amount";//+ABS(AssignMatrix.Amount);


                   AssignMatrix.RESET;
                   //AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETFILTER(Type,'%1',AssignMatrix.Type::Loan);
                   AssignMatrix.SETFILTER(AssignMatrix.Description,LoanBalances.Description);

                   AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                   IF AssignMatrix.FIND('-') THEN BEGIN
                    REPEAT
                     TotalRepayment:=TotalRepayment+ABS(AssignMatrix.Amount);
                     //i:=i+1;
                    UNTIL AssignMatrix.NEXT=0;
                     END;
                EVALUATE(ArrEarningsAmt[1,i],FORMAT(LoanBal-TotalRepayment));
                   ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                    // TotalDeduction:=TotalDeduction+ABS(AssignMatrix.Amount);
                     i:=i+1;
                     LoanBal:=0;
                     TotalRepayment:=0;

                  UNTIL LoanBalances.NEXT=0;
                    END;

               */
                // i:=i+1;


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


                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';






                i := i + 1;
                ArrEarnings[1, i] := 'Employee Details';
                // Employee details
                i := i + 1;

                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';
                i := i + 1;

                ArrEarnings[1, i] := 'T.I.N';
                ArrEarningsAmt[1, i] := Employee."P.I.N";

                i := i + 1;
                if EmpBank.GET("Employee's Bank", "Bank Branch") then
                    BankName := EmpBank.Name;

                ArrEarnings[1, i] := 'Employee Bank';
                ArrEarningsAmt[1, i] := BankName;

                i := i + 1;
                ArrEarnings[1, i] := 'Bank Branch';
                ArrEarningsAmt[1, i] := EmpBank."Name 2";

                i := i + 1;
                ArrEarnings[1, i] := 'NSSF No';
                ArrEarningsAmt[1, i] := Employee."Social Security No.";

                i := i + 1;
                ArrEarnings[1, i] := 'AAR No';
                ArrEarningsAmt[1, i] := Employee."N.H.I.F No";

                i := i + 1;
                ArrEarnings[1, i] := 'HELSB No';
                ArrEarningsAmt[1, i] := Employee."HELB No";

                i := i + 1;
                ArrEarnings[1, i] := '*******End of Payslip********';

            end;

            trigger OnPostDataItem();
            begin
                if check7 = 7 then begin
                    //MESSAGE('Generation & Mailing Complete...');
                end;
            end;

            trigger OnPreDataItem();
            begin
                CompRec.GET;
                Message2[1, 1] := CompRec."General Payslip Message";

                CoRec.CALCFIELDS(Picture);
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

    trigger OnInitReport();
    begin
        periodrec.RESET;
        periodrec.SETFILTER(periodrec.Closed, '%1', true);
        if periodrec.FINDLAST then begin
            MonthStartDate := CALCDATE('1M', periodrec."Starting Date");
        end;
    end;

    trigger OnPreReport();
    begin
        if MonthStartDate <> 0D then begin
            Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);

            PayPeriodtext := Employee.GETFILTER("Pay Period Filter");

            EVALUATE(PayrollMonth, FORMAT(PayPeriodtext));
            PayrollMonthText := FORMAT(PayrollMonth, 1, 4);

            CoRec.GET;
            CoName := CoRec.Name;
            EVALUATE(DateSpecified, FORMAT(PayPeriodtext));
        end;
        if MonthStartDate = 0D then begin
            periodrec.RESET;
            periodrec.SETFILTER(periodrec.Sendslip, '%1', true);
            if periodrec.FINDSET then begin
                MonthStartDate := periodrec."Starting Date";
                check7 := 7;
                if periodrec.Closed = true then begin
                    copy99 := 99;
                end;
            end;
            Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);

            PayPeriodtext := Employee.GETFILTER("Pay Period Filter");

            EVALUATE(PayrollMonth, FORMAT(PayPeriodtext));
            PayrollMonthText := FORMAT(PayrollMonth, 1, 4);

            CoRec.GET;
            CoName := CoRec.Name;
            EVALUATE(DateSpecified, FORMAT(PayPeriodtext));
        end;
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
        PayPeriodtext: Text[70];
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
        EmpNo: Code[50];
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
        CoName: Text[70];
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
        PayMode: Text[70];
        Intex: Integer;
        NetPay1: Decimal;
        Principal: Decimal;
        Interest: Decimal;
        Desc: Text[50];
        dedrec: Record Deductions;
        RoundedNetPay: Decimal;
        diff: Decimal;
        CFWD: Decimal;
        Nssfcomptext: Text[70];
        Nssfcomp: Decimal;
        LoanDesc: Text[60];
        LoanDesc1: Text[60];
        Deduct: Record Deductions;
        OriginalLoan: Decimal;
        LoanBalance: Decimal;
        Message1: Text[250];
        Message2: array[3, 1] of Text[250];
        DeptArr: array[3, 1] of Text[60];
        CampArr: array[3, 1] of Text[60];
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
        PayrollMonthText: Text[70];
        PayeeTest: Decimal;
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
        Camp_CaptionLbl: Label 'Campus:';
        AmountCaptionLbl: Label 'Amount';
        Pay_slipCaptionLbl: Label 'Pay slip';
        EmptyStringCaptionLbl: Label '***************************************************';
        CurrReport_PAGENOCaptionLbl: Label 'Copy';
        TaxCharged: Decimal;
        LeaveApplication: Record "Employee Leave Application";
        FiscalStart: Date;
        MaturityDate: Date;
        PositivePAYEManual: Decimal;
        TotalToDate: Decimal;
        LoanTopUps: Record "Loan Top-up";
        AccPeriod: Record "Accounting Period";
        MonthStartDate: Date;
        Age_CaptionLbl: Label 'Age';
        LoanTrans: Record "Loans transactions";
        periodrec: Record "Payroll Period";
        check7: Integer;
        copy99: Integer;
        PrincipalAmt: Decimal;
        InterestCode: Code[10];
        Balance: array[3, 100] of Decimal;
        TotalAmount: Decimal;
        BalanceArr: array[3, 100] of Decimal;
        BalanceArrs: array[3, 100] of Decimal;

    procedure GetTaxBracket(var TaxableAmount: Decimal);
    var
        TaxTable: Record "Bracket Tables";
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
        TaxTable: Record "Bracket Tables";
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

