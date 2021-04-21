report 51513173 "Reconciliation Summary"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Reconciliation Summary.rdl';
    Caption = 'Reconciliation Summary';

    dataset
    {
        dataitem(Earnings; Earnings)
        {
            DataItemTableView = WHERE ("Show on Master Roll" = CONST (true), "Non-Cash Benefit" = CONST (false));
            RequestFilterFields = "Code";
            column(CompInformation_Picture_; CompInformation.Picture)
            {
            }
            column(PreviousMonthStartDate_; PreviousMonthStartDate)
            {
            }
            column(PFNo_; PFNo)
            {
            }
            column(Name_; Name)
            {
            }
            column(PreviousAmount_; PreviousAmount)
            {
            }
            column(CurrentAmount_; CurrentAmount)
            {
            }
            column(MonthStartDate; MonthStartDate)
            {
            }
            column(SumCurrentAmount_; SumCurrentAmount)
            {
            }
            column(SumLastMonth; SumLastMonth)
            {
            }
            column(PreviousAmountTotal_; PreviousAmountTotal)
            {
            }
            column(Code_EarningsX1; Earnings.Code)
            {
            }
            column(Description_EarningsX1; Earnings.Description)
            {
            }
            column(TotalAmount_EarningsX1; Earnings."Total Amount")
            {
            }
            column(Difference_; Difference)
            {
            }
            column(hidethis; hidethis)
            {
            }
            column(GrossPayslip; GrossPayslip)
            {
            }
            column(NSSF; NSSF)
            {
            }
            column(pension; pension)
            {
            }
            column(GrossPayslip2; GrossPayslip2)
            {
            }
            column(NSSF2; NSSF2)
            {
            }
            column(pension2; pension2)
            {
            }
            column(earningtot; earningtot)
            {
            }
            column(earningtot2; earningtot2)
            {
            }

            trigger OnAfterGetRecord();
            begin

                AssignmentMatrixCopy.RESET;
                PreviousAmount := 0;
                CurrentAmount := 0;
                PreviousAmountTotal := 0;
                hidethis := 0;
                AssignmentMatrixCopy.RESET;
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy."Payroll Period", '%1', PreviousMonthStartDate);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Type, '%1', AssignmentMatrixCopy.Type::Payment);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Code, Earnings.Code);
                if AssignmentMatrixCopy.FINDSET then
                    repeat
                        PreviousAmount := PreviousAmount + AssignmentMatrixCopy.Amount;
                    until AssignmentMatrixCopy.NEXT = 0;
                PreviousAmountTotal := PreviousAmountTotal + PreviousAmount;
                //IF Earnings.Code='001' then begin
                //   Message('%1', PreviousAmountTotal);
                //end;

                //Current month earnings
                AssignmentMatrixCopy.RESET;
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy."Payroll Period", '%1', MonthStartDate);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Type, '%1', AssignmentMatrixCopy.Type::Payment);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Code, '%1', Earnings.Code);
                if AssignmentMatrixCopy.FINDSET then
                    repeat
                        CurrentAmount := CurrentAmount + AssignmentMatrixCopy.Amount;
                    until AssignmentMatrixCopy.NEXT = 0;
                SumCurrentAmount := SumCurrentAmount + CurrentAmount;
                // IF Earnings.Code='001' then begin
                //Message('%1..%2', PreviousAmountTotal,SumCurrentAmount);
                // end;

                Difference := Difference + ABS(CurrentAmount - PreviousAmount);

                if (PreviousAmountTotal = 0) and (CurrentAmount = 0) then begin
                    hidethis := 7;
                    CurrReport.SKIP;
                    //Message('...');
                end;

                if Earnings.Description = '' then begin
                    CurrReport.SKIP;
                end;
            end;

            trigger OnPreDataItem();
            begin
                PreviousMonthStartDate := CALCDATE('-1M', MonthStartDate);
                CompInformation.CALCFIELDS(Picture);

                Earnings.SETRANGE(Earnings."Pay Period Filter", MonthStartDate);

                //PreviousAmountTotal:=0;
                //============++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                //================================================================================
                Earn.RESET;
                Earn.SETRANGE(Earn."Show on Master Roll", true);
                // Earn.SETRANGE(Earn."Earning Type",Earn."Earning Type"::"Normal Earning");
                //     Earn.SETRANGE(Earn."Non-Cash Benefit",FALSE);
                if Earn.FIND('-') then begin
                    repeat
                        AssignM7.RESET;
                        AssignM7.SETRANGE(AssignM7."Payroll Period", MonthStartDate);
                        AssignM7.SETRANGE(Type, AssignM7.Type::Payment);
                        AssignM7.SETRANGE(AssignM7."Non-Cash Benefit", false);
                        AssignM7.SETRANGE(Code, Earn.Code);
                        if AssignM7.FIND('-') then begin
                            repeat
                                GrossPayslip := GrossPayslip + PayrollRounding(AssignM7.Amount);
                                //  GrossPayslip:=GrossPayslip+AssignM7.Amount;
                            until AssignM7.NEXT = 0;
                        end;
                    until Earn.NEXT = 0;
                end; //Message('%1',GrossPayslip);
                     //=======================================================================================
                     //================================================================================
                     //Not required at KERRA ====BKK
                     /*

                          Ded.RESET;
                          Ded.SETRANGE(Ded."Institution Code",'NSSF');
                          IF Ded.FIND('-') THEN BEGIN REPEAT
                            AssignM7.RESET;
                            AssignM7.SETRANGE(AssignM7."Payroll Period",MonthStartDate);
                            AssignM7.SETRANGE(Type,AssignM7.Type::Deduction);
                            AssignM7.SETRANGE(Code,Ded.Code);
                            IF AssignM7.FIND('-') THEN BEGIN    REPEAT
                                NSSF:=NSSF+ABS(ROUND(AssignM7.Amount,0.01));
                            UNTIL AssignM7.NEXT=0;
                            END;
                           UNTIL Ded.NEXT=0;
                          END; //Message('%1',NSSF);
                          //=======================================================================================
                          //================================================================================
                            HRSETUP.RESET;
                            HRSETUP.GET;
                            AssignM7.RESET;
                            AssignM7.SETRANGE(AssignM7."Payroll Period",MonthStartDate);
                            AssignM7.SETRANGE(Type,AssignM7.Type::Deduction);
                            AssignM7.SETFILTER(Code,'%1|%2',HRSETUP."Health Deduction Code",HRSETUP."Education Deduction Cost");
                            IF AssignM7.FIND('-') THEN BEGIN    REPEAT
                                pension:=pension+ABS(ROUND(AssignM7."Employer Amount",0.01));
                            UNTIL AssignM7.NEXT=0;
                            END;
                            earningtot:=GrossPayslip+NSSF+pension;

                      */
                     //BKK
                     //=======================================================================================
                     //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                     //============++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                     //================================================================================
                Earn.RESET;
                Earn.SETRANGE(Earn."Show on Master Roll", true);
                //Earn.SETRANGE(Earn."Earning Type",Earn."Earning Type"::"Normal Earning");
                //Earn.SETRANGE(Earn."Non-Cash Benefit",FALSE);
                if Earn.FIND('-') then begin
                    repeat
                        AssignM7.RESET;
                        AssignM7.SETRANGE(AssignM7."Payroll Period", PreviousMonthStartDate);
                        AssignM7.SETRANGE(Type, AssignM7.Type::Payment);
                        AssignM7.SETRANGE(AssignM7."Non-Cash Benefit", false);
                        AssignM7.SETRANGE(Code, Earn.Code);
                        if AssignM7.FIND('-') then begin
                            repeat
                                GrossPayslip2 := GrossPayslip2 + PayrollRounding(AssignM7.Amount);
                                //GrossPayslip2:=GrossPayslip2+AssignM7.Amount;
                            until AssignM7.NEXT = 0;
                        end;
                    until Earn.NEXT = 0;
                end; //Message('%1',GrossPayslip2);
                     //=======================================================================================
                     //================================================================================
                Ded.RESET;
                Ded.SETRANGE(Ded."Institution Code", 'NSSF');
                if Ded.FIND('-') then begin
                    repeat
                        AssignM7.RESET;
                        AssignM7.SETRANGE(AssignM7."Payroll Period", PreviousMonthStartDate);
                        AssignM7.SETRANGE(Type, AssignM7.Type::Deduction);
                        AssignM7.SETRANGE(Code, Ded.Code);
                        if AssignM7.FIND('-') then begin
                            repeat
                                NSSF2 := NSSF2 + ABS(ROUND(AssignM7.Amount, 0.01));
                            until AssignM7.NEXT = 0;
                        end;
                    until Ded.NEXT = 0;
                end; //Message('%1',NSSF2);
                     //=======================================================================================
                     /*//================================================================================
                       HRSETUP.RESET;
                       HRSETUP.GET;
                       AssignM7.RESET;
                       AssignM7.SETRANGE(AssignM7."Payroll Period",PreviousMonthStartDate);
                       AssignM7.SETRANGE(Type,AssignM7.Type::Deduction);
                       AssignM7.SETFILTER(Code,'%1|%2',HRSETUP."Health Deduction Code",HRSETUP."Education Deduction Cost");
                       IF AssignM7.FIND('-') THEN BEGIN    REPEAT
                           pension2:=pension2+ABS(ROUND(AssignM7."Employer Amount",0.01));
                       UNTIL AssignM7.NEXT=0;
                       END;
                       */
                     //=======================================================================================
                     //================================================================================
                earningtot2 := GrossPayslip2 + NSSF2 + pension2;
                //=======================================================================================
                //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

            end;
        }
        dataitem(Deductions; Deductions)
        {
            RequestFilterFields = "Code";
            column(PreviousAmount_2; PreviousAmount2)
            {
            }
            column(SumCurrentAmount_2; SumCurrentAmount2)
            {
            }
            column(SumLastMonth2; SumLastMonth2)
            {
            }
            column(PreviousAmountTotal_2; PreviousAmountTotal2)
            {
            }
            column(CurrentAmount_2; CurrentAmount2)
            {
            }
            column(Description_DeductionsX1; Deductions.Description)
            {
            }
            column(hidethis2; hidethis2)
            {
            }

            trigger OnAfterGetRecord();
            begin
                //====================================================================
                // Message('%1', Deductions.Description);
                //====================================================================
                //AssignmentMatrixCopy.RESET;
                PreviousAmount2 := 0;
                CurrentAmount2 := 0;
                PreviousAmountTotal2 := 0;
                hidethis2 := 0;
                AssignmentMatrixCopy.RESET;
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy."Payroll Period", '%1', PreviousMonthStartDate);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Type, '%1', AssignmentMatrixCopy.Type::Deduction);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Code, Deductions.Code);
                if AssignmentMatrixCopy.FINDSET then
                    repeat
                        PreviousAmount2 := PreviousAmount2 + AssignmentMatrixCopy.Amount;
                    until AssignmentMatrixCopy.NEXT = 0;
                PreviousAmountTotal2 := PreviousAmountTotal2 + PreviousAmount;
                //IF Earnings.Code='001' then begin
                //   Message('%1', PreviousAmountTotal);
                //end;

                //Current month earnings
                AssignmentMatrixCopy.RESET;
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy."Payroll Period", '%1', MonthStartDate);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Type, '%1', AssignmentMatrixCopy.Type::Deduction);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Code, '%1', Deductions.Code);
                if AssignmentMatrixCopy.FINDSET then
                    repeat
                        CurrentAmount2 := CurrentAmount2 + AssignmentMatrixCopy.Amount;
                    until AssignmentMatrixCopy.NEXT = 0;
                SumCurrentAmount2 := SumCurrentAmount2 + CurrentAmount;
                // IF Earnings.Code='001' then begin
                //Message('Previous Amt %1,  Current Amount  %2', PreviousAmount2,SumCurrentAmount2);
                // end;

                Difference := Difference + ABS(CurrentAmount - PreviousAmount);
                if (PreviousAmount2 = 0) and (CurrentAmount2 = 0) then begin
                    hidethis2 := 0;
                    //Message('%1',Deductions.Description);
                    //CurrReport.SKIP;
                    //Message('...');
                    // Message('Previous Amt %1,  Current Amount  %2', PreviousAmount2,SumCurrentAmount2);
                    CurrReport.SKIP;
                end;
                if Deductions.Description = '' then begin
                    CurrReport.SKIP;
                end;
            end;

            trigger OnPreDataItem();
            begin
                PreviousMonthStartDate := CALCDATE('-1M', MonthStartDate);
                CompInformation.CALCFIELDS(Picture);

                Earnings.SETRANGE(Earnings."Pay Period Filter", MonthStartDate);

                //PreviousAmountTotal:=0;
            end;
        }
        dataitem(NonCashBenefits; Earnings)
        {
            DataItemTableView = WHERE ("Non-Cash Benefit" = CONST (true));
            column(PreviousAmountNonCash_; PreviousAmountNonCash)
            {
            }
            column(CurrentAmountNonCash_; CurrentAmountNonCash)
            {
            }
            column(Code_NonCashBenefits; NonCashBenefits.Code)
            {
            }
            column(Description_NonCashBenefits; NonCashBenefits.Description)
            {
            }

            trigger OnAfterGetRecord();
            begin
                AssignmentMatrixCopy.RESET;
                PreviousAmountNonCash := 0;
                CurrentAmountNonCash := 0;
                AssignmentMatrixCopy.RESET;
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy."Payroll Period", '%1', PreviousMonthStartDate);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Type, '%1', AssignmentMatrixCopy.Type::Payment);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Code, NonCashBenefits.Code);
                if AssignmentMatrixCopy.FINDSET then
                    repeat
                        PreviousAmountNonCash := PreviousAmountNonCash + AssignmentMatrixCopy.Amount;
                    until AssignmentMatrixCopy.NEXT = 0;
                // PreviousAmountTotal:=PreviousAmountTotal+PreviousAmount;


                //Current month non cash earnings
                AssignmentMatrixCopy.RESET;
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy."Payroll Period", '%1', MonthStartDate);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Type, '%1', AssignmentMatrixCopy.Type::Payment);
                AssignmentMatrixCopy.SETFILTER(AssignmentMatrixCopy.Code, '%1', NonCashBenefits.Code);
                if AssignmentMatrixCopy.FINDSET then
                    repeat
                        CurrentAmountNonCash := CurrentAmountNonCash + AssignmentMatrixCopy.Amount;
                    until AssignmentMatrixCopy.NEXT = 0;
                // SumCurrentAmount:=SumCurrentAmount+CurrentAmount;
            end;

            trigger OnPreDataItem();
            begin
                SETRANGE(NonCashBenefits."Pay Period Filter", MonthStartDate);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(MonthStartDate; MonthStartDate)
                {
                    Caption = 'Month Start Date';
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

    var
        MonthStartDate: Date;
        EarningsX1Copy: Record Earnings;
        CompInformation: Record "Company Information";
        PreviousMonthStartDate: Date;
        PreviousEarningAmount: Decimal;
        EmpRec: Record Employee;
        AssignmentMatrixCopy: Record "Assignment Matrix";
        AssignM7: Record "Assignment Matrix";
        Name: Text;
        PFNo: Code[10];
        CurrentAmount: Decimal;
        CurrentAmount2: Decimal;
        PreviousAmount: Decimal;
        Difference: Decimal;
        SumCurrentAmount: Decimal;
        SumLastMonth: Decimal;
        PreviousAmountTotal: Decimal;
        PreviousAmount2: Decimal;
        SumCurrentAmount2: Decimal;
        SumLastMonth2: Decimal;
        PreviousAmountTotal2: Decimal;
        hidethis: Integer;
        hidethis2: Integer;
        Earn: Record Earnings;
        Ded: Record Deductions;
        GrossPayslip: Decimal;
        NSSF: Decimal;
        pension: Decimal;
        GrossPayslip2: Decimal;
        NSSF2: Decimal;
        pension2: Decimal;
        HRSETUP: Record "Human Resources Setup";
        earningtot: Decimal;
        earningtot2: Decimal;
        dedtotals: Decimal;
        PreviousAmountNonCash: Decimal;
        CurrentAmountNonCash: Decimal;

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
}

