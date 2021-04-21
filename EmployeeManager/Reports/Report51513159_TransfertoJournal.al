report 51513159 "Transfer to Journal"
{
    // version PAYROLL
    Caption = 'Transfer to Journal';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Transfer to Journal.rdl';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field("Payroll Period"; Datefilter)
                {
                    TableRelation = "Payroll Period"."Starting Date";

                    /*trigger OnLookup(Text: Text): Boolean;
                    begin
                        PayrollPeriod.RESET;
                        if PAGE.RUNMODAL(51513085, PayrollPeriod) = ACTION::LookupOK then
                            Datefilter := PayrollPeriod."Starting Date";
                    end;*/
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

    end;


    trigger OnPreReport();
    begin
        if Datefilter = 0D then
            ERROR('Please Enter Payroll Period!');
        HRSetup.Get();
        HRSetup.TestField("Payroll Template");
        HRSetup.TestField("Payroll Batch");
        JTemplate := HRSetup."Payroll Template";
        JBatch := HRSetup."Payroll Batch";


        GenJnline.RESET;
        GenJnline.SETRANGE("Journal Template Name", JTemplate);
        GenJnline.SETRANGE("Journal Batch Name", JBatch);
        GenJnline.DELETEALL;


        GenJnlBatch.RESET;
        GenJnlBatch.SETRANGE(Name, JBatch);
        if GenJnlBatch.FIND('-') then
            /* IF GenJnlBatch."No. Series"<>'' THEN BEGIN
              Noseries:=NoSeriesMgt.GetNextNo(GenJnlBatch."No. Series",TODAY,TRUE);
               END ELSE BEGIN
                 Noseries:=FORMAT(DATE2DMY(Datefilter,2))+'-'+FORMAT(DATE2DMY(Datefilter,3));
                 END;
                 */
        Noseries := FORMAT(DATE2DMY(Datefilter, 2)) + '-' + FORMAT(DATE2DMY(Datefilter, 3));

    end;


    trigger OnPostReport();
    begin
        PostingGroup.RESET;
        if PostingGroup.FIND('-') then
            PayablesAcc := PostingGroup."Net Salary Payable";
        FringeAcc := PostingGroup."Fringe benefits";
        GLSetup.GET;

        PayrollPeriod.RESET;
        PayrollPeriod.SETRANGE("Starting Date", Datefilter);
        if PayrollPeriod.FIND('-') then begin
            Payday := Today;
            //PayrollPeriod.TESTFIELD("Pay Date");
            //Payday := PayrollPeriod."Starting Date";//PayrollPeriod."Pay Date"
        end;
        TotalDebits := 0;
        TotalCredits := 0;

        //=============================================NORMAL EARNINGS

        Earn.RESET;
        // Earn.SETRANGE("Reduces Tax",FALSE);
        Earn.SETFILTER("Account No.", '<>%1', '');
        Earn.SETRANGE("Non-Cash Benefit", false);
        if Earn.FIND('-') then begin
            repeat
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(Code, Earn.Code);
                AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                AssignMatrix.CALCSUMS(Amount);

                GenJnline.INIT;
                LineNumber := LineNumber + 10;
                GenJnline."Journal Template Name" := JTemplate;
                GenJnline."Journal Batch Name" := JBatch;
                GenJnline."Line No." := GenJnline."Line No." + 10;
                GenJnline."Account No." := Earn."Account No.";
                GenJnline.VALIDATE("Account No.");
                GenJnline."Posting Date" := Payday;
                GenJnline.Description := Earn.Description + ': ' + FORMAT(Datefilter, 0, '<month text> <year4>');//+' '+"Dimension Value".Code;
                GenJnline."Document No." := Noseries;
                //GenJnline."Shortcut Dimension 1 Code":="Dimension Value".Code;
                GenJnline.Amount := AssignMatrix.Amount;
                GenJnline.VALIDATE(Amount);
                GenJnline."Employee Code" := AssignMatrix."Employee No";

                if GenJnline.Amount <> 0 then
                    GenJnline.INSERT;
                TotalCredits := TotalCredits + AssignMatrix.Amount;
            until Earn.NEXT = 0;
        end;

        //===========================================END NORMAL EARNINGS

        //============================================FRINGE BENEFITS
        Earn.RESET;
        Earn.SETRANGE("Non-Cash Benefit", true);
        Earn.SETRANGE(Fringe, true);
        if Earn.FIND('-') then begin
            repeat
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(Code, Earn.Code);
                AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                AssignMatrix.CALCSUMS("Employer Amount");

                GenJnline.INIT;
                LineNumber := LineNumber + 10;
                GenJnline."Journal Template Name" := JTemplate;
                GenJnline."Journal Batch Name" := JBatch;
                GenJnline."Line No." := GenJnline."Line No." + 10;
                GenJnline."Account No." := Earn."Account No.";
                GenJnline.VALIDATE("Account No.");
                GenJnline."Posting Date" := Payday;
                GenJnline.Description := Earn.Description + ': ' + FORMAT(Datefilter, 0, '<month text> <year4>');//+' '+"Dimension Value".Code;
                GenJnline."Document No." := Noseries;
                //GenJnline."Shortcut Dimension 1 Code":="Dimension Value".Code;
                GenJnline.Amount := AssignMatrix."Employer Amount";
                GenJnline.VALIDATE(Amount);
                //GenJnline."Employee Code":=AssignMatrix."Employee No";
                //TotalDebits:=TotalDebits+AssignMatrix.Amount;
                if GenJnline.Amount <> 0 then
                    GenJnline.INSERT;
            until Earn.NEXT = 0;
        end;


        //================================================END FRINGE BENEFITS

        //====================================================================DEDUCTIONS

        //=========================================================EMPLOYER AMOUNT

        Deduction.RESET;
        Deduction.SETFILTER("Account No.", '<>%1', '');
        if Deduction.FIND('-') then begin
            repeat
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(Code, Deduction.Code);
                AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                AssignMatrix.CALCSUMS(Amount, "Employer Amount");
                if (AssignMatrix."Employer Amount" <> 0) and (Deduction."G/L Account Employer" <> '') then begin
                    GenJnline.INIT;
                    LineNumber := LineNumber + 10;
                    GenJnline."Journal Template Name" := JTemplate;
                    GenJnline."Journal Batch Name" := JBatch;
                    GenJnline."Line No." := GenJnline."Line No." + 10;
                    GenJnline."Account No." := Deduction."G/L Account Employer";
                    GenJnline."Posting Date" := Payday;
                    GenJnline.Description := Deduction.Description + ': ' + FORMAT(Datefilter, 0, '<month text> <year4>');//+' '+"Dimension Value".Code+'-'+Dim2Value.Code+'-'+Dim3Value.Code;
                    GenJnline."Document No." := Noseries;
                    // GenJnline."Shortcut Dimension 1 Code":="Dimension Value".Code;
                    /*
                   vendrec.RESET;
                   IF vendrec.GET(Deduction.vendor) THEN BEGIN
                       GenJnline."Account Type":=GenJnline."Account Type"::Vendor;
                       GenJnline."Account No.":=Deduction.vendor;
                   END;
                   */
                    GenJnline.Amount := AssignMatrix."Employer Amount";
                    GenJnline.VALIDATE(Amount);
                    if GenJnline.Amount <> 0 then
                        GenJnline.INSERT;
                end;
            until Deduction.NEXT = 0;
        end;

        //============================================================END EMPLYER AMOUNT
        Deduction.RESET;
        Deduction.SETFILTER("Account No.", '<>%1', '');
        if Deduction.FIND('-') then begin
            repeat
                if Deduction.Individual = true then begin
                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, Deduction.Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    if AssignMatrix.FINDFIRST then begin
                        repeat
                            LoanProductType1.RESET;
                            LoanProductType1.SETRANGE("Deduction Code", AssignMatrix.Code);
                            if LoanProductType1.FINDFIRST then
                                EmpAccMap.RESET;
                            EmpAccMap.SETRANGE("Employee No.", AssignMatrix."Employee No");
                            EmpAccMap.SETRANGE("Loan Type", LoanProductType1.Code);
                            if EmpAccMap.FINDFIRST then begin
                                // AssignMatrix.CALCSUMS(Amount,"Employer Amount");
                                GenJnline.INIT;
                                LineNumber := LineNumber + 10;
                                GenJnline."Journal Template Name" := JTemplate;
                                GenJnline."Journal Batch Name" := JBatch;
                                GenJnline."Line No." := GenJnline."Line No." + 10;
                                GenJnline."Account Type" := GenJnline."Account Type"::Customer;
                                GenJnline."Account No." := EmpAccMap."Customer A/c";
                                /* vendrec.RESET;
                                 IF vendrec.GET(Deduction.vendor) THEN BEGIN
                                     GenJnline."Account Type":=GenJnline."Account Type"::Vendor;
                                     GenJnline."Account No.":=Deduction.vendor;
                                 END;
                                 */
                                GenJnline."Posting Date" := Payday;
                                GenJnline.Description := Deduction.Description + ': ' + FORMAT(Datefilter, 0, '<month text> <year4>');//+' '+"Dimension Value".Code+'-'+Dim2Value.Code+'-'+Dim3Value.Code;
                                GenJnline."Document No." := Noseries;//GenJnlBatch."Posting No. Series";//NoSeriesMgt.InitSeries(GLSetup."GLTemplate Nos.",'',0D,GenJnline."Document No.",GenJnline.'');//FORMAT(Datefilter);
                                if (AssignMatrix."Employer Amount" <> 0) and (Deduction."G/L Account Employer" <> '') then begin
                                    GenJnline.Amount := AssignMatrix.Amount - AssignMatrix."Employer Amount";
                                    // MESSAGE('........%1.......%2',GenJnline.Description,AssignMatrix."Employer Amount");
                                end else begin
                                    GenJnline.Amount := AssignMatrix.Amount;
                                end;
                                GenJnline.VALIDATE(Amount);
                                //GenJnline."Employee Code":=AssignMatrix."Employee No";
                                if AssignMatrix.Amount <= 0 then
                                    TotalDebits := TotalDebits + AssignMatrix.Amount;
                                if GenJnline.Amount <> 0 then
                                    GenJnline.INSERT;
                            end;
                        until AssignMatrix.NEXT = 0;
                    end;
                end else begin
                    ;

                    AssignMatrix.RESET;
                    AssignMatrix.SETRANGE(Code, Deduction.Code);
                    AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                    AssignMatrix.CALCSUMS(Amount, "Employer Amount");
                    GenJnline.INIT;
                    LineNumber := LineNumber + 10;
                    GenJnline."Journal Template Name" := JTemplate;
                    GenJnline."Journal Batch Name" := JBatch;
                    GenJnline."Line No." := GenJnline."Line No." + 10;
                    GenJnline."Account No." := Deduction."Account No.";
                    /* vendrec.RESET;
                     IF vendrec.GET(Deduction.vendor) THEN BEGIN
                         GenJnline."Account Type":=GenJnline."Account Type"::Vendor;
                         GenJnline."Account No.":=Deduction.vendor;
                     END;
                     */
                    GenJnline."Posting Date" := Payday;
                    GenJnline.Description := Deduction.Description + ': ' + FORMAT(Datefilter, 0, '<month text> <year4>');//+' '+"Dimension Value".Code+'-'+Dim2Value.Code+'-'+Dim3Value.Code;
                    GenJnline."Document No." := Noseries;//GenJnlBatch."Posting No. Series";//NoSeriesMgt.InitSeries(GLSetup."GLTemplate Nos.",'',0D,GenJnline."Document No.",GenJnline.'');//FORMAT(Datefilter);
                    if (AssignMatrix."Employer Amount" <> 0) and (Deduction."G/L Account Employer" <> '') then begin
                        GenJnline.Amount := AssignMatrix.Amount - AssignMatrix."Employer Amount";
                        // MESSAGE('........%1.......%2',GenJnline.Description,AssignMatrix."Employer Amount");
                    end else begin
                        GenJnline.Amount := AssignMatrix.Amount;
                    end;
                    GenJnline.VALIDATE(Amount);
                    //GenJnline."Employee Code":=AssignMatrix."Employee No";
                    if AssignMatrix.Amount <= 0 then
                        TotalDebits := TotalDebits + AssignMatrix.Amount;
                    if GenJnline.Amount <> 0 then
                        GenJnline.INSERT;
                end;
            //DimMgt.ValidateShortcutDimValues(3,Dim3Value.Code,GenJnline."Dimension Set ID");

            until Deduction.NEXT = 0;
        end;
        //=========================================================================END DEDUCTIONS

        //============================================balancing FRINGE BENEFITS
        Earn.RESET;
        Earn.SETRANGE("Non-Cash Benefit", true);
        Earn.SETRANGE(Fringe, true);
        if Earn.FIND('-') then begin
            repeat
                AssignMatrix.RESET;
                AssignMatrix.SETRANGE(Code, Earn.Code);
                AssignMatrix.SETRANGE("Payroll Period", Datefilter);
                AssignMatrix.CALCSUMS("Employer Amount");

                GenJnline.INIT;
                LineNumber := LineNumber + 10;
                GenJnline."Journal Template Name" := JTemplate;
                GenJnline."Journal Batch Name" := JBatch;
                GenJnline."Line No." := GenJnline."Line No." + 10;
                GenJnline."Account No." := FringeAcc;
                GenJnline.VALIDATE("Account No.");
                GenJnline."Posting Date" := Payday;
                GenJnline.Description := Earn.Description + ': ' + FORMAT(Datefilter, 0, '<month text> <year4>');//+' '+"Dimension Value".Code;
                GenJnline."Document No." := Noseries;
                //GenJnline."Shortcut Dimension 1 Code":="Dimension Value".Code;
                GenJnline.Amount := -AssignMatrix."Employer Amount";
                GenJnline.VALIDATE(Amount);
                //GenJnline."Employee Code":=AssignMatrix."Employee No";
                //TotalDebits:=TotalDebits+AssignMatrix.Amount;
                if GenJnline.Amount <> 0 then
                    GenJnline.INSERT;
            until Earn.NEXT = 0;
        end;


        //================================================END FRINGE BENEFITS
        //====================NET PAYABLE
        GenJnline.INIT;
        LineNumber := LineNumber + 10;
        GenJnline."Journal Template Name" := JTemplate;
        GenJnline."Journal Batch Name" := JBatch;
        GenJnline."Line No." := GenJnline."Line No." + 10;
        GenJnline."Account No." := PayablesAcc;
        GenJnline."Posting Date" := Payday;
        // GenJnline."Shortcut Dimension 1 Code":="Dimension Value".Code;
        GenJnline.Description := 'Salaries Payable:' + FORMAT(Datefilter, 0, '<month text> <year4>');//+' '+"Dimension Value".Code+'-'+Dim2Value.Code+'-'+Dim3Value.Code;
                                                                                                     // GenJnline."Shortcut Dimension 1 Code":="Dimension Value".Code;//EmpRec."Global Dimension 1 Code";
                                                                                                     //GenJnline."Shortcut Dimension 2 Code":=Dim2Value.Code;//EmpRec."Global Dimension 2 Code";
                                                                                                     //GenJnline."Shortcut Dimension 3 Code":=Dim3Value.Code;//EmpRec."Shortcut Dimension 3 Code";//"Dimension Value".Code;
        GenJnline."Document No." := Noseries;//GenJnlBatch."Posting No. Series";//NoSeriesMgt.InitSeries(GLSetup."GLTemplate Nos.",'',0D,GenJnline."Document No.",GenJnline.'');//FORMAT(Datefilter);
        GenJnline.Amount := -(TotalCredits + TotalDebits);
        GenJnline.VALIDATE(Amount);
        //nJnline."Employee Code":=EmpRec."No.";
        if GenJnline.Amount <> 0 then
            GenJnline.INSERT;




        Message('Salaries Journals successfuly created and ready for posting. Journal Template = %1, Journal Batch = %2', JTemplate, JBatch);
    end;



    var
        Earn: Record Earnings;
        Datefilter: Date;
        GenJnline: Record "Gen. Journal Line";
        LineNumber: Integer;
        AmountRemaining: Decimal;
        Company: Record "Company Information";
        IncomeTax: Decimal;
        NetPay: Decimal;
        RightBracket: Boolean;
        Companyz: Code[10];
        "Posting Date": Date;
        BatchName: Text[30];
        JTemplate: Code[20];
        JBatch: Code[20];
        DocumentNo: Code[10];
        Description: Text[30];
        Amount: Decimal;
        "G/LAccount": Code[10];
        TotalncomeTax: Decimal;
        GrossPay: Decimal;
        Totalgross: Decimal;
        TotalNetPay: Decimal;
        Payday: Date;
        TotalBasic: Decimal;
        PayrollPeriod: Record "Payroll Period";
        PostingGroup: Record "Staff Posting Group";
        TaxAccount: Code[10];
        SalariesAcc: Code[10];
        PayablesAcc: Code[10];
        FringeAcc: Code[10];
        First: Code[10];
        Last: Code[10];
        EmployeeTemp: Record Employee temporary;
        TotalDebits: Decimal;
        TotalCredits: Decimal;
        AssignMatrix: Record "Assignment Matrix";
        JnlTemp: Record "Gen. Journal Batch";
        Found: Boolean;
        TotalSSF: Decimal;
        PeriodStartDate: Date;
        EmpRec: Record Employee;
        DateSpecified: Date;
        Payperiodtext: Text[30];
        TransferLoans: Boolean;
        TaxCode: Code[10];
        BasicSalary: Decimal;
        PAYE: Decimal;
        HRSetup: Record "Human Resources Setup";
        HseLimit: Decimal;
        ExcessRetirement: Decimal;
        CfMpr: Decimal;
        relief: Decimal;
        GetPeriodFilter: Date;
        ActivityRec: Record "Dimension Value";
        EarningsCopy: Record Earnings;
        LoanApp: Record "Loan Application";
        EmpAccMap: Record "Employee Account Mapping";
        PGMapping: Record "Staff PGroups";
        Deduction: Record Deductions;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GLSetup: Record "General Ledger Setup";
        GenJnlBatch: Record "Gen. Journal Batch";
        Noseries: Code[50];
        Dim2Value: Record "Dimension Value";
        Dim3Value: Record "Dimension Value";
        DimMgt: Codeunit DimensionManagement;
        DimSetEntry: Record "Dimension Set Entry";
        DimSetEntry2: Record "Dimension Set Entry";
        //Imprestheader: Record "Request Header";
        saladno: Integer;
        vendrec: Record Vendor;
        employers: Decimal;
        LoanProductType1: Record "Loan Product Type";

    procedure GetTaxBracket(var TaxableAmount: Decimal);
    var
        TaxTable: Record Brackets;
        TotalTax: Decimal;
        Tax: Decimal;
        EndTax: Boolean;
        Employee: Record Employee;
    begin
        AmountRemaining := TaxableAmount;
        AmountRemaining := AmountRemaining;
        AmountRemaining := PayrollRounding(AmountRemaining);
        EndTax := false;
        TaxTable.SETRANGE("Table Code", TaxCode);
        if TaxTable.FIND('-') then begin
            repeat
                if AmountRemaining <= 0 then
                    EndTax := true
                else begin
                    if (TaxableAmount) > TaxTable."Upper Limit" then
                        Tax := TaxTable."Taxable Amount" * TaxTable.Percentage / 100
                    else begin
                        Tax := AmountRemaining * TaxTable.Percentage / 100;
                        TotalTax := TotalTax + Tax;
                        EndTax := true;
                    end;
                    if not EndTax then begin
                        AmountRemaining := AmountRemaining - TaxTable."Taxable Amount";
                        TotalTax := TotalTax + Tax;
                    end;
                end;
            until (TaxTable.NEXT = 0) or EndTax = true;
        end;
        TotalTax := TotalTax;
        TotalTax := PayrollRounding(TotalTax);
        IncomeTax := -TotalTax;
        if not Employee."Pays tax" then
            IncomeTax := 0;
    end;

    procedure GetPayPeriod(var PayPeriods: Record "Payroll Period");
    begin
        PayrollPeriod := PayPeriods;
    end;

    procedure GetCurrentPeriod();
    var
        PayPeriodRec: Record "Payroll Period";
    begin
        PayPeriodRec.SETRANGE(PayPeriodRec.Closed, false);
        if PayPeriodRec.FIND('-') then
            PeriodStartDate := PayPeriodRec."Starting Date";
    end;

    procedure AdjustPostingGr();
    begin
        if AssignMatrix.FIND('-') then begin
            repeat
                if EmpRec.GET(AssignMatrix."Employee No") then
                    AssignMatrix."Posting Group Filter" := EmpRec."Posting Group";
                AssignMatrix.MODIFY;
            until AssignMatrix.NEXT = 0;
        end;
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
        //============================================================================================
    end;
}

