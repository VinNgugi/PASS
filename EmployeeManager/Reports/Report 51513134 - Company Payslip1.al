report 51513134 "Company Payslip1"
{
    // version PAYROLL

    // ArrEarnings[1,1]
    // ArrEarningsAmt[1,1]
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Company Payslip1.rdl';
    Caption= 'Company Payslip1';


    dataset
    {
        dataitem(Employee;Employee)
        {
            DataItemTableView = SORTING("Global Dimension 1 Code") ORDER(Ascending);
            RequestFilterFields = "No.","Global Dimension 1 Code";

            trigger OnPreDataItem();
            begin
                 CompRec.GET;
                 Message2[1,1]:=CompRec."General Payslip Message";

                //MESSAGE('%1',MonthStartDate);
            end;
        }
        dataitem("Integer";"Integer")
        {
            column(Addr_1__1_;Addr[1][1])
            {
            }
            column(Addr_1__2_;Addr[1][2])
            {
            }
            column(DeptArr_1_1_;DeptArr[1,1])
            {
            }
            column(ArrEarnings_1_1_;ArrEarnings[1,1])
            {
            }
            column(ArrEarnings_1_2_;ArrEarnings[1,2])
            {
            }
            column(ArrEarnings_1_3_;ArrEarnings[1,3])
            {
            }
            column(ArrEarningsAmt_1_1_;ArrEarningsAmt[1,1])
            {
                //DecimalPlaces = 2:2;
            }
            column(ArrEarningsAmt_1_2_;ArrEarningsAmt[1,2])
            {
               // DecimalPlaces = 2:2;
            }
            column(ArrEarningsAmt_1_3_;ArrEarningsAmt[1,3])
            {
               // DecimalPlaces = 2:2;
            }
            column(ArrEarnings_1_4_;ArrEarnings[1,4])
            {
            }
            column(ArrEarningsAmt_1_4_;ArrEarningsAmt[1,4])
            {
                //DecimalPlaces = 2:2;
            }
            column(ArrEarnings_1_5_;ArrEarnings[1,5])
            {
            }
            column(ArrEarningsAmt_1_5_;ArrEarningsAmt[1,5])
            {
                //DecimalPlaces = 2:2;
            }
            column(ArrEarnings_1_6_;ArrEarnings[1,6])
            {
            }
            column(ArrEarningsAmt_1_6_;ArrEarningsAmt[1,6])
            {
            }
            column(ArrEarnings_1_7_;ArrEarnings[1,7])
            {
            }
            column(ArrEarningsAmt_1_7_;ArrEarningsAmt[1,7])
            {
            }
            column(ArrEarnings_1_8_;ArrEarnings[1,8])
            {
            }
            column(ArrEarningsAmt_1_8_;ArrEarningsAmt[1,8])
            {
            }
            column(ArrEarnings_1_91_;ArrEarnings[1,91])
            {
            }
            column(ArrEarnings_1_92_;ArrEarnings[1,92])
            {
            }
            column(ArrEarnings_1_93_;ArrEarnings[1,93])
            {
            }
            column(ArrEarnings_1_94_;ArrEarnings[1,94])
            {
            }
            column(ArrEarnings_1_95_;ArrEarnings[1,95])
            {
            }
            column(ArrEarnings_1_96_;ArrEarnings[1,96])
            {
            }
            column(ArrEarningsAmt_1_91_;ArrEarningsAmt[1,91])
            {
            }
            column(ArrEarningsAmt_1_92_;ArrEarningsAmt[1,92])
            {
            }
            column(ArrEarningsAmt_1_93_;ArrEarningsAmt[1,93])
            {
            }
            column(ArrEarningsAmt_1_94_;ArrEarningsAmt[1,94])
            {
            }
            column(ArrEarningsAmt_1_95_;ArrEarningsAmt[1,95])
            {
            }
            column(ArrEarningsAmt_1_96_;ArrEarningsAmt[1,96])
            {
            }
            column(ArrEarnings_1_97_;ArrEarnings[1,97])
            {
            }
            column(ArrEarnings_1_98_;ArrEarnings[1,98])
            {
            }
            column(ArrEarnings_1_99_;ArrEarnings[1,99])
            {
            }
            column(ArrEarnings_1_100_;ArrEarnings[1,100])
            {
            }
            column(ArrEarningsAmt_1_97_;ArrEarningsAmt[1,97])
            {
            }
            column(ArrEarningsAmt_1_98_;ArrEarningsAmt[1,98])
            {
            }
            column(ArrEarningsAmt_1_99_;ArrEarningsAmt[1,99])
            {
            }
            column(ArrEarningsAmt_1_100_;ArrEarningsAmt[1,100])
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____;UPPERCASE(FORMAT(DateSpecified,0,'<month text> <year4>')))
            {
            }
            column(CoName;CoName)
            {
            }
            column(DateMHCA;DateMHCALbl)
            {
            }
            column(DateDCS;DateDCSLbl)
            {
            }
            column(Designation_________________________________________________________________________________________Caption;Designation_________________________________________________________________________________________CaptionLbl)
            {
            }
            column(DateMF;DateMFLbl)
            {
            }
            column(SignatureMHCA;SignatureMHCALbl)
            {
            }
            column(SignatureMF;SignatureMFLbl)
            {
            }
            column(SignatureDCS;SignatureDCSLbl)
            {
            }
            /*column(DataItem1000000328;Designation_________________________________________________________________________________________Caption_Control1000000069Lbl)
            {
            }
            column(DataItem1000000329;Designation_________________________________________________________________________________________Caption_Control1000000070Lbl)
            {
            }*/
            column(ArrEarningsAmt_1_9_;ArrEarningsAmt[1,9])
            {
            }
            column(ArrEarningsAmt_1_10_;ArrEarningsAmt[1,10])
            {
            }
            column(ArrEarningsAmt_1_11_;ArrEarningsAmt[1,11])
            {
            }
            column(ArrEarningsAmt_1_12_;ArrEarningsAmt[1,12])
            {
            }
            column(ArrEarningsAmt_1_13_;ArrEarningsAmt[1,13])
            {
            }
            column(ArrEarningsAmt_1_14_;ArrEarningsAmt[1,14])
            {
            }
            column(ArrEarningsAmt_1_15_;ArrEarningsAmt[1,15])
            {
            }
            column(ArrEarningsAmt_1_16_;ArrEarningsAmt[1,16])
            {
            }
            column(ArrEarnings_1_9_;ArrEarnings[1,9])
            {
            }
            column(ArrEarnings_1_10_;ArrEarnings[1,10])
            {
            }
            column(ArrEarnings_1_11_;ArrEarnings[1,11])
            {
            }
            column(ArrEarnings_1_12_;ArrEarnings[1,12])
            {
            }
            column(ArrEarnings_1_13_;ArrEarnings[1,13])
            {
            }
            column(ArrEarnings_1_14_;ArrEarnings[1,14])
            {
            }
            column(ArrEarnings_1_15_;ArrEarnings[1,15])
            {
            }
            column(ArrEarnings_1_16_;ArrEarnings[1,16])
            {
            }
            column(ArrEarningsAmt_1_17_;ArrEarningsAmt[1,17])
            {
            }
            column(ArrEarnings_1_17_;ArrEarnings[1,17])
            {
            }
            column(ArrEarnings_1_18_;ArrEarnings[1,18])
            {
            }
            column(ArrEarnings_1_19_;ArrEarnings[1,19])
            {
            }
            column(ArrEarnings_1_20_;ArrEarnings[1,20])
            {
            }
            column(ArrEarnings_1_21_;ArrEarnings[1,21])
            {
            }
            column(ArrEarnings_1_22_;ArrEarnings[1,22])
            {
            }
            column(ArrEarnings_1_23_;ArrEarnings[1,23])
            {
            }
            column(ArrEarnings_1_25_;ArrEarnings[1,25])
            {
            }
            column(ArrEarnings_1_26_;ArrEarnings[1,26])
            {
            }
            column(ArrEarnings_1_34_;ArrEarnings[1,34])
            {
            }
            column(ArrEarnings_1_33_;ArrEarnings[1,33])
            {
            }
            column(ArrEarnings_1_32_;ArrEarnings[1,32])
            {
            }
            column(ArrEarnings_1_31_;ArrEarnings[1,31])
            {
            }
            column(ArrEarnings_1_30_;ArrEarnings[1,30])
            {
            }
            column(ArrEarnings_1_29_;ArrEarnings[1,29])
            {
            }
            column(ArrEarnings_1_28_;ArrEarnings[1,28])
            {
            }
            column(ArrEarnings_1_27_;ArrEarnings[1,27])
            {
            }
            column(ArrEarnings_1_41_;ArrEarnings[1,41])
            {
            }
            column(ArrEarnings_1_40_;ArrEarnings[1,40])
            {
            }
            column(ArrEarnings_1_39_;ArrEarnings[1,39])
            {
            }
            column(ArrEarnings_1_38_;ArrEarnings[1,38])
            {
            }
            column(ArrEarnings_1_37_;ArrEarnings[1,37])
            {
            }
            column(ArrEarnings_1_36_;ArrEarnings[1,36])
            {
            }
            column(ArrEarnings_1_35_;ArrEarnings[1,35])
            {
            }
            column(ArrEarningsAmt_1_33_;ArrEarningsAmt[1,33])
            {
            }
            column(ArrEarningsAmt_1_32_;ArrEarningsAmt[1,32])
            {
            }
            column(ArrEarningsAmt_1_31_;ArrEarningsAmt[1,31])
            {
            }
            column(ArrEarningsAmt_1_30_;ArrEarningsAmt[1,30])
            {
            }
            column(ArrEarningsAmt_1_29_;ArrEarningsAmt[1,29])
            {
            }
            column(ArrEarningsAmt_1_28_;ArrEarningsAmt[1,28])
            {
            }
            column(ArrEarningsAmt_1_27_;ArrEarningsAmt[1,27])
            {
            }
            column(ArrEarningsAmt_1_26_;ArrEarningsAmt[1,26])
            {
            }
            column(ArrEarningsAmt_1_25_;ArrEarningsAmt[1,25])
            {
            }
            column(ArrEarningsAmt_1_24_;ArrEarningsAmt[1,24])
            {
            }
            column(ArrEarningsAmt_1_23_;ArrEarningsAmt[1,23])
            {
            }
            column(ArrEarningsAmt_1_22_;ArrEarningsAmt[1,22])
            {
            }
            column(ArrEarningsAmt_1_21_;ArrEarningsAmt[1,21])
            {
            }
            column(ArrEarningsAmt_1_20_;ArrEarningsAmt[1,20])
            {
            }
            column(ArrEarningsAmt_1_19_;ArrEarningsAmt[1,19])
            {
            }
            column(ArrEarningsAmt_1_18_;ArrEarningsAmt[1,18])
            {
            }
            column(ArrEarnings_1_24_;ArrEarnings[1,24])
            {
            }
            column(ArrEarningsAmt_1_39_;ArrEarningsAmt[1,39])
            {
            }
            column(ArrEarningsAmt_1_38_;ArrEarningsAmt[1,38])
            {
            }
            column(ArrEarningsAmt_1_37_;ArrEarningsAmt[1,37])
            {
            }
            column(ArrEarningsAmt_1_36_;ArrEarningsAmt[1,36])
            {
            }
            column(ArrEarningsAmt_1_35_;ArrEarningsAmt[1,35])
            {
            }
            column(ArrEarningsAmt_1_34_;ArrEarningsAmt[1,34])
            {
            }
            column(ArrEarningsAmt_1_41_;ArrEarningsAmt[1,41])
            {
            }
            column(ArrEarningsAmt_1_40_;ArrEarningsAmt[1,40])
            {
            }
            column(Message1;Message1)
            {
            }
            column(Message2_1_1_;Message2[1,1])
            {
            }
            column(ArrEarningsAmt_1_43_;ArrEarningsAmt[1,43])
            {
            }
            column(ArrEarningsAmt_1_42_;ArrEarningsAmt[1,42])
            {
            }
            column(ArrEarningsAmt_1_45_;ArrEarningsAmt[1,45])
            {
            }
            column(ArrEarningsAmt_1_44_;ArrEarningsAmt[1,44])
            {
            }
            column(ArrEarnings_1_45_;ArrEarnings[1,45])
            {
            }
            column(ArrEarnings_1_44_;ArrEarnings[1,44])
            {
            }
            column(ArrEarnings_1_43_;ArrEarnings[1,43])
            {
            }
            column(ArrEarnings_1_42_;ArrEarnings[1,42])
            {
            }
            column(ArrEarningsAmt_1_48_;ArrEarningsAmt[1,48])
            {
            }
            column(ArrEarningsAmt_1_46_;ArrEarningsAmt[1,46])
            {
            }
            column(ArrEarningsAmt_1_47_;ArrEarningsAmt[1,47])
            {
            }
            column(ArrEarnings_1_48_;ArrEarnings[1,48])
            {
            }
            column(ArrEarnings_1_47_;ArrEarnings[1,47])
            {
            }
            column(ArrEarnings_1_46_;ArrEarnings[1,46])
            {
            }
            column(CoRec_Picture;CoRec.Picture)
            {
            }
            column(BalanceArray_1_1_;BalanceArray[1,1])
            {
            }
            column(BalanceArray_1_2_;BalanceArray[1,2])
            {
            }
            column(BalanceArray_1_3_;BalanceArray[1,3])
            {
            }
            column(BalanceArray_1_4_;BalanceArray[1,4])
            {
            }
            column(BalanceArray_1_5_;BalanceArray[1,5])
            {
            }
            column(BalanceArray_1_6_;BalanceArray[1,6])
            {
            }
            column(BalanceArray_1_7_;BalanceArray[1,7])
            {
            }
            column(BalanceArray_1_8_;BalanceArray[1,8])
            {
            }
            column(BalanceArray_1_9_;BalanceArray[1,9])
            {
            }
            column(BalanceArray_1_10_;BalanceArray[1,10])
            {
            }
            column(BalanceArray_1_11_;BalanceArray[1,11])
            {
            }
            column(BalanceArray_1_12_;BalanceArray[1,12])
            {
            }
            column(BalanceArray_1_13_;BalanceArray[1,13])
            {
            }
            column(BalanceArray_1_14_;BalanceArray[1,14])
            {
            }
            column(BalanceArray_1_15_;BalanceArray[1,15])
            {
            }
            column(BalanceArray_1_16_;BalanceArray[1,16])
            {
            }
            column(BalanceArray_1_17_;BalanceArray[1,17])
            {
            }
            column(BalanceArray_1_19_;BalanceArray[1,19])
            {
            }
            column(BalanceArray_1_18_;BalanceArray[1,18])
            {
            }
            column(BalanceArray_1_20_;BalanceArray[1,20])
            {
            }
            column(BalanceArray_1_22_;BalanceArray[1,22])
            {
            }
            column(BalanceArray_1_21_;BalanceArray[1,21])
            {
            }
            column(BalanceArray_1_23_;BalanceArray[1,23])
            {
            }
            column(BalanceArray_1_26_;BalanceArray[1,26])
            {
            }
            column(BalanceArray_1_25_;BalanceArray[1,25])
            {
            }
            column(BalanceArray_1_24_;BalanceArray[1,24])
            {
            }
            column(BalanceArray_1_28_;BalanceArray[1,28])
            {
            }
            column(BalanceArray_1_27_;BalanceArray[1,27])
            {
            }
            column(BalanceArray_1_30_;BalanceArray[1,30])
            {
            }
            column(BalanceArray_1_29_;BalanceArray[1,29])
            {
            }
            column(BalanceArray_1_32_;BalanceArray[1,32])
            {
            }
            column(BalanceArray_1_31_;BalanceArray[1,31])
            {
            }
            column(BalanceArray_1_34_;BalanceArray[1,34])
            {
            }
            column(BalanceArray_1_33_;BalanceArray[1,33])
            {
            }
            column(BalanceArray_1_36_;BalanceArray[1,36])
            {
            }
            column(BalanceArray_1_35_;BalanceArray[1,35])
            {
            }
            column(BalanceArray_1_38_;BalanceArray[1,38])
            {
            }
            column(BalanceArray_1_37_;BalanceArray[1,37])
            {
            }
            column(BalanceArray_1_40_;BalanceArray[1,40])
            {
            }
            column(BalanceArray_1_39_;BalanceArray[1,39])
            {
            }
            column(BalanceArray_1_41_;BalanceArray[1,41])
            {
            }
            column(BalanceArray_1_42_;BalanceArray[1,42])
            {
            }
            column(BalanceArray_1_43_;BalanceArray[1,43])
            {
            }
            column(BalanceArray_1_44_;BalanceArray[1,44])
            {
            }
            column(BalanceArray_1_46_;BalanceArray[1,46])
            {
            }
            column(BalanceArray_1_45_;BalanceArray[1,45])
            {
            }
            column(BalanceArray_1_48_;BalanceArray[1,48])
            {
            }
            column(BalanceArray_1_47_;BalanceArray[1,47])
            {
            }
            column(STRSUBSTNO__Date__1__2__TODAY_TIME_;STRSUBSTNO('Date %1 %2',TODAY,TIME))
            {
            }
            column(USERID;USERID)
            {
            }
            column(CurrReport_PAGENO;CurrReport.PAGENO)
            {
            }
            column(EarningsCaption;EarningsCaptionLbl)
            {
            }
            column(AmountCaption;AmountCaptionLbl)
            {
            }
            column(BalanceCaption;BalanceCaptionLbl)
            {
            }
            column(Pay_slipCaption;Pay_slipCaptionLbl)
            {
            }
            column(EmptyStringCaption;EmptyStringCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption;CurrReport_PAGENOCaptionLbl)
            {
            }
            column(ArrEarnings_1_49_;ArrEarnings[1,49])
            {
            }
            column(ArrEarnings_1_50_;ArrEarnings[1,50])
            {
            }
            column(ArrEarnings_1_51_;ArrEarnings[1,51])
            {
            }
            column(ArrEarnings_1_52_;ArrEarnings[1,52])
            {
            }
            column(ArrEarnings_1_53_;ArrEarnings[1,53])
            {
            }
            column(ArrEarnings_1_54_;ArrEarnings[1,54])
            {
            }
            column(ArrEarnings_1_55_;ArrEarnings[1,55])
            {
            }
            column(ArrEarnings_1_56_;ArrEarnings[1,56])
            {
            }
            column(ArrEarnings_1_57_;ArrEarnings[1,57])
            {
            }
            column(ArrEarnings_1_58_;ArrEarnings[1,58])
            {
            }
            column(ArrEarnings_1_59_;ArrEarnings[1,59])
            {
            }
            column(ArrEarnings_1_60_;ArrEarnings[1,60])
            {
            }
            column(ArrEarnings_1_61_;ArrEarnings[1,61])
            {
            }
            column(ArrEarnings_1_62_;ArrEarnings[1,62])
            {
            }
            column(ArrEarnings_1_63_;ArrEarnings[1,63])
            {
            }
            column(ArrEarnings_1_73_;ArrEarnings[1,73])
            {
            }
            column(ArrEarnings_1_64_;ArrEarnings[1,64])
            {
            }
            column(ArrEarnings_1_65_;ArrEarnings[1,65])
            {
            }
            column(ArrEarnings_1_66_;ArrEarnings[1,66])
            {
            }
            column(ArrEarnings_1_67_;ArrEarnings[1,67])
            {
            }
            column(ArrEarnings_1_68_;ArrEarnings[1,68])
            {
            }
            column(ArrEarnings_1_69_;ArrEarnings[1,69])
            {
            }
            column(ArrEarnings_1_70_;ArrEarnings[1,70])
            {
            }
            column(ArrEarnings_1_71_;ArrEarnings[1,71])
            {
            }
            column(ArrEarnings_1_72_;ArrEarnings[1,72])
            {
            }
            column(ArrEarnings_1_74_;ArrEarnings[1,74])
            {
            }
            column(ArrEarnings_1_75_;ArrEarnings[1,75])
            {
            }
            column(ArrEarnings_1_76_;ArrEarnings[1,76])
            {
            }
            column(ArrEarnings_1_77_;ArrEarnings[1,77])
            {
            }
            column(ArrEarnings_1_78_;ArrEarnings[1,78])
            {
            }
            column(ArrEarnings_1_79_;ArrEarnings[1,79])
            {
            }
            column(ArrEarnings_1_80_;ArrEarnings[1,80])
            {
            }
            column(ArrEarnings_1_81_;ArrEarnings[1,81])
            {
            }
            column(ArrEarnings_1_82_;ArrEarnings[1,82])
            {
            }
            column(ArrEarnings_1_83_;ArrEarnings[1,83])
            {
            }
            column(ArrEarnings_1_84_;ArrEarnings[1,84])
            {
            }
            column(ArrEarnings_1_85_;ArrEarnings[1,85])
            {
            }
            column(ArrEarnings_1_86_;ArrEarnings[1,86])
            {
            }
            column(ArrEarnings_1_87_;ArrEarnings[1,87])
            {
            }
            column(ArrEarnings_1_88_;ArrEarnings[1,88])
            {
            }
            column(ArrEarnings_1_89_;ArrEarnings[1,89])
            {
            }
            column(ArrEarnings_1_90_;ArrEarnings[1,90])
            {
            }
            column(ArrEarnings_1_101_;ArrEarnings[1,101])
            {
            }
            column(ArrEarnings_1_102_;ArrEarnings[1,102])
            {
            }
            column(ArrEarnings_1_103_;ArrEarnings[1,103])
            {
            }
            column(ArrEarnings_1_104_;ArrEarnings[1,104])
            {
            }
            column(ArrEarnings_1_105_;ArrEarnings[1,105])
            {
            }
            column(ArrEarnings_1_106_;ArrEarnings[1,106])
            {
            }
            column(ArrEarnings_1_107_;ArrEarnings[1,107])
            {
            }
            column(ArrEarnings_1_108_;ArrEarnings[1,108])
            {
            }
            column(ArrEarnings_1_109_;ArrEarnings[1,109])
            {
            }
            column(ArrEarnings_1_110_;ArrEarnings[1,110])
            {
            }
            column(ArrEarningsAmt_1_49_;ArrEarningsAmt[1,49])
            {
            }
            column(ArrEarningsAmt_1_50_;ArrEarningsAmt[1,50])
            {
            }
            column(ArrEarningsAmt_1_51_;ArrEarningsAmt[1,51])
            {
            }
            column(ArrEarningsAmt_1_52_;ArrEarningsAmt[1,52])
            {
            }
            column(ArrEarningsAmt_1_53_;ArrEarningsAmt[1,53])
            {
            }
            column(ArrEarningsAmt_1_54_;ArrEarningsAmt[1,54])
            {
            }
            column(ArrEarningsAmt_1_55_;ArrEarningsAmt[1,55])
            {
            }
            column(ArrEarningsAmt_1_56_;ArrEarningsAmt[1,56])
            {
            }
            column(ArrEarningsAmt_1_57_;ArrEarningsAmt[1,57])
            {
            }
            column(ArrEarningsAmt_1_58_;ArrEarningsAmt[1,58])
            {
            }
            column(ArrEarningsAmt_1_59_;ArrEarningsAmt[1,59])
            {
            }
            column(ArrEarningsAmt_1_60_;ArrEarningsAmt[1,60])
            {
            }
            column(ArrEarningsAmt_1_61_;ArrEarningsAmt[1,61])
            {
            }
            column(ArrEarningsAmt_1_62_;ArrEarningsAmt[1,62])
            {
            }
            column(ArrEarningsAmt_1_63_;ArrEarningsAmt[1,63])
            {
            }
            column(ArrEarningsAmt_1_64_;ArrEarningsAmt[1,64])
            {
            }
            column(ArrEarningsAmt_1_65_;ArrEarningsAmt[1,65])
            {
            }
            column(ArrEarningsAmt_1_66_;ArrEarningsAmt[1,66])
            {
            }
            column(ArrEarningsAmt_1_67_;ArrEarningsAmt[1,67])
            {
            }
            column(ArrEarningsAmt_1_68_;ArrEarningsAmt[1,68])
            {
            }
            column(ArrEarningsAmt_1_69_;ArrEarningsAmt[1,69])
            {
            }
            column(ArrEarningsAmt_1_70_;ArrEarningsAmt[1,70])
            {
            }
            column(ArrEarningsAmt_1_71_;ArrEarningsAmt[1,71])
            {
            }
            column(ArrEarningsAmt_1_72_;ArrEarningsAmt[1,72])
            {
            }
            column(ArrEarningsAmt_1_73_;ArrEarningsAmt[1,73])
            {
            }
            column(ArrEarningsAmt_1_74_;ArrEarningsAmt[1,74])
            {
            }
            column(ArrEarningsAmt_1_75_;ArrEarningsAmt[1,75])
            {
            }
            column(ArrEarningsAmt_1_76_;ArrEarningsAmt[1,76])
            {
            }
            column(ArrEarningsAmt_1_77_;ArrEarningsAmt[1,77])
            {
            }
            column(ArrEarningsAmt_1_78_;ArrEarningsAmt[1,78])
            {
            }
            column(ArrEarningsAmt_1_79_;ArrEarningsAmt[1,79])
            {
            }
            column(ArrEarningsAmt_1_80_;ArrEarningsAmt[1,80])
            {
            }
            column(ArrEarningsAmt_1_81_;ArrEarningsAmt[1,81])
            {
            }
            column(ArrEarningsAmt_1_82_;ArrEarningsAmt[1,82])
            {
            }
            column(ArrEarningsAmt_1_83_;ArrEarningsAmt[1,83])
            {
            }
            column(ArrEarningsAmt_1_84_;ArrEarningsAmt[1,84])
            {
            }
            column(ArrEarningsAmt_1_85_;ArrEarningsAmt[1,85])
            {
            }
            column(ArrEarningsAmt_1_86_;ArrEarningsAmt[1,86])
            {
            }
            column(ArrEarningsAmt_1_87_;ArrEarningsAmt[1,87])
            {
            }
            column(ArrEarningsAmt_1_88_;ArrEarningsAmt[1,88])
            {
            }
            column(ArrEarningsAmt_1_89_;ArrEarningsAmt[1,89])
            {
            }
            column(ArrEarningsAmt_1_90_;ArrEarningsAmt[1,90])
            {
            }
            column(BalanceArray_1_49_;BalanceArray[1,49])
            {
            }
            column(BalanceArray_1_50_;BalanceArray[1,50])
            {
            }
            column(BalanceArray_1_51_;BalanceArray[1,51])
            {
            }
            column(BalanceArray_1_52_;BalanceArray[1,52])
            {
            }
            column(BalanceArray_1_53_;BalanceArray[1,53])
            {
            }
            column(BalanceArray_1_54_;BalanceArray[1,54])
            {
            }
            column(BalanceArray_1_55_;BalanceArray[1,55])
            {
            }
            column(BalanceArray_1_56_;BalanceArray[1,56])
            {
            }
            column(BalanceArray_1_57_;BalanceArray[1,57])
            {
            }
            column(BalanceArray_1_58_;BalanceArray[1,58])
            {
            }
            column(BalanceArray_1_59_;BalanceArray[1,59])
            {
            }
            column(BalanceArray_1_60_;BalanceArray[1,60])
            {
            }
            column(BalanceArray_1_61_;BalanceArray[1,61])
            {
            }
            column(BalanceArray_1_62_;BalanceArray[1,62])
            {
            }
            column(BalanceArray_1_63_;BalanceArray[1,63])
            {
            }
            column(BalanceArray_1_64_;BalanceArray[1,64])
            {
            }
            column(BalanceArray_1_65_;BalanceArray[1,65])
            {
            }
            column(BalanceArray_1_66_;BalanceArray[1,66])
            {
            }
            column(BalanceArray_1_67_;BalanceArray[1,67])
            {
            }
            column(BalanceArray_1_68_;BalanceArray[1,68])
            {
            }
            column(BalanceArray_1_69_;BalanceArray[1,69])
            {
            }
            column(BalanceArray_1_70_;BalanceArray[1,70])
            {
            }
            column(BalanceArray_1_71_;BalanceArray[1,71])
            {
            }
            column(BalanceArray_1_72_;BalanceArray[1,72])
            {
            }
            column(BalanceArray_1_73_;BalanceArray[1,73])
            {
            }
            column(BalanceArray_1_74_;BalanceArray[1,74])
            {
            }
            column(BalanceArray_1_75_;BalanceArray[1,75])
            {
            }
            column(BalanceArray_1_76_;BalanceArray[1,76])
            {
            }
            column(BalanceArray_1_77_;BalanceArray[1,77])
            {
            }
            column(BalanceArray_1_78_;BalanceArray[1,78])
            {
            }
            column(BalanceArray_1_79_;BalanceArray[1,79])
            {
            }
            column(BalanceArray_1_80_;BalanceArray[1,80])
            {
            }
            column(BalanceArray_1_81_;BalanceArray[1,81])
            {
            }
            column(BalanceArray_1_82_;BalanceArray[1,82])
            {
            }
            column(BalanceArray_1_83_;BalanceArray[1,83])
            {
            }
            column(BalanceArray_1_84_;BalanceArray[1,84])
            {
            }
            column(BalanceArray_1_85_;BalanceArray[1,85])
            {
            }
            column(BalanceArray_1_86_;BalanceArray[1,86])
            {
            }
            column(BalanceArray_1_87_;BalanceArray[1,87])
            {
            }
            column(BalanceArray_1_88_;BalanceArray[1,88])
            {
            }
            column(BalanceArray_1_89_;BalanceArray[1,89])
            {
            }
            column(BalanceArray_1_91_;BalanceArray[1,91])
            {
            }
            column(BalanceArray_1_92_;BalanceArray[1,92])
            {
            }
            column(BalanceArray_1_93_;BalanceArray[1,93])
            {
            }
            column(BalanceArray_1_94_;BalanceArray[1,94])
            {
            }
            column(BalanceArray_1_95_;BalanceArray[1,95])
            {
            }
            column(BalanceArray_1_96_;BalanceArray[1,96])
            {
            }
            column(BalanceArray_1_97_;BalanceArray[1,97])
            {
            }
            column(BalanceArray_1_98_;BalanceArray[1,98])
            {
            }
            column(BalanceArray_1_99_;BalanceArray[1,99])
            {
            }
            column(BalanceArray_1_100_;BalanceArray[1,100])
            {
            }
            column(CodeArr_1_1;CodeArr[1,1])
            {
            }
            column(CodeArr_1_2;CodeArr[1,2])
            {
            }
            column(CodeArr_1_3;CodeArr[1,3])
            {
            }
            column(CodeArr_1_4;CodeArr[1,4])
            {
            }
            column(CodeArr_1_5;CodeArr[1,5])
            {
            }
            column(CodeArr_1_6;CodeArr[1,6])
            {
            }
            column(CodeArr_1_7;CodeArr[1,7])
            {
            }
            column(CodeArr_1_8;CodeArr[1,8])
            {
            }
            column(CodeArr_1_9;CodeArr[1,9])
            {
            }
            column(CodeArr_1_10;CodeArr[1,10])
            {
            }
            column(CodeArr_1_11;CodeArr[1,11])
            {
            }
            column(CodeArr_1_12;CodeArr[1,12])
            {
            }
            column(CodeArr_1_13;CodeArr[1,13])
            {
            }
            column(CodeArr_1_14;CodeArr[1,14])
            {
            }
            column(CodeArr_1_15;CodeArr[1,15])
            {
            }
            column(CodeArr_1_16;CodeArr[1,16])
            {
            }
            column(CodeArr_1_17;CodeArr[1,17])
            {
            }
            column(CodeArr_1_18;CodeArr[1,18])
            {
            }
            column(CodeArr_1_19;CodeArr[1,19])
            {
            }
            column(CodeArr_1_20;CodeArr[1,20])
            {
            }
            column(CodeArr_1_21;CodeArr[1,21])
            {
            }
            column(CodeArr_1_22;CodeArr[1,22])
            {
            }
            column(CodeArr_1_23;CodeArr[1,23])
            {
            }
            column(CodeArr_1_24;CodeArr[1,24])
            {
            }
            column(CodeArr_1_25;CodeArr[1,25])
            {
            }
            column(CodeArr_1_26;CodeArr[1,26])
            {
            }
            column(CodeArr_1_27;CodeArr[1,27])
            {
            }
            column(CodeArr_1_28;CodeArr[1,28])
            {
            }
            column(CodeArr_1_29;CodeArr[1,29])
            {
            }
            column(CodeArr_1_30;CodeArr[1,30])
            {
            }
            column(CodeArr_1_31;CodeArr[1,31])
            {
            }
            column(CodeArr_1_32;CodeArr[1,32])
            {
            }
            column(CodeArr_1_33;CodeArr[1,33])
            {
            }
            column(CodeArr_1_34;CodeArr[1,34])
            {
            }
            column(CodeArr_1_35;CodeArr[1,35])
            {
            }
            column(CodeArr_1_36;CodeArr[1,36])
            {
            }
            column(CodeArr_1_37;CodeArr[1,37])
            {
            }
            column(CodeArr_1_38;CodeArr[1,38])
            {
            }
            column(CodeArr_1_39;CodeArr[1,39])
            {
            }
            column(CodeArr_1_40;CodeArr[1,40])
            {
            }
            column(CodeArr_1_41;CodeArr[1,41])
            {
            }
            column(CodeArr_1_42;CodeArr[1,42])
            {
            }
            column(CodeArr_1_43;CodeArr[1,43])
            {
            }
            column(CodeArr_1_44;CodeArr[1,44])
            {
            }
            column(CodeArr_1_45;CodeArr[1,45])
            {
            }
            column(CodeArr_1_46;CodeArr[1,46])
            {
            }
            column(CodeArr_1_47;CodeArr[1,47])
            {
            }
            column(CodeArr_1_48;CodeArr[1,48])
            {
            }
            column(CodeArr_1_49;CodeArr[1,49])
            {
            }
            column(CodeArr_1_50;CodeArr[1,50])
            {
            }
            column(CodeArr_1_51;CodeArr[1,51])
            {
            }
            column(CodeArr_1_52;CodeArr[1,52])
            {
            }
            column(CodeArr_1_53;CodeArr[1,53])
            {
            }
            column(CodeArr_1_54;CodeArr[1,54])
            {
            }
            column(CodeArr_1_55;CodeArr[1,55])
            {
            }
            column(CodeArr_1_56;CodeArr[1,56])
            {
            }
            column(CodeArr_1_57;CodeArr[1,57])
            {
            }
            column(CodeArr_1_58;CodeArr[1,58])
            {
            }
            column(CodeArr_1_59;CodeArr[1,59])
            {
            }
            column(CodeArr_1_60;CodeArr[1,60])
            {
            }
            column(CodeArr_1_61;CodeArr[1,61])
            {
            }
            column(CodeArr_1_62;CodeArr[1,62])
            {
            }
            column(CodeArr_1_63;CodeArr[1,63])
            {
            }
            column(CodeArr_1_64;CodeArr[1,64])
            {
            }
            column(CodeArr_1_65;CodeArr[1,65])
            {
            }
            column(CodeArr_1_66;CodeArr[1,66])
            {
            }
            column(CodeArr_1_67;CodeArr[1,67])
            {
            }
            column(CodeArr_1_68;CodeArr[1,68])
            {
            }
            column(CodeArr_1_69;CodeArr[1,69])
            {
            }
            column(CodeArr_1_70;CodeArr[1,70])
            {
            }
            column(CodeArr_1_71;CodeArr[1,71])
            {
            }
            column(CodeArr_1_72;CodeArr[1,72])
            {
            }
            column(CodeArr_1_73;CodeArr[1,73])
            {
            }
            column(CodeArr_1_74;CodeArr[1,74])
            {
            }
            column(CodeArr_1_75;CodeArr[1,75])
            {
            }
            column(CodeArr_1_76;CodeArr[1,76])
            {
            }
            column(CodeArr_1_77;CodeArr[1,77])
            {
            }
            column(CodeArr_1_78;CodeArr[1,78])
            {
            }
            column(CodeArr_1_79;CodeArr[1,79])
            {
            }
            column(CodeArr_1_80;CodeArr[1,80])
            {
            }
            column(CodeArr_1_81;CodeArr[1,81])
            {
            }
            column(CodeArr_1_82;CodeArr[1,82])
            {
            }
            column(CodeArr_1_83;CodeArr[1,83])
            {
            }
            column(CodeArr_1_84;CodeArr[1,84])
            {
            }
            column(CodeArr_1_85;CodeArr[1,85])
            {
            }
            column(CodeArr_1_86;CodeArr[1,86])
            {
            }
            column(CodeArr_1_87;CodeArr[1,87])
            {
            }
            column(CodeArr_1_88;CodeArr[1,88])
            {
            }
            column(CodeArr_1_89;CodeArr[1,89])
            {
            }
            column(CodeArr_1_90;CodeArr[1,90])
            {
            }
            column(CodeArr_1_91;CodeArr[1,91])
            {
            }
            column(CodeArr_1_92;CodeArr[1,92])
            {
            }
            column(CodeArr_1_93;CodeArr[1,93])
            {
            }
            column(CodeArr_1_94;CodeArr[1,94])
            {
            }
            column(CodeArr_1_95;CodeArr[1,95])
            {
            }
            column(CodeArr_1_96;CodeArr[1,96])
            {
            }
            column(CodeArr_1_97;CodeArr[1,97])
            {
            }
            column(CodeArr_1_98;CodeArr[1,98])
            {
            }
            column(CodeArr_1_99;CodeArr[1,99])
            {
            }
            column(CodeArr_1_100;CodeArr[1,100])
            {
            }
            column(CodeArr_1_101;CodeArr[1,101])
            {
            }
            column(CodeArr_1_102;CodeArr[1,102])
            {
            }
            column(CodeArr_1_103;CodeArr[1,103])
            {
            }
            column(CodeArr_1_104;CodeArr[1,104])
            {
            }
            column(CodeArr_1_105;CodeArr[1,105])
            {
            }
            column(CodeArr_1_106;CodeArr[1,106])
            {
            }
            column(CodeArr_1_107;CodeArr[1,107])
            {
            }
            column(CodeArr_1_108;CodeArr[1,108])
            {
            }
            column(CodeArr_1_109;CodeArr[1,109])
            {
            }
            column(CodeArr_1_110;CodeArr[1,110])
            {
            }
            column(CodeArr_1_111;CodeArr[1,111])
            {
            }
            column(CodeArr_1_112;CodeArr[1,112])
            {
            }
            column(CodeArr_1_113;CodeArr[1,113])
            {
            }
            column(CodeArr_1_114;CodeArr[1,114])
            {
            }
            column(CodeArr_1_115;CodeArr[1,115])
            {
            }
            column(CodeArr_1_116;CodeArr[1,116])
            {
            }
            column(CodeArr_1_117;CodeArr[1,117])
            {
            }
            column(CodeArr_1_118;CodeArr[1,118])
            {
            }
            column(CodeArr_1_119;CodeArr[1,119])
            {
            }
            column(CodeArr_1_120;CodeArr[1,120])
            {
            }
            column(CodeArr_1_121;CodeArr[1,121])
            {
            }
            column(CodeArr_1_122;CodeArr[1,122])
            {
            }
            column(CodeArr_1_123;CodeArr[1,123])
            {
            }
            column(CodeArr_1_124;CodeArr[1,124])
            {
            }
            column(CodeArr_1_125;CodeArr[1,125])
            {
            }
            column(CodeArr_1_126;CodeArr[1,126])
            {
            }
            column(CodeArr_1_127;CodeArr[1,127])
            {
            }
            column(CodeArr_1_128;CodeArr[1,128])
            {
            }
            column(CodeArr_1_129;CodeArr[1,129])
            {
            }
            column(CodeArr_1_130;CodeArr[1,130])
            {
            }
            column(CodeArr_1_131;CodeArr[1,131])
            {
            }
            column(CodeArr_1_132;CodeArr[1,132])
            {
            }
            column(CodeArr_1_133;CodeArr[1,133])
            {
            }
            column(CodeArr_1_134;CodeArr[1,134])
            {
            }
            column(CodeArr_1_135;CodeArr[1,135])
            {
            }
            column(CodeArr_1_136;CodeArr[1,136])
            {
            }
            column(CodeArr_1_137;CodeArr[1,137])
            {
            }
            column(CodeArr_1_138;CodeArr[1,138])
            {
            }
            column(CodeArr_1_139;CodeArr[1,139])
            {
            }
            column(CodeArr_1_140;CodeArr[1,140])
            {
            }
            column(CodeArr_1_141;CodeArr[1,141])
            {
            }
            column(CodeArr_1_142;CodeArr[1,142])
            {
            }
            column(CodeArr_1_143;CodeArr[1,143])
            {
            }
            column(CodeArr_1_144;CodeArr[1,144])
            {
            }
            column(CodeArr_1_145;CodeArr[1,145])
            {
            }
            column(CodeArr_1_146;CodeArr[1,146])
            {
            }
            column(CodeArr_1_147;CodeArr[1,147])
            {
            }
            column(CodeArr_1_148;CodeArr[1,148])
            {
            }
            column(CodeArr_1_149;CodeArr[1,149])
            {
            }
            column(CodeArr_1_150;CodeArr[1,150])
            {
            }
            column(CodeArr_1_151;CodeArr[1,151])
            {
            }
            column(CodeArr_1_152;CodeArr[1,152])
            {
            }
            column(CodeArr_1_153;CodeArr[1,153])
            {
            }
            column(CodeArr_1_154;CodeArr[1,154])
            {
            }
            column(CodeArr_1_155;CodeArr[1,155])
            {
            }
            column(CodeArr_1_156;CodeArr[1,156])
            {
            }
            column(CodeArr_1_157;CodeArr[1,157])
            {
            }
            column(CodeArr_1_158;CodeArr[1,158])
            {
            }
            column(CodeArr_1_159;CodeArr[1,159])
            {
            }
            column(CodeArr_1_160;CodeArr[1,160])
            {
            }
            column(CodeArr_1_161;CodeArr[1,161])
            {
            }
            column(CodeArr_1_162;CodeArr[1,162])
            {
            }
            column(CodeArr_1_163;CodeArr[1,163])
            {
            }
            column(CodeArr_1_164;CodeArr[1,164])
            {
            }
            column(CodeArr_1_165;CodeArr[1,165])
            {
            }
            column(CodeArr_1_166;CodeArr[1,166])
            {
            }
            column(CodeArr_1_167;CodeArr[1,167])
            {
            }
            column(CodeArr_1_168;CodeArr[1,168])
            {
            }
            column(CodeArr_1_169;CodeArr[1,169])
            {
            }
            column(CodeArr_1_170;CodeArr[1,170])
            {
            }
            column(CodeArr_1_171;CodeArr[1,171])
            {
            }
            column(CodeArr_1_172;CodeArr[1,172])
            {
            }
            column(CodeArr_1_173;CodeArr[1,173])
            {
            }
            column(CodeArr_1_174;CodeArr[1,174])
            {
            }
            column(CodeArr_1_175;CodeArr[1,175])
            {
            }
            column(CodeArr_1_176;CodeArr[1,176])
            {
            }
            column(CodeArr_1_177;CodeArr[1,177])
            {
            }
            column(CodeArr_1_178;CodeArr[1,178])
            {
            }
            column(CodeArr_1_179;CodeArr[1,179])
            {
            }
            column(CodeArr_1_180;CodeArr[1,180])
            {
            }
            column(CodeArr_1_181;CodeArr[1,181])
            {
            }
            column(CodeArr_1_182;CodeArr[1,182])
            {
            }
            column(CodeArr_1_183;CodeArr[1,183])
            {
            }
            column(CodeArr_1_184;CodeArr[1,184])
            {
            }
            column(CodeArr_1_185;CodeArr[1,185])
            {
            }
            column(CodeArr_1_186;CodeArr[1,186])
            {
            }
            column(CodeArr_1_187;CodeArr[1,187])
            {
            }
            column(CodeArr_1_188;CodeArr[1,188])
            {
            }
            column(CodeArr_1_189;CodeArr[1,189])
            {
            }
            column(CodeArr_1_190;CodeArr[1,190])
            {
            }
            column(CodeArr_1_191;CodeArr[1,191])
            {
            }
            column(CodeArr_1_192;CodeArr[1,192])
            {
            }
            column(CodeArr_1_193;CodeArr[1,193])
            {
            }
            column(CodeArr_1_194;CodeArr[1,194])
            {
            }
            column(CodeArr_1_195;CodeArr[1,195])
            {
            }
            column(CodeArr_1_196;CodeArr[1,196])
            {
            }
            column(CodeArr_1_197;CodeArr[1,197])
            {
            }
            column(CodeArr_1_198;CodeArr[1,198])
            {
            }
            column(CodeArr_1_199;CodeArr[1,199])
            {
            }
            column(CodeArr_1_200;CodeArr[1,200])
            {
            }
            column(CodeArr_1_201;CodeArr[1,201])
            {
            }
            column(CodeArr_1_202;CodeArr[1,202])
            {
            }
            column(CodeArr_1_203;CodeArr[1,203])
            {
            }
            column(CodeArr_1_204;CodeArr[1,204])
            {
            }
            column(CodeArr_1_205;CodeArr[1,205])
            {
            }
            column(CodeArr_1_206;CodeArr[1,206])
            {
            }
            column(CodeArr_1_207;CodeArr[1,207])
            {
            }
            column(CodeArr_1_208;CodeArr[1,208])
            {
            }
            column(CodeArr_1_209;CodeArr[1,209])
            {
            }
            column(CodeArr_1_210;CodeArr[1,210])
            {
            }
            column(CodeArr_1_211;CodeArr[1,211])
            {
            }
            column(CodeArr_1_212;CodeArr[1,212])
            {
            }
            column(CodeArr_1_213;CodeArr[1,213])
            {
            }
            column(CodeArr_1_214;CodeArr[1,214])
            {
            }
            column(CodeArr_1_215;CodeArr[1,215])
            {
            }
            column(CodeArr_1_216;CodeArr[1,216])
            {
            }
            column(CodeArr_1_217;CodeArr[1,217])
            {
            }
            column(CodeArr_1_218;CodeArr[1,218])
            {
            }
            column(CodeArr_1_219;CodeArr[1,219])
            {
            }
            column(CodeArr_1_220;CodeArr[1,220])
            {
            }
            column(BalanceArray_1_101_;BalanceArray[1,101])
            {
            }
            column(BalanceArray_1_102_;BalanceArray[1,102])
            {
            }
            column(BalanceArray_1_103_;BalanceArray[1,103])
            {
            }
            column(BalanceArray_1_104_;BalanceArray[1,104])
            {
            }
            column(BalanceArray_1_105_;BalanceArray[1,105])
            {
            }
            column(BalanceArray_1_106_;BalanceArray[1,106])
            {
            }
            column(BalanceArray_1_107_;BalanceArray[1,107])
            {
            }
            column(BalanceArray_1_108_;BalanceArray[1,108])
            {
            }
            column(BalanceArray_1_109_;BalanceArray[1,109])
            {
            }
            column(BalanceArray_1_110_;BalanceArray[1,110])
            {
            }
            column(BalanceArray_1_111_;BalanceArray[1,111])
            {
            }
            column(BalanceArray_1_112_;BalanceArray[1,112])
            {
            }
            column(BalanceArray_1_113_;BalanceArray[1,113])
            {
            }
            column(BalanceArray_1_114_;BalanceArray[1,114])
            {
            }
            column(BalanceArray_1_115_;BalanceArray[1,115])
            {
            }
            column(BalanceArray_1_116_;BalanceArray[1,116])
            {
            }
            column(BalanceArray_1_117_;BalanceArray[1,116])
            {
            }
            column(BalanceArray_1_118_;BalanceArray[1,118])
            {
            }
            column(BalanceArray_1_119_;BalanceArray[1,119])
            {
            }
            column(BalanceArray_1_120_;BalanceArray[1,120])
            {
            }
            column(BalanceArray_1_121_;BalanceArray[1,121])
            {
            }
            column(BalanceArray_1_122_;BalanceArray[1,122])
            {
            }
            column(BalanceArray_1_123_;BalanceArray[1,123])
            {
            }
            column(BalanceArray_1_124_;BalanceArray[1,124])
            {
            }
            column(BalanceArray_1_125_;BalanceArray[1,125])
            {
            }
            column(BalanceArray_1_126_;BalanceArray[1,126])
            {
            }
            column(BalanceArray_1_127_;BalanceArray[1,127])
            {
            }
            column(BalanceArray_1_128_;BalanceArray[1,128])
            {
            }
            column(BalanceArray_1_129_;BalanceArray[1,129])
            {
            }
            column(BalanceArray_1_130_;BalanceArray[1,130])
            {
            }
            column(BalanceArray_1_131_;BalanceArray[1,131])
            {
            }
            column(BalanceArray_1_132_;BalanceArray[1,132])
            {
            }
            column(BalanceArray_1_133_;BalanceArray[1,133])
            {
            }
            column(BalanceArray_1_134_;BalanceArray[1,134])
            {
            }
            column(BalanceArray_1_135_;BalanceArray[1,135])
            {
            }
            column(BalanceArray_1_136_;BalanceArray[1,136])
            {
            }
            column(BalanceArray_1_137_;BalanceArray[1,137])
            {
            }
            column(BalanceArray_1_138_;BalanceArray[1,138])
            {
            }
            column(BalanceArray_1_139_;BalanceArray[1,139])
            {
            }
            column(BalanceArray_1_140_;BalanceArray[1,140])
            {
            }
            column(BalanceArray_1_141_;BalanceArray[1,141])
            {
            }
            column(BalanceArray_1_142_;BalanceArray[1,142])
            {
            }
            column(BalanceArray_1_143_;BalanceArray[1,143])
            {
            }
            column(BalanceArray_1_144_;BalanceArray[1,144])
            {
            }
            column(BalanceArray_1_145_;BalanceArray[1,145])
            {
            }
            column(BalanceArray_1_146_;BalanceArray[1,146])
            {
            }
            column(BalanceArray_1_147_;BalanceArray[1,147])
            {
            }
            column(BalanceArray_1_148_;BalanceArray[1,148])
            {
            }
            column(BalanceArray_1_149_;BalanceArray[1,149])
            {
            }
            column(BalanceArray_1_150_;BalanceArray[1,150])
            {
            }
            column(BalanceArray_1_151_;BalanceArray[1,151])
            {
            }
            column(BalanceArray_1_152_;BalanceArray[1,152])
            {
            }
            column(BalanceArray_1_153_;BalanceArray[1,153])
            {
            }
            column(BalanceArray_1_154_;BalanceArray[1,154])
            {
            }
            column(BalanceArray_1_155_;BalanceArray[1,155])
            {
            }
            column(BalanceArray_1_156_;BalanceArray[1,156])
            {
            }
            column(BalanceArray_1_157_;BalanceArray[1,157])
            {
            }
            column(BalanceArray_1_158_;BalanceArray[1,158])
            {
            }
            column(BalanceArray_1_159_;BalanceArray[1,159])
            {
            }
            column(BalanceArray_1_160_;BalanceArray[1,160])
            {
            }
            column(BalanceArray_1_161_;BalanceArray[1,161])
            {
            }
            column(BalanceArray_1_162_;BalanceArray[1,162])
            {
            }
            column(BalanceArray_1_163_;BalanceArray[1,163])
            {
            }
            column(BalanceArray_1_164_;BalanceArray[1,164])
            {
            }
            column(BalanceArray_1_165_;BalanceArray[1,165])
            {
            }
            column(BalanceArray_1_166_;BalanceArray[1,166])
            {
            }
            column(BalanceArray_1_167_;BalanceArray[1,167])
            {
            }
            column(BalanceArray_1_168_;BalanceArray[1,168])
            {
            }
            column(BalanceArray_1_169_;BalanceArray[1,169])
            {
            }
            column(BalanceArray_1_170_;BalanceArray[1,170])
            {
            }
            column(BalanceArray_1_171_;BalanceArray[1,171])
            {
            }
            column(BalanceArray_1_172_;BalanceArray[1,172])
            {
            }
            column(BalanceArray_1_173_;BalanceArray[1,173])
            {
            }
            column(BalanceArray_1_174_;BalanceArray[1,174])
            {
            }
            column(BalanceArray_1_175_;BalanceArray[1,175])
            {
            }
            column(BalanceArray_1_176_;BalanceArray[1,176])
            {
            }
            column(BalanceArray_1_177_;BalanceArray[1,177])
            {
            }
            column(BalanceArray_1_178_;BalanceArray[1,178])
            {
            }
            column(BalanceArray_1_179_;BalanceArray[1,179])
            {
            }
            column(BalanceArray_1_180_;BalanceArray[1,180])
            {
            }
            column(BalanceArray_1_181_;BalanceArray[1,181])
            {
            }
            column(BalanceArray_1_182_;BalanceArray[1,182])
            {
            }
            column(BalanceArray_1_183_;BalanceArray[1,183])
            {
            }
            column(BalanceArray_1_184_;BalanceArray[1,184])
            {
            }
            column(BalanceArray_1_185_;BalanceArray[1,185])
            {
            }
            column(BalanceArray_1_186_;BalanceArray[1,186])
            {
            }
            column(BalanceArray_1_187_;BalanceArray[1,187])
            {
            }
            column(BalanceArray_1_188_;BalanceArray[1,188])
            {
            }
            column(BalanceArray_1_189_;BalanceArray[1,189])
            {
            }
            column(BalanceArray_1_190_;BalanceArray[1,190])
            {
            }
            column(BalanceArray_1_191_;BalanceArray[1,191])
            {
            }
            column(BalanceArray_1_192_;BalanceArray[1,192])
            {
            }
            column(BalanceArray_1_193_;BalanceArray[1,193])
            {
            }
            column(BalanceArray_1_194_;BalanceArray[1,194])
            {
            }
            column(BalanceArray_1_195_;BalanceArray[1,195])
            {
            }
            column(BalanceArray_1_196_;BalanceArray[1,196])
            {
            }
            column(BalanceArray_1_197_;BalanceArray[1,197])
            {
            }
            column(BalanceArray_1_198_;BalanceArray[1,198])
            {
            }
            column(BalanceArray_1_199_;BalanceArray[1,199])
            {
            }
            column(BalanceArray_1_200_;BalanceArray[1,200])
            {
            }
            column(BalanceArray_1_201_;BalanceArray[1,201])
            {
            }
            column(BalanceArray_1_202_;BalanceArray[1,202])
            {
            }
            column(BalanceArray_1_203_;BalanceArray[1,203])
            {
            }
            column(BalanceArray_1_204_;BalanceArray[1,204])
            {
            }
            column(BalanceArray_1_205_;BalanceArray[1,205])
            {
            }
            column(BalanceArray_1_206_;BalanceArray[1,206])
            {
            }
            column(BalanceArray_1_207_;BalanceArray[1,207])
            {
            }
            column(BalanceArray_1_208_;BalanceArray[1,208])
            {
            }
            column(BalanceArray_1_209_;BalanceArray[1,209])
            {
            }
            column(BalanceArray_1_210_;BalanceArray[1,210])
            {
            }
            column(BalanceArray_1_211_;BalanceArray[1,211])
            {
            }
            column(BalanceArray_1_212_;BalanceArray[1,212])
            {
            }
            column(BalanceArray_1_213_;BalanceArray[1,213])
            {
            }
            column(BalanceArray_1_214_;BalanceArray[1,214])
            {
            }
            column(BalanceArray_1_215_;BalanceArray[1,215])
            {
            }
            column(BalanceArray_1_216_;BalanceArray[1,216])
            {
            }
            column(BalanceArray_1_217_;BalanceArray[1,217])
            {
            }
            column(BalanceArray_1_218_;BalanceArray[1,218])
            {
            }
            column(BalanceArray_1_219_;BalanceArray[1,219])
            {
            }
            column(BalanceArray_1_220_;BalanceArray[1,220])
            {
            }
            column(ArrEarningsAmt_1_101_;ArrEarningsAmt[1,101])
            {
            }
            column(ArrEarningsAmt_1_102_;ArrEarningsAmt[1,102])
            {
            }
            column(ArrEarningsAmt_1_103_;ArrEarningsAmt[1,103])
            {
            }
            column(ArrEarningsAmt_1_104_;ArrEarningsAmt[1,104])
            {
            }
            column(ArrEarningsAmt_1_105_;ArrEarningsAmt[1,105])
            {
            }
            column(ArrEarningsAmt_1_106_;ArrEarningsAmt[1,106])
            {
            }
            column(ArrEarningsAmt_1_107_;ArrEarningsAmt[1,107])
            {
            }
            column(ArrEarningsAmt_1_108_;ArrEarningsAmt[1,108])
            {
            }
            column(ArrEarningsAmt_1_109_;ArrEarningsAmt[1,109])
            {
            }
            column(ArrEarningsAmt_1_110_;ArrEarningsAmt[1,110])
            {
            }
            column(ArrEarningsAmt_1_111_;ArrEarningsAmt[1,111])
            {
            }
            column(ArrEarningsAmt_1_112_;ArrEarningsAmt[1,112])
            {
            }
            column(ArrEarningsAmt_1_113_;ArrEarningsAmt[1,113])
            {
            }
            column(ArrEarningsAmt_1_114_;ArrEarningsAmt[1,114])
            {
            }
            column(ArrEarningsAmt_1_115_;ArrEarningsAmt[1,115])
            {
            }
            column(ArrEarningsAmt_1_116_;ArrEarningsAmt[1,116])
            {
            }
            column(ArrEarningsAmt_1_117_;ArrEarningsAmt[1,117])
            {
            }
            column(ArrEarningsAmt_1_118_;ArrEarningsAmt[1,118])
            {
            }
            column(ArrEarningsAmt_1_119_;ArrEarningsAmt[1,119])
            {
            }
            column(ArrEarningsAmt_1_120_;ArrEarningsAmt[1,120])
            {
            }
            column(ArrEarningsAmt_1_121_;ArrEarningsAmt[1,121])
            {
            }
            column(ArrEarningsAmt_1_122_;ArrEarningsAmt[1,122])
            {
            }
            column(ArrEarningsAmt_1_123_;ArrEarningsAmt[1,123])
            {
            }
            column(ArrEarningsAmt_1_124_;ArrEarningsAmt[1,124])
            {
            }
            column(ArrEarningsAmt_1_125_;ArrEarningsAmt[1,125])
            {
            }
            column(ArrEarningsAmt_1_126_;ArrEarningsAmt[1,126])
            {
            }
            column(ArrEarningsAmt_1_127_;ArrEarningsAmt[1,127])
            {
            }
            column(ArrEarningsAmt_1_128_;ArrEarningsAmt[1,128])
            {
            }
            column(ArrEarningsAmt_1_129_;ArrEarningsAmt[1,129])
            {
            }
            column(ArrEarningsAmt_1_130_;ArrEarningsAmt[1,130])
            {
            }
            column(ArrEarningsAmt_1_131_;ArrEarningsAmt[1,131])
            {
            }
            column(ArrEarningsAmt_1_132_;ArrEarningsAmt[1,132])
            {
            }
            column(ArrEarningsAmt_1_133_;ArrEarningsAmt[1,133])
            {
            }
            column(ArrEarningsAmt_1_134_;ArrEarningsAmt[1,134])
            {
            }
            column(ArrEarningsAmt_1_135_;ArrEarningsAmt[1,135])
            {
            }
            column(ArrEarningsAmt_1_136_;ArrEarningsAmt[1,136])
            {
            }
            column(ArrEarningsAmt_1_137_;ArrEarningsAmt[1,137])
            {
            }
            column(ArrEarningsAmt_1_138_;ArrEarningsAmt[1,138])
            {
            }
            column(ArrEarningsAmt_1_139_;ArrEarningsAmt[1,139])
            {
            }
            column(ArrEarningsAmt_1_140_;ArrEarningsAmt[1,140])
            {
            }
            column(ArrEarningsAmt_1_141_;ArrEarningsAmt[1,141])
            {
            }
            column(ArrEarningsAmt_1_142_;ArrEarningsAmt[1,142])
            {
            }
            column(ArrEarningsAmt_1_143_;ArrEarningsAmt[1,143])
            {
            }
            column(ArrEarningsAmt_1_144_;ArrEarningsAmt[1,144])
            {
            }
            column(ArrEarningsAmt_1_145_;ArrEarningsAmt[1,145])
            {
            }
            column(ArrEarningsAmt_1_146_;ArrEarningsAmt[1,146])
            {
            }
            column(ArrEarningsAmt_1_147_;ArrEarningsAmt[1,147])
            {
            }
            column(ArrEarningsAmt_1_148_;ArrEarningsAmt[1,148])
            {
            }
            column(ArrEarningsAmt_1_149_;ArrEarningsAmt[1,149])
            {
            }
            column(ArrEarningsAmt_1_150_;ArrEarningsAmt[1,150])
            {
            }
            column(ArrEarningsAmt_1_151_;ArrEarningsAmt[1,151])
            {
            }
            column(ArrEarningsAmt_1_152_;ArrEarningsAmt[1,152])
            {
            }
            column(ArrEarningsAmt_1_153_;ArrEarningsAmt[1,153])
            {
            }
            column(ArrEarningsAmt_1_154_;ArrEarningsAmt[1,154])
            {
            }
            column(ArrEarningsAmt_1_155_;ArrEarningsAmt[1,155])
            {
            }
            column(ArrEarningsAmt_1_156_;ArrEarningsAmt[1,156])
            {
            }
            column(ArrEarningsAmt_1_157_;ArrEarningsAmt[1,157])
            {
            }
            column(ArrEarningsAmt_1_158_;ArrEarningsAmt[1,158])
            {
            }
            column(ArrEarningsAmt_1_159_;ArrEarningsAmt[1,159])
            {
            }
            column(ArrEarningsAmt_1_160_;ArrEarningsAmt[1,160])
            {
            }
            column(ArrEarningsAmt_1_161_;ArrEarningsAmt[1,161])
            {
            }
            column(ArrEarningsAmt_1_162_;ArrEarningsAmt[1,162])
            {
            }
            column(ArrEarningsAmt_1_163_;ArrEarningsAmt[1,163])
            {
            }
            column(ArrEarningsAmt_1_164_;ArrEarningsAmt[1,164])
            {
            }
            column(ArrEarningsAmt_1_165_;ArrEarningsAmt[1,165])
            {
            }
            column(ArrEarningsAmt_1_166_;ArrEarningsAmt[1,166])
            {
            }
            column(ArrEarningsAmt_1_167_;ArrEarningsAmt[1,167])
            {
            }
            column(ArrEarningsAmt_1_168_;ArrEarningsAmt[1,168])
            {
            }
            column(ArrEarningsAmt_1_169_;ArrEarningsAmt[1,169])
            {
            }
            column(ArrEarningsAmt_1_170_;ArrEarningsAmt[1,170])
            {
            }
            column(ArrEarningsAmt_1_171_;ArrEarningsAmt[1,171])
            {
            }
            column(ArrEarningsAmt_1_172_;ArrEarningsAmt[1,172])
            {
            }
            column(ArrEarningsAmt_1_173_;ArrEarningsAmt[1,173])
            {
            }
            column(ArrEarningsAmt_1_174_;ArrEarningsAmt[1,174])
            {
            }
            column(ArrEarningsAmt_1_175_;ArrEarningsAmt[1,175])
            {
            }
            column(ArrEarningsAmt_1_176_;ArrEarningsAmt[1,176])
            {
            }
            column(ArrEarningsAmt_1_177_;ArrEarningsAmt[1,177])
            {
            }
            column(ArrEarningsAmt_1_178_;ArrEarningsAmt[1,178])
            {
            }
            column(ArrEarningsAmt_1_179_;ArrEarningsAmt[1,179])
            {
            }
            column(ArrEarningsAmt_1_180_;ArrEarningsAmt[1,180])
            {
            }
            column(ArrEarningsAmt_1_181_;ArrEarningsAmt[1,181])
            {
            }
            column(ArrEarningsAmt_1_182_;ArrEarningsAmt[1,182])
            {
            }
            column(ArrEarningsAmt_1_183_;ArrEarningsAmt[1,183])
            {
            }
            column(ArrEarningsAmt_1_184_;ArrEarningsAmt[1,184])
            {
            }
            column(ArrEarningsAmt_1_185_;ArrEarningsAmt[1,185])
            {
            }
            column(ArrEarningsAmt_1_186_;ArrEarningsAmt[1,186])
            {
            }
            column(ArrEarningsAmt_1_187_;ArrEarningsAmt[1,187])
            {
            }
            column(ArrEarningsAmt_1_188_;ArrEarningsAmt[1,188])
            {
            }
            column(ArrEarningsAmt_1_189_;ArrEarningsAmt[1,189])
            {
            }
            column(ArrEarningsAmt_1_190_;ArrEarningsAmt[1,190])
            {
            }
            column(ArrEarningsAmt_1_191_;ArrEarningsAmt[1,191])
            {
            }
            column(ArrEarningsAmt_1_192_;ArrEarningsAmt[1,192])
            {
            }
            column(ArrEarningsAmt_1_193_;ArrEarningsAmt[1,193])
            {
            }
            column(ArrEarningsAmt_1_194_;ArrEarningsAmt[1,194])
            {
            }
            column(ArrEarningsAmt_1_195_;ArrEarningsAmt[1,195])
            {
            }
            column(ArrEarningsAmt_1_196_;ArrEarningsAmt[1,196])
            {
            }
            column(ArrEarningsAmt_1_197_;ArrEarningsAmt[1,197])
            {
            }
            column(ArrEarningsAmt_1_198_;ArrEarningsAmt[1,198])
            {
            }
            column(ArrEarningsAmt_1_199_;ArrEarningsAmt[1,199])
            {
            }
            column(ArrEarningsAmt_1_200_;ArrEarningsAmt[1,200])
            {
            }
            column(ArrEarningsAmt_1_201_;ArrEarningsAmt[1,201])
            {
            }
            column(ArrEarningsAmt_1_202_;ArrEarningsAmt[1,202])
            {
            }
            column(ArrEarningsAmt_1_203_;ArrEarningsAmt[1,203])
            {
            }
            column(ArrEarningsAmt_1_204_;ArrEarningsAmt[1,204])
            {
            }
            column(ArrEarningsAmt_1_205_;ArrEarningsAmt[1,205])
            {
            }
            column(ArrEarningsAmt_1_206_;ArrEarningsAmt[1,206])
            {
            }
            column(ArrEarningsAmt_1_207_;ArrEarningsAmt[1,207])
            {
            }
            column(ArrEarningsAmt_1_208_;ArrEarningsAmt[1,208])
            {
            }
            column(ArrEarningsAmt_1_209_;ArrEarningsAmt[1,209])
            {
            }
            column(ArrEarningsAmt_1_210_;ArrEarningsAmt[1,210])
            {
            }
            column(ArrEarningsAmt_1_211_;ArrEarningsAmt[1,211])
            {
            }
            column(ArrEarningsAmt_1_212_;ArrEarningsAmt[1,212])
            {
            }
            column(ArrEarningsAmt_1_213_;ArrEarningsAmt[1,213])
            {
            }
            column(ArrEarningsAmt_1_214_;ArrEarningsAmt[1,214])
            {
            }
            column(ArrEarningsAmt_1_215_;ArrEarningsAmt[1,215])
            {
            }
            column(ArrEarningsAmt_1_216_;ArrEarningsAmt[1,216])
            {
            }
            column(ArrEarningsAmt_1_217_;ArrEarningsAmt[1,217])
            {
            }
            column(ArrEarningsAmt_1_218_;ArrEarningsAmt[1,218])
            {
            }
            column(ArrEarningsAmt_1_219_;ArrEarningsAmt[1,219])
            {
            }
            column(ArrEarningsAmt_1_220_;ArrEarningsAmt[1,220])
            {
            }
            column(ArrEarnings_1_111_;ArrEarnings[1,111])
            {
            }
            column(ArrEarnings_1_112_;ArrEarnings[1,112])
            {
            }
            column(ArrEarnings_1_113_;ArrEarnings[1,113])
            {
            }
            column(ArrEarnings_1_114_;ArrEarnings[1,114])
            {
            }
            column(ArrEarnings_1_115_;ArrEarnings[1,115])
            {
            }
            column(ArrEarnings_1_116_;ArrEarnings[1,116])
            {
            }
            column(ArrEarnings_1_117_;ArrEarnings[1,117])
            {
            }
            column(ArrEarnings_1_118_;ArrEarnings[1,118])
            {
            }
            column(ArrEarnings_1_119_;ArrEarnings[1,119])
            {
            }
            column(ArrEarnings_1_120_;ArrEarnings[1,120])
            {
            }
            column(ArrEarnings_1_121_;ArrEarnings[1,121])
            {
            }
            column(ArrEarnings_1_122_;ArrEarnings[1,122])
            {
            }
            column(ArrEarnings_1_123_;ArrEarnings[1,123])
            {
            }
            column(ArrEarnings_1_124_;ArrEarnings[1,124])
            {
            }
            column(ArrEarnings_1_125_;ArrEarnings[1,125])
            {
            }
            column(ArrEarnings_1_126_;ArrEarnings[1,126])
            {
            }
            column(ArrEarnings_1_127_;ArrEarnings[1,127])
            {
            }
            column(ArrEarnings_1_128_;ArrEarnings[1,128])
            {
            }
            column(ArrEarnings_1_129_;ArrEarnings[1,129])
            {
            }
            column(ArrEarnings_1_130_;ArrEarnings[1,130])
            {
            }
            column(ArrEarnings_1_131_;ArrEarnings[1,131])
            {
            }
            column(ArrEarnings_1_132_;ArrEarnings[1,132])
            {
            }
            column(ArrEarnings_1_133_;ArrEarnings[1,133])
            {
            }
            column(ArrEarnings_1_134_;ArrEarnings[1,134])
            {
            }
            column(ArrEarnings_1_135_;ArrEarnings[1,135])
            {
            }
            column(ArrEarnings_1_136_;ArrEarnings[1,136])
            {
            }
            column(ArrEarnings_1_137_;ArrEarnings[1,137])
            {
            }
            column(ArrEarnings_1_138_;ArrEarnings[1,138])
            {
            }
            column(ArrEarnings_1_139_;ArrEarnings[1,139])
            {
            }
            column(ArrEarnings_1_140_;ArrEarnings[1,140])
            {
            }
            column(ArrEarnings_1_141_;ArrEarnings[1,141])
            {
            }
            column(ArrEarnings_1_142_;ArrEarnings[1,142])
            {
            }
            column(ArrEarnings_1_143_;ArrEarnings[1,143])
            {
            }
            column(ArrEarnings_1_144_;ArrEarnings[1,144])
            {
            }
            column(ArrEarnings_1_145_;ArrEarnings[1,145])
            {
            }
            column(ArrEarnings_1_146_;ArrEarnings[1,146])
            {
            }
            column(ArrEarnings_1_147_;ArrEarnings[1,147])
            {
            }
            column(ArrEarnings_1_148_;ArrEarnings[1,148])
            {
            }
            column(ArrEarnings_1_149_;ArrEarnings[1,149])
            {
            }
            column(ArrEarnings_1_150_;ArrEarnings[1,150])
            {
            }
            column(ArrEarnings_1_151_;ArrEarnings[1,151])
            {
            }
            column(ArrEarnings_1_152_;ArrEarnings[1,152])
            {
            }
            column(ArrEarnings_1_153_;ArrEarnings[1,153])
            {
            }
            column(ArrEarnings_1_154_;ArrEarnings[1,154])
            {
            }
            column(ArrEarnings_1_155_;ArrEarnings[1,155])
            {
            }
            column(ArrEarnings_1_156_;ArrEarnings[1,156])
            {
            }
            column(ArrEarnings_1_157_;ArrEarnings[1,157])
            {
            }
            column(ArrEarnings_1_158_;ArrEarnings[1,158])
            {
            }
            column(ArrEarnings_1_159_;ArrEarnings[1,159])
            {
            }
            column(ArrEarnings_1_160_;ArrEarnings[1,160])
            {
            }
            column(ArrEarnings_1_161_;ArrEarnings[1,161])
            {
            }
            column(ArrEarnings_1_162_;ArrEarnings[1,162])
            {
            }
            column(ArrEarnings_1_163_;ArrEarnings[1,163])
            {
            }
            column(ArrEarnings_1_164_;ArrEarnings[1,164])
            {
            }
            column(ArrEarnings_1_165_;ArrEarnings[1,165])
            {
            }
            column(ArrEarnings_1_166_;ArrEarnings[1,166])
            {
            }
            column(ArrEarnings_1_167_;ArrEarnings[1,167])
            {
            }
            column(ArrEarnings_1_168_;ArrEarnings[1,168])
            {
            }
            column(ArrEarnings_1_169_;ArrEarnings[1,169])
            {
            }
            column(ArrEarnings_1_170_;ArrEarnings[1,170])
            {
            }
            column(ArrEarnings_1_171_;ArrEarnings[1,171])
            {
            }
            column(ArrEarnings_1_172_;ArrEarnings[1,172])
            {
            }
            column(ArrEarnings_1_173_;ArrEarnings[1,173])
            {
            }
            column(ArrEarnings_1_174_;ArrEarnings[1,174])
            {
            }
            column(ArrEarnings_1_175_;ArrEarnings[1,175])
            {
            }
            column(ArrEarnings_1_176_;ArrEarnings[1,176])
            {
            }
            column(ArrEarnings_1_177_;ArrEarnings[1,177])
            {
            }
            column(ArrEarnings_1_178_;ArrEarnings[1,178])
            {
            }
            column(ArrEarnings_1_179_;ArrEarnings[1,179])
            {
            }
            column(ArrEarnings_1_180_;ArrEarnings[1,180])
            {
            }
            column(ArrEarnings_1_181_;ArrEarnings[1,181])
            {
            }
            column(ArrEarnings_1_182_;ArrEarnings[1,182])
            {
            }
            column(ArrEarnings_1_183_;ArrEarnings[1,183])
            {
            }
            column(ArrEarnings_1_184_;ArrEarnings[1,184])
            {
            }
            column(ArrEarnings_1_185_;ArrEarnings[1,185])
            {
            }
            column(ArrEarnings_1_186_;ArrEarnings[1,186])
            {
            }
            column(ArrEarnings_1_187_;ArrEarnings[1,187])
            {
            }
            column(ArrEarnings_1_188_;ArrEarnings[1,188])
            {
            }
            column(ArrEarnings_1_189_;ArrEarnings[1,189])
            {
            }
            column(ArrEarnings_1_190_;ArrEarnings[1,190])
            {
            }
            column(ArrEarnings_1_191_;ArrEarnings[1,191])
            {
            }
            column(ArrEarnings_1_192_;ArrEarnings[1,192])
            {
            }
            column(ArrEarnings_1_193_;ArrEarnings[1,193])
            {
            }
            column(ArrEarnings_1_194_;ArrEarnings[1,194])
            {
            }
            column(ArrEarnings_1_195_;ArrEarnings[1,195])
            {
            }
            column(ArrEarnings_1_196_;ArrEarnings[1,196])
            {
            }
            column(ArrEarnings_1_197_;ArrEarnings[1,197])
            {
            }
            column(ArrEarnings_1_198_;ArrEarnings[1,198])
            {
            }
            column(ArrEarnings_1_199_;ArrEarnings[1,199])
            {
            }
            column(ArrEarnings_1_200_;ArrEarnings[1,200])
            {
            }
            column(ArrEarnings_1_201_;ArrEarnings[1,201])
            {
            }
            column(ArrEarnings_1_202_;ArrEarnings[1,202])
            {
            }
            column(ArrEarnings_1_203_;ArrEarnings[1,203])
            {
            }
            column(ArrEarnings_1_204_;ArrEarnings[1,204])
            {
            }
            column(ArrEarnings_1_205_;ArrEarnings[1,205])
            {
            }
            column(ArrEarnings_1_206_;ArrEarnings[1,206])
            {
            }
            column(ArrEarnings_1_207_;ArrEarnings[1,207])
            {
            }
            column(ArrEarnings_1_208_;ArrEarnings[1,208])
            {
            }
            column(ArrEarnings_1_209_;ArrEarnings[1,209])
            {
            }
            column(ArrEarnings_1_210_;ArrEarnings[1,210])
            {
            }
            column(ArrEarnings_1_211_;ArrEarnings[1,211])
            {
            }
            column(ArrEarnings_1_212;ArrEarnings[1,212])
            {
            }
            column(ArrEarnings_1_213_;ArrEarnings[1,213])
            {
            }
            column(ArrEarnings_1_214_;ArrEarnings[1,214])
            {
            }
            column(ArrEarnings_1_215_;ArrEarnings[1,215])
            {
            }
            column(ArrEarnings_1_216_;ArrEarnings[1,216])
            {
            }
            column(ArrEarnings_1_217_;ArrEarnings[1,217])
            {
            }
            column(ArrEarnings_1_218_;ArrEarnings[1,218])
            {
            }
            column(ArrEarnings_1_219_;ArrEarnings[1,219])
            {
            }
            column(ArrEarnings_1_220_;ArrEarnings[1,220])
            {
            }
            column(CoRecPicture;CoRec.Picture)
            {
            }

            trigger OnAfterGetRecord();
            var
                loanType : Record "Loan Product Type";
                RepSchedule : Record "Repayment Schedule";
                payefirst : Decimal;
                emprec7 : Record Employee;
            begin
                
                 CLEAR(Addr);
                 CLEAR(DeptArr);
                 CLEAR(BasicPay);
                 CLEAR(EmpArray);
                 CLEAR(ArrEarnings);
                 CLEAR(ArrEarningsAmt);
                 CLEAR(BalanceArray);
                 GrossPay:=0;
                 TotalDeduction:=0;
                 Totalcoopshares:=0;
                 Totalnssf:=0;
                 LoanBalance:=0;
                 NetPay:=0;
                
                
                Emp.RESET;
                Emp.SETRANGE(Emp.Status,Emp.Status::Active);
                EmpCount:=Emp.COUNT;
                
                // Get Basic Salary
                Earn.RESET;
                Earn.SETRANGE(Earn."Basic Salary Code",true);
                Earn.SETRANGE(Earn."Applies to All",true);
                Earn.SETRANGE(Earn.Board,false);
                if Earn.FIND('-') then
                begin
                  AssignMatrix.RESET;
                  AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                  AssignMatrix.SETRANGE(AssignMatrix.Type,AssignMatrix.Type::Payment);
                  AssignMatrix.SETRANGE(AssignMatrix.Code,Earn.Code);
                 // AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                 // IF AssignMatrix.FIND('-') THEN
                    EmpCount:=AssignMatrix.COUNT;
                end;
                
                Earn.RESET;
                Earn.SETRANGE(Earn."Basic Salary Code",true);
                Earn.SETRANGE(Earn."Applies to All",false);
                Earn.SETRANGE(Earn.Board,false);
                if Earn.FIND('-') then
                begin
                  AssignMatrix.RESET;
                  AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                  AssignMatrix.SETRANGE(AssignMatrix.Type,AssignMatrix.Type::Payment);
                  AssignMatrix.SETRANGE(AssignMatrix.Code,Earn.Code);
                 // AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                 // IF AssignMatrix.FIND('-') THEN
                    CMFIUCount:=AssignMatrix.COUNT;
                end;
                
                Earn.RESET;
                //Earn.SETRANGE(Earn."Basic Salary Code",TRUE);
                Earn.SETRANGE(Earn."Applies to All",false);
                Earn.SETRANGE(Earn.Board,false);
                //Earn.SETRANGE(Earn."Temporary",TRUE);
                if Earn.FIND('-') then
                begin
                  AssignMatrix.RESET;
                  AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                  AssignMatrix.SETRANGE(AssignMatrix.Type,AssignMatrix.Type::Payment);
                  AssignMatrix.SETRANGE(AssignMatrix.Code,Earn.Code);
                 // AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                 // IF AssignMatrix.FIND('-') THEN
                    TempEmpCount:=AssignMatrix.COUNT;
                end;
                
                
                
                i:=1;
                Earn.RESET;
                Earn.SETRANGE(Earn."Earning Type",Earn."Earning Type"::"Normal Earning");
                Earn.SETRANGE(Earn."Non-Cash Benefit",false);
                Earn.SETRANGE(Earn.Board,false);
                Earn.ASCENDING(true);
                
                if Earn.FIND('-') then begin
                 repeat
                  AssignMatrix.RESET;
                  AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                  AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                  //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                 // AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",FALSE);
                  AssignMatrix.SETRANGE(Code,Earn.Code);
                                                              /*
                                                                  //====================================================================
                                                                  IF Employee.GETFILTER(Employee."Employee's Bank")<>'' THEN BEGIN
                                                                     //MESSAGE('Mite...');
                                                                     emprec7.RESET;
                                                                     emprec7.SETFILTER(emprec7."Employee's Bank",Employee."Employee's Bank");
                                                                     emprec7.SETFILTER(emprec7."No.",AssignMatrix."Employee No");
                                                                     IF emprec7.FINDSET THEN BEGIN
                                                                       // MESSAGE('%1 ..%2',AssignMatrix."Employee NO",AssignMatrix.Amount);
                                                                        //AssignMatrix.SETFILTER(AssignMatrix."Employee NO",emprec7."No.");
                                                                     END;
                                                                  END;
                                                                  //====================================================================
                                                                  */
                  if AssignMatrix.FINDSET then begin
                  // REPEAT
                   AssignMatrix.CALCSUMS(Amount);
                    ArrEarnings[1,i]:=AssignMatrix.Description;
                    CodeArr[1,i]:=AssignMatrix.Code;
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(PayrollRounding(AssignMatrix.Amount)));
                      ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                   // GrossPay:=GrossPay+PayrollRounding(AssignMatrix.Amount);
                   GrossPay:=GrossPay+AssignMatrix.Amount;
                     i:=i+1;
                     //MESSAGE('%1 ..%2',AssignMatrix."Employee NO",AssignMatrix.Amount);
                  // UNTIL AssignMatrix.NEXT=0;   //160317
                  end;
                 until Earn.NEXT=0;
                 end;
                
                    ArrEarnings[1,i]:='GROSS PAY';
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(GrossPay));
                    ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                    //================++
                    TaxableAmt:=GrossPay;    //message('%1', TaxableAmt);
                    //================++
                    i:=i+1;
                
                    ArrEarnings[1,i]:='************************************************';
                    ArrEarningsAmt[1,i]:='************************************************';
                
                    i:=i+1;
                
                    // taxation
                    ArrEarnings[1,i]:='Taxations';
                
                    i:=i+1;
                
                    ArrEarnings[1,i]:='************************************************';
                    ArrEarningsAmt[1,i]:='***********************************************';
                
                    i:=i+1;
                    // Non Cash Benefits
                   Earn.RESET;
                   Earn.SETRANGE(Earn."Earning Type",Earn."Earning Type"::"Normal Earning");
                   Earn.SETRANGE(Earn."Non-Cash Benefit",true);
                   Earn.SETFILTER(Earn."Calculation Method",'<>%1',Earn."Calculation Method"::"% of Salary Recovery");
                   Earn.SETRANGE(Earn.Fringe,false);
                   Earn.ASCENDING(true);
                    if Earn.FIND('-') then begin
                     repeat
                      AssignMatrix.RESET;
                     // AssignMatrix.SETFILTER(AssignMatrix."Payroll Period",'>=%1',050113D);
                      AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                      AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                      //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                      AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",false);
                      AssignMatrix.SETRANGE(Code,Earn.Code);
                      if AssignMatrix.FIND('-') then begin
                       //REPEAT
                       AssignMatrix.CALCSUMS(Amount);
                        ArrEarnings[1,i]:=AssignMatrix.Description;
                        CodeArr[1,i]:=AssignMatrix.Code;
                        EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(AssignMatrix.Amount))));
                      ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                        i:=i+1;
                       //UNTIL AssignMatrix.NEXT=0;
                      end;
                     until Earn.NEXT=0;
                    end;
                
                
                
                    // end of non cash
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                    AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Deduction);
                    //AssignMatrix.SETRANGE(AssignMatrix.Code,'895');
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,true);
                    if AssignMatrix.FIND('-') then begin
                       AssignMatrix.CALCSUMS(Amount,"Less Pension Contribution","Taxable amount");
                      ArrEarnings[1,i]:='Less Pension contribution benefit';
                    //  EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(AssignMatrix."Less Pension Contribution"))));
                        EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix."Less Pension Contribution")));
                      CodeArr[1,i]:=AssignMatrix.Code;
                      ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                      PAYE:=0;
                      TaxableAmt:=0;
                      PAYE:=AssignMatrix.Amount;
                   // TaxableAmt:=AssignMatrix."Taxable amount";  //++++++
                      TaxableAmt:=GrossPay-AssignMatrix."Less Pension Contribution";  // message('%1',TaxableAmt);
                   end;
                  // {
                    //========================================================================================bkn
                    i:=i+1;
                    Earn.RESET;
                    Earn.SETRANGE(Earn."Earning Type",Earn."Earning Type"::"Owner Occupier");
                    if Earn.FIND('-') then begin
                    //message('%1...%2..%3..%4',DateSpecified,Earn.Code,Employee."No.");
                     repeat
                      AssignMatrix.RESET;
                      AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                      AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                     // AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                      AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",false);
                      AssignMatrix.SETRANGE(Code,Earn.Code);
                      if AssignMatrix.FIND('-') then begin
                        //message('::');
                       repeat
                        ArrEarnings[1,i]:=AssignMatrix.Description;
                     //   EVALUATE(ArrEarningsAmt[1,i],FORMAT(PayrollRounding(AssignMatrix.Amount)));
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(AssignMatrix.Amount));
                      ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                         //Message('%1',ArrEarningsAmt[1,i]);
                         //+++++++++++++++++++
                         TaxableAmt:=TaxableAmt-(ABS(AssignMatrix.Amount));
                         //+++++++++++++++++++
                       i:=i+1;
                     until AssignMatrix.NEXT=0;
                     end;
                   until Earn.NEXT=0;
                  end;
                    //======================================================================================bkn
                
                    // }
                    /*AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                    AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Deduction);
                    AssignMatrix.SETRANGE(AssignMatrix.Code,'898');
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,TRUE);
                    IF AssignMatrix.FIND('-') THEN BEGIN
                       AssignMatrix.CALCSUMS(Amount,"Less Pension Contribution","Taxable amount");
                     TaxableAmt:=TaxableAmt+AssignMatrix."Taxable amount";
                    PAYE2:=0;
                    PAYE2:=AssignMatrix.Amount;
                   END; */
                
                
                   // i:=i+1;
                   /* Earn.RESET;
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
                        EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(AssignMatrix.Amount))));
                        ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i]);
                
                       i:=i+1;
                     //UNTIL AssignMatrix.NEXT=0;
                     END;
                   UNTIL Earn.NEXT=0;
                  END; */
                
                  // Taxable amount
                      ArrEarnings[1,i]:='Taxable Amount';
                     // EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(TaxableAmt))));
                      EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(TaxableAmt)));
                      ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                    i:=i+1;
                // Tax Charged + Relief
                  TaxCharged:=0;
                
                    Earn.RESET;
                    Earn.SETFILTER(Earn."Earning Type",'%1|%2',Earn."Earning Type"::"Tax Relief",
                    Earn."Earning Type"::"Insurance Relief");
                    if Earn.FIND('-') then begin
                     repeat
                     //Message('%1',     Earn.Description);
                      AssignMatrix.RESET;
                      AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                      AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                      //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                      AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",false);
                      AssignMatrix.SETRANGE(Code,Earn.Code);
                      if AssignMatrix.FIND('-') then begin
                       //REPEAT
                       AssignMatrix.CALCSUMS(Amount);
                    //  TaxCharged:=TaxCharged+ABS(PayrollRounding(AssignMatrix.Amount));
                       TaxCharged:=TaxCharged+ABS(AssignMatrix.Amount);
                
                     //  i:=i+1;
                     //UNTIL AssignMatrix.NEXT=0;
                     end;
                   until Earn.NEXT=0;
                  end;
                  //Add Paye
                   // TaxCharged:=TaxCharged+ABS(PayrollRounding(PAYE));
                     TaxCharged:=TaxCharged+ABS(PAYE);
                
                   //Add Paye2
                    //TaxCharged:=TaxCharged+ABS(PayrollRounding(PAYE2));
                     TaxCharged:=TaxCharged+ABS(PAYE2);
                      ArrEarnings[1,i]:='Tax Charged';
                      EVALUATE(ArrEarningsAmt[1,i],FORMAT(TaxCharged));
                      ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                
                    i:=i+1;
                
                // Relief
                    Earn.RESET;
                    Earn.SETFILTER(Earn."Earning Type",'%1|%2',Earn."Earning Type"::"Tax Relief",
                    Earn."Earning Type"::"Insurance Relief"); //,Earn."Earning Type"::"Owner Occupier"
                    if Earn.FIND('-') then begin
                     repeat
                      AssignMatrix.RESET;
                      AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                      AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                      //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                      AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",false);
                      AssignMatrix.SETRANGE(Code,Earn.Code);
                      if AssignMatrix.FIND('-') then begin
                       //REPEAT
                       AssignMatrix.CALCSUMS(Amount);
                       CodeArr[1,i]:=AssignMatrix.Code;
                        ArrEarnings[1,i]:=AssignMatrix.Description;
                        EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix.Amount)));
                        ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                       i:=i+1;
                     //UNTIL AssignMatrix.NEXT=0;
                     end;
                   until Earn.NEXT=0;
                  end;
                
                    ArrEarnings[1,i]:='************************************************';
                    ArrEarningsAmt[1,i]:='***********************************************';
                
                
                     i:=i+1;
                
                   // Deductions
                    ArrEarnings[1,i]:='Deductions';
                
                    i:=i+1;
                
                    ArrEarnings[1,i]:='************************************************';
                    ArrEarningsAmt[1,i]:='***********************************************';
                
                    i:=i+1;
                   //PAYE
                   PAYEEAmount:=0;
                
                    Deduct1.RESET;
                    Deduct1.SETRANGE("PAYE Code",true);
                                                        /*
                                                          //====================================================================
                                                          IF Employee.GETFILTER(Employee."Employee's Bank")<>'' THEN BEGIN
                                                             emprec7.RESET;
                                                             emprec7.SETFILTER(emprec7."Employee's Bank",Employee."Employee's Bank");
                                                             emprec7.SETFILTER(emprec7."No.",AssignMatrix."Employee No");
                                                             IF emprec7.FINDSET THEN BEGIN
                                                                Deduct1.SETFILTER(Deduct1."Employee Filter",emprec7."No.");
                                                             END;
                                                          END;
                                                          //====================================================================
                                                          */
                    //Deduct1.SETFILTER(Deduct1."Calculation Method",'%1',Deduct1."Calculation Method"::"Based on Table");
                    if Deduct1.FINDFIRST then begin
                         //  MESSAGE('%1',Deduct1.Code);
                           PAYEEAmount:=0;
                            repeat
                              AssignMatrix.RESET;
                              AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                              AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Deduction);
                              AssignMatrix.SETRANGE(Code,Deduct1.Code);
                              if AssignMatrix.FINDFIRST then begin    //(+)
                               AssignMatrix.CALCSUMS(Amount);
                               PAYEEAmount:=PAYEEAmount+ABS(AssignMatrix.Amount);
                               PAYEEDesc:=AssignMatrix.Description;
                               //payefirst:= ABS(PayrollRounding(AssignMatrix.Amount));
                              end;
                               //Message('%1..%2',Deduct1.Code,PAYEEAmount);
                            until Deduct1.NEXT =0;
                            //MESSAGE('%1',Deduct1.Code);
                          //Message('%1..%2',Deduct1.Code,PAYEEAmount);
                     // message('%1\%2',i,AssignMatrix.Code);
                      //Display payee as One
                      ArrEarnings[1,i]:=PAYEEDesc;
                      CodeArr[1,i]:=AssignMatrix.Code;
                      //Message('%1..%2',ArrEarnings[1,i],PAYEEAmount);
                      EVALUATE(ArrEarningsAmt[1,i],FORMAT(PAYEEAmount));
                      ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                      //Message('%1\%2\%3',ArrEarningsAmt[1,i],DateSpecified,CodeArr[1,i]);
                      i:=i+1;
                
                     end;// Message('%1',ArrEarningsAmt[1,i]);
                     //Message('%1',ArrEarningsAmt[1,i]);
                  //For PAYE Manual
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"% of Salary Recovery");
                    Deduct.ASCENDING(true);
                                                                      /*
                                                                        //====================================================================
                                                                        IF Employee.GETFILTER(Employee."Employee's Bank")<>'' THEN BEGIN
                                                                           emprec7.RESET;
                                                                           emprec7.SETFILTER(emprec7."Employee's Bank",Employee."Employee's Bank");
                                                                           emprec7.SETFILTER(emprec7."No.",AssignMatrix."Employee No");
                                                                           IF emprec7.FINDSET THEN BEGIN
                                                                              Deduct.SETFILTER(Deduct."Employee Filter",emprec7."No.");
                                                                           END;
                                                                        END;
                                                                        //====================================================================
                                                                        */
                    if Deduct.FIND('-') then begin
                     repeat
                  // Message('%1',Deduct.Code);
                     LoanBalance:=0;
                
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                   // AssignMatrix.SETRANGE(AssignMatrix.Shares,FALSE);
                   // AssignMatrix.SETRANGE(AssignMatrix."Insurance Code",FALSE);
                
                    if AssignMatrix.FIND('-') then begin
                   //  REPEAT
                     AssignMatrix.CALCSUMS(Amount);
                      CodeArr[1,i]:=AssignMatrix.Code;
                      ArrEarnings[1,i]:=AssignMatrix.Description;
                
                    PositivePAYEManual:=0;
                
                    Earn.RESET;
                    Earn.SETRANGE(Earn."Calculation Method",Earn."Calculation Method"::"% of Salary Recovery");
                    if Earn.FIND('-') then begin
                   // REPEAT
                      PayDeduct.RESET;
                      PayDeduct.SETRANGE(PayDeduct."Payroll Period",DateSpecified);
                      PayDeduct.SETFILTER(Type,'%1',PayDeduct.Type::Payment);
                      PayDeduct.SETRANGE(Code,Earn.Code);
                      PayDeduct.SETRANGE(PayDeduct."Manual Entry",true);
                     // AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                      if PayDeduct.FIND('-') then begin
                      repeat
                        PositivePAYEManual:=PositivePAYEManual+PayDeduct.Amount;
                
                      until PayDeduct.NEXT=0;
                      end;
                     end;
                      EVALUATE(ArrEarningsAmt[1,i],FORMAT(AssignMatrix.Amount-PositivePAYEManual));
                      ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                      CodeArr[1,i]:=AssignMatrix.Code;
                      TotalDeduction:=TotalDeduction+AssignMatrix.Amount-PositivePAYEManual;
                   // END;
                  i:=i+1;
                    //  i:=i+1;
                   //  UNTIL AssignMatrix.NEXT=0;
                     end;
                    until Deduct.NEXT=0;
                   end;    //1...
                    //MESSAGE('%1',I);
                    Deduct.RESET;
                    Deduct.SETFILTER(Deduct."Calculation Method",'<>%1',Deduct."Calculation Method"::"% of Salary Recovery");
                    Deduct.SETFILTER(Deduct."PAYE Code",'%1',false);
                    Deduct.SETRANGE(Informational,false);
                    Deduct.ASCENDING(true);
                                                          /*
                                                            //====================================================================
                                                            IF Employee.GETFILTER(Employee."Employee's Bank")<>'' THEN BEGIN
                                                               emprec7.RESET;
                                                               emprec7.SETFILTER(emprec7."Employee's Bank",Employee."Employee's Bank");
                                                               emprec7.SETFILTER(emprec7."No.",AssignMatrix."Employee No");
                                                               IF emprec7.FINDSET THEN BEGIN
                                                                  Deduct.SETFILTER(Deduct."Employee Filter",emprec7."No.");
                                                               END;
                                                            END;
                                                            //====================================================================
                                                             */
                    if Deduct.FIND('-') then begin
                     repeat
                     //Message('%1',Deduct.Code);
                     LoanBalance:=0;
                
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                   // AssignMatrix.SETRANGE(AssignMatrix.Paye,FALSE);
                   // AssignMatrix.SETRANGE(AssignMatrix.Shares,FALSE);
                   // AssignMatrix.SETRANGE(AssignMatrix."Insurance Code",FALSE);
                                                      /*
                                                         //====================================================================
                                                         IF Employee.GETFILTER(Employee."Employee's Bank")<>'' THEN BEGIN
                                                            emprec7.RESET;
                                                            emprec7.SETFILTER(emprec7."Employee's Bank",Employee."Employee's Bank");
                                                            emprec7.SETFILTER(emprec7."No.",AssignMatrix."Employee No");
                                                            IF emprec7.FINDSET THEN BEGIN
                                                               AssignMatrix.SETFILTER(AssignMatrix."Employee No",emprec7."No.");
                                                            END;
                                                         END;
                                                         //====================================================================
                
                                                       */
                    if AssignMatrix.FIND('-') then begin
                   //  REPEAT
                     AssignMatrix.CALCSUMS(Amount);
                
                       CodeArr[1,i]:=AssignMatrix.Code;
                      ArrEarnings[1,i]:=AssignMatrix.Description;//Deduct.Description+' Repayment'
                
                      EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix.Amount)));
                      ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                      // Message('%1..%2..%3\%4',AssignMatrix.Code,AssignMatrix.Description,ArrEarningsAmt[1,i],I);
                      TotalDeduction:=TotalDeduction+ABS(AssignMatrix.Amount);
                   // END;
                
                  i:=i+1;
                    //  i:=i+1;
                   //  UNTIL AssignMatrix.NEXT=0;
                     end;
                    until Deduct.NEXT=0;
                   end;
                
                //Payee + Total Deduction
                TotalDeduction:=TotalDeduction+PAYEEAmount;
                
                
                    ArrEarnings[1,i]:='TOTAL DEDUCTIONS';
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(TotalDeduction));
                    ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                        i:=i+1;
                
                    ArrEarnings[1,i]:='**************************************';
                    ArrEarningsAmt[1,i]:='*****************';
                
                    i:=i+1;
                    //Net Pay
                    ArrEarnings[1,i]:='NET PAY';
                    NetPay:=GrossPay-TotalDeduction;
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(NetPay));
                    ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                    i:=i+1;
                
                    ArrEarnings[1,i]:='**************************************';
                    ArrEarningsAmt[1,i]:='*****************';
                
                    i:=i+1;
                       //Information
                    ArrEarnings[1,i]:='Information';
                
                    i:=i+1;
                
                    ArrEarnings[1,i]:='**************************************';
                       ArrEarningsAmt[1,i]:='*****************';
                
                 i:=i+1;
                
                
                
                //Car Loan Interest;
                Deduct.RESET;
                Deduct.SETRANGE(Informational,true);
                if Deduct.FIND('-') then begin
                 repeat
                    CodeArr[1,i]:=Deduct.Code;
                    ArrEarnings[1,i]:=Deduct.Description;
                    TotalToDate:=0;
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                   // AssignMatrix.SETFILTER(Type,'=%1',AssignMatrix.Type::Informational);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    AssignMatrix.CALCSUMS(Amount,"Employer Amount","Opening Balance");
                     TotalToDate:=AssignMatrix.Amount+AssignMatrix."Employer Amount"+AssignMatrix."Opening Balance";
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(TotalToDate)));
                     ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                    i:=i+1;
                
                until Deduct.NEXT=0;
                end;
                
                
                
                /*
                Deduct.RESET;
                Deduct.SETRANGE(Loan,TRUE);
                IF Deduct.FIND('-') THEN BEGIN
                REPEAT
                    ArrEarnings[1,i]:=Deduct.Description+ 'Principal Rep';
                
                
                InterestToDate:=0;
                loanType.RESET;
                //loanType.SETRANGE("Deduction Code",Deduct.Code);
                loanType.SETRANGE("Interest Calculation Method",loanType."Interest Calculation Method"::"Reducing Balance");
                IF loanType.FIND('-') THEN BEGIN
                  REPEAT
                    CodeArr[1,i]:='611';
                    ArrEarnings[1,i]:=loanType.Description+' Interest Repayment';
                    RepSchedule.RESET;
                    RepSchedule.SETCURRENTKEY("Loan No","Repayment Date");
                    RepSchedule.SETRANGE("Loan Category",loanType.Code);
                    RepSchedule.SETRANGE(RepSchedule."Repayment Date",DateSpecified);
                    RepSchedule.CALCSUMS(RepSchedule."Monthly Interest");
                    //RepSchedule."Principal Repayment";
                    TotalToDate:=RepSchedule."Monthly Interest";
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(InterestToDate))));
                    ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i]);
                    i:=i+1;
                
                
                  UNTIL loanType.NEXT=0;
                END;
                
                
                 TotalToDate:=0;
                loanType.RESET;
                //loanType.SETRANGE("Deduction Code",Deduct.Code);
                loanType.SETRANGE("Interest Calculation Method",loanType."Interest Calculation Method"::"Reducing Balance");
                IF loanType.FIND('-') THEN BEGIN
                  REPEAT
                    CodeArr[1,i]:='612';
                    ArrEarnings[1,i]:=loanType.Description+' Principal Repayment';
                    RepSchedule.RESET;
                    RepSchedule.SETCURRENTKEY("Loan No","Repayment Date");
                    RepSchedule.SETRANGE("Loan Category",loanType.Code);
                    RepSchedule.SETRANGE(RepSchedule."Repayment Date",DateSpecified);
                    RepSchedule.CALCSUMS("Principal Repayment");
                    TotalToDate:=RepSchedule."Principal Repayment";
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(TotalToDate))));
                    ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i]);
                    i:=i+1;
                
                
                  UNTIL loanType.NEXT=0;
                END;
                */
                
                /*
                UNTIL Deduct.NEXT=0;
                END;
                */
                
                
                 //Soko Savings Balance to Date
                  TotalToDate:=0;
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Show Balance",true);
                   // Deduct.SETRANGE(Deduct."Date Filter",0D,DateSpecified);
                   // Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"% of Basic Pay");
                    Deduct.SETRANGE(Deduct.Shares,true);
                    if Deduct.FIND('-') then
                    begin
                     repeat
                    // MESSAGE('PENSION DEDUCTION CODE=%1',Deduct.Code);
                   // MESSAGE('Pension PERIOD=%1',Deduct."Pay Period Filter");
                 //   LoanBalance:=0;
                //Balances
                          Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");
                         // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                          ArrEarnings[1,i]:=Deduct.Description+' Bal. to Date';
                         // TotalToDate:=TotalToDate+Deduct."Total Amount";//+AssignMatrix."Opening Balance Company";
                
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",0D,DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    AssignMatrix.CALCSUMS(Amount,"Employer Amount","Opening Balance");
                    TotalToDate:=AssignMatrix.Amount+AssignMatrix."Employer Amount"+AssignMatrix."Opening Balance";
                
                         TotalDeposits:=0;
                         /*SavingsRec.RESET;
                         SavingsRec.SETCURRENTKEY(Code,"Payroll Period",Type);
                         SavingsRec.SETRANGE(SavingsRec.Code,Deduct.Code);
                         SavingsRec.SETRANGE(SavingsRec."Payroll Period",0D,DateSpecified);
                         SavingsRec.SETRANGE(SavingsRec.Type,SavingsRec.Type::Deposit);
                         SavingsRec.CALCSUMS(Amount);
                         TotalDeposits:=SavingsRec.Amount;
                
                         TotalWithdrawals:=0;
                         SavingsRec.RESET;
                         SavingsRec.SETCURRENTKEY(Code,"Payroll Period",Type);
                         SavingsRec.SETRANGE(SavingsRec.Code,Deduct.Code);
                         SavingsRec.SETRANGE(SavingsRec."Payroll Period",0D,DateSpecified);
                         SavingsRec.SETRANGE(SavingsRec.Type,SavingsRec.Type::Withdrawal);
                         SavingsRec.CALCSUMS(Amount);
                         TotalWithdrawals:=SavingsRec.Amount;*/
                         //MESSAGE('%4\TotalDeposits=%1\TotalWithdrawals=%2\TotalToDate=%3',TotalDeposits,TotalWithdrawals,TotalToDate,DateSpecified);
                
                          TotalToDate:=TotalToDate-TotalDeposits;
                         TotalToDate:=TotalToDate+TotalWithdrawals;
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(TotalToDate)));
                          ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                        //  EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding((AssignMatrix."Employer Amount")+(AssignMatrix."Opening Balance Company")))));
                         // ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i]);
                
                      i:=i+1;
                    // UNTIL AssignMatrix.NEXT=0;
                
                    until Deduct.NEXT=0;
                   end;
                
                
                    // Fringe Benefits
                   Earn.RESET;
                   Earn.SETRANGE(Earn."Earning Type",Earn."Earning Type"::"Normal Earning");
                   Earn.SETRANGE(Earn."Non-Cash Benefit",true);
                   Earn.SETRANGE(Earn.Fringe,true);
                    if Earn.FIND('-') then begin
                     repeat
                      AssignMatrix.RESET;
                      AssignMatrix.SETFILTER(AssignMatrix."Payroll Period",'>=%1',20130105D);
                      AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                      AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                      //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                      AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",false);
                      AssignMatrix.SETRANGE(Code,Earn.Code);
                      if AssignMatrix.FIND('-') then begin
                       //REPEAT
                       AssignMatrix.CALCSUMS(Amount);
                        ArrEarnings[1,i]:=AssignMatrix.Description;
                        EVALUATE(ArrEarningsAmt[1,i],FORMAT(AssignMatrix.Amount));
                      ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                        i:=i+1;
                       //UNTIL AssignMatrix.NEXT=0;
                      end;
                     until Earn.NEXT=0;
                    end;
                
                    // Fringe Benefits Taxations
                
                TotalFringe:=0;
                
                   Earn.RESET;
                   Earn.SETRANGE(Earn."Earning Type",Earn."Earning Type"::"Normal Earning");
                   Earn.SETRANGE(Earn."Non-Cash Benefit",true);
                   Earn.SETRANGE(Earn.Fringe,true);
                    if Earn.FIND('-') then begin
                     repeat
                      AssignMatrix.RESET;
                      AssignMatrix.SETFILTER(AssignMatrix."Payroll Period",'>=%1',20130501D);
                      AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                      AssignMatrix.SETRANGE(Type,AssignMatrix.Type::Payment);
                      //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                      AssignMatrix.SETRANGE(AssignMatrix."Basic Salary Code",false);
                      AssignMatrix.SETRANGE(Code,Earn.Code);
                      if AssignMatrix.FIND('-') then begin
                       //REPEAT
                       AssignMatrix.CALCSUMS(Amount);
                       // ArrEarnings[1,i]:=AssignMatrix.Description+' Tax';
                        FringeTax:=AssignMatrix.Amount*30/100;
                        TotalFringe:=TotalFringe+FringeTax;
                      //  EVALUATE(ArrEarningsAmt[1,i],FORMAT(PayrollRounding(FringeTax)));
                      //ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i]);
                
                       // i:=i+1;
                       //UNTIL AssignMatrix.NEXT=0;
                      end;
                     until Earn.NEXT=0;
                    end;
                
                    ArrEarnings[1,i]:='Total Fringe Tax';
                    EVALUATE(ArrEarningsAmt[1,i],FORMAT(TotalFringe));
                    ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                     i:=i+1;
                
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Show Balance",true);
                    Deduct.SETRANGE(Loan,true);
                    Deduct.SETFILTER(Deduct."Calculation Method",'<>%1',Deduct."Calculation Method"::"% of Basic Pay");
                    Deduct.SETRANGE(Deduct.Shares,false);
                  //  Deduct.SETRANGE(Deduct."Salary Recovery",FALSE);
                    if Deduct.FIND('-') then begin
                     repeat
                    // MESSAGE('DEDUCTIONCODE=%1',Deduct.Code);
                    LoanBalance:=0;
                    TotalBulkRepayments:=0;
                    TotalRepayments:=0;
                //Balances
                
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",0D,DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    if AssignMatrix.FIND('-') then begin
                
                    AssignMatrix.CALCSUMS(Amount);
                
                
                         LoanBalances.RESET;
                         LoanBalances.SETRANGE(LoanBalances."Date filter",0D,DateSpecified);
                         LoanBalances.SETRANGE(LoanBalances."Deduction Code",AssignMatrix.Code);
                         LoanBalances.SETFILTER("Stop Loan",'<>%1',true);
                         if LoanBalances.FIND('-') then
                          begin repeat
                          if loanType.GET(LoanBalances."Loan Product Type") then begin
                           if loanType."Interest Calculation Method"=loanType."Interest Calculation Method"::"Flat Rate" then begin
                           LoanBalances.CALCFIELDS(LoanBalances."Total Repayment",LoanBalances."Total Loan");
                           ArrEarnings[1,i]:=Deduct.Description+' Balance';
                          // add Total Loan/Approved Amount
                           if LoanBalances."Total Loan"<>0 then begin
                              LoanTopUps.RESET;
                              LoanTopUps.SETCURRENTKEY("Loan No","Payroll Period");
                              LoanTopUps.SETRANGE(LoanTopUps."Loan No",LoanBalances."Loan No");
                              LoanTopUps.SETRANGE("Payroll Period",0D,DateSpecified);
                              LoanTopUps.CALCSUMS(Amount);
                              LineAmt:=LoanTopUps.Amount;
                            LoanBalance:=LoanBalance+LineAmt;
                
                             // MESSAGE('%1  %2, %3 ,%4',LineAmt,LoanBalances."Total Repayment",(LineAmt+LoanBalances."Total Repayment"),LoanBalances."Employee No");
                          end else
                           LoanBalance:=LoanBalance+LoanBalances."Approved Amount";
                
                           LoanBalance:=LoanBalance+LoanBalances."Total Repayment";
                           //   MESSAGE('%1  %2, %3 ,%4',LoanBalances."Approved Amount",LoanBalances."Total Repayment",(LoanBalances."Approved Amount"+LoanBalances."Total Repayment"),LoanBalances."Employee No");
                           end;
                           if loanType."Interest Calculation Method"=loanType."Interest Calculation Method"::"Reducing Balance" then begin
                               ArrEarnings[1,i]:=Deduct.Description+' Balance';//AssignMatrix.Description;
                
                
                               RepSchedule.RESET;
                               RepSchedule.SETCURRENTKEY("Loan Category","Repayment Date");
                               RepSchedule.SETRANGE(RepSchedule."Loan Category",loanType.Code);
                               RepSchedule.SETRANGE(RepSchedule."Loan No",LoanBalances."Loan No");
                               RepSchedule.SETRANGE(RepSchedule."Repayment Date",DateSpecified);
                               //RepSchedule.CALCSUMS(RepSchedule."Remaining Debt");
                               if RepSchedule.FIND('-') then
                               begin
                                repeat
                                 LoanBalance:=LoanBalance+RepSchedule."Remaining Debt";
                             //    MESSAGE('Loan No %1\LoanBalance=%2',RepSchedule."Loan No",LoanBalance);
                                until RepSchedule.NEXT=0;
                               end;
                           end;
                          end;
                         until LoanBalances.NEXT=0;
                         LoanBalance:=LoanBalance;
                        // MESSAGE('LoanBalance1=%1',LoanBalance);
                         end;
                     end;
                
                       EVALUATE(ArrEarningsAmt[1,i],FORMAT(PayrollRounding(LoanBalance)));
                       ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                      i:=i+1;
                
                    until Deduct.NEXT=0;
                   end;
                
                 //Pension Employer Contribution
                
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Show Balance",true);
                    Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"% of Basic Pay");
                    Deduct.SETRANGE(Deduct."Pension Scheme",true);
                    if Deduct.FIND('-') then
                    begin
                     repeat
                    // MESSAGE('PENSION DEDUCTION CODE=%1',Deduct.Code);
                   // MESSAGE('Pension PERIOD=%1',Deduct."Pay Period Filter");
                 //   LoanBalance:=0;
                //Balances
                
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    if AssignMatrix.FIND('-') then
                     begin
                    // REPEAT
                     AssignMatrix.CALCSUMS(Amount,"Employer Amount");
                
                        if Deduct.GET(AssignMatrix.Code) then
                         begin
                          Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                          Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");
                         // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                          ArrEarnings[1,i]:='Pension Employer Contribution';
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(Deduct."Total Amount Employer")));
                          ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                       // MESSAGE('TotalPension=%1',ArrEarningsAmt[1,i]);
                       end;
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix."Employer Amount")));
                          ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                      i:=i+1;
                    // UNTIL AssignMatrix.NEXT=0;
                     end;
                    until Deduct.NEXT=0;
                   end;
                
                //Pension Arrears Self
                   TotalToDate:=0;
                   TotalPensionInactive:=0;
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Show Balance",true);
                    Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"Flat Amount");
                    Deduct.SETRANGE(Deduct."Pension Scheme",true);
                    if Deduct.FIND('-') then
                    begin
                     repeat
                
                          Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");
                         // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                          ArrEarnings[1,i]:=Deduct.Description;
                          //TotalToDate:=TotalToDate+Deduct."Total Amount";//+AssignMatrix."Opening Balance";
                
                
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    AssignMatrix.CALCSUMS(Amount,"Employer Amount",AssignMatrix."Opening Balance");
                    //TotalToDate:=AssignMatrix.Amount+AssignMatrix."Opening Balance";
                
                
                     //EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(PayrollRounding(TotalToDate))));
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix.Amount)));
                     ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                     i:=i+1;
                    until Deduct.NEXT=0;
                   end;
                
                
                 //Pension Arrears Employer
                   TotalToDate:=0;
                   TotalPensionInactive:=0;
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Show Balance",true);
                    Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"Flat Amount");
                    Deduct.SETRANGE(Deduct."Pension Scheme",true);
                    if Deduct.FIND('-') then
                    begin
                     repeat
                
                          Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");
                         // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                          ArrEarnings[1,i]:=Deduct.Description+' Employer';
                          //TotalToDate:=TotalToDate+Deduct."Total Amount";//+AssignMatrix."Opening Balance";
                
                
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    AssignMatrix.CALCSUMS(Amount,"Employer Amount",AssignMatrix."Opening Balance");
                    //TotalToDate:=AssignMatrix.Amount+AssignMatrix."Opening Balance";
                
                
                     //EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(TotalToDate))));
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix."Employer Amount")));
                     ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                     i:=i+1;
                    until Deduct.NEXT=0;
                   end;
                
                
                //Gratuity Arrears
                //Gratuity Employer Contribution
                    TotalToDate:=0;
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Show Balance",true);
                    Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"Flat Amount");
                    Deduct.SETRANGE(Deduct."Gratuity Arrears",true);
                   // Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                    if Deduct.FIND('-') then
                    begin
                
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    AssignMatrix.CALCSUMS(Amount,"Employer Amount");
                         // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                          ArrEarnings[1,i]:='Gratuity Contribution Arrears';
                          TotalToDate:=-AssignMatrix."Employer Amount";
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(-TotalToDate));
                
                          GratuityArrs:=AssignMatrix."Employer Amount";
                
                          ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix."Employer Amount")));
                          ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                      i:=i+1;
                    // UNTIL AssignMatrix.NEXT=0;
                
                   end;
                
                
                //Gratuity Employer Contribution
                
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Show Balance",true);
                    Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"% of Basic Pay");
                    Deduct.SETRANGE(Deduct.Gratuity,true);
                   // Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                    if Deduct.FIND('-') then
                    begin
                     repeat
                    // MESSAGE('Gratuity PERIOD=%1',Deduct."Pay Period Filter");
                 //   LoanBalance:=0;
                //Balances
                
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    if AssignMatrix.FIND('-') then
                     begin
                    // REPEAT
                     AssignMatrix.CALCSUMS(Amount,"Employer Amount");
                        if Deduct.GET(AssignMatrix.Code) then
                         begin
                          Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                          Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");
                         // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                          ArrEarnings[1,i]:='Gratuity Employer Contribution';
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(Deduct."Total Amount Employer")));
                          ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                       //  MESSAGE('TotalGratuity=%1',ArrEarningsAmt[1,i]);
                       end;
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(AssignMatrix."Employer Amount")));
                          ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                      i:=i+1;
                    // UNTIL AssignMatrix.NEXT=0;
                     end;
                    until Deduct.NEXT=0;
                   end;
                
                 TotalToDate:=0;
                //Gratuity Balance To Date
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Show Balance",true);
                    Deduct.SETFILTER(Deduct."Calculation Method",'=%1|=%2',Deduct."Calculation Method"::"% of Basic Pay",Deduct."Calculation Method"::"Flat Amount");
                    Deduct.SETRANGE(Deduct.Gratuity,true);
                   // Deduct.SETRANGE(Deduct."Pay Period Filter",0D,DateSpecified);
                    if Deduct.FIND('-') then
                    begin
                     repeat
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",0D,DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    AssignMatrix.CALCSUMS(Amount,"Employer Amount","Opening Balance Company");
                    Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");
                
                          ArrEarnings[1,i]:='Gratuity Employer Contrib Bal. to Date';
                          TotalToDate:=AssignMatrix."Employer Amount"+AssignMatrix."Opening Balance Company";
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(TotalToDate)));
                          ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(TotalToDate)));
                          ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                          // MESSAGE('Opening Balance Company=%1',AssignMatrix."Opening Balance Company");
                          // MESSAGE('OpeningBalanceCompany+TotalGratuityDeduct=%1',TotalToDate);
                      i:=i+1;
                     //UNTIL AssignMatrix.NEXT=0;
                    until Deduct.NEXT=0;
                   end;
                
                 //Pension Self Contribution to Date
                   TotalToDate:=0;
                   TotalPensionInactive:=0;
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Show Balance",true);
                    Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"Flat Amount");
                    Deduct.SETRANGE(Deduct."Pension Scheme",true);
                    if Deduct.FIND('-') then
                    begin
                     repeat
                
                          Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");
                         // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                          ArrEarnings[1,i]:=Deduct.Description+' Bal. to Date';
                          //TotalToDate:=TotalToDate+Deduct."Total Amount";//+AssignMatrix."Opening Balance";
                
                
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",0D,DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    AssignMatrix.CALCSUMS(Amount,"Employer Amount",AssignMatrix."Opening Balance");
                    TotalToDate:=AssignMatrix.Amount+AssignMatrix."Opening Balance";
                
                
                       EmpRec.RESET;
                       EmpRec.SETFILTER(EmpRec.Status,'<>%1',EmpRec.Status::Active);
                       if EmpRec.FIND('-') then begin
                       repeat
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",0D,DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix."Employee No",EmpRec."No.");
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    AssignMatrix.CALCSUMS(Amount,"Employer Amount","Opening Balance");
                    TotalPensionInactive:=TotalPensionInactive+AssignMatrix."Opening Balance"+AssignMatrix.Amount;
                      until EmpRec.NEXT=0;
                    end;
                       TotalToDate:=TotalToDate-TotalPensionInactive;
                      PensionArrs:=TotalToDate;
                
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(TotalToDate)));
                     ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                     i:=i+1;
                    until Deduct.NEXT=0;
                   end;
                
                
                
                 //Pension Employer Contribution to Date
                  TotalToDate:=0;
                  TotalPensionInactive:=0;
                
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Show Balance",true);
                    Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"% of Basic Pay");
                    Deduct.SETRANGE(Deduct."Pension Scheme",true);
                    if Deduct.FIND('-') then
                    begin
                     repeat
                    // MESSAGE('PENSION DEDUCTION CODE=%1',Deduct.Code);
                   // MESSAGE('Pension PERIOD=%1',Deduct."Pay Period Filter");
                 //   LoanBalance:=0;
                //Balances
                
                          Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");
                        //  MESSAGE('Total Employer Pension=%1',Deduct."Total Amount Employer");
                         // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                          ArrEarnings[1,i]:='Pension Employer Contrib. Bal. to Date';
                          TotalToDate:=TotalToDate+Deduct."Total Amount Employer"-(PensionArrs*2);//+AssignMatrix."Opening Balance Company";
                
                
                    AssignMatrix.RESET;
                   // AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",0D,DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    //AssignMatrix.SETRANGE(AssignMatrix."Employee No",Employee."No.");
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    if AssignMatrix.FIND('-') then
                     begin
                    // REPEAT
                     AssignMatrix.CALCSUMS(Amount,"Employer Amount","Opening Balance Company");
                   //MESSAGE('Opening Company Pension=%1',AssignMatrix."Opening Balance Company");
                
                          TotalToDate:=TotalToDate+AssignMatrix."Opening Balance Company";
                
                     //  UNTIL AssignMatrix.NEXT=0;
                      end;
                
                       EmpRec.RESET;
                     //EmpRec.SETFILTER(EmpRec."No.",'%1|%2','CMA0148','CMA0162');
                       EmpRec.SETFILTER(EmpRec.Status,'<>%1',EmpRec.Status::Active);
                       if EmpRec.FIND('-') then begin
                       repeat
                    AssignMatrix.RESET;
                  //AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",0D,DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix."Employee No",EmpRec."No.");
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    if AssignMatrix.FIND('-') then
                     begin
                    // REPEAT
                
                     AssignMatrix.CALCSUMS(Amount,"Employer Amount","Opening Balance Company");
                   //MESSAGE('Opening Company Pension=%1',AssignMatrix."Opening Balance Company");
                
                          TotalPensionInactive:=TotalPensionInactive+AssignMatrix."Opening Balance Company"+AssignMatrix."Employer Amount";
                
                     //  UNTIL AssignMatrix.NEXT=0;
                      end;
                      // ELSE
                      //   TotalPensionInactive:=0;
                     // MESSAGE('Employee=%1\OpeningBal=%2\Employer Amt=%3\Total=%4',EmpRec."No.",AssignMatrix."Opening Balance Company",AssignMatrix."Employer Amount",TotalPensionInactive);
                      until EmpRec.NEXT=0;
                    end;
                   //  MESSAGE('TotalPensionInactive=%1',TotalPensionInactive);
                
                       TotalToDate:=TotalToDate-TotalPensionInactive;
                
                          EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(TotalToDate)));
                          ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                      i:=i+1;
                    until Deduct.NEXT=0;
                   end;
                
                
                
                 //Pension Self Contribution to Date
                   TotalToDate:=0;
                   TotalPensionInactive:=0;
                    Deduct.RESET;
                    Deduct.SETRANGE(Deduct."Show Balance",true);
                    Deduct.SETRANGE(Deduct."Calculation Method",Deduct."Calculation Method"::"% of Basic Pay");
                    Deduct.SETRANGE(Deduct."Pension Scheme",true);
                    if Deduct.FIND('-') then
                    begin
                     repeat
                
                          Deduct.CALCFIELDS(Deduct."Total Amount",Deduct."Total Amount Employer");
                         // BalanceArray[1,i]:=ABS(Deduct."Total Amount Employer");
                          ArrEarnings[1,i]:=Deduct.Description+' Bal. to Date';
                          //TotalToDate:=TotalToDate+Deduct."Total Amount";//+AssignMatrix."Opening Balance";
                
                
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",0D,DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    AssignMatrix.CALCSUMS(Amount,"Employer Amount",AssignMatrix."Opening Balance");
                    TotalToDate:=AssignMatrix.Amount+AssignMatrix."Opening Balance";
                
                
                       EmpRec.RESET;
                       EmpRec.SETFILTER(EmpRec.Status,'<>%1',EmpRec.Status::Active);
                       if EmpRec.FIND('-') then begin
                       repeat
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(AssignMatrix."Payroll Period",0D,DateSpecified);
                    AssignMatrix.SETFILTER(Type,'%1|%2',AssignMatrix.Type::Deduction,AssignMatrix.Type::Loan);
                    AssignMatrix.SETRANGE(Code,Deduct.Code);
                    AssignMatrix.SETRANGE(AssignMatrix."Employee No",EmpRec."No.");
                    AssignMatrix.SETRANGE(AssignMatrix.Paye,false);
                    AssignMatrix.CALCSUMS(Amount,"Employer Amount","Opening Balance");
                    TotalPensionInactive:=TotalPensionInactive+AssignMatrix."Opening Balance"+AssignMatrix.Amount;
                      until EmpRec.NEXT=0;
                    end;
                
                
                
                
                       TotalToDate:=TotalToDate-TotalPensionInactive+PensionArrs;
                
                
                     EVALUATE(ArrEarningsAmt[1,i],FORMAT(ABS(TotalToDate)));
                     ArrEarningsAmt[1,i]:=ArrEarningsAmt[1,i];
                
                     i:=i+1;
                    until Deduct.NEXT=0;
                   end;
                
                
                
                EmpRec.RESET;
                if EmpRec.FIND('-') then begin
                repeat
                //ArrEarnings[1,i]:='Leave Balance';
                 AccPeriod.RESET;
                 AccPeriod.SETRANGE(AccPeriod."Starting Date",0D,TODAY);
                 AccPeriod.SETRANGE(AccPeriod."New Fiscal Year",true);
                 if AccPeriod.FIND('+') then
                 begin
                  FiscalStart:=AccPeriod."Starting Date";
                  MaturityDate:=CALCDATE('1Y',AccPeriod."Starting Date")-1;
                
                   //   ArrEarnings[1,i]:='Leave Balance';
                 // MESSAGE('MATURITY DATE=%1',MaturityDate);
                     LeaveApplication.RESET;
                     LeaveApplication.SETRANGE(LeaveApplication."Employee No",EmpRec."No.");
                     LeaveApplication.SETRANGE(LeaveApplication."Maturity Date",MaturityDate);
                     LeaveApplication.SETRANGE(LeaveApplication.Status,LeaveApplication.Status::Approved);
                     if LeaveApplication.FIND('+') then
                     // BEGIN
                       TotalLeaveBalance:=TotalLeaveBalance+LeaveApplication."Leave balance";
                      // ArrEarningsAmt[1,i]:=FORMAT(LeaveApplication."Leave balance");
                 //      MESSAGE('EMPLOYEE=%1, LEAVE BALANCE=%2',Employee."No.",LeaveApplication."Leave balance");
                   //  END;
                 end;
                
                until EmpRec.NEXT=0;
                end;
                
                  ArrEarnings[1,i]:='Leave Balance';
                  ArrEarningsAmt[1,i]:=FORMAT(TotalLeaveBalance);
                
                //End balances
                
                   i:=i+1;
                
                    ArrEarnings[1,i]:='**************************************';
                    ArrEarningsAmt[1,i]:='*****************';
                
                
                     i:=i+1;
                    ArrEarnings[1,i]:='Company Details';
                    // Employee details
                     i:=i+1;
                
                    ArrEarnings[1,i]:='**************************************';
                    ArrEarningsAmt[1,i]:='*****************';
                     i:=i+1;
                    CompInfo.GET;
                
                    ArrEarnings[1,i]:='P.I.N';
                    //ArrEarningsAmt[1,i]:=CompInfo."Company P.I.N";
                
                    i:=i+1;
                   // IF EmpBank.GET("Employee's Bank","Bank Branch") THEN
                    // BankName:=EmpBank.Name;
                
                    ArrEarnings[1,i]:='Company Bank';
                    ArrEarningsAmt[1,i]:=CompInfo."Bank Name";
                
                    i:=i+1;
                    ArrEarnings[1,i]:='Bank Branch';
                    ArrEarningsAmt[1,i]:=CompInfo."Bank Branch No.";
                
                    i:=i+1;
                    ArrEarnings[1,i]:='NSSF No';
                    //ArrEarningsAmt[1,i]:=CompInfo."N.S.S.F No.";
                    i:=i+1;
                    ArrEarnings[1,i]:='AAR No';
                    //ArrEarningsAmt[1,i]:=CompInfo."N.H.I.F No";
                
                    i:=i+1;
                    ArrEarnings[1,i]:=EmpCountCaption;
                    ArrEarningsAmt[1,i]:=FORMAT(EmpCount);
                
                    i:=i+1;
                    ArrEarnings[1,i]:=CMFIUCountCaption;
                    ArrEarningsAmt[1,i]:=FORMAT(CMFIUCount);
                
                    i:=i+1;
                    ArrEarnings[1,i]:=TempStaffCaption;
                    ArrEarningsAmt[1,i]:=FORMAT(TempEmpCount);
                
                
                    i:=i+1;
                
                    ArrEarnings[1,i]:='*************End of Report**************';

            end;

            trigger OnPreDataItem();
            begin
                Integer.SETRANGE(Number,1,1);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Month Begin Date";MonthStartDate)
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
          Employee.SETFILTER("Pay Period Filter",'%1',MonthStartDate);

          PayPeriodtext:=Employee.GETFILTER("Pay Period Filter");
          EVALUATE(PayrollMonth,FORMAT(PayPeriodtext));
          PayrollMonthText:=FORMAT(PayrollMonth,1,4);

          if PayPeriodtext='' then

          ERROR('Pay period must be specified for this report');
          CoRec.GET;
          CoName:=CoRec.Name;
          CoRec.CALCFIELDS(CoRec.Picture);
          EVALUATE(DateSpecified,FORMAT(PayPeriodtext));
    end;

    var
        Addr : array [10,100] of Text[250];
        NoOfRecords : Integer;
        RecordNo : Integer;
        NoOfColumns : Integer;
        ColumnNo : Integer;
        i : Integer;
        AmountRemaining : Decimal;
        IncomeTax : Decimal;
        PayPeriod : Record "Payroll Period";
        PayPeriodtext : Text[30];
        BeginDate : Date;
        DateSpecified : Date;
        EndDate : Date;
        EmpBank : Record "Staff  Bank Account";
        BankName : Text[250];
        BasicSalary : Decimal;
        TaxableAmt : Decimal;
        RightBracket : Boolean;
        NetPay : Decimal;
        PayPeriodRec : Record "Payroll Period";
        PayDeduct : Record "Assignment Matrix";
        EmpRec : Record Employee;
        EmpNo : Code[10];
        TaxableAmount : Decimal;
        PAYE : Decimal;
        PAYE2 : Decimal;
        ArrEarnings : array [3,100000] of Text[250];
        ArrDeductions : array [3,100000] of Text[250];
        Index : Integer;
        Index1 : Integer;
        j : Integer;
        ArrEarningsAmt : array [3,100000] of Text[60];
        ArrDeductionsAmt : array [3,100000] of Decimal;
        Year : Integer;
        EmpArray : array [10,15] of Decimal;
        HoldDate : Date;
        DenomArray : array [3,12] of Text[50];
        NoOfUnitsArray : array [3,12] of Integer;
        AmountArray : array [3,12] of Decimal;
        PayModeArray : array [3] of Text[30];
        HoursArray : array [3,60] of Decimal;
        CompRec : Record "Human Resources Setup";
        HseLimit : Decimal;
        ExcessRetirement : Decimal;
        CfMpr : Decimal;
        relief : Decimal;
        TaxCode : Code[20];
        HoursBal : Decimal;
        Pay : Record Earnings;
        Ded : Record Deductions;
        HoursArrayD : array [3,60] of Decimal;
        BankBranch : Text[100];
        CoName : Text[100];
        retirecontribution : Decimal;
        EarngingCount : Integer;
        DeductionCount : Integer;
        EarnAmount : Decimal;
        GrossTaxCharged : Decimal;
        DimVal : Record "Dimension Value";
        Department : Text[60];
        LowInterestBenefits : Decimal;
        SpacePos : Integer;
        NetPayLength : Integer;
        AmountText : Text[30];
        DecimalText : Text[30];
        DecimalAMT : Decimal;
        InsuranceRelief : Decimal;
        InsuranceReliefText : Text[30];
        IncometaxNew : Decimal;
        NewRelief : Decimal;
        TaxablePayNew : Decimal;
        InsuranceReliefNew : Decimal;
        TaxChargedNew : Decimal;
        finalTax : Decimal;
        TotalBenefits : Decimal;
        RetireCont : Decimal;
        TotalQuarters : Decimal;
        "Employee Payroll" : Record Employee;
        PayMode : Text[30];
        Intex : Integer;
        NetPay1 : Decimal;
        Principal : Decimal;
        Interest : Decimal;
        Desc : Text[50];
        dedrec : Record Deductions;
        RoundedNetPay : Decimal;
        diff : Decimal;
        CFWD : Decimal;
        Nssfcomptext : Text[30];
        Nssfcomp : Decimal;
        LoanDesc : Text[60];
        LoanDesc1 : Text[60];
        Deduct : Record Deductions;
        OriginalLoan : Decimal;
        LoanBalance : Decimal;
        Message1 : Text[250];
        Message2 : array [3,1] of Text[250];
        DeptArr : array [3,1] of Text[60];
        BasicPay : array [3,1] of Text[250];
        InsurEARN : Decimal;
        HasInsurance : Boolean;
        RoundedAmt : Decimal;
        TerminalDues : Decimal;
        Earn : Record Earnings;
        AssignMatrix : Record "Assignment Matrix";
        RoundingDesc : Text[60];
        BasicChecker : Decimal;
        CoRec : Record "Company Information";
        GrossPay : Decimal;
        TotalDeduction : Decimal;
        PayrollMonth : Date;
        PayrollMonthText : Text[30];
        PayeeTest : Decimal;
        GroupCode : Code[20];
        CUser : Code[20];
        Totalcoopshares : Decimal;
        LoanBal : Decimal;
        LoanBalances : Record "Loan Application";
        TotalRepayment : Decimal;
        Totalnssf : Decimal;
        Totalpension : Decimal;
        Totalprovid : Decimal;
        BalanceArray : array [3,100000] of Decimal;
        EarningsCaptionLbl : Label 'Earnings';
        Employee_No_CaptionLbl : Label 'Employee No:';
        Name_CaptionLbl : Label 'Name:';
        Dept_CaptionLbl : Label 'Dept:';
        AmountCaptionLbl : Label 'Amount';
        Pay_slipCaptionLbl : Label 'Company Totals By Analysis';
        EmptyStringCaptionLbl : Label '***************************************************';
        CurrReport_PAGENOCaptionLbl : Label 'Copy';
        TaxCharged : Decimal;
        InterestCode : Code[20];
        BalanceCaptionLbl : Label 'Balances';
        CompInfo : Record "Company Information";
        FiscalStart : Date;
        MaturityDate : Date;
        LeaveApplication : Record "Employee Leave Application";
        TotalLeaveBalance : Decimal;
        LastMaturityDate : Date;
        NextMaturityDate : Date;
        Emp : Record Employee;
        CarryForwardDays : Decimal;
        EmpleaveCpy : Record "HR Type Of Intervention";
        TotalToDate : Decimal;
        //SavingsRec : Record "Savings Scheme Transactions";
        TotalDeposits : Decimal;
        TotalWithdrawals : Decimal;
        PositivePAYEManual : Decimal;
        TotalBulkRepayments : Decimal;
        LoanTopUps : Record "Loan Top-up";
        TotalRepayments : Decimal;
        CurrentRepayment : Decimal;
        TotalPensionInactive : Decimal;
        FringeTax : Decimal;
        GratuityArrs : Decimal;
        OpeningBal : Decimal;
        LineAmt : Decimal;
        PensionArrs : Decimal;
        CodeArr : array [3,100000] of Code[30];
        AccPeriod : Record "Accounting Period";
        DateMHCALbl : Label 'Date......................................';
        DateMFLbl : Label 'Date......................................';
        Designation_________________________________________________________________________________________CaptionLbl : Label 'Designation.........................................................................................';
        DateDCSLbl : Label 'Date......................................';
        SignatureMHCALbl : Label 'Checked By MHCA......................................................';
        SignatureMFLbl : Label 'First Authorized by MF.................................................';
        SignatureDCSLbl : Label 'Second Authorized by DCS............................................';
        /*Designation_________________________________________________________________________________________Caption_Control1000000069Lbl : Label 'Designation.........................................................................................';
        Designation_________________________________________________________________________________________Caption_Control1000000070Lbl : Label 'Designation.........................................................................................';*/
        TotalFringe : Decimal;
        InterestToDate : Decimal;
        EmpCount : Integer;
        EmpCountCaption : Label 'Permanent Employees:';
        CMFIUCount : Integer;
        TempEmpCount : Integer;
        CMFIUCountCaption : Label 'CMFIU/Seconded Staff:';
        TempStaffCaption : Label '"Interns and Temporary Staff: "';
        MonthStartDate : Date;
        Deduct1 : Record Deductions;
        PAYEEAmount : Decimal;
        PAYEEDesc : Text;

    procedure GetTaxBracket(var TaxableAmount : Decimal);
    var
        TaxTable : Record Brackets;
        TotalTax : Decimal;
        Tax : Decimal;
        EndTax : Boolean;
    begin
    end;

    procedure GetPayPeriod();
    begin
    end;

    procedure GetTaxBracket1(var TaxableAmount : Decimal);
    var
        TaxTable : Record Brackets;
        TotalTax : Decimal;
        Tax : Decimal;
        EndTax : Boolean;
    begin
    end;

    procedure CoinageAnalysis(var NetPay : Decimal;var ColNo : Integer);
    var
        Index : Integer;
        Intex : Integer;
    begin
    end;

    procedure PayrollRounding(var Amount : Decimal) PayrollRounding : Decimal;
    var
        HRsetup : Record "Human Resources Setup";
    begin

            HRsetup.GET;
            if HRsetup."Payroll Rounding Precision"=0 then
               ERROR('You must specify the rounding precision under HR setup');

          if HRsetup."Payroll Rounding Type"=HRsetup."Payroll Rounding Type"::Nearest then
            PayrollRounding:=ROUND(Amount,HRsetup."Payroll Rounding Precision",'=');

          if HRsetup."Payroll Rounding Type"=HRsetup."Payroll Rounding Type"::Up then
            PayrollRounding:=ROUND(Amount,HRsetup."Payroll Rounding Precision",'>');

          if HRsetup."Payroll Rounding Type"=HRsetup."Payroll Rounding Type"::Down then
            PayrollRounding:=ROUND(Amount,HRsetup."Payroll Rounding Precision",'<');
    end;

    procedure ChckRound(var AmtText : Text[30]) ChckRound : Text[30];
    var
        LenthOfText : Integer;
        DecimalPos : Integer;
        AmtWithoutDec : Text[30];
        DecimalAmt : Text[30];
        Decimalstrlen : Integer;
    begin
        LenthOfText:=STRLEN(AmtText);
        DecimalPos:=STRPOS(AmtText,'.');
        if DecimalPos=0 then begin
         AmtWithoutDec:=AmtText;
         DecimalAmt:='.00';
        end else begin
         AmtWithoutDec:=COPYSTR(AmtText,1,DecimalPos-1);
         DecimalAmt:=COPYSTR(AmtText,DecimalPos+1,2);
         Decimalstrlen:=STRLEN(DecimalAmt);
        if Decimalstrlen<2 then begin
          DecimalAmt:='.' +DecimalAmt+'0';
         end else
           DecimalAmt:='.' +DecimalAmt
        end;
        ChckRound:=AmtWithoutDec+DecimalAmt;
    end;

    procedure getdate(bddate : Date);
    begin
        MonthStartDate:=bddate;
    end;
}

