report 51513270 "Company Payslip"
{
    // version C.3.7

    // ArrEarnings[1,1]
    // ArrEarningsAmt[1,1]
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Company Payslip.rdl';
    Caption = 'Company Payslip';


    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING ("Global Dimension 1 Code") ORDER(Ascending);
            RequestFilterFields = "No.", "Global Dimension 1 Code";

            trigger OnPreDataItem();
            begin
                CompRec.GET;
                Message2[1, 1] := CompRec."General Payslip Message";

                CoRec.CALCFIELDS(Picture);

                //CUser:=USERID;
                //GetGroup.GetUserGroup(CUser,GroupCode);
                SETRANGE(Employee."Posting Group", GroupCode.Code);
            end;
        }
        dataitem("Integer"; "Integer")
        {
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
            column(CoName; CoName)
            {
            }
            column(DateMHCA; DateMHCALbl)
            {
            }
            column(DateDCS; DateDCSLbl)
            {
            }
            column(Designation_________________________________________________________________________________________Caption; Designation_________________________________________________________________________________________CaptionLbl)
            {
            }
            column(DateMF; DateMFLbl)
            {
            }
            column(SignatureMHCA; SignatureMHCALbl)
            {
            }
            column(SignatureMF; SignatureMFLbl)
            {
            }
            column(SignatureDCS; SignatureDCSLbl)
            {
            }
            /*column(DataItem1000000328; Designation_________________________________________________________________________________________Caption_Control1000000069Lbl)
            {
            }
            column(DataItem1000000329; Designation_________________________________________________________________________________________Caption_Control1000000070Lbl)
            {
            }*/
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
            column(USERID; USERID)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(EarningsCaption; EarningsCaptionLbl)
            {
            }
            column(AmountCaption; AmountCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
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
            column(ArrEarnings_1_61_; ArrEarnings[1, 61])
            {
            }
            column(ArrEarnings_1_62_; ArrEarnings[1, 62])
            {
            }
            column(ArrEarnings_1_63_; ArrEarnings[1, 63])
            {
            }
            column(ArrEarnings_1_73_; ArrEarnings[1, 73])
            {
            }
            column(ArrEarnings_1_64_; ArrEarnings[1, 64])
            {
            }
            column(ArrEarnings_1_65_; ArrEarnings[1, 65])
            {
            }
            column(ArrEarnings_1_66_; ArrEarnings[1, 66])
            {
            }
            column(ArrEarnings_1_67_; ArrEarnings[1, 67])
            {
            }
            column(ArrEarnings_1_68_; ArrEarnings[1, 68])
            {
            }
            column(ArrEarnings_1_69_; ArrEarnings[1, 69])
            {
            }
            column(ArrEarnings_1_70_; ArrEarnings[1, 70])
            {
            }
            column(ArrEarnings_1_71_; ArrEarnings[1, 71])
            {
            }
            column(ArrEarnings_1_72_; ArrEarnings[1, 72])
            {
            }
            column(ArrEarnings_1_74_; ArrEarnings[1, 74])
            {
            }
            column(ArrEarnings_1_75_; ArrEarnings[1, 75])
            {
            }
            column(ArrEarnings_1_76_; ArrEarnings[1, 76])
            {
            }
            column(ArrEarnings_1_77_; ArrEarnings[1, 77])
            {
            }
            column(ArrEarnings_1_78_; ArrEarnings[1, 78])
            {
            }
            column(ArrEarnings_1_79_; ArrEarnings[1, 79])
            {
            }
            column(ArrEarnings_1_80_; ArrEarnings[1, 80])
            {
            }
            column(ArrEarnings_1_81_; ArrEarnings[1, 81])
            {
            }
            column(ArrEarnings_1_82_; ArrEarnings[1, 82])
            {
            }
            column(ArrEarnings_1_83_; ArrEarnings[1, 83])
            {
            }
            column(ArrEarnings_1_84_; ArrEarnings[1, 84])
            {
            }
            column(ArrEarnings_1_85_; ArrEarnings[1, 85])
            {
            }
            column(ArrEarnings_1_86_; ArrEarnings[1, 86])
            {
            }
            column(ArrEarnings_1_87_; ArrEarnings[1, 87])
            {
            }
            column(ArrEarnings_1_88_; ArrEarnings[1, 88])
            {
            }
            column(ArrEarnings_1_89_; ArrEarnings[1, 89])
            {
            }
            column(ArrEarnings_1_90_; ArrEarnings[1, 90])
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
            column(ArrEarningsAmt_1_61_; ArrEarningsAmt[1, 61])
            {
            }
            column(ArrEarningsAmt_1_62_; ArrEarningsAmt[1, 62])
            {
            }
            column(ArrEarningsAmt_1_63_; ArrEarningsAmt[1, 63])
            {
            }
            column(ArrEarningsAmt_1_64_; ArrEarningsAmt[1, 64])
            {
            }
            column(ArrEarningsAmt_1_65_; ArrEarningsAmt[1, 65])
            {
            }
            column(ArrEarningsAmt_1_66_; ArrEarningsAmt[1, 66])
            {
            }
            column(ArrEarningsAmt_1_67_; ArrEarningsAmt[1, 67])
            {
            }
            column(ArrEarningsAmt_1_68_; ArrEarningsAmt[1, 68])
            {
            }
            column(ArrEarningsAmt_1_69_; ArrEarningsAmt[1, 69])
            {
            }
            column(ArrEarningsAmt_1_70_; ArrEarningsAmt[1, 70])
            {
            }
            column(ArrEarningsAmt_1_71_; ArrEarningsAmt[1, 71])
            {
            }
            column(ArrEarningsAmt_1_72_; ArrEarningsAmt[1, 72])
            {
            }
            column(ArrEarningsAmt_1_73_; ArrEarningsAmt[1, 73])
            {
            }
            column(ArrEarningsAmt_1_74_; ArrEarningsAmt[1, 74])
            {
            }
            column(ArrEarningsAmt_1_75_; ArrEarningsAmt[1, 75])
            {
            }
            column(ArrEarningsAmt_1_76_; ArrEarningsAmt[1, 76])
            {
            }
            column(ArrEarningsAmt_1_77_; ArrEarningsAmt[1, 77])
            {
            }
            column(ArrEarningsAmt_1_78_; ArrEarningsAmt[1, 78])
            {
            }
            column(ArrEarningsAmt_1_79_; ArrEarningsAmt[1, 79])
            {
            }
            column(ArrEarningsAmt_1_80_; ArrEarningsAmt[1, 80])
            {
            }
            column(ArrEarningsAmt_1_81_; ArrEarningsAmt[1, 81])
            {
            }
            column(ArrEarningsAmt_1_82_; ArrEarningsAmt[1, 82])
            {
            }
            column(ArrEarningsAmt_1_83_; ArrEarningsAmt[1, 83])
            {
            }
            column(ArrEarningsAmt_1_84_; ArrEarningsAmt[1, 84])
            {
            }
            column(ArrEarningsAmt_1_85_; ArrEarningsAmt[1, 85])
            {
            }
            column(ArrEarningsAmt_1_86_; ArrEarningsAmt[1, 86])
            {
            }
            column(ArrEarningsAmt_1_87_; ArrEarningsAmt[1, 87])
            {
            }
            column(ArrEarningsAmt_1_88_; ArrEarningsAmt[1, 88])
            {
            }
            column(ArrEarningsAmt_1_89_; ArrEarningsAmt[1, 89])
            {
            }
            column(ArrEarningsAmt_1_90_; ArrEarningsAmt[1, 90])
            {
            }
            column(BalanceArray_1_49_; BalanceArray[1, 49])
            {
            }
            column(BalanceArray_1_50_; BalanceArray[1, 50])
            {
            }
            column(BalanceArray_1_51_; BalanceArray[1, 51])
            {
            }
            column(BalanceArray_1_52_; BalanceArray[1, 52])
            {
            }
            column(BalanceArray_1_53_; BalanceArray[1, 53])
            {
            }
            column(BalanceArray_1_54_; BalanceArray[1, 54])
            {
            }
            column(BalanceArray_1_55_; BalanceArray[1, 55])
            {
            }
            column(BalanceArray_1_56_; BalanceArray[1, 56])
            {
            }
            column(BalanceArray_1_57_; BalanceArray[1, 57])
            {
            }
            column(BalanceArray_1_58_; BalanceArray[1, 58])
            {
            }
            column(BalanceArray_1_59_; BalanceArray[1, 59])
            {
            }
            column(BalanceArray_1_60_; BalanceArray[1, 60])
            {
            }
            column(BalanceArray_1_61_; BalanceArray[1, 61])
            {
            }
            column(BalanceArray_1_62_; BalanceArray[1, 62])
            {
            }
            column(BalanceArray_1_63_; BalanceArray[1, 63])
            {
            }
            column(BalanceArray_1_64_; BalanceArray[1, 64])
            {
            }
            column(BalanceArray_1_65_; BalanceArray[1, 65])
            {
            }
            column(BalanceArray_1_66_; BalanceArray[1, 66])
            {
            }
            column(BalanceArray_1_67_; BalanceArray[1, 67])
            {
            }
            column(BalanceArray_1_68_; BalanceArray[1, 68])
            {
            }
            column(BalanceArray_1_69_; BalanceArray[1, 69])
            {
            }
            column(BalanceArray_1_70_; BalanceArray[1, 70])
            {
            }
            column(BalanceArray_1_71_; BalanceArray[1, 71])
            {
            }
            column(BalanceArray_1_73_; BalanceArray[1, 72])
            {
            }
            column(BalanceArray_1_74_; BalanceArray[1, 74])
            {
            }
            column(BalanceArray_1_75_; BalanceArray[1, 75])
            {
            }
            column(BalanceArray_1_76_; BalanceArray[1, 76])
            {
            }
            column(BalanceArray_1_77_; BalanceArray[1, 77])
            {
            }
            column(BalanceArray_1_78_; BalanceArray[1, 78])
            {
            }
            column(BalanceArray_1_79_; BalanceArray[1, 79])
            {
            }
            column(BalanceArray_1_80_; BalanceArray[1, 80])
            {
            }
            column(CodeArr_1_1; CodeArr[1, 1])
            {
            }
            column(CodeArr_1_2; CodeArr[1, 2])
            {
            }
            column(CodeArr_1_3; CodeArr[1, 3])
            {
            }
            column(CodeArr_1_4; CodeArr[1, 4])
            {
            }
            column(CodeArr_1_5; CodeArr[1, 5])
            {
            }
            column(CodeArr_1_6; CodeArr[1, 6])
            {
            }
            column(CodeArr_1_7; CodeArr[1, 7])
            {
            }
            column(CodeArr_1_8; CodeArr[1, 8])
            {
            }
            column(CodeArr_1_9; CodeArr[1, 9])
            {
            }
            column(CodeArr_1_10; CodeArr[1, 10])
            {
            }
            column(CodeArr_1_11; CodeArr[1, 11])
            {
            }
            column(CodeArr_1_12; CodeArr[1, 12])
            {
            }
            column(CodeArr_1_13; CodeArr[1, 13])
            {
            }
            column(CodeArr_1_14; CodeArr[1, 14])
            {
            }
            column(CodeArr_1_15; CodeArr[1, 15])
            {
            }
            column(CodeArr_1_16; CodeArr[1, 16])
            {
            }
            column(CodeArr_1_17; CodeArr[1, 17])
            {
            }
            column(CodeArr_1_18; CodeArr[1, 18])
            {
            }
            column(CodeArr_1_19; CodeArr[1, 19])
            {
            }
            column(CodeArr_1_20; CodeArr[1, 20])
            {
            }
            column(CodeArr_1_21; CodeArr[1, 21])
            {
            }
            column(CodeArr_1_22; CodeArr[1, 22])
            {
            }
            column(CodeArr_1_23; CodeArr[1, 23])
            {
            }
            column(CodeArr_1_24; CodeArr[1, 24])
            {
            }
            column(CodeArr_1_25; CodeArr[1, 25])
            {
            }
            column(CodeArr_1_26; CodeArr[1, 26])
            {
            }
            column(CodeArr_1_27; CodeArr[1, 27])
            {
            }
            column(CodeArr_1_28; CodeArr[1, 28])
            {
            }
            column(CodeArr_1_29; CodeArr[1, 29])
            {
            }
            column(CodeArr_1_30; CodeArr[1, 30])
            {
            }
            column(CodeArr_1_31; CodeArr[1, 31])
            {
            }
            column(CodeArr_1_32; CodeArr[1, 32])
            {
            }
            column(CodeArr_1_33; CodeArr[1, 33])
            {
            }
            column(CodeArr_1_34; CodeArr[1, 34])
            {
            }
            column(CodeArr_1_35; CodeArr[1, 35])
            {
            }
            column(CodeArr_1_36; CodeArr[1, 36])
            {
            }
            column(CodeArr_1_37; CodeArr[1, 37])
            {
            }
            column(CodeArr_1_38; CodeArr[1, 38])
            {
            }
            column(CodeArr_1_39; CodeArr[1, 39])
            {
            }
            column(CodeArr_1_40; CodeArr[1, 40])
            {
            }
            column(CodeArr_1_41; CodeArr[1, 41])
            {
            }
            column(CodeArr_1_42; CodeArr[1, 42])
            {
            }
            column(CodeArr_1_43; CodeArr[1, 43])
            {
            }
            column(CodeArr_1_44; CodeArr[1, 44])
            {
            }
            column(CodeArr_1_45; CodeArr[1, 45])
            {
            }
            column(CodeArr_1_46; CodeArr[1, 46])
            {
            }
            column(CodeArr_1_47; CodeArr[1, 47])
            {
            }
            column(CodeArr_1_48; CodeArr[1, 48])
            {
            }
            column(CodeArr_1_49; CodeArr[1, 49])
            {
            }
            column(CodeArr_1_50; CodeArr[1, 50])
            {
            }
            column(CodeArr_1_51; CodeArr[1, 51])
            {
            }
            column(CodeArr_1_52; CodeArr[1, 52])
            {
            }
            column(CodeArr_1_53; CodeArr[1, 53])
            {
            }
            column(CodeArr_1_54; CodeArr[1, 54])
            {
            }
            column(CodeArr_1_55; CodeArr[1, 55])
            {
            }
            column(CodeArr_1_56; CodeArr[1, 56])
            {
            }
            column(CodeArr_1_57; CodeArr[1, 57])
            {
            }
            column(CodeArr_1_58; CodeArr[1, 58])
            {
            }
            column(CodeArr_1_59; CodeArr[1, 59])
            {
            }
            column(CodeArr_1_60; CodeArr[1, 60])
            {
            }
            column(CodeArr_1_61; CodeArr[1, 61])
            {
            }
            column(CodeArr_1_62; CodeArr[1, 62])
            {
            }
            column(CodeArr_1_63; CodeArr[1, 63])
            {
            }
            column(CodeArr_1_64; CodeArr[1, 64])
            {
            }
            column(CodeArr_1_65; CodeArr[1, 65])
            {
            }
            column(CodeArr_1_66; CodeArr[1, 66])
            {
            }
            column(CodeArr_1_67; CodeArr[1, 67])
            {
            }
            column(CodeArr_1_68; CodeArr[1, 68])
            {
            }
            column(CodeArr_1_69; CodeArr[1, 69])
            {
            }
            column(CodeArr_1_70; CodeArr[1, 70])
            {
            }

            trigger OnAfterGetRecord();
            var
                loanType: Record "Loan Product Type";
                RepSchedule: Record "Repayment Schedule";
            begin

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
                LoanBalance := 0;
                NetPay := 0;
                /*
                Addr[1][1]:=Employee."No.";
                Addr[1][2]:=Employee."First Name"+' '+Employee."Last Name";

                // get Department Name
                DimVal.RESET;
                DimVal.SETRANGE(DimVal.Code,Employee."Global Dimension 1 Code");
                DimVal.SETRANGE("Global Dimension No.",1);
                IF DimVal.FIND('-') THEN
                DeptArr[1,1]:=DimVal.Name;
                */
                // Get Basic Salary
                Earn.RESET;
                Earn.SETRANGE(Earn."Basic Salary Code", true);
                if Earn.FIND('-') then begin
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                    AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                    AssignMatrix.SETRANGE(AssignMatrix.Code, Earn.Code);
                    //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
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
                Earn.SETRANGE(Earn.Board, false);
                if Earn.FIND('-') then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                        //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                        // AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",FALSE);
                        AssignMatrix.SETRANGE(Code, Earn.Code);
                        if AssignMatrix.FIND('-') then begin
                            //REPEAT
                            AssignMatrix.CALCSUMS(Amount);
                            if AssignMatrix.Amount > 0 then begin
                                ArrEarnings[1, i] := AssignMatrix.Description;
                                CodeArr[1, i] := AssignMatrix.Code;
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(PayrollRounding(AssignMatrix.Amount)));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                GrossPay := GrossPay + PayrollRounding(AssignMatrix.Amount);
                                i := i + 1;
                            end;
                            //UNTIL AssignMatrix.NEXT=0;
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
                /*   // Non Cash Benefits
                  Earn.RESET;
                  Earn.SETRANGE(Earn."Earning Type",Earn."Earning Type"::"Normal Earning");
                  Earn.SETRANGE(Earn."Non-Cash Benefit",TRUE);
                  Earn.SETFILTER(Earn."Calculation Method",'<>%1',Earn."Calculation Method"::"% of Salary Recovery");
                  Earn.SETRANGE(Earn.Fringe,FALSE);
                   IF Earn.FIND('-') THEN BEGIN
                    REPEAT
                     AssignMatrix.RESET;
                    // AssignMatrix.SETFILTER(AssignMatrix."Payroll Period",'>=%1',050113D);
                     AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                     AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                    // AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                     AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",FALSE);
                     AssignMatrix.SETRANGE(Code,Earn.Code);
                     IF AssignMatrix.FIND('-') THEN BEGIN
                      //REPEAT
                      AssignMatrix.CALCSUMS(Amount);
                       ArrEarnings[1,i]:=AssignMatrix.Description;
                       CodeArr[1,i]:=AssignMatrix.Code;
                       EVALUATE(ArrEarningsAmt[1,i],FORMAT(PayrollRounding(AssignMatrix.Amount)));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                       i:=i+1;
                      //UNTIL AssignMatrix.NEXT=0;
                     END;
                    UNTIL Earn.NEXT=0;
                   END;


                 {
                  Earn.RESET;
                  Earn.SETRANGE(Earn."Earning Type",Earn."Earning Type"::"Normal Earning");
                  Earn.SETRANGE(Earn."Non-Cash Benefit",TRUE);
                  Earn.SETFILTER(Earn."Calculation Method",'<>%1',Earn."Calculation Method"::"% of Salary Recovery");
                  Earn.SETRANGE(Earn.Fringe,TRUE);
                   IF Earn.FIND('-') THEN BEGIN
                    REPEAT
                     AssignMatrix.RESET;
                     AssignMatrix.SETFILTER(AssignMatrix."Payroll Period",'<%1',010513D);
                     AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                     AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                     //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                     AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",FALSE);
                     AssignMatrix.SETRANGE(Code,Earn.Code);
                     IF AssignMatrix.FIND('-') THEN BEGIN
                      //REPEAT
                      AssignMatrix.CALCSUMS(Amount);
                       ArrEarnings[1,i]:=AssignMatrix.Description;
                       EVALUATE(ArrEarningsAmt[1,i],FORMAT(PayrollRounding(AssignMatrix.Amount)));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                       i:=i+1;
                      //UNTIL AssignMatrix.NEXT=0;
                     END;
                    UNTIL Earn.NEXT=0;
                   END;
               }

                   // end of non cash
                   AssignMatrix.RESET;
                   AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Deduction);
                   //AssignMatrix.SETRANGE(AssignMatrix.Code,'D01');
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,TRUE);
                   IF AssignMatrix.FIND('-') THEN BEGIN
                      AssignMatrix.CALCSUMS(Amount,"Less Pension Contribution","Taxable amount");
                     ArrEarnings[1,i]:='Less Pension contribution benefit';
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(AssignMatrix."Less Pension Contribution"))));
                     CodeArr[1,i]:=AssignMatrix.Code;
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);
                     PAYE:=0;
                     TaxableAmt:=0;
                     PAYE:=AssignMatrix.Amount;
                   TaxableAmt:=AssignMatrix."Taxable amount";
                  END;


                   {AssignMatrix.RESET;
                   AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Deduction);
                   //AssignMatrix.SETRANGE(AssignMatrix.Code,'898');
                   AssignMatrix.SETRANGE(AssignMatrix.Paye,TRUE);
                   IF AssignMatrix.FIND('-') THEN BEGIN
                      AssignMatrix.CALCSUMS(Amount,"Less Pension Contribution","Taxable amount");

                    TaxableAmt:=TaxableAmt+AssignMatrix."Taxable amount";

                    PAYE2:=0;
                   PAYE2:=AssignMatrix.Amount;

                  END;}

                   i:=i+1;
                   Earn.RESET;
                   Earn.SETRANGE(Earn."Earning Type",Earn."Earning Type"::"Owner Occupier");
                   IF Earn.FIND('-') THEN BEGIN
                    REPEAT
                     AssignMatrix.RESET;
                     AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                     AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                     //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                     AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",FALSE);
                     AssignMatrix.SETRANGE(Code,Earn.Code);
                     IF AssignMatrix.FIND('-') THEN BEGIN
                      //REPEAT
                        AssignMatrix.CALCSUMS(Amount);
                        CodeArr[1,i]:=AssignMatrix.Code;
                       ArrEarnings[1,i]:=AssignMatrix.Description;
                       EVALUATE(ArrEarningsAmt[1,i],FORMAT(PayrollRounding(AssignMatrix.Amount)));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                      i:=i+1;
                    //UNTIL AssignMatrix.NEXT=0;
                    END;
                  UNTIL Earn.NEXT=0;
                 END;

                 // Taxable amount
                     ArrEarnings[1,i]:='Taxable Amount';
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(TaxableAmt))));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                   i:=i+1;
               // Tax Charged + Relief
                 TaxCharged:=0;

                   Earn.RESET;
                   Earn.SETFILTER(Earn."Earning Type",'%1|%2',Earn."Earning Type"::"Tax Relief",
                   Earn."Earning Type"::"Insurance Relief");
                   IF Earn.FIND('-') THEN BEGIN
                    REPEAT
                     AssignMatrix.RESET;
                     AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                     AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                     AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                     //AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",FALSE);
                     AssignMatrix.SETRANGE(Code,Earn.Code);
                     IF AssignMatrix.FIND('-') THEN BEGIN
                      //REPEAT
                      AssignMatrix.CALCSUMS(Amount);
                     TaxCharged:=TaxCharged+ABS(PayrollRounding(AssignMatrix.Amount));

                    //  i:=i+1;
                    //UNTIL AssignMatrix.NEXT=0;
                    END;
                  UNTIL Earn.NEXT=0;
                 END;
                 //Add Paye
                   TaxCharged:=TaxCharged+ABS(PayrollRounding(PAYE));

                  //Add Paye2
                   TaxCharged:=TaxCharged+ABS(PayrollRounding(PAYE2));

                     ArrEarnings[1,i]:='Tax Charged';
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(TaxCharged));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);


                   i:=i+1;

               // Relief
                   Earn.RESET;
                   Earn.SETFILTER(Earn."Earning Type",'%1|%2',Earn."Earning Type"::"Tax Relief",
                   Earn."Earning Type"::"Insurance Relief");
                   IF Earn.FIND('-') THEN BEGIN
                    REPEAT
                     AssignMatrix.RESET;
                     AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                     AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                     //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                     AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",FALSE);
                     AssignMatrix.SETRANGE(Code,Earn.Code);
                     IF AssignMatrix.FIND('-') THEN BEGIN
                      //REPEAT
                      AssignMatrix.CALCSUMS(Amount);
                      CodeArr[1,i]:=AssignMatrix.Code;
                       ArrEarnings[1,i]:=AssignMatrix.Description;
                       EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(AssignMatrix.Amount))));
                     ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                      i:=i+1;
                    //UNTIL AssignMatrix.NEXT=0;
                    END;
                  UNTIL Earn.NEXT=0;
                 END;
                  */
                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';


                i := i + 1;

                // Deductions
                ArrEarnings[1, i] := 'Deductions';

                i := i + 1;

                ArrEarnings[1, i] := '************************************************';
                ArrEarningsAmt[1, i] := '***********************************************';

                i := i + 1;
                //PAYE
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SETRANGE(AssignMatrix.Paye, true);
                // AssignMatrix.SETRANGE(AssignMatrix.Code,'895');
                if AssignMatrix.FIND('-') then begin
                    AssignMatrix.CALCSUMS(Amount);
                    if AssignMatrix.Amount > 0 then begin
                        CodeArr[1, i] := AssignMatrix.Code;
                        ArrEarnings[1, i] := AssignMatrix.Description;
                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(AssignMatrix.Amount))));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                        TotalDeduction := TotalDeduction + ABS(AssignMatrix.Amount);

                        i := i + 1;
                    end;

                end;

                //PAYE2
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Deduction);
                AssignMatrix.SETRANGE(AssignMatrix.Paye, true);
                //AssignMatrix.SETRANGE(AssignMatrix.Code, '898');
                if AssignMatrix.FIND('-') then begin
                    AssignMatrix.CALCSUMS(Amount);

                    CodeArr[1, i] := AssignMatrix.Code;
                    ArrEarnings[1, i] := AssignMatrix.Description;
                    EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(AssignMatrix.Amount))));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                    TotalDeduction := TotalDeduction + ABS(AssignMatrix.Amount);
                    i := i + 1;
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
                        //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        // AssignMatrix.SETRANGE(AssignMatrix.Shares,FALSE);
                        // AssignMatrix.SETRANGE(AssignMatrix."Insurance Code",FALSE);

                        if AssignMatrix.FIND('-') then begin
                            //  REPEAT
                            AssignMatrix.CALCSUMS(Amount);
                            if (ABS(AssignMatrix.Amount) > 0) then begin
                                CodeArr[1, i] := AssignMatrix.Code;
                                ArrEarnings[1, i] := AssignMatrix.Description;

                                //  MESSAGE('negative paye manual=%1',AssignMatrix.Amount);

                                PositivePAYEManual := 0;

                                Earn.RESET;
                                Earn.SETRANGE(Earn."Calculation Method", Earn."Calculation Method"::"% of Salary Recovery");
                                if Earn.FIND('-') then begin
                                    // REPEAT
                                    PayDeduct.RESET;
                                    PayDeduct.SETRANGE(PayDeduct."Payroll Period", DateSpecified);
                                    PayDeduct.SETFILTER(Type, '%1', PayDeduct.Type::Payment);
                                    PayDeduct.SETRANGE(Code, Earn.Code);
                                    PayDeduct.SETRANGE(PayDeduct."Manual Entry", true);
                                    // AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                                    if PayDeduct.FIND('-') then begin
                                        repeat
                                            PositivePAYEManual := PositivePAYEManual + PayDeduct.Amount;

                                        until PayDeduct.NEXT = 0;
                                    end;
                                end;
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(PayrollRounding(AssignMatrix.Amount) - PayrollRounding(PositivePAYEManual)));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                CodeArr[1, i] := AssignMatrix.Code;
                                TotalDeduction := TotalDeduction + PayrollRounding(AssignMatrix.Amount) - PayrollRounding(PositivePAYEManual);
                                // END;
                                i := i + 1;
                            end;
                            //  i:=i+1;
                            //  UNTIL AssignMatrix.NEXT=0;
                        end;
                    until Deduct.NEXT = 0;
                end;

                Deduct.RESET;
                Deduct.SETFILTER(Deduct."Calculation Method", '<>%1', Deduct."Calculation Method"::"% of Salary Recovery");
                Deduct.SETRANGE(Informational, false);
                if Deduct.FIND('-') then begin
                    repeat

                        LoanBalance := 0;

                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        // AssignMatrix.SETRANGE(AssignMatrix.Shares,FALSE);
                        // AssignMatrix.SETRANGE(AssignMatrix."Insurance Code",FALSE);

                        if AssignMatrix.FIND('-') then begin
                            //  REPEAT
                            AssignMatrix.CALCSUMS(Amount);
                            if (ABS(AssignMatrix.Amount) > 0) then begin
                                CodeArr[1, i] := AssignMatrix.Code;
                                ArrEarnings[1, i] := AssignMatrix.Description;//Deduct.Description+' Repayment'

                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(AssignMatrix.Amount))));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                                TotalDeduction := TotalDeduction + ABS(PayrollRounding(AssignMatrix.Amount));
                                // END;
                                /*
                                   //START
                                   IF Deduct.GET(AssignMatrix.Code) THEN
                                   BEGIN
                                     //     {
                                    IF Deduct."Show Balance" THEN
                                    BEGIN

                                    LoanBalances.RESET;
                                  //  LoanBalances.SETRANGE(LoanBalances."Loan No",AssignMatrix."Reference No");
                                    LoanBalances.SETRANGE(LoanBalances."Deduction Code",AssignMatrix.Code);
                                   IF LoanBalances.FIND('-') THEN
                                   BEGIN
                                   REPEAT
                                   LoanBalances.SETRANGE(LoanBalances."Date filter",0D,DateSpecified);
                                   LoanBalances.CALCFIELDS(LoanBalances."Total Repayment",LoanBalances."Total Loan");
                                   // MESSAGE('%1 Loan amount=%2',LoanBalances."Total Repayment",LoanBalances."Approved Amount");
                                  IF LoanBalances."Total Loan"<>0 THEN

                                   LoanBalance:=LoanBalance+(LoanBalances."Total Loan"+LoanBalances."Total Repayment")

                                  ELSE

                                   LoanBalance:=LoanBalance+(LoanBalances."Approved Amount"+LoanBalances."Total Repayment");
                                 //  MESSAGE('%1=%2',ArrEarnings[1,i],BalanceArray[1,i]);
                                   UNTIL LoanBalances.NEXT=0;
                                   END
                                   ELSE
                                   BEGIN
                                   // Deduct.SETRANGE(Deduct."Employee Filter",Employee."No.");
                                    Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                                    Deduct.CALCFIELDS(Deduct."Total Amount");
                                    LoanBalance:=Deduct."Total Amount";
                                    //MESSAGE('Balance=%1',Deduct."Total Amount");
                                    END;
                                   END;
                                 BalanceArray[1,i]:=LoanBalance;
                                   END;


                              //EMD
                               //}//
                                 */

                                i := i + 1;
                            end;

                            //  i:=i+1;
                            //  UNTIL AssignMatrix.NEXT=0;
                        end;
                    until Deduct.NEXT = 0;
                end;





                ArrEarnings[1, i] := 'TOTAL DEDUCTIONS';
                EVALUATE(ArrEarningsAmt[1, i], FORMAT(TotalDeduction));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                i := i + 1;

                ArrEarnings[1, i] := '**************************************';
                ArrEarningsAmt[1, i] := '*****************';

                i := i + 1;
                // Net Pay
                ArrEarnings[1, i] := 'NET PAY';
                NetPay := GrossPay - TotalDeduction;
                EVALUATE(ArrEarningsAmt[1, i], FORMAT(NetPay));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                i := i + 1;

                ArrEarnings[1, i] := '**************************************';
                ArrEarningsAmt[1, i] := '*****************';

                i := i + 1;
                //Information
                ArrEarnings[1, i] := 'Information';

                i := i + 1;

                ArrEarnings[1, i] := '**************************************';
                ArrEarningsAmt[1, i] := '*****************';

                i := i + 1;

                //Car Loan Interest;
                Deduct.RESET;
                Deduct.SETRANGE(Informational, true);
                if Deduct.FIND('-') then begin
                    repeat
                        CodeArr[1, i] := Deduct.Code;
                        ArrEarnings[1, i] := Deduct.Description;
                        TotalToDate := 0;
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        // AssignMatrix.SETFILTER(Type,'=%1',AssignMatrix.Type::Informational);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        AssignMatrix.CALCSUMS(Amount, "Employer Amount", "Opening Balance");
                        TotalToDate := AssignMatrix.Amount + AssignMatrix."Employer Amount" + AssignMatrix."Opening Balance";
                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                        i := i + 1;

                    until Deduct.NEXT = 0;
                end;
                /*Deduct.RESET;
                Deduct.SETRANGE(Loan,TRUE);
                IF Deduct.FIND('-') THEN BEGIN
                REPEAT
                    ArrEarnings[1,i]:=Deduct.Description+ 'Principal Rep';
                
                */
                TotalToDate := 0;
                loanType.RESET;
                //loanType.SETRANGE("Deduction Code",Deduct.Code);
                loanType.SETRANGE("Interest Calculation Method", loanType."Interest Calculation Method"::"Reducing Balance");
                if loanType.FIND('-') then begin
                    repeat
                        CodeArr[1, i] := '609';
                        ArrEarnings[1, i] := loanType.Description + ' Principal Repayment';
                        RepSchedule.RESET;
                        RepSchedule.SETCURRENTKEY("Loan No", "Repayment Date");
                        RepSchedule.SETRANGE("Loan Category", loanType.Code);
                        RepSchedule.SETRANGE(RepSchedule."Repayment Date", DateSpecified);
                        RepSchedule.CALCSUMS("Principal Repayment");
                        TotalToDate := RepSchedule."Principal Repayment";
                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                        i := i + 1;


                    until loanType.NEXT = 0;
                end;
                /*
                UNTIL Deduct.NEXT=0;
                END;
                */


                //Soko Savings Balance to Date
                TotalToDate := 0;
                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                // Deduct.SETRANGE(Deduct."Date Filter",0D,DateSpecified);
                // Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"% of Basic Pay");
                Deduct.SETRANGE(Deduct.Shares, true);
                if Deduct.FIND('-') then begin
                    repeat
                        // MESSAGE('PENSION DEDUCTION CODE=%1',Deduct.Code);
                        // MESSAGE('Pension PERIOD=%1',Deduct."Pay Period Filter");
                        //   LoanBalance:=0;
                        //Balances
                        Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");
                        // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                        ArrEarnings[1, i] := Deduct.Description + ' Bal. to Date';
                        // TotalToDate:=TotalToDate+Deduct."Total Amount";//+AssignMatrix."Opening Balance Company";

                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", 0D, DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        AssignMatrix.CALCSUMS(Amount, "Employer Amount", "Opening Balance");
                        TotalToDate := AssignMatrix.Amount + AssignMatrix."Employer Amount" + AssignMatrix."Opening Balance";

                        TotalDeposits := 0;
                        /*SavingsRec.RESET;
                        SavingsRec.SETCURRENTKEY(Code, "Payroll Period", Type);
                        SavingsRec.SETRANGE(SavingsRec.Code, Deduct.Code);
                        SavingsRec.SETRANGE(SavingsRec."Payroll Period", 0D, DateSpecified);
                        SavingsRec.SETRANGE(SavingsRec.Type, SavingsRec.Type::Deposit);
                        SavingsRec.CALCSUMS(Amount);
                        TotalDeposits := SavingsRec.Amount;

                        TotalWithdrawals := 0;
                        SavingsRec.RESET;
                        SavingsRec.SETCURRENTKEY(Code, "Payroll Period", Type);
                        SavingsRec.SETRANGE(SavingsRec.Code, Deduct.Code);
                        SavingsRec.SETRANGE(SavingsRec."Payroll Period", 0D, DateSpecified);
                        SavingsRec.SETRANGE(SavingsRec.Type, SavingsRec.Type::Withdrawal);
                        SavingsRec.CALCSUMS(Amount);
                        TotalWithdrawals := SavingsRec.Amount;*/
                        //MESSAGE('%4\TotalDeposits=%1\TotalWithdrawals=%2\TotalToDate=%3',TotalDeposits,TotalWithdrawals,TotalToDate,DateSpecified);

                        TotalToDate := TotalToDate - TotalDeposits;
                        TotalToDate := TotalToDate + TotalWithdrawals;
                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                        //  EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding((AssignMatrix."Employer Amount")+(AssignMatrix."Opening Balance Company")))));
                        // ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                        i := i + 1;
                        // UNTIL AssignMatrix.NEXT=0;

                    until Deduct.NEXT = 0;
                end;


                // Fringe Benefits
                Earn.RESET;
                Earn.SETRANGE(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SETRANGE(Earn."Non-Cash Benefit", true);
                Earn.SETRANGE(Earn.Fringe, true);
                if Earn.FIND('-') then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETFILTER(AssignMatrix."Payroll Period", '>=%1', 20130105D);
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                        // AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code", false);
                        AssignMatrix.SETRANGE(Code, Earn.Code);
                        if AssignMatrix.FIND('-') then begin
                            //REPEAT
                            AssignMatrix.CALCSUMS(Amount);
                            ArrEarnings[1, i] := AssignMatrix.Description;
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(PayrollRounding(AssignMatrix.Amount)));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                            i := i + 1;
                            //UNTIL AssignMatrix.NEXT=0;
                        end;
                    until Earn.NEXT = 0;
                end;

                // Fringe Benefits Taxations

                TotalFringe := 0;

                Earn.RESET;
                Earn.SETRANGE(Earn."Earning Type", Earn."Earning Type"::"Normal Earning");
                Earn.SETRANGE(Earn."Non-Cash Benefit", true);
                Earn.SETRANGE(Earn.Fringe, true);
                Earn.SETFILTER(Earn."Market Rate", '>%1', 0);
                if Earn.FIND('-') then begin
                    repeat
                        AssignMatrix.RESET;
                        AssignMatrix.SETFILTER(AssignMatrix."Payroll Period", '>=%1', 20130501D);
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETRANGE(Type, AssignMatrix.Type::Payment);
                        //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code", false);
                        AssignMatrix.SETRANGE(Code, Earn.Code);
                        if AssignMatrix.FIND('-') then begin
                            //REPEAT
                            AssignMatrix.CALCSUMS(Amount);
                            // ArrEarnings[1,i]:=AssignMatrix.Description+' Tax';
                            FringeTax := AssignMatrix.Amount * 30 / 100;
                            TotalFringe := TotalFringe + FringeTax;
                            //  EVALUATE(ArrEarningsAmt[1,i],FORMAT(PayrollRounding(FringeTax)));
                            //ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);

                            // i:=i+1;
                            //UNTIL AssignMatrix.NEXT=0;
                        end;
                    until Earn.NEXT = 0;
                end;
                ArrEarnings[1, i] := 'Total Fringe Tax';
                EVALUATE(ArrEarningsAmt[1, i], FORMAT(PayrollRounding(TotalFringe)));
                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
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
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        if AssignMatrix.FIND('-') then begin

                            AssignMatrix.CALCSUMS(Amount);


                            LoanBalances.RESET;
                            LoanBalances.SETRANGE(LoanBalances."Date filter", 0D, DateSpecified);
                            LoanBalances.SETRANGE(LoanBalances."Deduction Code", AssignMatrix.Code);
                            LoanBalances.SETFILTER("Stop Loan", '<>%1', true);
                            if LoanBalances.FIND('-') then begin
                                repeat
                                    if loanType.GET(LoanBalances."Loan Product Type") then begin
                                        if loanType."Interest Calculation Method" = loanType."Interest Calculation Method"::"Flat Rate" then begin
                                            LoanBalances.CALCFIELDS(LoanBalances."Total Repayment", LoanBalances."Total Loan");
                                            ArrEarnings[1, i] := Deduct.Description + ' Balance';
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
                                            ArrEarnings[1, i] := Deduct.Description + ' Balance';//AssignMatrix.Description;


                                            RepSchedule.RESET;
                                            RepSchedule.SETCURRENTKEY("Loan Category", "Repayment Date");
                                            RepSchedule.SETRANGE(RepSchedule."Loan Category", loanType.Code);
                                            RepSchedule.SETRANGE(RepSchedule."Loan No", LoanBalances."Loan No");
                                            RepSchedule.SETRANGE(RepSchedule."Repayment Date", DateSpecified);
                                            //RepSchedule.CALCSUMS(RepSchedule."Remaining Debt");
                                            if RepSchedule.FIND('-') then begin
                                                repeat
                                                    LoanBalance := LoanBalance + RepSchedule."Remaining Debt";
                                                    //    MESSAGE('Loan No %1\LoanBalance=%2',RepSchedule."Loan No",LoanBalance);
                                                until RepSchedule.NEXT = 0;
                                            end;
                                        end;
                                    end;
                                until LoanBalances.NEXT = 0;
                                LoanBalance := LoanBalance;
                                // MESSAGE('LoanBalance1=%1',LoanBalance);
                            end;
                        end;

                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(PayrollRounding(LoanBalance)));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                        i := i + 1;

                    until Deduct.NEXT = 0;
                end;

                //Pension Employer Contribution

                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                Deduct.SETRANGE(Deduct."Calculation Method", Deduct."Calculation Method"::"% of Basic Pay");
                Deduct.SETRANGE(Deduct."Pension Scheme", true);
                if Deduct.FIND('-') then begin
                    repeat
                        // MESSAGE('PENSION DEDUCTION CODE=%1',Deduct.Code);
                        // MESSAGE('Pension PERIOD=%1',Deduct."Pay Period Filter");
                        //   LoanBalance:=0;
                        //Balances

                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        if AssignMatrix.FIND('-') then begin
                            // REPEAT
                            AssignMatrix.CALCSUMS(Amount, "Employer Amount");

                            if Deduct.GET(AssignMatrix.Code) then begin
                                Deduct.SETRANGE(Deduct."Pay Period Filter", 0D, DateSpecified);
                                Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");
                                // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                                ArrEarnings[1, i] := 'Pension Employer Contribution';
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(Deduct."Total Amount Employer"))));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                // MESSAGE('TotalPension=%1',ArrEarningsAmt[1,i]);
                            end;
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(AssignMatrix."Employer Amount"))));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                            i := i + 1;
                            // UNTIL AssignMatrix.NEXT=0;
                        end;
                    until Deduct.NEXT = 0;
                end;

                //Pension Arrears Contribution to Date
                TotalToDate := 0;
                TotalPensionInactive := 0;
                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                Deduct.SETRANGE(Deduct."Calculation Method", Deduct."Calculation Method"::"Flat Amount");
                Deduct.SETRANGE(Deduct."Pension Scheme", true);
                if Deduct.FIND('-') then begin
                    repeat

                        Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");
                        // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                        ArrEarnings[1, i] := Deduct.Description + ' Employer';
                        //TotalToDate:=TotalToDate+Deduct."Total Amount";//+AssignMatrix."Opening Balance";


                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        AssignMatrix.CALCSUMS(Amount, "Employer Amount", AssignMatrix."Opening Balance");
                        TotalToDate := AssignMatrix."Employer Amount";//+AssignMatrix."Opening Balance";


                        EmpRec.RESET;
                        EmpRec.SETFILTER(EmpRec.Status, '<>%1', EmpRec.Status::Active);
                        if EmpRec.FIND('-') then begin
                            repeat
                                AssignMatrix.RESET;
                                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                                AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                                AssignMatrix.SETRANGE(Code, Deduct.Code);
                                AssignMatrix.SETRANGE(AssignMatrix."Employee No", EmpRec."No.");
                                AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                                AssignMatrix.CALCSUMS(Amount, "Employer Amount", "Opening Balance");
                                TotalPensionInactive := TotalPensionInactive + AssignMatrix."Employer Amount";//+AssignMatrix."Opening Balance"+
                            until EmpRec.NEXT = 0;
                        end;
                        TotalToDate := TotalToDate - TotalPensionInactive;
                        PensionArrs := TotalToDate;

                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                        i := i + 1;
                    until Deduct.NEXT = 0;
                end;


                //Gratuity Arrears
                //Gratuity Employer Contribution
                TotalToDate := 0;
                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                Deduct.SETRANGE(Deduct."Calculation Method", Deduct."Calculation Method"::"Flat Amount");
                Deduct.SETRANGE(Deduct."Gratuity Arrears", true);
                // Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                if Deduct.FIND('-') then begin

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", 0D, DateSpecified);
                    AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code, Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                    AssignMatrix.CALCSUMS(Amount, "Employer Amount");
                    // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                    ArrEarnings[1, i] := 'Gratuity Contribution Arrears';
                    TotalToDate := -AssignMatrix."Employer Amount";
                    EVALUATE(ArrEarningsAmt[1, i], FORMAT(-PayrollRounding(TotalToDate)));

                    GratuityArrs := AssignMatrix."Employer Amount";

                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);


                    EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(AssignMatrix."Employer Amount"))));
                    ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                    i := i + 1;
                    // UNTIL AssignMatrix.NEXT=0;

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
                        //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        if AssignMatrix.FIND('-') then begin
                            // REPEAT
                            AssignMatrix.CALCSUMS(Amount, "Employer Amount");
                            if Deduct.GET(AssignMatrix.Code) then begin
                                Deduct.SETRANGE(Deduct."Pay Period Filter", 0D, DateSpecified);
                                Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");
                                // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                                ArrEarnings[1, i] := 'Gratuity Employer Contribution';
                                EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(Deduct."Total Amount Employer"))));
                                ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                                //  MESSAGE('TotalGratuity=%1',ArrEarningsAmt[1,i]);
                            end;
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(AssignMatrix."Employer Amount"))));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                            i := i + 1;
                            // UNTIL AssignMatrix.NEXT=0;
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
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        AssignMatrix.CALCSUMS(Amount, "Employer Amount", "Opening Balance Company");
                        Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");

                        ArrEarnings[1, i] := 'Gratuity Employer Contrib Bal. to Date';
                        TotalToDate := AssignMatrix."Employer Amount" + AssignMatrix."Opening Balance Company";
                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                        // MESSAGE('Opening Balance Company=%1',AssignMatrix."Opening Balance Company");
                        // MESSAGE('OpeningBalanceCompany+TotalGratuityDeduct=%1',TotalToDate);
                        i := i + 1;
                        //UNTIL AssignMatrix.NEXT=0;
                    until Deduct.NEXT = 0;
                end;


                //SRBS Balance
                TotalToDate := 0;
                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                Deduct.SETRANGE(Deduct."Salary Recovery", true);
                Deduct.SETRANGE(Deduct."Pay Period Filter", 0D, DateSpecified);
                if Deduct.FIND('-') then begin
                    repeat
                        Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");
                        ArrEarnings[1, i] := 'SRBS Recovery Balance';

                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", 0D, DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        AssignMatrix.CALCSUMS(Amount, AssignMatrix."Opening Balance");
                        TotalToDate := AssignMatrix."Opening Balance" - AssignMatrix.Amount;


                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                        i := i + 1;
                        // UNTIL AssignMatrix.NEXT=0;
                        //  END;
                    until Deduct.NEXT = 0;
                end;
                //Coremen
                //Show current month
                //Show arrears of current month
                //Pension Arrears Contribution to Date
                TotalToDate := 0;
                TotalPensionInactive := 0;
                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                Deduct.SETRANGE(Deduct."Calculation Method", Deduct."Calculation Method"::"Flat Amount");
                Deduct.SETRANGE(Deduct."Pension Scheme", true);
                if Deduct.FIND('-') then begin
                    repeat

                        Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");
                        //BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                        ArrEarnings[1, i] := Deduct.Description + ' for ' + FORMAT(DateSpecified, 0, '<Month Text> <Year4>');
                        //TotalToDate:=TotalToDate+Deduct."Total Amount";//+AssignMatrix."Opening Balance";


                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        AssignMatrix.CALCSUMS(Amount, "Employer Amount", AssignMatrix."Opening Balance");
                        //TotalToDate:=AssignMatrix.Amount-AssignMatrix."Employer Amount"+AssignMatrix."Opening Balance";
                        TotalToDate := AssignMatrix.Amount - AssignMatrix."Employer Amount";

                        EmpRec.RESET;
                        EmpRec.SETFILTER(EmpRec.Status, '<>%1', EmpRec.Status::Active);
                        if EmpRec.FIND('-') then begin
                            repeat
                                AssignMatrix.RESET;
                                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", 0D, DateSpecified);
                                AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                                AssignMatrix.SETRANGE(Code, Deduct.Code);
                                AssignMatrix.SETRANGE(AssignMatrix."Employee No", EmpRec."No.");
                                AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                                AssignMatrix.CALCSUMS(Amount, "Employer Amount", "Opening Balance");
                                //TotalPensionInactive:=TotalPensionInactive+AssignMatrix."Opening Balance"+AssignMatrix.Amount-AssignMatrix."Employer Amount";
                                TotalPensionInactive := TotalPensionInactive + AssignMatrix.Amount - AssignMatrix."Employer Amount";
                            until EmpRec.NEXT = 0;
                        end;
                        TotalToDate := TotalToDate - TotalPensionInactive;
                        PensionArrs := TotalToDate;

                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                        i := i + 1;
                    until Deduct.NEXT = 0;
                end;



                //Pension Employer Contribution to Date
                TotalToDate := 0;
                TotalPensionInactive := 0;

                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                Deduct.SETRANGE(Deduct."Calculation Method", Deduct."Calculation Method"::"% of Basic Pay");
                Deduct.SETRANGE(Deduct."Pension Scheme", true);
                if Deduct.FIND('-') then begin
                    repeat
                        // MESSAGE('PENSION DEDUCTION CODE=%1',Deduct.Code);
                        // MESSAGE('Pension PERIOD=%1',Deduct."Pay Period Filter");
                        //   LoanBalance:=0;
                        //Balances

                        Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");
                        //  MESSAGE('Total Employer Pension=%1',Deduct."Total Amount Employer");
                        // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                        ArrEarnings[1, i] := 'Pension Employer Contrib. Bal. to Date';
                        TotalToDate := TotalToDate + Deduct."Total Amount Employer" - (PensionArrs);//+AssignMatrix."Opening Balance Company";


                        AssignMatrix.RESET;
                        // AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",0D,DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        if AssignMatrix.FIND('-') then begin
                            // REPEAT
                            AssignMatrix.CALCSUMS(Amount, "Employer Amount", "Opening Balance Company");
                            //MESSAGE('Opening Company Pension=%1',AssignMatrix."Opening Balance Company");

                            TotalToDate := TotalToDate + AssignMatrix."Opening Balance Company";

                            //  UNTIL AssignMatrix.NEXT=0;
                        end;

                        EmpRec.RESET;
                        //EmpRec.SETFILTER(EmpRec."No.",'%1|%2','CMA0148','CMA0162');
                        EmpRec.SETFILTER(EmpRec.Status, '<>%1', EmpRec.Status::Active);
                        if EmpRec.FIND('-') then begin
                            repeat
                                AssignMatrix.RESET;
                                //AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",0D,DateSpecified);
                                AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                                AssignMatrix.SETRANGE(Code, Deduct.Code);
                                AssignMatrix.SETRANGE(AssignMatrix."Employee No", EmpRec."No.");
                                AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                                if AssignMatrix.FIND('-') then begin
                                    // REPEAT

                                    AssignMatrix.CALCSUMS(Amount, "Employer Amount", "Opening Balance Company");
                                    //MESSAGE('Opening Company Pension=%1',AssignMatrix."Opening Balance Company");

                                    TotalPensionInactive := TotalPensionInactive + AssignMatrix."Opening Balance Company" + AssignMatrix."Employer Amount";

                                    //  UNTIL AssignMatrix.NEXT=0;
                                end;
                                // ELSE
                                //   TotalPensionInactive:=0;
                                // MESSAGE('Employee=%1\OpeningBal=%2\Employer Amt=%3\Total=%4',EmpRec."No.",AssignMatrix."Opening Balance Company",AssignMatrix."Employer Amount",TotalPensionInactive);
                            until EmpRec.NEXT = 0;
                        end;
                        //  MESSAGE('TotalPensionInactive=%1',TotalPensionInactive);

                        TotalToDate := TotalToDate - TotalPensionInactive;
                        TotalToDate := TotalToDate;
                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                        i := i + 1;
                    until Deduct.NEXT = 0;
                end;



                //Pension Self Contribution to Date
                TotalToDate := 0;
                TotalPensionInactive := 0;
                Deduct.RESET;
                Deduct.SETRANGE(Deduct."Show Balance", true);
                Deduct.SETRANGE(Deduct."Calculation Method", Deduct."Calculation Method"::"% of Basic Pay");
                Deduct.SETRANGE(Deduct."Pension Scheme", true);
                if Deduct.FIND('-') then begin
                    repeat

                        Deduct.CALCFIELDS(Deduct."Total Amount", Deduct."Total Amount Employer");
                        // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                        ArrEarnings[1, i] := Deduct.Description + ' Bal. to Date';
                        //TotalToDate:=TotalToDate+Deduct."Total Amount";//+AssignMatrix."Opening Balance";


                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", 0D, DateSpecified);
                        AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                        AssignMatrix.SETRANGE(Code, Deduct.Code);
                        AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                        AssignMatrix.CALCSUMS(Amount, "Employer Amount", AssignMatrix."Opening Balance");
                        TotalToDate := AssignMatrix.Amount + AssignMatrix."Opening Balance";


                        EmpRec.RESET;
                        EmpRec.SETFILTER(EmpRec.Status, '<>%1', EmpRec.Status::Active);
                        if EmpRec.FIND('-') then begin
                            repeat
                                AssignMatrix.RESET;
                                AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", 0D, DateSpecified);
                                AssignMatrix.SETFILTER(Type, '%1|%2', AssignMatrix.Type::Deduction, AssignMatrix.Type::Loan);
                                AssignMatrix.SETRANGE(Code, Deduct.Code);
                                AssignMatrix.SETRANGE(AssignMatrix."Employee No", EmpRec."No.");
                                AssignMatrix.SETRANGE(AssignMatrix.Paye, false);
                                AssignMatrix.CALCSUMS(Amount, "Employer Amount", "Opening Balance");
                                TotalPensionInactive := TotalPensionInactive + AssignMatrix."Opening Balance" + AssignMatrix.Amount;
                            until EmpRec.NEXT = 0;
                        end;




                        TotalToDate := TotalToDate - TotalPensionInactive + PensionArrs;


                        EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(PayrollRounding(TotalToDate))));
                        ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);

                        i := i + 1;
                    until Deduct.NEXT = 0;
                end;



                EmpRec.RESET;
                if EmpRec.FIND('-') then begin
                    repeat
                        //ArrEarnings[1,i]:='Leave Balance';
                        AccPeriod.RESET;
                        AccPeriod.SETRANGE(AccPeriod."Starting Date", 0D, TODAY);
                        AccPeriod.SETRANGE(AccPeriod."New Fiscal Year", true);
                        if AccPeriod.FIND('+') then begin
                            FiscalStart := AccPeriod."Starting Date";
                            MaturityDate := CALCDATE('1Y', AccPeriod."Starting Date") - 1;

                            //   ArrEarnings[1,i]:='Leave Balance';
                            // MESSAGE('MATURITY DATE=%1',MaturityDate);
                            LeaveApplication.RESET;
                            LeaveApplication.SETRANGE(LeaveApplication."Employee No", EmpRec."No.");
                            LeaveApplication.SETRANGE(LeaveApplication."Maturity Date", MaturityDate);
                            LeaveApplication.SETRANGE(LeaveApplication.Status, LeaveApplication.Status::Approved);
                            if LeaveApplication.FIND('+') then
                                // BEGIN
                                TotalLeaveBalance := TotalLeaveBalance + LeaveApplication."Leave balance";
                            // ArrEarningsAmt[1,i]:=FORMAT(LeaveApplication."Leave balance");
                            //      MESSAGE('EMPLOYEE=%1, LEAVE BALANCE=%2',Employee."No.",LeaveApplication."Leave balance");
                            //  END;
                        end;

                        /*
                         PayPeriod.RESET;
                         PayPeriod.SETRANGE(PayPeriod."Starting Date",0D,TODAY);
                         PayPeriod.SETRANGE(PayPeriod."New Fiscal Year",TRUE);
                         IF PayPeriod.FIND('+') THEN
                         BEGIN
                          FiscalStart:=PayPeriod."Starting Date";
                          MaturityDate:=CALCDATE('6M',PayPeriod."Starting Date")-1;
                         // MESSAGE('MATURITY DATE=%1',MaturityDate);
                             LeaveApplication.RESET;
                             LeaveApplication.SETRANGE(LeaveApplication."Employee No",EmpRec."No.");
                             LeaveApplication.SETRANGE(LeaveApplication."Maturity Date",MaturityDate);
                             LeaveApplication.SETRANGE(LeaveApplication.Status,LeaveApplication.Status::Released);
                             IF LeaveApplication.FIND('+') THEN
                              BEGIN
                             //  MESSAGE('LEAVE BALANCE=%1',LeaveApplication."Leave balance");
                               TotalLeaveBalance:=TotalLeaveBalance+LeaveApplication."Leave balance";
                              END;
                          END;
                          */
                    until EmpRec.NEXT = 0;
                end;

                ArrEarnings[1, i] := 'Leave Balance';
                ArrEarningsAmt[1, i] := FORMAT(TotalLeaveBalance);

                //End balances

                i := i + 1;

                ArrEarnings[1, i] := '**************************************';
                ArrEarningsAmt[1, i] := '*****************';

                i := i + 1;
                ArrEarnings[1, i] := 'Employer Contributions';

                i := i + 1;

                ArrEarnings[1, i] := '**************************************';
                ArrEarningsAmt[1, i] := '*****************';

                i := i + 1;
                Ded.RESET;
                Ded.SETRANGE(Ded."Pay Period Filter", DateSpecified);
                Ded.SETRANGE(Ded."Show on Payslip Information", true);
                if Ded.FIND('-') then
                    repeat
                        Ded.CALCFIELDS(Ded."Total Amount", Ded."Total Amount Employer");
                        ArrEarnings[1, i] := Ded.Description + '(Employer)';
                        if Ded."Total Amount Employer" <> 0 then begin
                            CodeArr[1, i] := Ded.Code;
                            EVALUATE(ArrEarningsAmt[1, i], FORMAT(ABS(Ded."Total Amount Employer")));
                            ArrEarningsAmt[1, i] := ChckRound(ArrEarningsAmt[1, i]);
                            i := i + 1;
                        end;
                    until Ded.NEXT = 0;

                i := i + 1;

                ArrEarnings[1, i] := '**************************************';
                ArrEarningsAmt[1, i] := '*****************';


                i := i + 1;
                ArrEarnings[1, i] := 'Company Details';
                // Employee details
                i := i + 1;

                ArrEarnings[1, i] := '**************************************';
                ArrEarningsAmt[1, i] := '*****************';
                i := i + 1;
                CompInfo.GET;

                ArrEarnings[1, i] := 'P.I.N';
                //ArrEarningsAmt[1, i] := CompInfo."Company P.I.N";

                i := i + 1;
                // IF EmpBank.GET("Employee's Bank","Bank Branch") THEN
                // BankName:=EmpBank.Name;

                ArrEarnings[1, i] := 'Company Bank';
                ArrEarningsAmt[1, i] := CompInfo."Bank Name";

                i := i + 1;
                ArrEarnings[1, i] := 'Bank Branch';
                ArrEarningsAmt[1, i] := CompInfo."Bank Branch No.";

                i := i + 1;
                ArrEarnings[1, i] := 'NSSF No';
                //ArrEarningsAmt[1, i] := CompInfo."N.S.S.F No.";
                i := i + 1;
                ArrEarnings[1, i] := 'NHIF No';
                //ArrEarningsAmt[1, i] := CompInfo."N.H.I.F No";

                i := i + 1;

                ArrEarnings[1, i] := '*************End of Report**************';

            end;

            trigger OnPreDataItem();
            begin
                Integer.SETRANGE(Number, 1, 1);
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
                field("GroupCode.Code"; GroupCode.Code)
                {
                    Caption = 'Posting Group';
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
        /*PayPeriodtext:=Employee.GETFILTER("Pay Period Filter");
        EVALUATE(PayrollMonth,FORMAT(PayPeriodtext));
        PayrollMonthText:=FORMAT(PayrollMonth,1,4);*/


        Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);

        PayPeriodtext := Employee.GETFILTER("Pay Period Filter");

        EVALUATE(PayrollMonth, FORMAT(PayPeriodtext));
        PayrollMonthText := FORMAT(PayrollMonth, 1, 4);


        if PayPeriodtext = '' then
            ERROR('Pay period must be specified for this report');
        CoRec.GET;
        CoName := CoRec.Name;
        EVALUATE(DateSpecified, FORMAT(PayPeriodtext));






        /*
        //CreateLeaveEntitlement
        LastMaturityDate:=CALCDATE('-1D',TODAY);
        NextMaturityDate:=CALCDATE('1Y',LastMaturityDate);
        
        LeaveType.RESET;
        LeaveType.SETRANGE(LeaveType."Annual Leave",TRUE);
        IF LeaveType.FIND('-') THEN
        BEGIN
        
        Emp.RESET;
        Emp.SETRANGE(Emp.Status,Emp.Status::Active);
        Emp.SETFILTER(Emp."Posting Group",'<>%1','INTERN');
        IF Emp.FIND('-') THEN
        REPEAT
        
          IF EmpleaveCpy.GET(Emp."No.",LeaveType.Code,LastMaturityDate) THEN
          BEGIN
          EmpleaveCpy.CALCFIELDS(EmpleaveCpy."Total Days Taken");
          CarryForwardDays:=EmpleaveCpy.Entitlement+EmpleaveCpy."Balance Brought Forward" +EmpleaveCpy."Recalled Days"-EmpleaveCpy."Total Days Taken";
        
          IF CarryForwardDays>LeaveType."Max Carry Forward Days" THEN
          CarryForwardDays:=LeaveType."Max Carry Forward Days";
          END;
        
          Empleave.INIT;
          Empleave."Employee No":=Emp."No.";
          Empleave."Leave Code":=LeaveType.Code;
          Empleave."Maturity Date":=NextMaturityDate;
          Empleave.Entitlement:=LeaveType.Days;
          Empleave."Balance Brought Forward":=CarryForwardDays;
          IF NOT Empleave.GET(Empleave."Employee No", Empleave."Leave Code",Empleave."Maturity Date") THEN
          Empleave.INSERT;
        //MESSAGE('EMP %1\LEAVETYPE=%2\MATURITYDATE=%3\ENTITLEMENT=%4\BALANCEBF=%5',Empleave."Employee No",Empleave."Leave Code",Empleave."Maturity Date",Empleave.Entitlement,CarryForwardDays);
        UNTIL Emp.NEXT=0;
        END
        ELSE
        ERROR('You must select one leave type as annual on the leave setup');
        //END;
        */

    end;

    var
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
        //EmpBank: Record "Employee Bank Accounts";
        BankName: Text[250];
        BasicSalary: Decimal;
        TaxableAmt: Decimal;
        RightBracket: Boolean;
        NetPay: Decimal;
        PayPeriodRec: Record "Payroll Period";
        PayDeduct: Record "Assignment Matrix";
        EmpRec: Record Employee;
        EmpNo: Code[20];
        TaxableAmount: Decimal;
        PAYE: Decimal;
        PAYE2: Decimal;
        ArrEarnings: array[3, 10000] of Text[250];
        ArrDeductions: array[3, 1000] of Text[250];
        Index: Integer;
        Index1: Integer;
        j: Integer;
        ArrEarningsAmt: array[3, 1000] of Text[60];
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
        TaxCode: Code[20];
        HoursBal: Decimal;
        Pay: Record Earnings;
        Ded: Record Deductions;
        HoursArrayD: array[3, 60] of Decimal;
        BankBranch: Text[100];
        CoName: Text[100];
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
        //PayrollCodeunit: Codeunit "Payment- Post";
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
        Nssfcomptext: Text[50];
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
        //GetPaye: Codeunit "Payment- Post";
        PayeeTest: Decimal;
        //GetGroup: Codeunit "Payment- Post";
        GroupCode: Record "Employee Posting Group";
        CUser: Code[20];
        Totalcoopshares: Decimal;
        LoanBal: Decimal;
        LoanBalances: Record "Loan Application";
        TotalRepayment: Decimal;
        Totalnssf: Decimal;
        Totalpension: Decimal;
        Totalprovid: Decimal;
        BalanceArray: array[3, 10000] of Decimal;
        EarningsCaptionLbl: Label 'Earnings';
        Employee_No_CaptionLbl: Label 'Employee No:';
        Name_CaptionLbl: Label 'Name:';
        Dept_CaptionLbl: Label 'Dept:';
        AmountCaptionLbl: Label 'Amount';
        Pay_slipCaptionLbl: Label 'Company Totals By Analysis';
        EmptyStringCaptionLbl: Label '***************************************************';
        CurrReport_PAGENOCaptionLbl: Label 'Copy';
        TaxCharged: Decimal;
        InterestCode: Code[20];
        BalanceCaptionLbl: Label 'Balances';
        CompInfo: Record "Company Information";
        FiscalStart: Date;
        MaturityDate: Date;
        LeaveApplication: Record "Employee Leave Application";
        TotalLeaveBalance: Decimal;
        Empleave: Record "HR Type Of Intervention";
        LeaveType: Record "HR Learning Intervention";
        LastMaturityDate: Date;
        NextMaturityDate: Date;
        Emp: Record Employee;
        CarryForwardDays: Decimal;
        EmpleaveCpy: Record "HR Type Of Intervention";
        TotalToDate: Decimal;
        //SavingsRec: Record "Savings Scheme Transactions";
        TotalDeposits: Decimal;
        TotalWithdrawals: Decimal;
        PositivePAYEManual: Decimal;
        TotalBulkRepayments: Decimal;
        LoanTopUps: Record "Loan Top-up";
        TotalRepayments: Decimal;
        CurrentRepayment: Decimal;
        TotalPensionInactive: Decimal;
        FringeTax: Decimal;
        GratuityArrs: Decimal;
        OpeningBal: Decimal;
        LineAmt: Decimal;
        PensionArrs: Decimal;
        CodeArr: array[3, 100] of Code[20];
        AccPeriod: Record "Accounting Period";
        DateMHCALbl: Label 'Date......................................';
        DateMFLbl: Label 'Date......................................';
        Designation_________________________________________________________________________________________CaptionLbl: Label 'Designation.........................................................................................';
        DateDCSLbl: Label 'Date......................................';
        SignatureMHCALbl: Label 'Checked By MHCA......................................................';
        SignatureMFLbl: Label 'First Authorized by MF.................................................';
        SignatureDCSLbl: Label 'Second Authorized by DCS............................................';
        /*Designation_________________________________________________________________________________________Caption_Control1000000069Lbl: Label 'Designation.........................................................................................';
        Designation_________________________________________________________________________________________Caption_Control1000000070Lbl: Label 'Designation.........................................................................................';*/
        TotalFringe: Decimal;
        MonthStartDate: Date;

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

