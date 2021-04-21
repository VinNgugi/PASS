report 51513170 "Master Roll Report A2 Format"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Master Roll Report A2 Format.rdl';
    Caption = 'Master Roll Report A2 Format';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING("No.") where(Status = const(Active));
            RequestFilterFields = "No.", Status, "Posting Group", "Salary Scale";
            column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            column(USERID; USERID)
            {
            }
            column(UPPERCASE_FORMAT_DateSpecified_0___month_text___year4____; UPPERCASE(FORMAT(DateSpecified, 0, '<month text> <year4>')))
            {
            }
            column(TIME; TIME)
            {
            }
            column(Cost_Center; BudgetLine)
            {
            }
            column(Location_Code; Employee."Global Dimension 1 Code")
            {
            }
            column(Pay_Grade; Employee."Salary Scale")
            {
            }
            column(DOB; DateOfBirth)
            {
            }
            column(Age; EmpAge)
            {
            }
            column(Pension_Rate; PensionRate)
            {
            }
            column(Annual_Salary; AnnualSal)
            {
            }
            column(Show_Ads; ShowAds)
            {
            }
            /*column(Payroll; Employee."Salary Distributor")
            {
            }*/
            column(DedDesc_1_; DedDesc[1])
            {
            }
            column(DedDesc_2_; DedDesc[2])
            {
            }
            column(DedDesc_3_; DedDesc[3])
            {
            }
            column(DedDesc_4_; DedDesc[4])
            {
            }
            column(DedDesc_5_; DedDesc[5])
            {
            }
            column(DedDesc_6_; DedDesc[6])
            {
            }
            column(DedDesc_7_; DedDesc[7])
            {
            }
            column(DedDesc_8_; DedDesc[8])
            {
            }
            column(DedDesc_9_; DedDesc[9])
            {
            }
            column(DedDesc_10_; DedDesc[10])
            {
            }
            column(DedDesc_11_; DedDesc[11])
            {
            }
            column(DedDesc_12_; DedDesc[12])
            {
            }
            column(DedDesc_13_; DedDesc[13])
            {
            }
            column(DedDesc_14_; DedDesc[14])
            {
            }
            column(DedDesc_15_; DedDesc[15])
            {
            }
            column(DedDesc_16_; DedDesc[16])
            {
            }
            column(DedDesc_17_; DedDesc[17])
            {
            }
            column(DedDesc_18_; DedDesc[18])
            {
            }
            column(DedDesc_19_; DedDesc[19])
            {
            }
            column(DedDesc_20_; DedDesc[20])
            {
            }
            column(DedDesc_21_; DedDesc[21])
            {
            }
            column(DedDesc_22_; DedDesc[22])
            {
            }
            column(DedDesc_23_; DedDesc[23])
            {
            }
            column(DedDesc_24_; DedDesc[24])
            {
            }
            column(DedDesc_25_; DedDesc[25])
            {
            }
            column(DedDesc_26_; DedDesc[26])
            {
            }
            column(DedDesc_27_; DedDesc[27])
            {
            }
            column(DedDesc_28_; DedDesc[28])
            {
            }
            column(DedDesc_29_; DedDesc[29])
            {
            }
            column(DedDesc_30_; DedDesc[30])
            {
            }
            column(DedDesc_31_; DedDesc[31])
            {
            }
            column(DedDesc_32_; DedDesc[32])
            {
            }
            column(DedDesc_33_; DedDesc[33])
            {
            }
            column(DedDesc_34_; DedDesc[34])
            {
            }
            column(DedDesc_35_; DedDesc[35])
            {
            }
            column(DedDesc_36_; DedDesc[36])
            {
            }
            column(DedDesc_37_; DedDesc[37])
            {
            }
            column(DedDesc_38_; DedDesc[38])
            {
            }
            column(DedDesc_39_; DedDesc[39])
            {
            }
            column(DedDesc_40_; DedDesc[40])
            {
            }
            column(Other_Deductions_; 'Other Deductions')
            {
            }
            column(Net_Pay_; 'Net Pay')
            {
            }
            column(PF_No__; 'PF No.')
            {
            }
            column(Name_; 'Name')
            {
            }
            column(EarnDesc_1_; EarnDesc[1])
            {
            }
            column(EarnDesc_2_; EarnDesc[2])
            {
            }
            column(EarnDesc_3_; EarnDesc[3])
            {
            }
            column(EarnDesc_4_; EarnDesc[4])
            {
            }
            column(EarnDesc_5_; EarnDesc[5])
            {
            }
            column(EarnDesc_6_; EarnDesc[6])
            {
            }
            column(EarnDesc_7_; EarnDesc[7])
            {
            }
            column(EarnDesc_8_; EarnDesc[8])
            {
            }
            column(EarnDesc_9_; EarnDesc[9])
            {
            }
            column(EarnDesc_10_; EarnDesc[10])
            {
            }
            column(EarnDesc_11_; EarnDesc[11])
            {
            }
            column(EarnDesc_12_; EarnDesc[12])
            {
            }
            column(EarnDesc_13_; EarnDesc[13])
            {
            }
            column(EarnDesc_14_; EarnDesc[14])
            {
            }
            column(EarnDesc_15_; EarnDesc[15])
            {
            }
            column(EarnDesc_16_; EarnDesc[16])
            {
            }
            column(EarnDesc_17_; EarnDesc[17])
            {
            }
            column(EarnDesc_18_; EarnDesc[18])
            {
            }
            column(EarnDesc_19_; EarnDesc[19])
            {
            }
            column(EarnDesc_20_; EarnDesc[20])
            {
            }
            column(EarnDesc_21_; EarnDesc[21])
            {
            }
            column(EarnDesc_22_; EarnDesc[22])
            {
            }
            column(EarnDesc_23_; EarnDesc[23])
            {
            }
            column(EarnDesc_24_; EarnDesc[24])
            {
            }
            column(EarnDesc_25_; EarnDesc[25])
            {
            }
            column(EarnDesc_26_; EarnDesc[26])
            {
            }
            column(EarnDesc_27_; EarnDesc[27])
            {
            }
            column(EarnDesc_28_; EarnDesc[28])
            {
            }
            column(EarnDesc_29_; EarnDesc[29])
            {
            }
            column(EarnDesc_30_; EarnDesc[30])
            {
            }
            column(EarnDesc_31_; EarnDesc[31])
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(Deductions_1_; Deductions[1])
            {
            }
            column(Deductions_2_; Deductions[2])
            {
            }
            column(Deductions_3_; Deductions[3])
            {
            }
            column(Deductions_4_; Deductions[4])
            {
            }
            column(Deductions_5_; Deductions[5])
            {
            }
            column(Deductions_6_; Deductions[6])
            {
            }
            column(Deductions_7_; Deductions[7])
            {
            }
            column(Deductions_8_; Deductions[8])
            {
            }
            column(Deductions_9_; Deductions[9])
            {
            }
            column(Deductions_10_; Deductions[10])
            {
            }
            column(Deductions_11_; Deductions[11])
            {
            }
            column(Deductions_12_; Deductions[12])
            {
            }
            column(Deductions_13_; Deductions[13])
            {
            }
            column(Deductions_14_; Deductions[14])
            {
            }
            column(Deductions_15_; Deductions[15])
            {
            }
            column(Deductions_16_; Deductions[16])
            {
            }
            column(Deductions_17_; Deductions[17])
            {
            }
            column(Deductions_18_; Deductions[18])
            {
            }
            column(Deductions_19_; Deductions[19])
            {
            }
            column(Deductions_20_; Deductions[20])
            {
            }
            column(Deductions_21_; Deductions[21])
            {
            }
            column(Deductions_23_; Deductions[23])
            {
            }
            column(Deductions_24_; Deductions[24])
            {
            }
            column(Deductions_25_; Deductions[25])
            {
            }
            column(Deductions_22_; Deductions[22])
            {
            }
            column(Deductions_26_; Deductions[26])
            {
            }
            column(Deductions_27_; Deductions[27])
            {
            }
            column(Deductions_28_; Deductions[28])
            {
            }
            column(Deductions_29_; Deductions[29])
            {
            }
            column(Deductions_30_; Deductions[30])
            {
            }
            column(Deductions_31_; Deductions[31])
            {
            }
            column(Deductions_32_; Deductions[32])
            {
            }
            column(Deductions_33_; Deductions[33])
            {
            }
            column(Deductions_34_; Deductions[34])
            {
            }
            column(Deductions_35_; Deductions[35])
            {
            }
            column(Deductions_36_; Deductions[36])
            {
            }
            column(Deductions_37_; Deductions[37])
            {
            }
            column(Deductions_38_; Deductions[38])
            {
            }
            column(Deductions_39_; Deductions[39])
            {
            }
            column(Deductions_40_; Deductions[40])
            {
            }
            column(Total_Deductions; TotalDeductions)
            {
            }
            column(Total_DeductionsCaption; Total_DeductionsCaptionLbl)
            {
            }
            column(NetPay; NetPay)
            {
            }
            column(First_Name_________Middle_Name_______Last_Name_; "Last Name" + ', ' + "First Name" + ' ' + "Middle Name")
            {
            }
            column(Allowances_1_; Allowances[1])
            {
            }
            column(Allowances_2_; Allowances[2])
            {
            }
            column(Allowances_3_; Allowances[3])
            {
            }
            column(Allowances_4_; Allowances[4])
            {
            }
            column(Allowances_5_; Allowances[5])
            {
            }
            column(Allowances_6_; Allowances[6])
            {
            }
            column(Allowances_7_; Allowances[7])
            {
            }
            column(Allowances_8_; Allowances[8])
            {
            }
            column(Allowances_9_; Allowances[9])
            {
            }
            column(Allowances_10_; Allowances[10])
            {
            }
            column(Allowances_11_; Allowances[11])
            {
            }
            column(Allowances_12_; Allowances[12])
            {
            }
            column(Allowances_13_; Allowances[13])
            {
            }
            column(Allowances_14_; Allowances[14])
            {
            }
            column(Allowances_15_; Allowances[15])
            {
            }
            column(Allowances_16_; Allowances[16])
            {
            }
            column(Allowances_17_; Allowances[17])
            {
            }
            column(Allowances_18_; Allowances[18])
            {
            }
            column(Allowances_19_; Allowances[19])
            {
            }
            column(Allowances_20_; Allowances[20])
            {
            }
            column(Allowances_21_; Allowances[21])
            {
            }
            column(Allowances_22_; Allowances[22])
            {
            }
            column(Allowances_23_; Allowances[23])
            {
            }
            column(Allowances_24_; Allowances[24])
            {
            }
            column(Allowances_25_; Allowances[25])
            {
            }
            column(Allowances_26_; Allowances[26])
            {
            }
            column(Allowances_27_; Allowances[27])
            {
            }
            column(Allowances_28_; Allowances[28])
            {
            }
            column(Allowances_29_; Allowances[29])
            {
            }
            column(Allowances_30_; Allowances[30])
            {
            }
            column(Allowances_31_; Allowances[31])
            {
            }
            column(DataItem46; Totallowances)
            {
            }
            column(STRSUBSTNO__Employees__1__counter_; STRSUBSTNO('Employees=%1', counter))
            {
            }
            column(Prepared_By______________________________________________________; 'Prepared By.....................................................')
            {
            }
            column(Approved_By_____________________________________________________; 'Approved By....................................................')
            {
            }
            column(Approved_By_____________________________________________; 'Approved By............................................')
            {
            }
            column(OtherDeduct; OtherDeduct)
            {
            }
            column(OtherEarn_Control1000000076; OtherEarn)
            {
            }
            column(Deductions_1__Control1000000077; Deductions[1])
            {
            }
            column(Deductions_2__Control1000000078; Deductions[2])
            {
            }
            column(Deductions_3__Control1000000081; Deductions[3])
            {
            }
            column(Deductions_4__Control1000000079; Deductions[4])
            {
            }
            column(Deductions_5__Control1000000077; Deductions[5])
            {
            }
            column(Deductions_6__Control1000000078; Deductions[6])
            {
            }
            column(Deductions_7__Control1000000081; Deductions[7])
            {
            }
            column(Deductions_8__Control1000000079; Deductions[8])
            {
            }
            column(Deductions_9__Control1000000077; Deductions[9])
            {
            }
            column(Deductions_10__Control1000000078; Deductions[10])
            {
            }
            column(Deductions_11__Control1000000081; Deductions[11])
            {
            }
            column(Deductions_12__Control1000000079; Deductions[12])
            {
            }
            column(Deductions_13__Control1000000077; Deductions[13])
            {
            }
            column(Deductions_14__Control1000000078; Deductions[14])
            {
            }
            column(Deductions_15__Control1000000081; Deductions[15])
            {
            }
            column(Deductions_16__Control1000000079; Deductions[16])
            {
            }
            column(Deductions_17__Control1000000077; Deductions[17])
            {
            }
            column(Deductions_18__Control1000000078; Deductions[18])
            {
            }
            column(Deductions_19__Control1000000081; Deductions[19])
            {
            }
            column(Deductions_20__Control1000000079; Deductions[20])
            {
            }
            column(OtherDeduct_Control1000000080; OtherDeduct)
            {
            }
            column(Allowances_1__Control1000000000; Allowances[1])
            {
            }
            column(Allowances_2__Control1000000012; Allowances[2])
            {
            }
            column(Allowances_3__Control1000000013; Allowances[3])
            {
            }
            column(Allowances_4__Control1000000063; Allowances[4])
            {
            }
            column(Allowances_5__Control1000000084; Allowances[5])
            {
            }
            column(Allowances_6__Control1000000085; Allowances[6])
            {
            }
            column(Allowances_7__Control1000000086; Allowances[7])
            {
            }
            column(Allowances_8__Control1000000087; Allowances[8])
            {
            }
            column(Allowances_9__Control1000000088; Allowances[9])
            {
            }
            column(Allowances_10__Control1000000089; Allowances[10])
            {
            }
            column(Allowances_11__Control1000000090; Allowances[11])
            {
            }
            column(Allowances_12__Control1000000091; Allowances[12])
            {
            }
            column(Allowances_13__Control1000000092; Allowances[13])
            {
            }
            column(Allowances_14__Control1000000093; Allowances[14])
            {
            }
            column(Allowances_15__Control1000000094; Allowances[15])
            {
            }
            column(Allowances_16__Control1000000095; Allowances[16])
            {
            }
            column(NetPay_Control1000000102; NetPay)
            {
            }
            column(DataItem6; Totallowances)
            {
            }
            column(MASTER_ROLLCaption; MASTER_ROLLCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Other_AllowancesCaption; Other_AllowancesCaptionLbl)
            {
            }
            column(Total_AllowancesCaption; Total_AllowancesCaptionLbl)
            {
            }
            column(TOTALSCaption; TOTALSCaptionLbl)
            {
            }
            column(TotalAllowances_; Totallowances)
            {
            }
            column(CompanyInf_Picture; CompanyInf.Picture)
            {
            }
            column(NonCashBenefitDesc_1; NonCashBenefitDesc[1])
            {
            }
            column(NonCashBenefitDesc_2; NonCashBenefitDesc[2])
            {
            }
            column(NonCashBenefitDesc_3; NonCashBenefitDesc[3])
            {
            }
            column(NonCashBenefitDesc_4; NonCashBenefitDesc[4])
            {
            }
            column(NonCashBenefitDesc_5; NonCashBenefitDesc[5])
            {
            }
            column(NonCashBenefitDesc_6; NonCashBenefitDesc[6])
            {
            }
            column(NonCashBenefitDesc_7; NonCashBenefitDesc[7])
            {
            }
            column(NonCashBenefitAmount_1; NonCashBenefitAmount[1])
            {
            }
            column(NonCashBenefitAmount_2; NonCashBenefitAmount[2])
            {
            }
            column(NonCashBenefitAmount_3; NonCashBenefitAmount[3])
            {
            }
            column(NonCashBenefitAmount_4; NonCashBenefitAmount[4])
            {
            }
            column(NonCashBenefitAmount_5; NonCashBenefitAmount[5])
            {
            }
            column(NonCashBenefitAmount_6; NonCashBenefitAmount[6])
            {
            }
            column(NonCashBenefitAmount_7; NonCashBenefitAmount[7])
            {
            }
            column(PensionAddback_; PensionAddback)
            {
            }
            column(PensionValue; PensionVal)
            {
            }
            column(ErAmts1; ErAmts[1])
            {
            }
            column(ErAmts2; ErAmts[2])
            {
            }
            column(ErAmts3; ErAmts[3])
            {
            }
            column(ErAmts4; ErAmts[4])
            {
            }
            column(ErAmts5; ErAmts[5])
            {
            }
            column(ErAmts6; ErAmts[6])
            {
            }
            column(ErAmts7; ErAmts[7])
            {
            }
            column(ErAmts8; ErAmts[8])
            {
            }
            column(ErAmts9; ErAmts[9])
            {
            }
            column(ErAmts10; ErAmts[10])
            {
            }
            column(ErDescript1; ErDescript[1])
            {
            }
            column(ErDescript2; ErDescript[2])
            {
            }
            column(ErDescript3; ErDescript[3])
            {
            }
            column(ErDescript4; ErDescript[4])
            {
            }
            column(ErDescript5; ErDescript[5])
            {
            }
            column(ErDescript6; ErDescript[6])
            {
            }
            column(ErDescript7; ErDescript[7])
            {
            }
            column(ErDescript8; ErDescript[8])
            {
            }
            column(ErDescript9; ErDescript[9])
            {
            }
            column(ErDescript10; ErDescript[10])
            {
            }
            column(Voluntary_Pension; VolPension)
            {
            }
            column(Employer_Pension; ERPension)
            {
            }
            column(ShowPension; ShowPen)
            {
            }

            trigger OnAfterGetRecord();
            begin
                Employee.SETRANGE("Pay Period Filter", MonthStartDate);
                Employee.CALCFIELDS(Employee."Total Allowances", Employee."Total Deductions", Basic);
                PensionVal := 0;
                ERPension := 0;
                VolPension := 0;
                BudgetLine := '';
                PensionRate := 0;
                EmpAge := 0;
                CLEAR(Allowances[i]);
                CLEAR(Deductions[j]);
                if n > 0 then
                    CLEAR(ErAmts[n]);
                if K > 0 then
                    CLEAR(NonCashBenefitAmount[K]);
                if Employee."Global Dimension 2 Code" = '' then begin
                    /*Allocation.RESET;
                    Allocation.SETRANGE("Employee No",Employee."No.");
                    if Allocation.FIND('-') then
                      repeat
                        BudgetLine:=BudgetLine+Allocation."Global Dimension 2"+' ';
                        until Allocation.NEXT=0;
                      end else begin
                     BudgetLine:=Employee."Global Dimension 2 Code";
                        end;*/
                    //IF (Employee."Total Allowances"+Employee."Total Deductions")=0 THEN
                    if Employee."Total Allowances" = 0 then
                        CurrReport.SKIP;
                    counter := counter + 1;
                    ShowAds := 4;
                    ShowPen := 3;
                    if Empost.GET(Employee."Posting Group") then begin
                        if Empost."Show Additional Info" = true then begin
                            DateOfBirth := 0D;
                            AnnualSal := 0;

                            AnnualSal := Employee.Basic * 12;
                            ShowAds := 1;
                            if Employee."Date Of Birth" <> 0D then begin
                                if Employee."Pays SSF" = true then begin
                                    EmpAge := ROUND(((TODAY - Employee."Date Of Birth") / 365.2364), 1, '<');
                                    PensionRate := GetPensionRate(EmpAge);
                                    PensionRate := PensionRate / 100;
                                    DateOfBirth := Employee."Date Of Birth";
                                    if Employee."Pension Rate" <> 0 then begin
                                        PensionRate := Employee."Pension Rate";
                                        DateOfBirth := Employee."Date Of Birth";
                                    end;
                                end else begin
                                    PensionRate := Employee."Pension Rate" / 100;
                                end;
                            end;
                        end;
                        if Empost."Combine Pension" = true then
                            ShowPen := 1;
                    end;
                    //MESSAGE('Allowances %1,  Deductions %2,  Net Pay %3',Employee."Total Allowances",Employee."Total Deductions",NetPay);
                    NetPay := Employee."Total Allowances" + Employee."Total Deductions";
                    if ((NetPay <= 0.3) and (NetPay >= -0.3)) then
                        NetPay := 0;

                    //NetPay:=PayrollRounding(NetPay);

                    for i := 1 to NoOfDeductions do begin
                        CLEAR(Allowances[i]);
                        CLEAR(Deductions[j]);
                        if K > 0 then
                            CLEAR(NonCashBenefitAmount[K]);
                        if n > 0 then
                            CLEAR(ErAmts[n]);

                    end;
                    OtherEarn := 0;
                    OtherDeduct := 0;
                    Totallowances := 0;
                    OtherDeduct := 0;
                    TotalDeductions := 0;
                    TotalDeduction := 0;


                    for i := 1 to NoOfEarnings do begin
                        Assignmat.RESET;
                        Assignmat.SETRANGE(Assignmat."Employee No", Employee."No.");
                        Assignmat.SETRANGE(Assignmat.Type, Assignmat.Type::Payment);
                        Assignmat.SETRANGE(Assignmat.Code, Earncode[i]);
                        Assignmat.SETRANGE(Assignmat."Payroll Period", DateSpecified);
                        Assignmat.SETRANGE(Assignmat."Non-Cash Benefit", false);
                        if Assignmat.FIND('-') then begin
                            Assignmat.CALCSUMS(Amount);
                            //Allowances[i]:=FORMAT(PayrollRounding(Assignmat.Amount));

                            //EVALUATE(Allowances[i],FORMAT(PayrollRounding(Assignmat.Amount)));
                            EVALUATE(Allowances[i], FORMAT(Assignmat.Amount));
                            if (Assignmat."Non-Cash Benefit" = false) then
                                Totallowances := Totallowances + Allowances[i];

                            //Allowances[i]:=ChckRound(Allowances[i]);
                            /*EVALUATE(Allowances[i],FORMAT(PayrollRounding(AssignMatrix.Amount)));
                              ArrEarningsAmt[1,i]:=ChckRound(ArrEarningsAmt[1,i]);*/

                        end;
                    end;
                    //Non Cash

                    for K := 1 to NoOfNonCashEarnings do begin
                        NonCashBenefitAmount[K] := 0;
                        Assignmat.RESET;

                        Assignmat.SETRANGE(Assignmat."Employee No", Employee."No.");
                        Assignmat.SETRANGE(Assignmat.Type, Assignmat.Type::Payment);
                        Assignmat.SETRANGE(Assignmat.Code, EarncodeCopy[K]);
                        Assignmat.SETRANGE(Assignmat."Payroll Period", DateSpecified);
                        if Assignmat.FIND('-') then begin
                            Assignmat.CALCSUMS(Amount);
                            if Assignmat.Amount <> 0 then begin
                                //EVALUATE(NonCashBenefitAmount[K],FORMAT(PayrollRounding(Assignmat.Amount)));
                                EVALUATE(NonCashBenefitAmount[K], FORMAT(Assignmat.Amount));
                            end;
                        end;
                    end;
                    //Pension Add back
                    PensionAddback := 0;
                    Assignmat.RESET;
                    Assignmat.SETRANGE(Assignmat."Employee No", Employee."No.");
                    Assignmat.SETRANGE(Assignmat.Type, Assignmat.Type::Deduction);
                    Assignmat.SETRANGE(Assignmat.Paye, true);
                    Assignmat.SETRANGE(Assignmat."Payroll Period", DateSpecified);
                    if Assignmat.FINDFIRST then begin
                        // PensionAddback:=Assignmat."Excess Pension-Add Back";
                    end;



                    /*
                    EarnRec.RESET;
                    EarnRec.SETRANGE(EarnRec."Show on Master Roll",FALSE);
                    IF EarnRec.FINDLAST THEN
                    REPEAT
                    Assignmat.RESET;
                    Assignmat.SETRANGE(Assignmat."Employee No",Employee."No.");
                    Assignmat.SETRANGE(Assignmat."Payroll Period",DateSpecified);
                    Assignmat.SETRANGE(Assignmat.Code,EarnRec.Code);
                    OOTH
                     UNTIL EarnRec.NEXT=0;

                    */

                    //OtherEarn:=Employee."Total Allowances"-Totallowances;
                    //OtherEarn:=ABS(PayrollRounding(Employee."Total Allowances")-PayrollRounding(Totallowances));

                    for i := 1 to NoOfDeductions do begin
                        Assignmat.RESET;
                        Assignmat.SETRANGE(Assignmat."Employee No", Employee."No.");
                        Assignmat.SETRANGE(Assignmat.Type, Assignmat.Type::Deduction);
                        Assignmat.SETRANGE(Assignmat.Code, deductcode[i]);
                        Assignmat.SETRANGE(Assignmat."Payroll Period", DateSpecified);
                        if Assignmat.FIND('-') then begin
                            Deductions[i] := ABS(Assignmat.Amount);
                            EVALUATE(Deductions[i], FORMAT(Assignmat.Amount));
                            TotalDeductions := TotalDeductions + Deductions[i];
                        end;
                    end;
                    //OtherDeduct:=ABS(Employee."Total Deductions"+TotalDeductions);
                    TotalDeductions := ABS(TotalDeductions);

                    //Employer Contibutions and accruals
                    for i := 1 to ErDedCount do begin
                        ErAmts[i] := 0;
                        Assignmat.RESET;
                        Assignmat.SETRANGE(Assignmat."Employee No", Employee."No.");
                        Assignmat.SETRANGE(Assignmat.Type, Assignmat.Type::Deduction);
                        Assignmat.SETRANGE(Assignmat.Code, ErDeds[i]);
                        Assignmat.SETRANGE(Assignmat."Payroll Period", DateSpecified);
                        if Assignmat.FIND('-') then begin
                            ErAmts[i] := ABS(Assignmat."Employer Amount");
                            EVALUATE(ErAmts[i], FORMAT(Assignmat."Employer Amount"));

                        end;
                    end;

                    //Combine Pension
                    Ded.RESET;
                    Ded.SETRANGE("Pension Scheme", true);
                    if Ded.FIND('-') then begin
                        repeat
                            //MESSAGE('Code Ded %1',Ded.Code);
                            Assignmat.RESET;
                            Assignmat.SETRANGE(Assignmat."Employee No", Employee."No.");
                            Assignmat.SETRANGE(Assignmat.Type, Assignmat.Type::Deduction);
                            Assignmat.SETRANGE(Assignmat.Code, Ded.Code);
                            Assignmat.SETRANGE(Assignmat."Payroll Period", DateSpecified);
                            if Assignmat.FIND('-') then begin
                                PensionVal := PensionVal + Assignmat.Amount;
                                VolPension := Assignmat."Employee Voluntary";
                                PensionVal := PensionVal + VolPension;
                                ERPension := Assignmat."Employer Amount";
                                //MESSAGE('Code Asg %1 Amt %2 Code Ded %3',Assignmat.Code,Assignmat.Amount,Ded.Code);
                            end;
                        until Ded.NEXT = 0;
                    end;

                    if PrintToExcel then
                        MakeExcelDataBody;

                end;
            end;

            trigger OnPostDataItem();
            begin
                if PrintToExcel then begin
                    CreateExcelbook;
                    MakeExcelFooter;
                end;
            end;

            trigger OnPreDataItem();
            begin
                Employee.SETRANGE("Posting Group", SatffPost);
                //CurrReport.CREATETOTALS(Allowances,Deductions,OtherEarn,OtherDeduct,NetPay,Employee."Total Deductions");

                //CurrReport.CREATETOTALS(Allowances,Deductions,OtherEarn,OtherDeduct,NetPay);
                HRSetup.GET;

                ExcelBuf.DELETEALL;
                if PrintToExcel then
                    MakeExcelInfo;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                    }
                    field("Month Begin Date"; MonthStartDate)
                    {
                        Caption = 'Month Begin Date';
                    }
                    /*field(SatffPost; SatffPost)
                    {
                        Caption = 'Posting Group';
                        TableRelation = "Staff Posting Group".Code;
                    }*/
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
        //Employee.SETFILTER("Pay Period Filter",'%1',MonthStartDate);

        Employee.SETFILTER("Date Filter", '%1', MonthStartDate);

        DateSpecified := Employee.GETRANGEMIN(Employee."Date Filter");
        EarnRec.RESET;
        EarnRec.SETRANGE(EarnRec."Show on Master Roll", true);
        EarnRec.SETRANGE(EarnRec."Pay Period Filter", MonthStartDate);
        EarnRec.SETRANGE(EarnRec."Non-Cash Benefit", false);
        EarnRec.SETRANGE("Posting Group Filter", SatffPost);
        // NoOfEarnings:=EarnRec.COUNT;
        //MESSAGE(FORMAT(NoOfEarnings));
        if EarnRec.FIND('-') then begin
            repeat
                EarnRec.CALCFIELDS("Total Amount");
                /*
                EarnFact:=0;
                Employ.RESET;
                Employ.SETFILTER("No.",'<>%1','');
                IF Employ.FIND('-') THEN
                  REPEAT
                Assignmat.RESET;
                Assignmat.SETRANGE(Assignmat.Type,Assignmat.Type::Payment);
                Assignmat.SETRANGE("Employee No",Employ."No.");
                Assignmat.SETRANGE(Assignmat.Code,EarnRec.Code);
                Assignmat.SETRANGE(Assignmat."Payroll Period",MonthStartDate);
                Assignmat.CALCSUMS(Amount);
                 EarnRec.CALCFIELDS(EarnRec."Total Amount");
               // IF EarnRec."Total Amount"<>0
                EarnFact:=EarnFact+Assignmat.Amount;
               UNTIL Employ.NEXT=0;
               */
                if EarnRec."Total Amount" <> 0
                  then begin
                    i := i + 1;
                    NoOfEarnings := NoOfEarnings + 1;
                    Earncode[i] := EarnRec.Code;
                    EarnDesc[i] := EarnRec.Description;

                end;
            until EarnRec.NEXT = 0;
            //  MESSAGE(FORMAT(NoOfEarnings));
        end;

        //No of Non Cash
        EarnRecCopy.RESET;
        EarnRecCopy.SETRANGE(EarnRecCopy."Show on Master Roll", true);
        EarnRecCopy.SETRANGE(EarnRecCopy."Pay Period Filter", MonthStartDate);
        EarnRecCopy.SETRANGE(EarnRecCopy."Non-Cash Benefit", true);
        EarnRecCopy.SETRANGE("Posting Group Filter", SatffPost);
        if EarnRecCopy.FIND('-') then begin
            repeat
                EarnRecCopy.CALCFIELDS("Total Amount");
                /*
                NonCashFact:=0;
                 Employ.RESET;
                  Employ.SETFILTER("No.",'<>%1','');
                  IF Employ.FIND('-') THEN
                    REPEAT
               Assignmat.RESET;
               Assignmat.SETRANGE(Assignmat.Code,EarnRecCopy.Code);
               Assignmat.SETRANGE("Employee No",Employ."No.");
               Assignmat.SETRANGE(Assignmat."Payroll Period",MonthStartDate);
               Assignmat.CALCSUMS(Amount);
               NonCashFact:=NonCashFact+Assignmat.Amount;
             // IF EarnRec."Total Amount"<>0
               UNTIL Employ.NEXT=0;
               */
                if EarnRecCopy."Total Amount" <> 0
                    then begin
                    K := K + 1;
                    NoOfNonCashEarnings := NoOfNonCashEarnings + 1;
                    EarncodeCopy[K] := EarnRecCopy.Code;
                    NonCashBenefitDesc[K] := EarnRecCopy.Description;
                end;
            until EarnRecCopy.NEXT = 0;
        end;
        //  MESSAGE(FORMAT(NoOfNonCashEarnings));


        DedRec.RESET;
        DedRec.SETRANGE(DedRec."Show on Master Roll", true);
        DedRec.SETRANGE(DedRec."Pay Period Filter", MonthStartDate);
        DedRec.SETRANGE("Posting Group Filter", SatffPost);
        //DedRec.SETRANGE("Pension Scheme",FALSE);
        //NoOfDeductions:=DedRec.COUNT;
        if DedRec.FIND('-') then begin
            repeat
                DedRec.CALCFIELDS("Total Amount");
                /*
                  DedFact:=0;
                  Employ.RESET;
                  Employ.SETFILTER("No.",'<>%1','');
                  IF Employ.FIND('-') THEN
                    REPEAT
                  Assignmat.RESET;
                  Assignmat.SETRANGE(Assignmat.Type,Assignmat.Type::Deduction);
                  Assignmat.SETRANGE(Assignmat.Code,DedRec.Code);
                  Assignmat.SETRANGE(Assignmat."Payroll Period",MonthStartDate);
                  Assignmat.CALCSUMS(Amount);
                  DedFact:=DedFact+Assignmat.Amount;
                  // DedRec.CALCFIELDS(DedRec."Total Amount");
                  UNTIL Employ.NEXT=0;
                  */
                if DedRec."Total Amount" <> 0
                  then begin
                    j := j + 1;
                    NoOfDeductions := NoOfDeductions + 1;
                    deductcode[j] := DedRec.Code;
                    DedDesc[j] := DedRec.Description;
                end;
            until DedRec.NEXT = 0;
        end;

        //Employer Contribution
        DedER.RESET;
        DedER.SETRANGE(DedER."Show on Master Roll", true);
        DedER.SETRANGE(DedER."Pay Period Filter", MonthStartDate);
        DedER.SETRANGE("Posting Group Filter", SatffPost);
        if DedER.FIND('-') then begin
            repeat
                DedER.CALCFIELDS("Total Amount Employer");
                if DedER."Total Amount Employer" <> 0 then begin
                    n := n + 1;
                    ErDedCount := ErDedCount + 1;
                    ErDeds[n] := DedER.Code;
                    ErDescript[n] := 'ER-' + DedER.Description;
                end;
            until DedER.NEXT = 0;
        end;

        CompanyInf.CALCFIELDS(Picture);
        exit;

    end;

    var
        Allowances: array[80] of Decimal;
        Deductions: array[80] of Decimal;
        [SecurityFiltering(SecurityFilter::Filtered)]
        EarnRecCopy: Record Earnings;
        [SecurityFiltering(SecurityFilter::Filtered)]
        EarnRec: Record Earnings;
        [SecurityFiltering(SecurityFilter::Filtered)]
        DedRec: Record Deductions;
        EarncodeCopy: array[80] of Code[20];
        Earncode: array[80] of Code[20];
        deductcode: array[80] of Code[20];
        EarnDesc: array[80] of Text[50];
        DedDesc: array[80] of Text[50];
        i: Integer;
        j: Integer;
        Assignmat: Record "Assignment Matrix";
        DateSpecified: Date;
        Totallowances: Decimal;
        TotalDeductions: Decimal;
        OtherEarn: Decimal;
        OtherDeduct: Decimal;
        counter: Integer;
        HRSetup: Record "Human Resources Setup";
        NetPay: Decimal;
        //Payroll : Codeunit "Payment- Post";
        MASTER_ROLLCaptionLbl: Label 'MASTER ROLL';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Other_AllowancesCaptionLbl: Label 'Other Allowances';
        Total_AllowancesCaptionLbl: Label 'Total Allowances';
        Total_DeductionsCaptionLbl: Label 'Total Deductions';
        TOTALSCaptionLbl: Label 'TOTALS';
        ExcelBuf: Record "Excel Buffer";
        Text000: Label 'Period: %1';
        Text001: Label 'Master Roll';
        Text002: Label 'Data';
        Text003: Label 'Debit';
        Text004: Label 'Credit';
        Text005: Label 'Company Name';
        Text006: Label 'Report No.';
        Text007: Label 'Report Name';
        Text008: Label 'User ID';
        Text009: Label 'Date';
        NoOfEarnings: Integer;
        NoOfDeductions: Integer;
        PrintToExcel: Boolean;
        MonthStartDate: Date;
        Text010: Label 'Master Roll A2';
        CompanyInf: Record "Company Information";
        TotalDeduction: Decimal;
        NonCashBenefitAmount: array[80] of Decimal;
        NonCashBenefitDesc: array[80] of Text;
        K: Integer;
        NoOfNonCashEarnings: Integer;
        PensionAddback: Decimal;
        [SecurityFiltering(SecurityFilter::Filtered)]
        Ded: Record Deductions;
        PensionVal: Decimal;
        [SecurityFiltering(SecurityFilter::Filtered)]
        Employ: Record Employee;
        EarnFact: Decimal;
        DedFact: Decimal;
        NonCashFact: Decimal;
        EmpAge: Decimal;
        PensionRate: Decimal;
        ShowAds: Integer;
        Empost: Record "Staff Posting Group";
        //Allocation : Record "Allocation Matrix";
        BudgetLine: Text;
        DateOfBirth: Date;
        AnnualSal: Decimal;
        Emp: Record Employee;
        SatffPost: Code[20];
        ErDeds: array[10] of Code[20];
        ErAmts: array[10] of Decimal;
        ErDescript: array[10] of Text;
        [SecurityFiltering(SecurityFilter::Filtered)]
        DedER: Record Deductions;
        n: Integer;
        ErDedCount: Integer;
        VolPension: Decimal;
        ERPension: Decimal;
        ShowPen: Integer;

    procedure CreateExcelbook();
    begin
        ExcelBuf.CreateBookAndOpenExcel(Text010, Text002, Text001, COMPANYNAME, USERID);
        ERROR('');

        ExcelBuf.CreateBook(Text010, Text002);
        ExcelBuf.WriteSheet(Text001, COMPANYNAME, USERID);
    end;

    procedure MakeExcelDataBody();
    var
        BlankFiller: Text[250];
    begin

        BlankFiller := PADSTR(' ', MAXSTRLEN(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(Employee."No.", false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
        for i := 1 to NoOfEarnings do begin
            ExcelBuf.AddColumn(Allowances[i], false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        end;
        ExcelBuf.AddColumn(Totallowances, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        for i := 1 to NoOfDeductions do begin
            ExcelBuf.AddColumn(Deductions[i], false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        end;
        ExcelBuf.AddColumn(TotalDeductions, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(NetPay, false, '', false, false, false, '', ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelHeader();
    var
        BlankFiller: Text[250];
    begin
        BlankFiller := PADSTR(' ', MAXSTRLEN(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('Employee Name', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Employee Number', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        for i := 1 to NoOfEarnings do begin
            ExcelBuf.AddColumn(EarnDesc[i], false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        end;
        ExcelBuf.AddColumn('Gross Pay', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        for i := 1 to NoOfDeductions do begin
            ExcelBuf.AddColumn(DedDesc[i], false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        end;
        ExcelBuf.AddColumn('Total Deductions', true, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Net Pay', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        MakeExcelFooter;
    end;

    procedure MakeExcelFooter();
    var
        BlankFiller: Text[250];
    begin
        BlankFiller := PADSTR(' ', MAXSTRLEN(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."Cell Type"::Text);
        for i := 1 to NoOfEarnings do begin
            ExcelBuf.AddColumn(Allowances[i], false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        end;
        ExcelBuf.AddColumn(Employee."Total Allowances", false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        for i := 1 to NoOfDeductions do begin
            ExcelBuf.AddColumn(Deductions[i], false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        end;
        ExcelBuf.AddColumn(ABS(Employee."Total Deductions"), false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(NetPay, false, '', false, false, false, '', ExcelBuf."Cell Type"::Number);
    end;

    procedure MakeExcelInfo();
    begin
        /*
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text001),FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Master Roll Report A2 Format",FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009),FALSE,'',TRUE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY,FALSE,'',FALSE,FALSE,FALSE,'',ExcelBuf."Cell Type"::Date);
        ExcelBuf.ClearNewRow;
        MakeExcelHeader;
        */

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

    procedure getdate(bddate: Date);
    begin
        MonthStartDate := bddate;
    end;

    local procedure GetPensionRate(Age: Decimal) Rated: Decimal;
    var
        Lines: Record "Age Based Lines";
        Header: Record "Age Based Calculations";
    begin
        Header.RESET;
        Header.SETRANGE(Type, Header.Type::Earning);
        if Header.FINDFIRST then begin
            Lines.RESET;
            Lines.SETRANGE(Code, Header.No);
            if Lines.FIND('-') then begin
                repeat
                    if ((Age >= Lines."Lower Limit") and (Age <= Lines."Max Limit")) then
                        Rated := Lines.Percentage;
                until Lines.NEXT = 0;
            end;
        end;
    end;
}

