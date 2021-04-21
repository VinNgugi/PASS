report 51513120 "Negative Pay"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Negative Pay.rdl';
    Caption = 'Negative Pay';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING ("No.") WHERE (Status = CONST (Active));
            RequestFilterFields = "No.", Status, "Posting Group";
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
            column(EarnDesc_1_; EarnDesc[1])
            {
            }
            column(EarnDesc_2_; EarnDesc[2])
            {
            }
            column(EarnDesc_3_; EarnDesc[3])
            {
            }
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
            column(First_Name_________Middle_Name_______Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
            {
            }
            column(Employee__No__; "No.")
            {
            }
            column(Allowances_1_; Allowances[1])
            {
            }
            column(Allowances_2_; Allowances[2])
            {
            }
            column(Allowances_2__Control1000000013; Allowances[2])
            {
            }
            column(OtherEarn; OtherEarn)
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
            column(OtherDeduct; OtherDeduct)
            {
            }
            column(Employee__Total_Deductions___Total_Allowances_; Employee."Total Deductions" + "Total Allowances")
            {
            }
            column(Allowances_1__Control1000000009; Allowances[1])
            {
            }
            column(Allowances_2__Control1000000018; Allowances[2])
            {
            }
            column(Allowances_2__Control1000000032; Allowances[2])
            {
            }
            column(OtherEarn_Control1000000033; OtherEarn)
            {
            }
            column(Deductions_1__Control1000000034; Deductions[1])
            {
            }
            column(Deductions_2__Control1000000035; Deductions[2])
            {
            }
            column(Deductions_3__Control1000000036; Deductions[3])
            {
            }
            column(Deductions_4__Control1000000037; Deductions[4])
            {
            }
            column(OtherDeduct_Control1000000038; OtherDeduct)
            {
            }
            column(Employee__Total_Deductions___Total_Allowances__Control1000000039; Employee."Total Deductions" + "Total Allowances")
            {
            }
            column(STRSUBSTNO__Employees__1__counter_; STRSUBSTNO('Employees=%1', counter))
            {
            }
            column(MASTER_ROLL_NEGATIVE_PAYCaption; MASTER_ROLL_NEGATIVE_PAYCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Other_AllowancesCaption; Other_AllowancesCaptionLbl)
            {
            }

            trigger OnAfterGetRecord();
            begin
                Employee.CALCFIELDS(Employee."Total Allowances", Employee."Total Deductions");
                if (Employee."Total Allowances" + Employee."Total Deductions") > 0 then
                    CurrReport.SKIP;
                counter := counter + 1;
                for i := 1 to 10 do begin
                    CLEAR(Allowances[i]);
                    CLEAR(Deductions[i]);
                end;
                OtherEarn := 0;
                OtherDeduct := 0;
                Totallowances := 0;
                OtherDeduct := 0;
                TotalDeductions := 0;

                for i := 1 to 10 do begin
                    Assignmat.RESET;
                    Assignmat.SETRANGE(Assignmat."Employee No", Employee."No.");
                    Assignmat.SETRANGE(Assignmat.Type, Assignmat.Type::Payment);
                    Assignmat.SETRANGE(Assignmat.Code, Earncode[i]);
                    Assignmat.SETRANGE(Assignmat."Payroll Period", DateSpecified);
                    if Assignmat.FIND('-') then
                        Allowances[i] := Assignmat.Amount;
                    Totallowances := Totallowances + Allowances[i];
                end;
                OtherEarn := Employee."Total Allowances" - Totallowances;

                for i := 1 to 10 do begin
                    Assignmat.RESET;
                    Assignmat.SETRANGE(Assignmat."Employee No", Employee."No.");
                    Assignmat.SETRANGE(Assignmat.Type, Assignmat.Type::Deduction);
                    Assignmat.SETRANGE(Assignmat.Code, deductcode[i]);
                    Assignmat.SETRANGE(Assignmat."Payroll Period", DateSpecified);
                    if Assignmat.FIND('-') then
                        Deductions[i] := ABS(Assignmat.Amount);
                    TotalDeductions := TotalDeductions + Deductions[i];
                end;
                OtherDeduct := ABS(Employee."Total Deductions" + TotalDeductions);
            end;

            trigger OnPreDataItem();
            begin
                //CurrReport.CREATETOTALS(Allowances, Deductions, OtherEarn, OtherDeduct);
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
        Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);


        // DateSpecified:=Employee.GETRANGEMIN(Employee."Pay Period Filter");
        DateSpecified := MonthStartDate;
        EarnRec.RESET;
        EarnRec.SETRANGE(EarnRec."Show on Master Roll", true);
        if EarnRec.FIND('-') then
            repeat
                i := i + 1;
                Earncode[i] := EarnRec.Code;
                EarnDesc[i] := EarnRec.Description;
            until EarnRec.NEXT = 0;


        DedRec.RESET;
        DedRec.SETRANGE(DedRec."Show on Master Roll", true);
        if DedRec.FIND('-') then
            repeat
                j := j + 1;
                deductcode[j] := DedRec.Code;
                DedDesc[j] := DedRec.Description;
            until DedRec.NEXT = 0;
    end;

    var
        Allowances: array[80] of Decimal;
        Deductions: array[80] of Decimal;
        EarnRec: Record Earnings;
        DedRec: Record Deductions;
        Earncode: array[80] of Code[20];
        deductcode: array[80] of Code[20];
        EarnDesc: array[80] of Text[100];
        DedDesc: array[80] of Text[100];
        i: Integer;
        j: Integer;
        Assignmat: Record "Assignment Matrix";
        DateSpecified: Date;
        Totallowances: Decimal;
        TotalDeductions: Decimal;
        OtherEarn: Decimal;
        OtherDeduct: Decimal;
        counter: Integer;
        MASTER_ROLL_NEGATIVE_PAYCaptionLbl: Label 'MASTER ROLL-NEGATIVE PAY';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        Other_AllowancesCaptionLbl: Label 'Other Allowances';
        MonthStartDate: Date;
}

