report 51513208 "Employer P10 Report"
{
    //UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Employer P10 Report.rdl';
    caption = 'Employer P10 Report';

    dataset
    {
        dataitem("Company Information"; "Company Information")
        {
            column(Name; Name)
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
            column(VAT_Registration_No_; "VAT Registration No.")
            {

            }
            dataitem(Employee; Employee)
            {
                RequestFilterFields = "No.", "Employee Posting Group", "Date Filter";
                column(No_; "No.")
                {

                }
                column(First_Name; "First Name")
                {

                }
                column(Middle_Name; "Middle Name")
                {

                }
                column(Last_Name; "Last Name")
                {

                }
                column(Date_Of_Birth; "Date Of Birth")
                {

                }
                column(Gender; Gender)
                {

                }
                column(Job_Title; "Job Title")
                {

                }
                column(Contract_Type; "Contract Type")
                {

                }
                column(WCF_Number; "WCF Number")
                {

                }
                column(Date_Filter; "Date Filter")
                {

                }
                column(Employee_Address; Address)
                {

                }
                column(Residential_Address; "Residential Address")
                {

                }
                column(PeriodText; PeriodText)
                {

                }
                column(DateFilter; DateFilter)
                {

                }
                column(EarnDesc_1; EarnDesc[1])
                {

                }
                column(EarnDesc_2; EarnDesc[2])
                {

                }
                column(EarnDesc_3; EarnDesc[3])
                {

                }
                column(EarnDesc_4; EarnDesc[4])
                {

                }
                column(EarnDesc_5; EarnDesc[5])
                {

                }
                column(EarnDesc_6; EarnDesc[6])
                {

                }
                column(EarnDesc_7; EarnDesc[7])
                {

                }
                column(EarnDesc_8; EarnDesc[8])
                {

                }
                column(EarnDesc_9; EarnDesc[9])
                {

                }
                column(EarnDesc_10; EarnDesc[10])
                {

                }
                column(EarnDesc_11; EarnDesc[11])
                {

                }
                column(EarnDesc_12; EarnDesc[12])
                {

                }
                column(EarnDesc_13; EarnDesc[13])
                {

                }
                column(EarnDesc_14; EarnDesc[14])
                {

                }
                column(EarnDesc_15; EarnDesc[15])
                {

                }
                column(EarnDesc_16; EarnDesc[16])
                {

                }
                column(EarnDesc_17; EarnDesc[17])
                {

                }
                column(EarnDesc_18; EarnDesc[18])
                {

                }
                column(EarnDesc_19; EarnDesc[19])
                {

                }
                column(EarnDesc_20; EarnDesc[20])
                {

                }
                column(Allowances_1; Allowances[1])
                {

                }
                column(Allowances_2; Allowances[2])
                {

                }
                column(Allowances_3; Allowances[3])
                {

                }
                column(Allowances_4; Allowances[4])
                {

                }
                column(Allowances_5; Allowances[5])
                {

                }
                column(Allowances_6; Allowances[6])
                {

                }
                column(Allowances_7; Allowances[7])
                {

                }
                column(Allowances_8; Allowances[8])
                {

                }
                column(Allowances_9; Allowances[9])
                {

                }
                column(Allowances_10; Allowances[10])
                {

                }
                column(Allowances_11; Allowances[11])
                {

                }
                column(Allowances_12; Allowances[12])
                {

                }
                column(Allowances_13; Allowances[13])
                {

                }
                column(Allowances_14; Allowances[14])
                {

                }
                column(Allowances_15; Allowances[15])
                {

                }
                column(Allowances_16; Allowances[16])
                {

                }
                column(Allowances_17; Allowances[17])
                {

                }
                column(Allowances_18; Allowances[18])
                {

                }
                column(Allowances_19; Allowances[19])
                {

                }
                column(Allowances_20; Allowances[20])
                {

                }
                column(TotalAllowances; TotalAllowances)
                {

                }
                column(DedDesc_1; DedDesc[1])
                {

                }
                column(DedDesc_2; DedDesc[2])
                {

                }
                column(DedDesc_3; DedDesc[3])
                {

                }
                column(DedDesc_4; DedDesc[4])
                {

                }
                column(DedDesc_5; DedDesc[5])
                {

                }
                column(DedDesc_6; DedDesc[6])
                {

                }
                column(DedDesc_7; DedDesc[7])
                {

                }
                column(DedDesc_8; DedDesc[8])
                {

                }
                column(DedDesc_9; DedDesc[9])
                {

                }
                column(DedDesc_10; DedDesc[10])
                {

                }
                column(DedDesc_11; DedDesc[11])
                {

                }
                column(DedDesc_12; DedDesc[12])
                {

                }
                column(DedDesc_13; DedDesc[13])
                {

                }
                column(DedDesc_14; DedDesc[14])
                {

                }
                column(DedDesc_15; DedDesc[15])
                {

                }
                column(DedDesc_16; DedDesc[16])
                {

                }
                column(DedDesc_17; DedDesc[17])
                {

                }
                column(DedDesc_18; DedDesc[18])
                {

                }
                column(DedDesc_19; DedDesc[19])
                {

                }
                column(DedDesc_20; DeductCode[20])
                {

                }
                column(Deductions_1; Deductions[1])
                {

                }
                column(Deductions_2; Deductions[2])
                {

                }
                column(Deductions_3; Deductions[3])
                {

                }
                column(Deductions_4; Deductions[4])
                {

                }
                column(Deductions_5; Deductions[5])
                {

                }
                column(Deductions_6; Deductions[6])
                {

                }
                column(Deductions_7; Deductions[7])
                {

                }
                column(Deductions_8; Deductions[8])
                {

                }
                column(Deductions_9; Deductions[9])
                {

                }
                column(Deductions_10; Deductions[10])
                {

                }
                column(Deductions_11; Deductions[11])
                {

                }
                column(Deductions_12; Deductions[12])
                {

                }
                column(Deductions_13; Deductions[13])
                {

                }
                column(Deductions_14; Deductions[14])
                {

                }
                column(Deductions_15; Deductions[15])
                {

                }
                column(Deductions_16; Deductions[16])
                {

                }
                column(Deductions_17; Deductions[17])
                {

                }
                column(Deductions_18; Deductions[18])
                {

                }
                column(Deductions_19; Deductions[19])
                {

                }
                column(Deductions_20; Deductions[20])
                {

                }
                column(TotalDeductions; TotalDeductions)
                {

                }
                column(TaxableAmount; TaxableAmount)
                {

                }
                column(PAYEAmt; PAYEAmt)
                {

                }
                column(PensionAmt; PensionAmt)
                {

                }

                trigger OnPreDataItem()
                var
                    myInt: Integer;
                begin


                    if Employee.GETFILTER("Date Filter") <> '' then
                        DateFilter := Employee.GetFilter("Date Filter")
                    else
                        DateFilter := '..' + Format(Today);

                    Clear(i);
                    Clear(j);
                    Clear(EarnCode);
                    Clear(EarnDesc);
                    Clear(Allowances);
                    Clear(DeductCode);
                    Clear(DedDesc);
                    Clear(Deductions);

                    i := 0;
                    j := 0;
                    EarningsCount := 0;
                    DeductionCount := 0;

                    //******************Earnings
                    EarnRec.RESET;
                    EarnRec.SETRANGE(EarnRec."Show on Master Roll", true);
                    //EarnRec.SETRANGE(EarnRec."Non-Cash Benefit", false);
                    EarnRec.SetFilter("Pay Period Filter", DateFilter);
                    if EarnRec.FindSet() then
                        repeat
                            EarnRec.CalcFields("Total Amount");
                            i := i + 1;
                            EarningsCount := EarningsCount + 1;
                            EarnCode[i] := EarnRec.Code;
                            EarnDesc[i] := EarnRec.Description;
                        until EarnRec.Next() = 0;

                    //******************Deductions
                    DedRec.RESET;
                    DedRec.SETRANGE(DedRec."Show on Master Roll", true);
                    DedRec.SetFilter(DedRec."Pay Period Filter", DateFilter);
                    if DedRec.FindSet() then
                        repeat
                            DedRec.CalcFields("Total Amount");
                            j := j + 1;
                            DeductionCount := DeductionCount + 1;
                            DeductCode[j] := DedRec.Code;
                            DedDesc[j] := DedRec.Description;
                        until DedRec.Next() = 0;



                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Clear(Allowances);
                    Clear(Deductions);
                    TaxableAmount := 0;
                    TotalAllowances := 0;
                    TotalDeductions := 0;
                    PAYEAmt := 0;
                    PensionAmt := 0;

                    //********************************Sum Earnings**************************************//
                    for i := 1 to EarningsCount do begin
                        Earn := 0;
                        AssignmentMatrix.RESET;
                        AssignmentMatrix.SETRANGE(AssignmentMatrix."Employee No", Employee."No.");
                        AssignmentMatrix.SETRANGE(AssignmentMatrix.Type, AssignmentMatrix.Type::Payment);
                        AssignmentMatrix.SETRANGE(AssignmentMatrix.Code, EarnCode[i]);
                        AssignmentMatrix.SetFilter(AssignmentMatrix."Payroll Period", DateFilter);
                        //AssignmentMatrix.SETRANGE(AssignmentMatrix."Non-Cash Benefit", false);
                        if AssignmentMatrix.FindSet() then
                            repeat
                                Earn := Earn + AssignmentMatrix.Amount;

                                if AssignmentMatrix.Taxable then
                                    TaxableAmount := TaxableAmount + AssignmentMatrix.Amount;

                            until AssignmentMatrix.Next() = 0;

                        EVALUATE(Allowances[i], FORMAT(Earn));
                        TotalAllowances := TotalAllowances + Earn;

                    end;
                    //********************************Sum Deductions**************************************//
                    for j := 1 to DeductionCount do begin
                        DedAmount := 0;
                        AssignmentMatrix.RESET;
                        AssignmentMatrix.SETRANGE(AssignmentMatrix."Employee No", Employee."No.");
                        AssignmentMatrix.SETRANGE(AssignmentMatrix.Type, AssignmentMatrix.Type::Deduction);
                        AssignmentMatrix.SETRANGE(AssignmentMatrix.Code, DeductCode[j]);
                        AssignmentMatrix.SetFilter(AssignmentMatrix."Payroll Period", DateFilter);
                        if AssignmentMatrix.FindSet() then
                            repeat
                                DedAmount := DedAmount + Abs(AssignmentMatrix.Amount);

                                if AssignmentMatrix."Tax Deductible" then
                                    TaxableAmount := TaxableAmount - Abs(AssignmentMatrix.Amount);

                                if AssignmentMatrix.Paye then
                                    PAYEAmt := PAYEAmt + Abs(AssignmentMatrix.Amount);

                                if DedRec.Get(DeductCode[j], Employee."Country/Region Code") then begin
                                    if DedRec."Pension Scheme" then
                                        PensionAmt := PensionAmt + Abs(AssignmentMatrix.Amount);
                                end;

                            until AssignmentMatrix.Next() = 0;

                        EVALUATE(Deductions[j], FORMAT(ABS(DedAmount)));
                        TotalDeductions := TotalDeductions + DedAmount;

                    end;


                end;


                trigger OnPostDataItem()
                var
                    myInt: Integer;
                begin

                end;
            }
            trigger OnPredataItem()
            var
                myInt: Integer;
            begin
                "Company Information".CalcFields(Picture)
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        EarnRec: Record Earnings;
        DedRec: Record Deductions;
        AssignmentMatrix: Record "Assignment Matrix";
        PeriodText: Text;
        DateFilter: Text;
        EarnCode: array[20] of Code[20];
        EarnDesc: array[20] of Text[50];
        Allowances: array[20] of Decimal;
        DeductCode: array[20] of Code[20];
        DedDesc: array[20] of Text[50];
        Deductions: array[20] of Decimal;
        i: Integer;
        j: Integer;
        EarningsCount: Integer;
        DeductionCount: Integer;
        TotalAllowances: Decimal;
        TotalDeductions: Decimal;
        PAYEAmt: Decimal;
        TaxableAmount: Decimal;
        Earn: Decimal;
        DedAmount: Decimal;
        PensionAmt: Decimal;
}