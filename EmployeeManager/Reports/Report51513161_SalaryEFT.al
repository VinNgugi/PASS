report 51513161 "Salary EFT"
{
    // version PAYROLL

    ProcessingOnly = true;
    Caption = 'Salary EFT';
    dataset
    {
        dataitem(Employee; Employee)
        {
            DataItemTableView = SORTING ("No.") WHERE ("Pay Mode" = CONST (Bank), Status = CONST (Active));
            RequestFilterFields = "Pay Period Filter";
            column(Name; Name)
            {
            }
            column(BankName; BankName)
            {
            }
            column(RefNo; RefNo)
            {
            }
            column(BankAcc; BankAcc)
            {
            }
            column(BankCode; BankCode)
            {
            }
            column(Amount; Amount)
            {
            }

            trigger OnAfterGetRecord();
            begin
                EmployeeCount := EmployeeCount + 1;

                Employee.SetRange("Date Filter", "Pay Period Filter");
                Employee.CALCFIELDS(Employee."Total Allowances", Employee."Total Deductions");
                NetPay := 0;
                NetPay := Employee."Total Allowances" + Employee."Total Deductions";
                Name := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";

                BankName := '';
                BranchName := '';
                BankCodes := '';
                BranchCodes := '';
                KBA_Code := '';


                KBACode.RESET;
                KBACode.SETRANGE(KBACode.Code, Employee."Employee's Bank");
                if KBACode.FIND('-') then begin
                    BankName := KBACode."Bank Name";
                    BranchName := KBACode."Branch Name";
                    BankCodes := KBACode."Bank Code";
                    BranchCodes := KBACode."Branch Code";
                    KBA_Code := KBACode.Code;
                end;
                //
                NetPay := payroll.PayrollRounding(NetPay);
                BankCode := '';
                RefNo := '';
                Amount := '';
                EVALUATE(Amount, FORMAT(NetPay));
                Amount := DELCHR(Amount, '=', ',');
                //BankCode := Employee."Employee's Bank" + Employee."Bank Branch";
                RefNo := '' + Employee."No.";

                Amtlen := STRLEN(Amount);
                Space := '';
                i := 0;
                j := 0;
                i := 12 - (Amtlen + 1);
                if j < i then
                    repeat
                        Space := Space + ' ';
                        j := j + 1;
                    until j = i;
                Amount := Space + Amount;

                Amtlen2 := STRLEN(Employee."Bank Account Number");
                Space2 := '';
                i := 0;
                j := 0;
                i := 14 - (Amtlen2);
                if j < i then
                    repeat
                        if i = 1 then
                            Space2 := ' '
                        else
                            Space2 := Space2 + ' ';

                        j := j + 1;
                    until j = i;


                BankAcc := Space2 + DELCHR(Employee."Bank Account Number", '=', ' ');

                if NetPay = 0 then
                    CurrReport.SKIP;
                if BanknameEFT = BanknameEFT::CRDB then begin
                    RowNo := RowNo + 1;
                    EnterCell(RowNo, 1, Format(EmployeeCount), '', false);
                    EnterCell(RowNo, 2, Name, '', false);
                    EnterCell(RowNo, 3, Employee."Bank Account Number", '', false);
                    EnterCell(RowNo, 4, FORMAT(NetPay), '0.00', false);
                    EnterCell(RowNo, 5, BankCodes, '', false);
                    EnterCell(RowNo, 6, BranchCodes, '', false);
                    IF Employee."Posting Group" = 'PAYROLL' then
                        EnterCell(RowNo, 7, 'SALARY PAYMENT', '', false)
                    else
                        if Employee."Posting Group" = 'TEMP' then
                            EnterCell(RowNo, 7, 'WAGES', '', false)
                        else
                            if Employee."Posting Group" = 'INTERN' then
                                EnterCell(RowNo, 7, 'ALLOWANCES', '', false);

                end;

                TotalNet := TotalNet + NetPay;
                //MESSAGE('BANK NAME %1',BanknameEFT);
            end;

            trigger OnPostDataItem();
            begin
                TempExcelBuffer.CreateBookAndOpenExcel('', COMPANYNAME, Text0030, CompanyInformation.Name, USERID);
            end;

            trigger OnPreDataItem();
            begin
                LastFieldNo := FIELDNO("No.");
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(BanknameEFT; BanknameEFT)
                {
                    Caption = 'Select Bank';
                    OptionCaption = '"   ,CRDB"';
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
        //TESTNULL:=FORMAT(BanknameEFT);
        if BanknameEFT = BanknameEFT::"   " then
            ERROR('Please Choose Bank!');
        //TESTNULL:=FORMAT(BanknameEFT)

        RowNo := 1;
        MakeExcelHeader();
        datestring := FORMAT(TODAY, 10, '<Day,2>/<Month,2>/<Year4>');
        EmployeeCount := 0;
    end;

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        Name: Text[250];
        NetPay: Decimal;
        BankCode: Code[20];
        KBA_Code: Code[20];
        RefNo: Code[50];
        Amount: Text[30];
        payroll: Codeunit PayrollRounding;
        Amtlen: Integer;
        Space: Text[12];
        i: Integer;
        j: Integer;
        BankAcc: Text[20];
        Amtlen2: Integer;
        Space2: Text[15];
        BankName: Text[50];
        BranchName: Text[50];
        BankCodes: Code[10];
        BranchCodes: Code[10];
        EmpBank: Record "Staff  Bank Account";
        ExcelBuf: Record "Excel Buffer" temporary;
        TotalNet: Decimal;
        Text002: Label 'PAYROLLEFT';
        Text001: Label 'ERC';
        BanknameEFT: Option "   ",CRDB;
        TempExcelBuffer: Record "Excel Buffer" temporary;
        datestring: Text[20];
        KBABranchCode: Code[10];
        RowNo: Integer;
        Text0010: TextConst ENU = 'You must enter an As Of Date.', ESM = 'Debe insertar una fecha final.', FRC = 'Vous devez entrer un En date de.', ENC = 'You must enter an As Of Date.';
        Text0020: TextConst ENU = '0_);(0)', ESM = '0_);(0)', FRC = '0_);(0)', ENC = '0_);(0)';
        Text0030: TextConst ENU = 'GIFI', ESM = 'GIFI', FRC = 'IGRF', ENC = 'GIFI';
        CompanyInformation: Record "Company Information";
        TESTNULL: Text;
        KBACode: Record "Kenya Bankers Association Code";
        EmployeeCount: Integer;

    procedure MakeExcelHeader();
    var
        BlankFiller: Text[250];
    begin
        if BanknameEFT = BanknameEFT::CRDB then begin
            EnterCell(1, 1, 'ID', '', true);
            EnterCell(1, 2, 'NAME', '', true);
            EnterCell(1, 3, 'ACCOUNTNO', '', true);
            EnterCell(1, 4, 'AMOUNT', '', true);
            EnterCell(1, 5, 'BANK', '', true);
            EnterCell(1, 6, 'BRANCH', '', true);
            EnterCell(1, 7, 'DESCRIPTION', '', true);
        end;

    end;

    local procedure EnterCell(RowNo: Integer; ColumnNo: Integer; CellValue: Text[250]; NumberFormat: Text[30]; Bold: Boolean);
    begin
        TempExcelBuffer.INIT;
        TempExcelBuffer.VALIDATE("Row No.", RowNo);
        TempExcelBuffer.VALIDATE("Column No.", ColumnNo);
        if NumberFormat <> '' then begin
            TempExcelBuffer."Cell Type" := TempExcelBuffer."Cell Type"::Number;
            TempExcelBuffer.NumberFormat := NumberFormat;
        end else
            TempExcelBuffer."Cell Type" := TempExcelBuffer."Cell Type"::Text;
        TempExcelBuffer."Cell Value as Text" := CellValue;

        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.INSERT;
    end;
}

