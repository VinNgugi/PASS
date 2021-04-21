report 51513205 "Master Roll New Report"
{

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Master Roll New Report.rdl';
    Caption = 'Master Roll New Report';

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
            dataitem(Employee; Employee)
            {
                DataItemTableView = SORTING("No.") where(Status = const(Active));
                RequestFilterFields = "No.", Status, "Posting Group";

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
                column(MonthStartDate; MonthStartDate)
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
                column(ErContribution_1; ErContribution[1])
                {

                }
                column(ErContribution_2; ErContribution[2])
                {

                }
                column(ErContribution_3; ErContribution[3])
                {

                }
                column(ErContribution_4; ErContribution[4])
                {

                }
                column(ErContribution_5; ErContribution[5])
                {

                }
                column(ErContribution_6; ErContribution[6])
                {

                }
                column(ErContribution_7; ErContribution[7])
                {

                }
                column(ErContribution_8; ErContribution[8])
                {

                }
                column(ErContribution_9; ErContribution[9])
                {

                }
                column(ErContribution_10; ErContribution[10])
                {

                }
                column(ErContribution_11; ErContribution[11])
                {

                }
                column(ErContribution_12; ErContribution[12])
                {

                }
                column(ErContribution_13; ErContribution[13])
                {

                }
                column(ErContribution_14; ErContribution[14])
                {

                }
                column(ErContribution_15; ErContribution[15])
                {

                }
                column(ErContribution_16; ErContribution[16])
                {

                }
                column(ErContribution_17; ErContribution[17])
                {

                }
                column(ErContribution_18; ErContribution[18])
                {

                }
                column(ErContribution_19; ErContribution[19])
                {

                }
                column(ErContribution_20; ErContribution[20])
                {

                }

                trigger OnPredataItem()
                var
                    myInt: Integer;
                begin
                    Clear(i);
                    Clear(j);
                    Clear(EarnCode);
                    Clear(EarnDesc);
                    Clear(Allowances);
                    Clear(DeductCode);
                    Clear(DedDesc);
                    Clear(Deductions);
                    Clear(ErContribution);
                    i := 0;
                    j := 0;
                    EarningsCount := 0;
                    DeductionCount := 0;


                    Employee.SETFILTER("Date Filter", '%1', MonthStartDate);

                    //******************Earnings
                    EarnRec.RESET;
                    EarnRec.SETRANGE(EarnRec."Show on Master Roll", true);
                    EarnRec.SETRANGE(EarnRec."Pay Period Filter", MonthStartDate);
                    EarnRec.SETRANGE(EarnRec."Non-Cash Benefit", false);
                    if EarnRec.FindSet() then
                        repeat
                            EarnRec.CalcFields("Total Amount");
                            if EarnRec."Total Amount" > 0 then begin
                                i := i + 1;
                                EarningsCount := EarningsCount + 1;
                                EarnCode[i] := EarnRec.Code;
                                EarnDesc[i] := EarnRec.Description;
                            end;
                        until EarnRec.Next() = 0;

                    //******************Deductions
                    DedRec.RESET;
                    DedRec.SETRANGE(DedRec."Show on Master Roll", true);
                    DedRec.SETRANGE(DedRec."Pay Period Filter", MonthStartDate);
                    if DedRec.FindSet() then
                        repeat
                            DedRec.CalcFields("Total Amount", "Total Amount Employer");
                            if (ABS(DedRec."Total Amount") > 0) or (Abs(DedRec."Total Amount Employer") > 0) then begin
                                j := j + 1;
                                DeductionCount := DeductionCount + 1;
                                DeductCode[j] := DedRec.Code;
                                DedDesc[j] := DedRec.Description;
                            end;
                        until DedRec.Next() = 0;


                end;

                trigger OnAfterGetRecord()
                var
                    myInt: Integer;
                begin
                    Clear(Allowances);
                    Clear(Deductions);
                    Clear(ErContribution);
                    TotalAllowances := 0;
                    TotalDeductions := 0;

                    Employee.SETRANGE("Pay Period Filter", MonthStartDate);
                    Employee.CALCFIELDS(Employee."Total Allowances", Employee."Total Deductions", Basic);
                    //********************************Sum Earnings**************************************//
                    for i := 1 to EarningsCount do begin
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Type, AssignMatrix.Type::Payment);
                        AssignMatrix.SETRANGE(AssignMatrix.Code, Earncode[i]);
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", MonthStartDate);
                        AssignMatrix.SETRANGE(AssignMatrix."Non-Cash Benefit", false);
                        if AssignMatrix.FIND('-') then begin
                            AssignMatrix.CALCSUMS(Amount);
                            EVALUATE(Allowances[i], FORMAT(AssignMatrix.Amount));
                            if (AssignMatrix."Non-Cash Benefit" = false) then
                                TotalAllowances := TotalAllowances + Allowances[i];

                        end;
                    end;
                    //********************************Sum Deductions**************************************//
                    for j := 1 to DeductionCount do begin
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Type, AssignMatrix.Type::Deduction);
                        AssignMatrix.SETRANGE(AssignMatrix.Code, DeductCode[j]);
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", MonthStartDate);
                        if AssignMatrix.FIND('-') then begin
                            Deductions[j] := ABS(AssignMatrix.Amount);
                            EVALUATE(Deductions[j], FORMAT(ABS(AssignMatrix.Amount)));
                            TotalDeductions := TotalDeductions + Deductions[j];
                        end;
                    end;

                    //********************************Employer Contibutions and accruals
                    for j := 1 to DeductionCount do begin
                        AssignMatrix.RESET;
                        AssignMatrix.SETRANGE(AssignMatrix."Employee No", Employee."No.");
                        AssignMatrix.SETRANGE(AssignMatrix.Type, AssignMatrix.Type::Deduction);
                        AssignMatrix.SETRANGE(AssignMatrix.Code, DeductCode[j]);
                        AssignMatrix.SETRANGE(AssignMatrix."Payroll Period", MonthStartDate);
                        if AssignMatrix.FIND('-') then begin
                            if AssignMatrix."Employer Amount" <> 0 then begin
                                ErContribution[j] := ABS(AssignMatrix."Employer Amount");
                                EVALUATE(ErContribution[j], FORMAT(AssignMatrix."Employer Amount"));
                            end;


                        end;
                    end;
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
                group(Options)
                {
                    Caption = 'Options';
                    /*field(PrintToExcel; PrintToExcel)
                    {
                        Caption = 'Print to Excel';
                    }*/
                    field("Month Begin Date"; MonthStartDate)
                    {
                        Caption = 'Month Begin Date';
                    }
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
        i: Integer;
        j: Integer;
        AssignMatrix: Record "Assignment Matrix";
        EarnRec: Record Earnings;
        EarnCode: array[20] of Code[20];
        EarnDesc: array[20] of Text[50];
        Allowances: array[20] of Decimal;
        TotalAllowances: Decimal;
        EarningsCount: Integer;
        DedRec: Record Deductions;
        DeductCode: array[20] of Code[20];
        DedDesc: array[20] of Text[50];
        Deductions: array[20] of Decimal;
        ErContribution: array[20] of Decimal;
        TotalDeductions: Decimal;
        DeductionCount: Integer;
        MonthStartDate: Date;
        PrintToExcel: Boolean;

}