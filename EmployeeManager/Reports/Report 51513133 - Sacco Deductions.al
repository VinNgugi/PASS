report 51513133 "Sacco Deductions"
{
    // version PAYROLL

    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Sacco Deductions.rdl';
    Caption = 'Sacco Deductions';

    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING ("No.");
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
            column(DedDesc_2_; DedDesc[2])
            {
            }
            column(DedDesc_3_; DedDesc[3])
            {
            }
            column(DedDesc_4_; DedDesc[4])
            {
            }
            column(Total_Deductions_; 'Total Deductions')
            {
            }
            column(PF_No__; 'PF No.')
            {
            }
            column(Name_; 'Name')
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
            column(DedDesc_1_; DedDesc[1])
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
            column(TotalDeductions; TotalDeductions)
            {
            }
            column(First_Name_________Middle_Name_______Last_Name_; "First Name" + ' ' + "Middle Name" + ' ' + "Last Name")
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
            column(Deductions_9__Control1000000039; Deductions[9])
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
            column(TotalDeductions_Control1000000038; TotalDeductions)
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
            column(Deductions_7__Control1000000014; Deductions[7])
            {
            }
            column(Deductions_6__Control1000000015; Deductions[6])
            {
            }
            column(Deductions_5__Control1000000018; Deductions[5])
            {
            }
            column(Deductions_8__Control1000000049; Deductions[8])
            {
            }
            column(Deductions_9__Control1000000050; Deductions[9])
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
            column(SACCO_DEDUCTIONSCaption; SACCO_DEDUCTIONSCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(DeductionCode_; MainDedCode)
            {
            }
            column(Counter1; counter)
            {
            }
            column(CompInf_Picture; CompInf.Picture)
            {
            }

            trigger OnAfterGetRecord();
            begin
                //message('%1',Employee."No.");
                /*DedRec.RESET;
                DedRec.SETFILTER("Employee Filter",Employee."No.");
                DedRec.SETRANGE("Main Deduction Code",MainDedCode);
                //IF DedRec.FIND('-') THEN
                //CurrReport.SKIP;  */


                Employee.CALCFIELDS(Employee."Total Deductions");
                if (Employee."Total Deductions") = 0 then
                    CurrReport.SKIP;


                for i := 1 to NoOfDeductions do begin

                    CLEAR(Deductions[i]);
                end;
                OtherDeduct := 0;
                OtherDeduct := 0;
                TotalDeductions := 0;


                for i := 1 to NoOfDeductions do begin
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



                if TotalDeductions = 0 then
                    CurrReport.SKIP;

                counter := counter + 1;

            end;

            trigger OnPreDataItem();
            begin
                //CurrReport.CREATETOTALS(Deductions, OtherDeduct, TotalDeductions);
                HRSetup.GET;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(MonthBeginDate; MonthStartDate)
                {
                    Caption = 'Month StartDate';
                }
                field(MainDedCode; MainDedCode)
                {
                    Caption = 'Insitution Code';
                    TableRelation = Institution;
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
        //DateSpecified:=Employee.GETRANGEMIN(Employee."Pay Period Filter");
        Employee.SETFILTER("Pay Period Filter", '%1', MonthStartDate);
        DateSpecified := MonthStartDate;
        //counter:=0;
        CompInf.CALCFIELDS(CompInf.Picture);

        DedRec.RESET;
        //DedRec.SETRANGE(DedRec."Show on Master Roll",TRUE);
        DedRec.SETRANGE(DedRec."Pay Period Filter", DateSpecified);
        //DedRec.SETRANGE(DedRec."Institution Code",InstitutionFilter);
        DedRec.SETRANGE(DedRec."Institution Code", MainDedCode);
        if DedRec.FIND('-') then
            repeat
                DedRec.CALCFIELDS(DedRec."Total Amount");
                //MESSAGE('%1',DedRec.Code);
                if DedRec."Total Amount" <> 0 then begin
                    j := j + 1;
                    deductcode[j] := DedRec.Code;
                    DedDesc[j] := DedRec.Description;
                    NoOfDeductions := NoOfDeductions + 1;

                end;
            until DedRec.NEXT = 0;
        //===============================================================
        if NoOfDeductions = 0 then begin

        end;
        //===============================================================
    end;

    var
        Allowances: array[200] of Decimal;
        Deductions: array[200] of Decimal;
        EarnRec: Record Earnings;
        DedRec: Record Deductions;
        Earncode: array[12000] of Code[20];
        deductcode: array[12000] of Code[20];
        EarnDesc: array[13000] of Text[100];
        DedDesc: array[12000] of Text[100];
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
        InstitutionRec: Record Institution;
        InstitutionFilter: Code[20];
        SACCO_DEDUCTIONSCaptionLbl: Label 'COOPERATIVE DEDUCTIONS';
        CurrReport_PAGENOCaptionLbl: Label 'Page';
        MonthStartDate: Date;
        MainDedCode: Code[30];
        NoOfDeductions: Integer;
        CompInf: Record "Company Information";

    procedure getdate99(bddate: Date);
    begin
        MonthStartDate := bddate;
    end;
}

