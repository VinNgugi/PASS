report 51513400 "LO Journal Import"
{
    Caption = 'LO Journal Import';
    ProcessingOnly = true;

    dataset
    {

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    group("Import from")
                    {
                        field(FileName; FileName)
                        {
                            Caption = 'Workbook File Name';

                            trigger OnAssistEdit()
                            var
                                CommonDialogMgt: Codeunit "File Management";
                            begin
                                FileName := CommonDialogMgt.OpenFileDialog(Text006, FileName, '');
                                //Upload file to server for NAV server to access and process the file
                                IF FileName <> '' THEN
                                    FileNameServer := FileManagement.UploadFileSilent(FileName);
                            end;

                        }
                        field(SheetName; SheetName)
                        {
                            Caption = 'Worksheet Name';
                            trigger OnAssistEdit()

                            begin
                                SheetName := ExcelBuf.SelectSheetsName(FileNameServer);
                            end;
                        }
                    }
                    field(ImportOption; ImportOption)
                    {
                        Caption = 'Option';


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
    trigger OnPostReport()

    begin
        ExcelBuf.DELETEALL;

        MESSAGE(TEXT_SUMMARY, RecordCount);
    end;


    trigger OnPreReport()
    begin
        IF ImportOption = ImportOption::"Replace Entries" THEN begin
            JournalImport.SetRange(Code, BatchNo);
            JournalImport.DELETEALL;
        end;
        ExcelBuf.LOCKTABLE;

        InitImport;
        ReadExcelSheet;
        ProcessImportData;
    end;

    procedure CheckJournal(): Boolean
    var

        LOJournalLine: Record "Lenders Option Journal Line";
        NoOfLines: Integer;
    begin
        WITH LOJournalLine DO BEGIN
            NoOfLines := COUNT;
            IF (NoOfLines <> 0) THEN BEGIN
                IF CONFIRM(Text001, FALSE, NoOfLines) THEN     // Confirm append
                    FINDLAST
                ELSE
                    IF CONFIRM(Text002, FALSE) THEN           // Confirm delete
                        DELETEALL
                    ELSE
                        EXIT(FALSE);
            END;
        END;

        EXIT(TRUE);
    end;

    procedure InitImport()

    begin
        HeaderRowNo := 3;

        NoOfColumns := 49;
        //ExcelHeaderRow[1]  := 'NO.';                       // Integer
        ExcelHeaderRow[1] := 'NAMES OF CLIENTS';            // Text 50
        ExcelHeaderRow[2] := 'GENDER';                      // Text 30
        ExcelHeaderRow[3] := 'PASS BRANCH CODE';            // Text 30
        ExcelHeaderRow[4] := 'BDS/BDO';                      // Text 30
        //ExcelHeaderRow[5] := 'BANK';                         // Text 30
        //ExcelHeaderRow[6] := 'BANK BRANCH';                  // Text 30
        ExcelHeaderRow[5] := 'ACCOUNT NUMBER';               // Text 30
                                                             //ExcelHeaderRow[8] := 'BANK ADDRESS';                 // Text 50
                                                             //ExcelHeaderRow[9] := 'BANK ADDRESS 2';               // Text 50
                                                             // ExcelHeaderRow[10] := 'BANK CONTACT NO.';            // Text 30
                                                             //ExcelHeaderRow[11] := 'BANK EMAIL';                  // Text 30
                                                             //ExcelHeaderRow[12] := 'BANK CONTACT PERSON';         // Text 50
        ExcelHeaderRow[6] := 'AMOUNT APPROVED';             // Decimal
        ExcelHeaderRow[7] := 'CURRENCY';                    // Text 30

        //ExcelHeaderRow[16] := 'GUARANTEE SOURCE';            // Text 50
        ExcelHeaderRow[8] := 'LOAN APPROVED DATE';          // Date DD/MM/YYYY
        ExcelHeaderRow[9] := 'LOAN ACCOUNT NO';         // Text 30
        ExcelHeaderRow[10] := 'LOAN AMOUNT';                 // Decimal
        ExcelHeaderRow[11] := 'LOAN CURRENCY';               // Text 30
        ExcelHeaderRow[12] := 'CGC DATE';                    // Date DD/MM/YYYY
        ExcelHeaderRow[13] := 'CGC START DATE';              // Date DD/MM/YYYY
        ExcelHeaderRow[14] := 'VALUE DATE';                 // Date DD/MM/YYYY
        ExcelHeaderRow[15] := 'MATURITY DATE';              // Date DD/MM/YYYY
        ExcelHeaderRow[16] := 'TERM';                       // Text 30
        ExcelHeaderRow[17] := 'OWNER';                      // Text 50
        ExcelHeaderRow[18] := 'FEE %';                       // Decimal
        //ExcelHeaderRow[19] := 'SIGNATORY 1';                 // Text 50
        //ExcelHeaderRow[20] := 'SIGNATORY 2';                 // Text 50
        ExcelHeaderRow[19] := 'PROJECT DESCRIPTION';        // Text 50
        ExcelHeaderRow[20] := 'GROUP COUNT';                // Text 50
        ExcelHeaderRow[21] := 'PASS REGION CODE';            // Text 30
        ExcelHeaderRow[22] := 'BUSINESS TYPE';           // Text 30
        ExcelHeaderRow[23] := 'ADDRESS';                    // Text 50
        ExcelHeaderRow[24] := 'CITY';                       // Text 50
        ExcelHeaderRow[25] := 'POST CODE';                  // Text 30
        ExcelHeaderRow[26] := 'PHONE NO.';                  // Text 30
        ExcelHeaderRow[27] := 'FAX NO.';                    // Text 30
        ExcelHeaderRow[28] := 'EMAIL';                      // Text 30
        ExcelHeaderRow[29] := 'AMOUNT APPLIED';             // Decimal
        ExcelHeaderRow[30] := 'OWNERSHIP';                  // Text 50
        ExcelHeaderRow[31] := 'DISTRICT';                   // Text 30
        ExcelHeaderRow[32] := 'NO. OF EMPLOYMENTS CREATED'; // Integer
        ExcelHeaderRow[33] := 'FEES';                        // Decimal
        //ExcelHeaderRow[45] := 'BANK CODE';                   // Text 30
        //ExcelHeaderRow[46] := 'BANK CODE BRANCH';            // Text 30
        ExcelHeaderRow[34] := 'CGF %';                       // Decimal  
        ExcelHeaderRow[35] := '% GUARANTEE';                 // Decimal
        ExcelHeaderRow[36] := 'SUBSECTOR';            // Text 30
        ExcelHeaderRow[37] := 'DATE OF BIRTH';                    // Date DD/MM/YYYY

        ExcelHeaderRow[38] := 'FARM SIZE';
        ExcelHeaderRow[39] := 'TECHNOLOGY';
        ExcelHeaderRow[40] := 'TECHNOLOGY TYPE';
        ExcelHeaderRow[41] := 'TYPE';
        ExcelHeaderRow[42] := 'NO. OF ANIMALS';
        ExcelHeaderRow[43] := 'TYPE OF BREED';
        ExcelHeaderRow[44] := 'FARMING METHOD';

    end;

    local procedure ReadExcelSheet()

    begin
        ExcelBuf.OpenBook(FileNameServer, SheetName);
        ExcelBuf.ReadSheet;
    end;

    local procedure ProcessImportData()
    var
        PrvRowNo: Integer;
    begin
        Window.OPEN(Text007 + '@1@@@@@@@@@@@@@@@@@@@@@@@@@\');
        Window.UPDATE(1, 0);
        ExcelBuf.RESET;
        //Get Number of Rows
        IF ExcelBuf.FINDLAST THEN
            TotalRecNo := ExcelBuf."Row No.";
        RecNo := 0;
        PrvRowNo := HeaderRowNo + 1;

        IF ExcelBuf.FINDFIRST THEN
            REPEAT
                RecNo += 1;
                Window.UPDATE(1, ROUND(RecNo / TotalRecNo * 10000, 1));
                CASE TRUE OF
                    ExcelBuf."Column No." > NoOfColumns:
                        ERROR(ErrImport001, NoOfColumns);

                    (ExcelBuf."Row No." = HeaderRowNo)
                  AND (UPPERCASE(DELCHR(ExcelBuf."Cell Value as Text", '<>', ' ')) <> ExcelHeaderRow[ExcelBuf."Column No."]):
                        ERROR(ErrImport002, ExcelBuf."Row No.", ExcelColumnID(ExcelBuf."Column No."), ExcelHeaderRow[ExcelBuf."Column No."]);

                    (ExcelBuf."Row No." > HeaderRowNo):
                        BEGIN
                            IF (ExcelBuf."Row No." > PrvRowNo) THEN BEGIN
                                ProcessRowData(PrvRowNo);
                                PrvRowNo := ExcelBuf."Row No.";
                            END;
                            ExcelDataRow[ExcelBuf."Column No."] := ExcelBuf."Cell Value as Text";
                        END;
                END;
            UNTIL ExcelBuf.NEXT = 0;

        // Process last row - if any rows
        IF (PrvRowNo > HeaderRowNo) THEN
            ProcessRowData(PrvRowNo);

        Window.CLOSE;

    end;

    procedure ProcessRowData(RowNo: Integer)
    var
        LOJournalLine: Record "Lenders Option Journal Line";
        PASSContracts: Codeunit "Guarantee Management";
        LOHeader: Record "Lenders Option Journal Header";
    begin
        // Account data input from one row is converted to a Journal Line
        ConvertRowData(RowNo);

        WITH LOJournalLine DO BEGIN

            LOHeader.Reset();
            LOHeader.SetRange("No.", Code);
            if LOHeader.FindFirst() then
                // Insert Journal Line
                INIT;
            //Serial:=InpNo;
            Name := InpName;
            "Global Dimension 1 Code" := LOHeader."Global Dimension 1 Code";
            IF InpGender = 'Male' THEN
                Gender := Gender::Male;
            IF InpGender = 'Female' THEN
                Gender := Gender::Female;
            //"Global Dimension 1 Code" := InpPASSBranch;
            "BDS/BDO" := InpBDO;
            //"Receivables Acc. No." := InpBank;
            //"Bank Branch Name" := InpBankBranch;
            "Bank Account No" := InpAccountNo;
            //"Receivables Address" := InpBankAddress;
            //"Receivables Address 2" := InpBankAddress2;
            //"Receivables Contact No." := InpBankContactNo;
            //"Receivables Email Address" := InpBankEmail;
            //"Bank Contact Person" := InpBankContactPerson;
            "Loan Amount" := InpAmountApproved;
            "Currency Code" := InpCurrency;
            "Pct. Guarantee Approved" := InpGuaranteePerc;
            //"Guarantee Source" := InpGuaranteeSource;
            "Loan Issued Date" := InpLoanApprovedDate;
            "Loan No." := InpLoanAccNo;
            "Requested Amount" := InpLoanAmount;
            "CGC Date" := InpCGCDate;
            "CGC Start Date" := InpCGCStartDate;
            "Application Date" := InpValueDate;
            "Contract Signed Date" := InpMaturityDate;
            "Product Type" := ProductType;
            Product := Product;

            Code := BatchNo;

            CASE InpTerm of
                'Overdraft':
                    "Type of Facility" := "Type of Facility"::Overdraft;

                'Letter of Credit':
                    "Type of Facility" := "Type of Facility"::"Letter of Credit";

                'Bank Guarantee':
                    "Type of Facility" := "Type of Facility"::"Bank Guarantee";
                else
                    "Type of Facility" := "Type of Facility"::"Term Loan";
            end;
            // Owner := InpOwner;
            //"Consultancy Fee %" := InpFeePercent;
            //"Risk Sharing Fee %" := InpFeePercent;
            "Booked Fee %" := InpFeePercent;
            //"Signatory 1 (CGC)" := InpSignatory1;
            //"Signatory 2 (CGC)" := InpSignatory2;
            "Project Description" := InpProjDesc;
            // "Group Count" := InpGroupCount;
            "Global Dimension 2 Code" := InpPASSRegion;
            Subsector := InpSubsetor;
            "Business Type" := InpLineOfBusiness;
            Validate("Business Type");
            Address := InpAddress;
            City := InpCity;
            "Post Code" := InpPostCode;
            "Phone No." := InpPhoneNo;
            "Fax No." := InpFaxNo;
            "E-Mail" := InpEmail;
            //"Client Applied Amount" := InpAmountApplied;
            CASE InpOwnership OF
                'Individual':
                    Ownership := Ownership::Individual;
                'Company':
                    Ownership := Ownership::Company;
                'Partnership':
                    Ownership := Ownership::Partnership;
                'Proprietor':
                    Ownership := Ownership::Proprietor;
                'Cooperative/Farmers Association etc.':
                    Ownership := Ownership::"Cooperatives Societies";
                ELSE
                    Ownership := Ownership::Individual;
            END;
            //District := InpDistrict;
            "No of Employments Created" := InpNoEmp;
            //Fees := InpFees;
            //Select := TRUE;
            //"Select User ID" := USERID;
            "Bank Account No" := InpBankCode;
            RecordCount += 1;
            "Line No." := RecordCount;
            //Generate Client No
            "Customer No." := PASSContracts.GetLOClientNo(InpLoanAccNo);
            //"Bank Branch Name" := InpBankCodeBranch;
            //"CGF %" := InpCGFPerc;
            "Pct. Guarantee Approved" := InpGuaranteePerc;
            "Date of Birth" := InpDateofBirth;
            //"Risk Sharing Fee %" := InpFeePercent;
            case InpFarmSize of
                ' ':
                    "Farm Size" := "Farm Size"::" ";
                'Less than 1 Acre':
                    "Farm Size" := "Farm Size"::"Less than 1 Acre";
                'Over 1-5 Acres':
                    "Farm Size" := "Farm Size"::"Over 1-5 Acres";
                'Over 5-10 Acres':
                    "Farm Size" := "Farm Size"::"Over 5-10 Acres";
                'Over 10 Acres':
                    "Farm Size" := "Farm Size"::"Over 10 Acres";
            end;
            Technology := InpTechnology;
            case InpTechnologyType of
                ' ':
                    "Technology Type" := "Technology Type"::" ";
                'Drip':
                    "Technology Type" := "Technology Type"::Drip;
                'Centre Pivot':
                    "Technology Type" := "Technology Type"::"Centre Pivot";
                'Furrow/Canal':
                    "Technology Type" := "Technology Type"::"Furrow/Canal";
                'Flooding':
                    "Technology Type" := "Technology Type"::Flooding;
            end;
            Type := InpType;
            "No. of Animals" := InpNoOfAnimals;
            case InpTypeofBreed of
                ' ':
                    "Type of Breed" := "Type of Breed"::" ";
                'Improved':
                    "Type of Breed" := "Type of Breed"::Improved;
                'Local':
                    "Type of Breed" := "Type of Breed"::Local;
                'Traditional':
                    "Type of Breed" := "Type of Breed"::Traditional;
                'Layers':
                    "Type of Breed" := "Type of Breed"::Layers;
                'Broilers':
                    "Type of Breed" := "Type of Breed"::Broilers;
                'Kroilers':
                    "Type of Breed" := "Type of Breed"::Kroilers;
                'Sasso':
                    "Type of Breed" := "Type of Breed"::Sasso;
            end;
            case InpFarmingMethod of
                ' ':
                    "Farming Method" := "Farming Method"::" ";
                'Fish pond':
                    "Farming Method" := "Farming Method"::"Fish pond";
                'Fish Cage':
                    "Farming Method" := "Farming Method"::"Fish Cage";
                'Aquaponics':
                    "Farming Method" := "Farming Method"::Aquaponics;
                'Community Forest':
                    "Farming Method" := "Farming Method"::"Community Forest";
                'Private Farm':
                    "Farming Method" := "Farming Method"::"Private Farm";
                'Zero Grazing':
                    "Farming Method" := "Farming Method"::"Zero Grazing";
                'Open Field Grazing':
                    "Farming Method" := "Farming Method"::"Open Field Grazing";
                'In Cages':
                    "Farming Method" := "Farming Method"::"In Cages";
                'Without Cages':
                    "Farming Method" := "Farming Method"::"Without Cages";




            end;
            INSERT;
        END;

        CLEAR(ExcelDataRow);
    end;

    procedure ConvertRowData(RowNo: Integer)

    begin
        // Validate data input from row RowNo
        ClearInput;

        /* Column 1 'NO.';                  // Integer
        IF NOT EVALUATE(InpNo, ExcelDataRow[1]) THEN
                    ERROR(ErrImport004, RowNo, ExcelColumnID(1), ExcelDataRow[1], 'integer');*/

        // Column 1 'NAME';           // Text 50
        IF (STRLEN(ExcelDataRow[1]) > MAXSTRLEN(InpName)) THEN
            ExcelDataRow[1] := COPYSTR(ExcelDataRow[1], 1, MAXSTRLEN(InpName));
        IF NOT EVALUATE(InpName, ExcelDataRow[1]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(1), ExcelDataRow[1], 'text');

        // Column 2 'GENDER';           // Text 30
        IF (STRLEN(ExcelDataRow[2]) > MAXSTRLEN(InpGender)) THEN
            ExcelDataRow[2] := COPYSTR(ExcelDataRow[2], 1, MAXSTRLEN(InpGender));
        IF NOT EVALUATE(InpGender, ExcelDataRow[2]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(2), ExcelDataRow[2], 'text');

        // Column 3 'PASS BRANCH CODE';           // Text 30
        IF (STRLEN(ExcelDataRow[3]) > MAXSTRLEN(InpPASSBranch)) THEN
            ExcelDataRow[3] := COPYSTR(ExcelDataRow[3], 1, MAXSTRLEN(InpPASSBranch));
        IF NOT EVALUATE(InpPASSBranch, ExcelDataRow[3]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(3), ExcelDataRow[3], 'text');

        // Column 4 'BDS/BDO';                     // Text 30
        IF (STRLEN(ExcelDataRow[4]) > MAXSTRLEN(InpBDO)) THEN
            ExcelDataRow[4] := COPYSTR(ExcelDataRow[4], 1, MAXSTRLEN(InpBDO));
        IF NOT EVALUATE(InpBDO, ExcelDataRow[4]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(4), ExcelDataRow[4], 'text');
        /*
                // Column 5 'BANK';                       // Text 30
                IF (STRLEN(ExcelDataRow[5]) > MAXSTRLEN(InpBank)) THEN
                    ExcelDataRow[5] := COPYSTR(ExcelDataRow[5], 1, MAXSTRLEN(InpBank));
                IF NOT EVALUATE(InpBank, ExcelDataRow[5]) THEN
                    ERROR(ErrImport004, RowNo, ExcelColumnID(5), ExcelDataRow[5], 'text');

                // Column 6 'BANK BRANCH';                       // Text 30
                IF (STRLEN(ExcelDataRow[6]) > MAXSTRLEN(InpBankBranch)) THEN
                    ExcelDataRow[6] := COPYSTR(ExcelDataRow[6], 1, MAXSTRLEN(InpBankBranch));
                IF NOT EVALUATE(InpBankBranch, ExcelDataRow[6]) THEN
                    ERROR(ErrImport004, RowNo, ExcelColumnID(6), ExcelDataRow[6], 'text');
        */
        // Column 7 'ACCOUNT NUMBER';                       // Text 30
        IF (STRLEN(ExcelDataRow[5]) > MAXSTRLEN(InpAccountNo)) THEN
            ExcelDataRow[5] := COPYSTR(ExcelDataRow[5], 1, MAXSTRLEN(InpAccountNo));
        IF NOT EVALUATE(InpAccountNo, ExcelDataRow[5]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(5), ExcelDataRow[5], 'text');
        /*
                // Column 8 'BANK ADDRESS';                     // Text 30
                IF (STRLEN(ExcelDataRow[8]) > MAXSTRLEN(InpBankAddress)) THEN
                    ExcelDataRow[8] := COPYSTR(ExcelDataRow[8], 1, MAXSTRLEN(InpBankAddress));
                IF NOT EVALUATE(InpBankAddress, ExcelDataRow[8]) THEN
                    ERROR(ErrImport004, RowNo, ExcelColumnID(8), ExcelDataRow[8], 'text');

                // Column 9 'BANK ADDRESS 2';                     // Text 30
                IF (STRLEN(ExcelDataRow[9]) > MAXSTRLEN(InpBankAddress2)) THEN
                    ExcelDataRow[9] := COPYSTR(ExcelDataRow[9], 1, MAXSTRLEN(InpBankAddress2));
                IF NOT EVALUATE(InpBankAddress2, ExcelDataRow[9]) THEN
                    ERROR(ErrImport004, RowNo, ExcelColumnID(9), ExcelDataRow[9], 'text');

                // Column 10 'BANK CONTACT NO';                     // Text 30
                IF (STRLEN(ExcelDataRow[10]) > MAXSTRLEN(InpBankContactNo)) THEN
                    ExcelDataRow[10] := COPYSTR(ExcelDataRow[10], 1, MAXSTRLEN(InpBankContactNo));
                IF NOT EVALUATE(InpBankContactNo, ExcelDataRow[10]) THEN
                    ERROR(ErrImport004, RowNo, ExcelColumnID(10), ExcelDataRow[10], 'text');

                // Column 11 'BANK EMAIL';                     // Text 30
                IF (STRLEN(ExcelDataRow[11]) > MAXSTRLEN(InpBankEmail)) THEN
                    ExcelDataRow[11] := COPYSTR(ExcelDataRow[11], 1, MAXSTRLEN(InpBankEmail));
                IF NOT EVALUATE(InpBankEmail, ExcelDataRow[11]) THEN
                    ERROR(ErrImport004, RowNo, ExcelColumnID(11), ExcelDataRow[11], 'text');

                // Column 12 'BANK CONTACT PERSON';                     // Text 30
                IF (STRLEN(ExcelDataRow[12]) > MAXSTRLEN(InpBankContactPerson)) THEN
                    ExcelDataRow[12] := COPYSTR(ExcelDataRow[12], 1, MAXSTRLEN(InpBankContactPerson));
                IF NOT EVALUATE(InpBankContactPerson, ExcelDataRow[12]) THEN
                    ERROR(ErrImport004, RowNo, ExcelColumnID(12), ExcelDataRow[12], 'text');
        */
        // Column 13 'AMOUNT APPROVED';                     // Decimal
        IF NOT EVALUATE(InpAmountApproved, ExcelDataRow[6]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(6), ExcelDataRow[6], 'decimal');

        // Column 14 'CURRENCY';                       // Text 30
        IF (STRLEN(ExcelDataRow[7]) > MAXSTRLEN(InpCurrency)) THEN
            ExcelDataRow[7] := COPYSTR(ExcelDataRow[7], 1, MAXSTRLEN(InpCurrency));
        IF NOT EVALUATE(InpCurrency, ExcelDataRow[7]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(7), ExcelDataRow[14], 'text');

        // Column 16 'GUARANTEE SOURCE';                       // Text 30
        /*IF (STRLEN(ExcelDataRow[16]) > MAXSTRLEN(InpGuaranteeSource)) THEN
            ExcelDataRow[16] := COPYSTR(ExcelDataRow[16], 1, MAXSTRLEN(InpGuaranteeSource));
        IF NOT EVALUATE(InpGuaranteeSource, ExcelDataRow[16]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(16), ExcelDataRow[16], 'text');*/

        // Column 17 'LOAN APPROVED DATE';           // Date DD/MM/YYYY
        IF NOT EVALUATE(InpLoanApprovedDate, ExcelDataRow[8]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(8), ExcelDataRow[8], 'date');

        // Column 18 'LOAN ACCOUNT NUMBER';                       // Text 30
        IF (STRLEN(ExcelDataRow[9]) > MAXSTRLEN(InpLoanAccNo)) THEN
            ExcelDataRow[9] := COPYSTR(ExcelDataRow[9], 1, MAXSTRLEN(InpLoanAccNo));
        IF NOT EVALUATE(InpLoanAccNo, ExcelDataRow[9]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(9), ExcelDataRow[9], 'text');

        // Column 19 'LOAN AMOUNT';                       // Decimal
        IF NOT EVALUATE(InpLoanAmount, ExcelDataRow[10]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(10), ExcelDataRow[10], 'decimal');

        // Column 20 'LOAN CURRENCY';                       // Text 30
        IF (STRLEN(ExcelDataRow[11]) > MAXSTRLEN(InpLoanCurrency)) THEN
            ExcelDataRow[11] := COPYSTR(ExcelDataRow[11], 1, MAXSTRLEN(InpLoanCurrency));
        IF NOT EVALUATE(InpLoanCurrency, ExcelDataRow[11]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(11), ExcelDataRow[11], 'text');

        // Column 21 'CGC DATE';          // Date DD/MM/YYYY
        IF NOT EVALUATE(InpCGCDate, ExcelDataRow[12]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(12), ExcelDataRow[12], 'date');

        // Column 22 'CGC START DATE';          // Date DD/MM/YYYY
        IF NOT EVALUATE(InpCGCStartDate, ExcelDataRow[13]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(13), ExcelDataRow[13], 'date');

        // Column 23 'VALUE DATE';           // Date DD/MM/YYYY
        IF NOT EVALUATE(InpValueDate, ExcelDataRow[14]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(14), ExcelDataRow[14], 'date');

        // Column 24 'MATURITY DATE';          // Date DD/MM/YYYY
        IF NOT EVALUATE(InpMaturityDate, ExcelDataRow[15]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(15), ExcelDataRow[15], 'date');

        // Column 25 'TERM';                // Text 30
        IF (STRLEN(ExcelDataRow[16]) > MAXSTRLEN(InpTerm)) THEN
            ExcelDataRow[16] := COPYSTR(ExcelDataRow[16], 1, MAXSTRLEN(InpTerm));
        IF NOT EVALUATE(InpTerm, ExcelDataRow[16]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(16), ExcelDataRow[16], 'text');

        // Column 26 'OWNER';                       // Text 50
        IF (STRLEN(ExcelDataRow[17]) > MAXSTRLEN(InpOwner)) THEN
            ExcelDataRow[17] := COPYSTR(ExcelDataRow[17], 1, MAXSTRLEN(InpOwner));
        IF NOT EVALUATE(InpOwner, ExcelDataRow[17]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(17), ExcelDataRow[26], 'text');

        // Column 27 'FEE %';                       // Decimal
        IF NOT EVALUATE(InpFeePercent, ExcelDataRow[18]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(18), ExcelDataRow[18], 'decimal');


        // Column 28 'SIGNATORY 1';                       // Text 50
        /* IF (STRLEN(ExcelDataRow[28]) > MAXSTRLEN(InpSignatory1)) THEN
             ExcelDataRow[28] := COPYSTR(ExcelDataRow[28], 1, MAXSTRLEN(InpSignatory1));
         IF NOT EVALUATE(InpSignatory1, ExcelDataRow[28]) THEN
             ERROR(ErrImport004, RowNo, ExcelColumnID(28), ExcelDataRow[28], 'text');*/

        // Column 29 'SIGNATORY 2';                       // Text 50
        /*IF (STRLEN(ExcelDataRow[29]) > MAXSTRLEN(InpSignatory2)) THEN
            ExcelDataRow[29] := COPYSTR(ExcelDataRow[29], 1, MAXSTRLEN(InpSignatory2));
        IF NOT EVALUATE(InpSignatory2, ExcelDataRow[29]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(29), ExcelDataRow[29], 'text');*/

        // Column 30 'PROJECT DESCRIPTION';        // Text 50
        IF (STRLEN(ExcelDataRow[19]) > MAXSTRLEN(InpProjDesc)) THEN
            ExcelDataRow[19] := COPYSTR(ExcelDataRow[19], 1, MAXSTRLEN(InpProjDesc));
        IF NOT EVALUATE(InpProjDesc, ExcelDataRow[19]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(19), ExcelDataRow[19], 'text');

        // Column 31 'GROUP COUNT';                  // Integer
        IF NOT EVALUATE(InpGroupCount, ExcelDataRow[20]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(20), ExcelDataRow[20], 'integer');

        // Column 32 'PASS REGION CODE';               // Text 30
        IF (STRLEN(ExcelDataRow[21]) > MAXSTRLEN(InpPASSRegion)) THEN
            ExcelDataRow[21] := COPYSTR(ExcelDataRow[21], 1, MAXSTRLEN(InpPASSRegion));
        IF NOT EVALUATE(InpPASSRegion, ExcelDataRow[21]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(21), ExcelDataRow[21], 'text');

        // Column 33 'LINE OF BUSINESS';                       // Text 30
        IF (STRLEN(ExcelDataRow[22]) > MAXSTRLEN(InpLineOfBusiness)) THEN
            ExcelDataRow[22] := COPYSTR(ExcelDataRow[22], 1, MAXSTRLEN(InpLineOfBusiness));
        IF NOT EVALUATE(InpLineOfBusiness, ExcelDataRow[22]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(22), ExcelDataRow[22], 'text');

        // Column 34 'ADDRESS';              // Text 50
        IF (STRLEN(ExcelDataRow[23]) > MAXSTRLEN(InpAddress)) THEN
            ExcelDataRow[23] := COPYSTR(ExcelDataRow[23], 1, MAXSTRLEN(InpAddress));
        IF NOT EVALUATE(InpAddress, ExcelDataRow[23]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(23), ExcelDataRow[34], 'text');

        // Column 35 'CITY';              // Text 50
        IF (STRLEN(ExcelDataRow[24]) > MAXSTRLEN(InpCity)) THEN
            ExcelDataRow[24] := COPYSTR(ExcelDataRow[24], 1, MAXSTRLEN(InpCity));
        IF NOT EVALUATE(InpCity, ExcelDataRow[24]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(35), ExcelDataRow[24], 'text');

        // Column 36 'POST CODE';           // Text 30
        IF (STRLEN(ExcelDataRow[25]) > MAXSTRLEN(InpPostCode)) THEN
            ExcelDataRow[25] := COPYSTR(ExcelDataRow[25], 1, MAXSTRLEN(InpPostCode));
        IF NOT EVALUATE(InpPostCode, ExcelDataRow[25]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(25), ExcelDataRow[25], 'text');

        // Column 37 'PHONE NO.';        // Text 30
        IF (STRLEN(ExcelDataRow[26]) > MAXSTRLEN(InpPhoneNo)) THEN
            ExcelDataRow[26] := COPYSTR(ExcelDataRow[26], 1, MAXSTRLEN(InpPhoneNo));
        IF NOT EVALUATE(InpPhoneNo, ExcelDataRow[26]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(26), ExcelDataRow[26], 'text');

        // Column 38 'FAX NO.';        // Text 30
        IF (STRLEN(ExcelDataRow[27]) > MAXSTRLEN(InpFaxNo)) THEN
            ExcelDataRow[27] := COPYSTR(ExcelDataRow[27], 1, MAXSTRLEN(InpFaxNo));
        IF NOT EVALUATE(InpFaxNo, ExcelDataRow[27]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(27), ExcelDataRow[27], 'text');

        // Column 39 'EMAIL';        // Text 30
        IF (STRLEN(ExcelDataRow[28]) > MAXSTRLEN(InpEmail)) THEN
            ExcelDataRow[28] := COPYSTR(ExcelDataRow[28], 1, MAXSTRLEN(InpEmail));
        IF NOT EVALUATE(InpEmail, ExcelDataRow[28]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(28), ExcelDataRow[28], 'text');

        // Column 40 'AMOUNT APPLIED';                       // Decimal
        IF NOT EVALUATE(InpAmountApplied, ExcelDataRow[29]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(29), ExcelDataRow[29], 'decimal');

        // Column 41 'OWNERSHIP';        // Text 50
        IF (STRLEN(ExcelDataRow[30]) > MAXSTRLEN(InpOwnership)) THEN
            ExcelDataRow[30] := COPYSTR(ExcelDataRow[30], 1, MAXSTRLEN(InpOwnership));
        IF NOT EVALUATE(InpOwnership, ExcelDataRow[30]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(30), ExcelDataRow[30], 'text');

        // Column 42 'DISTRICT';        // Text 30
        IF (STRLEN(ExcelDataRow[31]) > MAXSTRLEN(InpDistrict)) THEN
            ExcelDataRow[31] := COPYSTR(ExcelDataRow[31], 1, MAXSTRLEN(InpDistrict));
        IF NOT EVALUATE(InpDistrict, ExcelDataRow[31]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(31), ExcelDataRow[31], 'text');

        // Column 43 'NO. OF EMPLOYMENTS CREATED';                  // Integer
        IF NOT EVALUATE(InpNoEmp, ExcelDataRow[32]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(32), ExcelDataRow[32], 'integer');


        // Column 44 'FEES';                     // Decimal
        IF NOT EVALUATE(InpFees, ExcelDataRow[33]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(33), ExcelDataRow[33], 'decimal');

        // Column 45 'BANK CODE';                       // Text 30
        /*IF (STRLEN(ExcelDataRow[34]) > MAXSTRLEN(InpBankCode)) THEN
            ExcelDataRow[34] := COPYSTR(ExcelDataRow[34], 1, MAXSTRLEN(InpBankCode));
        IF NOT EVALUATE(InpBankCode, ExcelDataRow[34]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(34), ExcelDataRow[34], 'text');*/

        // Column 46 'BANK CODE BRANCH';                       // Text 30
        /*IF (STRLEN(ExcelDataRow[35]) > MAXSTRLEN(InpBankCodeBranch)) THEN
            ExcelDataRow[35] := COPYSTR(ExcelDataRow[35], 1, MAXSTRLEN(InpBankCodeBranch));
        IF NOT EVALUATE(InpBankCodeBranch, ExcelDataRow[35]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(35), ExcelDataRow[35], 'text');*/

        // Column 47 'CGF %';                       // Decimal
        IF NOT EVALUATE(InpCGFPerc, ExcelDataRow[34]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(34), ExcelDataRow[34], 'decimal');

        // Column 15 '% GUARANTEED';                     // Decimal
        IF NOT EVALUATE(InpGuaranteePerc, ExcelDataRow[35]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(35), ExcelDataRow[35], 'decimal');

        IF (STRLEN(ExcelDataRow[36]) > MAXSTRLEN(InpSubsetor)) THEN
            ExcelDataRow[36] := COPYSTR(ExcelDataRow[36], 1, MAXSTRLEN(InpSubsetor));
        IF NOT EVALUATE(InpSubsetor, ExcelDataRow[36]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(36), ExcelDataRow[36], 'text');

        IF NOT EVALUATE(InpDateofBirth, ExcelDataRow[37]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(37), ExcelDataRow[37], 'date');

        IF (STRLEN(ExcelDataRow[38]) > MAXSTRLEN(InpFarmSize)) THEN
            ExcelDataRow[38] := COPYSTR(ExcelDataRow[38], 1, MAXSTRLEN(InpFarmSize));
        IF NOT EVALUATE(InpFarmSize, ExcelDataRow[38]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(38), ExcelDataRow[38], 'text');

        IF (STRLEN(ExcelDataRow[39]) > MAXSTRLEN(InpTechnology)) THEN
            ExcelDataRow[39] := COPYSTR(ExcelDataRow[39], 1, MAXSTRLEN(InpTechnology));
        IF NOT EVALUATE(InpTechnology, ExcelDataRow[39]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(39), ExcelDataRow[39], 'text');

        IF (STRLEN(ExcelDataRow[40]) > MAXSTRLEN(InpTechnologyType)) THEN
            ExcelDataRow[40] := COPYSTR(ExcelDataRow[40], 1, MAXSTRLEN(InpTechnologyType));
        IF NOT EVALUATE(InpTechnologyType, ExcelDataRow[40]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(40), ExcelDataRow[40], 'text');

        IF (STRLEN(ExcelDataRow[41]) > MAXSTRLEN(InpType)) THEN
            ExcelDataRow[41] := COPYSTR(ExcelDataRow[41], 1, MAXSTRLEN(InpType));
        IF NOT EVALUATE(InpType, ExcelDataRow[41]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(41), ExcelDataRow[41], 'text');

        iF NOT EVALUATE(InpNoOfAnimals, ExcelDataRow[42]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(42), ExcelDataRow[42], 'integer');

        IF (STRLEN(ExcelDataRow[43]) > MAXSTRLEN(InpTypeofBreed)) THEN
            ExcelDataRow[43] := COPYSTR(ExcelDataRow[43], 1, MAXSTRLEN(InpTypeofBreed));
        IF NOT EVALUATE(InpTypeofBreed, ExcelDataRow[43]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(43), ExcelDataRow[43], 'text');

        IF (STRLEN(ExcelDataRow[44]) > MAXSTRLEN(InpFarmingMethod)) THEN
            ExcelDataRow[44] := COPYSTR(ExcelDataRow[44], 1, MAXSTRLEN(InpFarmingMethod));
        IF NOT EVALUATE(InpFarmingMethod, ExcelDataRow[44]) THEN
            ERROR(ErrImport004, RowNo, ExcelColumnID(44), ExcelDataRow[44], 'text');
    end;


    procedure ClearInput()

    begin
        //CLEAR (InpNo);
        CLEAR(InpName);
        CLEAR(InpGender);
        CLEAR(InpAddress);
        CLEAR(InpPostCode);
        CLEAR(InpPASSBranch);
        CLEAR(InpPhoneNo);
        CLEAR(InpFaxNo);
        CLEAR(InpEmail);
        CLEAR(InpProjDesc);
        CLEAR(InpOwnership);
        CLEAR(InpDistrict);
        CLEAR(InpNoEmp);
        CLEAR(InpValueDate);
        CLEAR(InpMaturityDate);
        CLEAR(InpTerm);
        CLEAR(InpOwner);
        CLEAR(InpPASSRegion);
        CLEAR(InpLineOfBusiness);
        CLEAR(InpAmountApproved);
        CLEAR(InpFeePercent);
        CLEAR(InpFees);
        CLEAR(InpCurrency);
        CLEAR(InpLoanCurrency);
        CLEAR(InpBank);
        CLEAR(InpBankCode);
        CLEAR(InpAccountNo);
        CLEAR(InpBankAddress);
        CLEAR(InpBankAddress2);
        CLEAR(InpBankContactNo);
        CLEAR(InpBankEmail);
        CLEAR(InpBankContactPerson);
        CLEAR(InpBDO);
        CLEAR(InpBankBranch);
        CLEAR(InpGuaranteeSource);
        CLEAR(InpGuaranteePerc);
        CLEAR(InpLoanApprovedDate);
        CLEAR(InpLoanAccNo);
        CLEAR(InpLoanAmount);
        CLEAR(InpCGCDate);
        CLEAR(InpCGCStartDate);
        CLEAR(InpSignatory1);
        CLEAR(InpSignatory2);
        CLEAR(InpGroupCount);
        CLEAR(InpCity);
        CLEAR(InpAmountApplied);
        CLEAR(InpBankCodeBranch);
        CLEAR(InpCGFPerc);
        Clear(InpSubsetor);
        Clear(InpDateofBirth);
        Clear(InpFarmSize);
        Clear(InpTechnology);
        Clear(InpTechnologyType);
        Clear(InpType);
        Clear(InpNoOfAnimals);
        Clear(InpTypeofBreed);
        Clear(InpFarmingMethod);
    end;

    procedure ExcelColumnID(ColumnNo: Integer): Text[2]

    begin
        CASE ColumnNo OF
            1:
                EXIT('A');
            2:
                EXIT('B');
            3:
                EXIT('C');
            4:
                EXIT('D');
            5:
                EXIT('E');
            6:
                EXIT('F');
            7:
                EXIT('G');
            8:
                EXIT('H');
            9:
                EXIT('I');
            10:
                EXIT('J');
            11:
                EXIT('K');
            12:
                EXIT('L');
            13:
                EXIT('M');
            14:
                EXIT('N');
            15:
                EXIT('O');
            16:
                EXIT('P');
            17:
                EXIT('Q');
            18:
                EXIT('R');
            19:
                EXIT('S');
            20:
                EXIT('T');
            21:
                EXIT('U');
            22:
                EXIT('V');
            23:
                EXIT('W');
            24:
                EXIT('X');
            25:
                EXIT('Y');
            26:
                EXIT('Z');
            27:
                EXIT('AA');
            28:
                EXIT('AB');
            29:
                EXIT('AC');
            30:
                EXIT('AD');
            31:
                EXIT('AE');
            32:
                EXIT('AF');
            33:
                EXIT('AG');
            34:
                EXIT('AH');
            35:
                EXIT('AI');
            36:
                EXIT('AJ');
            37:
                EXIT('AK');
            38:
                EXIT('AL');
            39:
                EXIT('AM');
            40:
                EXIT('AN');
            41:
                EXIT('AO');
            42:
                EXIT('AP');
            43:
                EXIT('AQ');
            44:
                EXIT('AR');
            45:
                EXIT('AS');
            46:
                EXIT('AT');
            47:
                EXIT('AU');
        END;
        EXIT('?');

    end;

    procedure GetRecHeader(var Rec: Record "Lenders Option Journal Header")
    begin
        BatchNo := Rec."No.";
        ProductType := Rec."Product Type";
        Product := rec.Product;
        LOBatchHeader.Copy(Rec);
    end;

    var
        LOBatchHeader: Record "Lenders Option Journal Header";
        Product: Code[20];
        ProductType: Integer;
        BatchNo: Code[20];
        ExcelBuf: Record "Excel Buffer";

        ExcelHeaderRow: Array[47] of Text[250];
        ExcelDataRow: Array[47] of Text[250];
        HeaderRowNo: Integer;
        NoOfColumns: Integer;
        FileManagement: Codeunit "File Management";
        FileName: Text;
        FileNameServer: Text;
        SheetName: Text[250];
        TotalRecNo: Integer;
        RecNo: Integer;
        Window: Dialog;
        InpNo: Integer;
        InpName: Text[50];
        InpAddress: Text[50];
        InpPASSBranch: Text[30];
        InpPhoneNo: Text[30];
        InpValueDate: Date;
        InpMaturityDate: Date;
        InpTerm: Text[30];
        InpOwner: Text[50];
        InpPASSRegion: Text[30];
        InpGender: Text[30];
        InpLineOfBusiness: Text[30];
        InpAmountApproved: Decimal;
        InpFees: Decimal;
        InpAccountNo: Text;
        RecordCount: Integer;
        ImportOption: Option "Replace Entries","Add Entries";
        JournalImport: Record "Lenders Option Journal Line";
        InpPostCode: Text[30];
        InpFaxNo: Text[30];
        InpEmail: Text[30];
        InpProjDesc: Text[50];
        InpOwnership: Text[30];
        InpDistrict: Text[30];
        InpNoEmp: Integer;
        InpFeePercent: Decimal;
        InpBank: Text[30];
        InpBankAddress: Text[50];
        InpBankAddress2: Text[50];
        InpBankContactNo: Text[30];
        InpBankEmail: Text[30];
        InpBankContactPerson: Text[30];
        InpBDO: Text[30];
        InpBankBranch: Text[50];
        InpGuaranteePerc: Decimal;
        InpGuaranteeSource: Text[30];
        InpLoanApprovedDate: Date;
        InpLoanAccNo: Text[30];
        InpLoanAmount: Decimal;
        InpCGCDate: Date;
        InpCGCStartDate: Date;
        InpSignatory1: Text[50];
        InpSignatory2: Text[50];
        InpGroupCount: Integer;
        InpCity: Text[30];
        InpAmountApplied: Decimal;
        GuaranteeSource: Text[20];
        InpLoanCurrency: Text[30];
        InpCurrency: Text[30];
        InpBankCode: Text[30];
        InpCGFPerc: Decimal;
        InpBankCodeBranch: Text[30];
        InpSubsetor: Text[30];
        InpDateofBirth: Date;
        InpFarmSize: Text[30];
        InpTechnology: Text[30];
        InpTechnologyType: Text[30];
        InpType: Text[30];
        InpNoOfAnimals: Integer;
        InpTypeofBreed: Text[30];
        InpFarmingMethod: Text[30];
        Text006: TextConst ENU = ' Import Excel File';
        Text007: TextConst ENU = ' Processing Data...\\';
        ErrImport001: TextConst ENU = 'You can only import Excel worksheet with %1 columns.';
        ErrImport002: TextConst ENU = '    Row %1, Column %2: Header must be %3.';
        ErrImport003: TextConst ENU = '   Row %1, Column %2: %3 cannot exceed %4 characters.';
        ErrImport004: TextConst ENU = '   Row %1, Column %2: %3 invalid %4.';
        Text001: TextConst ENU = ' The journal already has %1 lines.\Do you want to append lines imported?';
        Text002: TextConst ENU = ' Do you want to delete existing journal lines?';
        Text003: TextConst ENU = ' Import cancelled by user.';
        TEXT_SUMMARY: TextConst ENU = '   %1 lines were imported.';
        Text008: TextConst ENU = ' Validating Header...\\';
}