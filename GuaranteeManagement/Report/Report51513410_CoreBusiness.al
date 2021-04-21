report 51513410 "A Core Business"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {

        DataItem(Parameters; "Guarantee Application")
        {
            DataItemTableView = SORTING ("No.");
            RequestFilterFields = Status, Ownership, "Global Dimension 2 Code", "Global Dimension 1 Code", "BDS/BDO", Gender;
            Column(STRSUBSTNO___Core_Business____1___Year_; STRSUBSTNO('Core Business - %1', Year))
            {

            }
            Column(FORMAT_TODAY_0_4_; FORMAT(TODAY, 0, 4))
            {

            }
            Column(ContFilter; ContFilter)
            {

            }

            Column(Parameters_No_; "No.")
            {

            }
        }
        DataItem("Application Received"; Integer)
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 5));
            Column(Year; Year)
            {

            }
            Column(BPCount_1_; BPCount[1])
            {

            }
            Column(BPAmount_1_; BPAmount[1])
            {

            }
            Column(BPAmount_2_; BPAmount[2])
            {

            }
            Column(BPCount_2_; BPCount[2])
            {

            }
            Column(BPAmount_3_; BPAmount[3])
            {

            }
            Column(BPCount_3_; BPCount[3])
            {

            }
            Column(BPAmount_4_; BPAmount[4])
            {

            }
            Column(BPCount_4_; BPCount[4])
            {

            }
            Column(BPAmount_5_; BPAmount[5])
            {

            }
            Column(BPCount_5_; BPCount[5])
            {

            }
            Column(BPStatus; BPStatus)
            {

            }
            Column(Q1Caption; Q1CaptionLbl)
            {

            }
            Column(Q2Caption; Q2CaptionLbl)
            {

            }
            Column(Q3Caption; Q3CaptionLbl)
            {

            }
            Column(Q4Caption; Q4CaptionLbl)
            {

            }
            Column(TypeCaption; TypeCaptionLbl)
            {

            }
            Column(No_Caption; No_CaptionLbl)
            {

            }
            Column(AmountCaption; AmountCaptionLbl)
            {

            }
            Column(AmountCaption_Control1000000019; AmountCaption_Control1000000019Lbl)
            {

            }
            Column(No_Caption_Control1000000020; No_Caption_Control1000000020Lbl)
            {

            }
            Column(AmountCaption_Control1000000021; AmountCaption_Control1000000021Lbl)
            {

            }
            Column(No_Caption_Control1000000022; No_Caption_Control1000000022Lbl)
            {

            }
            Column(AmountCaption_Control1000000023; AmountCaption_Control1000000023Lbl)
            {

            }
            Column(No_Caption_Control1000000024; No_Caption_Control1000000024Lbl)
            {

            }
            Column(AmountCaption_Control1000000025; AmountCaption_Control1000000025Lbl)
            {

            }
            Column(No_Caption_Control1000000026; No_Caption_Control1000000026Lbl)
            {

            }
            Column(Application_Received_Number; Number)
            {

            }

            trigger OnPostDataItem()
            begin
                Application.RESET;
                Contract.RESET;
                CLEAR(BPCount);
                CLEAR(BPAmount);
                BPStatus := 'Applications Received';

                SetApplicationFilter;
                SetContractFilter;

            end;

            trigger OnAfterGetRecord()
            begin
                Application.SETRANGE("Application Date", FromDate[Number], ToDate[Number]);
                ApplicationCountAndCalc(Number);

                Contract.SETRANGE("Application Date", FromDate[Number], ToDate[Number]);
                ContractCountAndCalc(Number, FALSE);
            end;
        }
        DataItem("Application Rejected"; Integer)
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 5));
            Column(BPCount_1__Control1000000079; BPCount[1])
            {

            }
            Column(BPAmount_1__Control1000000208; BPAmount[1])
            {

            }
            Column(BPAmount_2__Control1000000209; BPAmount[2])
            {

            }
            Column(BPCount_2__Control1000000210; BPCount[2])
            {

            }
            Column(BPAmount_3__Control1000000211; BPAmount[3])
            {

            }
            Column(BPCount_3__Control1000000212; BPCount[3])
            {

            }
            Column(BPAmount_4__Control1000000213; BPAmount[4])
            {

            }
            Column(BPCount_4__Control1000000214; BPCount[4])
            {

            }
            Column(BPAmount_5__Control1000000215; BPAmount[5])
            {

            }
            Column(BPCount_5__Control1000000216; BPCount[5])
            {

            }
            Column(BPStatus_Control1000000217; BPStatus)
            {

            }
            Column(Application_Rejected_Number; Number)
            {

            }


            trigger OnPreDataItem()
            begin
                Application.RESET;
                Contract.RESET;
                CLEAR(BPCount);
                CLEAR(BPAmount);
                BPStatus := 'Applications Rejected';

                SetApplicationFilter;
                SetContractFilter;
            end;


            trigger OnAfterGetRecord()
            begin
                Application.SETRANGE("Application Date", FromDate[Number], ToDate[Number]);
                ApplicationCountAndCalc(Number);
            end;
        }
        DataItem("Client Contracts Signed"; Integer)
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 5));
            Column(BPCount_1__Control1000000051; BPCount[1])
            {

            }
            Column(BPAmount_1__Control1000000052; BPAmount[1])
            {

            }
            Column(BPAmount_2__Control1000000053; BPAmount[2])
            {

            }
            Column(BPCount_2__Control1000000054; BPCount[2])
            {

            }
            Column(BPAmount_3__Control1000000055; BPAmount[3])
            {

            }
            Column(BPCount_3__Control1000000056; BPCount[3])
            {

            }
            Column(BPAmount_4__Control1000000057; BPAmount[4])
            {

            }
            Column(BPCount_4__Control1000000108; BPCount[4])
            {

            }
            Column(BPAmount_5__Control1000000109; BPAmount[5])
            {

            }
            Column(BPCount_5__Control1000000110; BPCount[5])
            {

            }
            Column(BPStatus_Control1000000111; BPStatus)
            {

            }
            Column(Client_Contracts_Signed_Number; Number)
            {

            }

            trigger OnPreDataItem()
            begin
                Contract.RESET;
                CLEAR(BPCount);
                CLEAR(BPAmount);
                BPStatus := 'Client contracts signed';

                SetApplicationFilter;
                SetContractFilter;
            end;


            trigger OnAfterGetRecord()
            begin
                Contract.SETRANGE("Contract Signed Date", FromDate[Number], ToDate[Number]);
                ContractCountAndCalc(Number, FALSE);
            end;
        }

        DataItem("Under Preparation - Not used"; Integer)
        {

            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 5));
            Column(BPCount_1__Control1000000120; BPCount[1])
            {

            }
            Column(BPAmount_1__Control1000000121; BPAmount[1])
            {

            }
            Column(BPAmount_2__Control1000000122; BPAmount[2])
            {

            }
            Column(BPCount_2__Control1000000123; BPCount[2])
            {

            }
            Column(BPAmount_3__Control1000000124; BPAmount[3])
            {

            }
            Column(BPCount_3__Control1000000125; BPCount[3])
            {

            }
            Column(BPAmount_4__Control1000000126; BPAmount[4])
            {

            }
            Column(BPCount_4__Control1000000127; BPCount[4])
            {

            }
            Column(BPAmount_5__Control1000000128; BPAmount[5])
            {

            }
            Column(BPCount_5__Control1000000129; BPCount[5])
            {

            }
            Column(BPStatus_Control1000000130; BPStatus)
            {

            }
            Column(Under_Preparation___Not_used_Number; Number)
            {

            }

            trigger OnPreDataItem()
            begin
                //Currently skip
                CurrReport.BREAK;
                Contract.RESET;
                CLEAR(BPCount);
                CLEAR(BPAmount);
                BPStatus := 'BP under preparation';

                SetApplicationFilter;
                SetContractFilter;

            end;
        }
        DataItem("In Pipeline"; Integer)
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 5));

            Column(BPCount_1__Control1000000139; BPCount[1])
            {

            }
            Column(BPAmount_1__Control1000000140; BPAmount[1])
            {

            }
            Column(BPAmount_2__Control1000000141; BPAmount[2])
            {

            }
            Column(BPCount_2__Control1000000142; BPCount[2])
            {

            }
            Column(BPAmount_3__Control1000000143; BPAmount[3])
            {

            }
            Column(BPCount_3__Control1000000144; BPCount[3])
            {

            }
            Column(BPAmount_4__Control1000000145; BPAmount[4])
            {

            }
            Column(BPCount_4__Control1000000146; BPCount[4])
            {

            }
            Column(BPAmount_5__Control1000000147; BPAmount[5])
            {

            }
            Column(BPCount_5__Control1000000148; BPCount[5])
            {

            }
            Column(BPStatus_Control1000000149; BPStatus)
            {

            }
            Column(In_Pipeline_Number; Number)
            {

            }

            trigger OnPreDataItem()
            begin
                Contract.RESET;
                CLEAR(BPCount);
                CLEAR(BPAmount);
                BPStatus := 'BP in pipeline';

                SetApplicationFilter;
                SetContractFilter;
            end;


            trigger OnAfterGetRecord()
            begin
                Contract.SETRANGE("Contract Signed Date", 0D, ToDate[Number]);
                Contract.SETFILTER("Submit to Bank Date", '>=%1', FromDate[Number]);
                ContractCountAndCalc(Number, FALSE);
            end;
        }

        DataItem("BP Sent To Bank"; Integer)
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 5));

            Column(BPCount_1__Control1000000158; BPCount[1])
            {

            }
            Column(BPAmount_1__Control1000000159; BPAmount[1])
            {

            }
            Column(BPAmount_2__Control1000000160; BPAmount[2])
            {

            }
            Column(BPCount_2__Control1000000161; BPCount[2])
            {

            }
            Column(BPAmount_3__Control1000000162; BPAmount[3])
            {

            }
            Column(BPCount_3__Control1000000163; BPCount[3])
            {

            }
            Column(BPAmount_4__Control1000000164; BPAmount[4])
            {

            }
            Column(BPCount_4__Control1000000165; BPCount[4])
            {

            }
            Column(BPAmount_5__Control1000000166; BPAmount[5])
            {

            }
            Column(BPCount_5__Control1000000167; BPCount[5])
            {

            }
            Column(BPStatus_Control1000000168; BPStatus)
            {

            }
            Column(BP_Sent_To_Bank_Number; Number)
            {

            }


            trigger OnPreDataItem()
            begin
                Contract.RESET;
                CLEAR(BPCount);
                CLEAR(BPAmount);
                BPStatus := 'BP sent to bank';

                SetApplicationFilter;
                SetContractFilter;
            end;
        }

        DataItem("Pending in Bank"; Integer)
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 5));

            Column(BPCount_1__Control1000000177; BPCount[1])
            {

            }
            Column(BPAmount_1__Control1000000178; BPAmount[1])
            {

            }
            Column(BPAmount_2__Control1000000179; BPAmount[2])
            {

            }
            Column(BPCount_2__Control1000000180; BPCount[2])
            {

            }
            Column(BPAmount_3__Control1000000181; BPAmount[3])
            {

            }
            Column(BPCount_3__Control1000000182; BPCount[3])
            {

            }
            Column(BPAmount_4__Control1000000183; BPAmount[4])
            {

            }
            Column(BPCount_4__Control1000000184; BPCount[4])
            {

            }
            Column(BPAmount_5__Control1000000185; BPAmount[5])
            {

            }
            Column(BPCount_5__Control1000000186; BPCount[5])
            {

            }
            Column(BPStatus_Control1000000187; BPStatus)
            {

            }
            Column(Pending_in_Bank_Number; Number)
            {
            }
        }

        DataItem("Loan Approved in Bank"; Integer)
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 5));
            Column(BPCount_1__Control1000000196; BPCount[1])
            {

            }
            Column(BPAmount_1__Control1000000197; BPAmount[1])
            {

            }
            Column(BPAmount_2__Control1000000198; BPAmount[2])
            {

            }
            Column(BPCount_2__Control1000000199; BPCount[2])
            {

            }
            Column(BPAmount_3__Control1000000200; BPAmount[3])
            {

            }
            Column(BPCount_3__Control1000000201; BPCount[3])
            {

            }
            Column(BPAmount_4__Control1000000202; BPAmount[4])
            {

            }
            Column(BPCount_4__Control1000000203; BPCount[4])
            {

            }
            Column(BPAmount_5__Control1000000204; BPAmount[5])
            {

            }
            Column(BPCount_5__Control1000000205; BPCount[5])
            {

            }
            Column(BPStatus_Control1000000206; BPStatus)
            {

            }
            Column(Loan_Approved_in_Bank_Number; Number)
            {

            }
        }
        DataItem("Loan Rejected"; Integer)
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 5));

            Column(BPCount_1__Control1000000098; BPCount[1])
            {

            }
            Column(BPAmount_1__Control1000000099; BPAmount[1])
            {

            }
            Column(BPAmount_2__Control1000000100; BPAmount[2])
            {

            }
            Column(BPCount_2__Control1000000101; BPCount[2])
            {

            }
            Column(BPAmount_3__Control1000000102; BPAmount[3])
            {

            }
            Column(BPCount_3__Control1000000103; BPCount[3])
            {

            }
            Column(BPAmount_4__Control1000000104; BPAmount[4])
            {

            }
            Column(BPCount_4__Control1000000105; BPCount[4])
            {

            }
            Column(BPAmount_5__Control1000000106; BPAmount[5])
            {

            }
            Column(BPCount_5__Control1000000107; BPCount[5])
            {

            }
            Column(BPStatus_Control1000000207; BPStatus)
            {

            }
            Column(Loan_Rejected_Number; Number)
            {

            }
        }

        DataItem("CGC Issued"; Integer)
        {
            DataItemTableView = SORTING (Number) WHERE (Number = FILTER (1 .. 5));
            Column(BPCount_1__Control1000000075; BPCount[1])
            {

            }
            Column(BPAmount_1__Control1000000077; BPAmount[1])
            {

            }
            Column(BPAmount_2__Control1000000080; BPAmount[2])
            {

            }
            Column(BPCount_2__Control1000000081; BPCount[2])
            {

            }
            Column(BPAmount_3__Control1000000082; BPAmount[3])
            {

            }
            Column(BPCount_3__Control1000000083; BPCount[3])
            {

            }
            Column(BPAmount_4__Control1000000084; BPAmount[4])
            {

            }
            Column(BPCount_4__Control1000000085; BPCount[4])
            {

            }
            Column(BPAmount_5__Control1000000086; BPAmount[5])
            {

            }
            Column(BPCount_5__Control1000000087; BPCount[5])
            {

            }
            Column(BPStatus_Control1000000088; BPStatus)
            {

            }
            Column(CGC_Issued_Number; Number)
            {

            }
        }






    }

    var

        BPCount: array[5] of Integer;
        BPAmount: array[5] of Decimal;
        Year: Integer;
        FromDate: array[5] of Date;
        ToDate: array[5] of Date;
        Application: Record "Guarantee Application";
        Contract: Record "Guarantee Contracts";
        BPStatus: Text[100];
        Ownership: Option;
        Gender: Option;
        Branch: Code[30];
        "Sales Men": Code[30];
        ContFilter: Text[100];
        LF: Text[1];
        ContFilter2: Text[100];


        Q1CaptionLbl: TextConst ENU = 'Q1';
        Q2CaptionLbl: TextConst ENU = 'Q2';
        Q3CaptionLbl: TextConst ENU = 'Q3';
        Q4CaptionLbl: TextConst ENU = 'Q4';
        TypeCaptionLbl: TextConst ENU = 'Type';
        No_CaptionLbl: TextConst ENU = 'No.';
        AmountCaptionLbl: TextConst ENU = 'Amount';
        AmountCaption_Control1000000019Lbl: TextConst ENU = 'Amount';
        No_Caption_Control1000000020Lbl: TextConst ENU = 'No.';
        AmountCaption_Control1000000021Lbl: TextConst ENU = 'Amount';
        No_Caption_Control1000000022Lbl: TextConst ENU = 'No.';
        AmountCaption_Control1000000023Lbl: TextConst ENU = 'Amount';
        No_Caption_Control1000000024Lbl: TextConst ENU = 'No.';
        AmountCaption_Control1000000025Lbl: TextConst ENU = 'Amount';
        No_Caption_Control1000000026Lbl: TextConst ENU = 'No.';


    trigger OnInitReport()

    begin
        Year := DATE2DMY(WORKDATE, 3);
    end;

    trigger OnPreReport()
    begin
        ContFilter := Parameters.GETFILTERS;
        IF ((Year < 2000) OR (Year > DATE2DMY(TODAY, 3))) THEN
            ERROR('Please enter Year between %1 and %2', 2000, DATE2DMY(TODAY, 3));

        FromDate[1] := DMY2DATE(1, 1, Year);
        FromDate[2] := DMY2DATE(1, 4, Year);
        FromDate[3] := DMY2DATE(1, 7, Year);
        FromDate[4] := DMY2DATE(1, 10, Year);
        FromDate[5] := FromDate[1];

        ToDate[1] := DMY2DATE(31, 3, Year);
        ToDate[2] := DMY2DATE(30, 6, Year);
        ToDate[3] := DMY2DATE(30, 9, Year);
        ToDate[4] := DMY2DATE(31, 12, Year);
        ToDate[5] := ToDate[4];
    end;

    procedure ApplicationCountAndCalc(PeriodIdx: Integer)
    var
        CurrencyFactor: Decimal;
    begin
        BPCount[PeriodIdx] += Application.COUNT;
        IF Application.FINDFIRST THEN
            REPEAT
                CurrencyFactor := GetCurrencyFactor(Application."Currency Code", FromDate[PeriodIdx]);
                BPAmount[PeriodIdx] += ROUND(Application."Loan Amount" * CurrencyFactor, 1);
            UNTIL Application.NEXT = 0;
    end;


    procedure ContractCountAndCalc(PeriodIdx: Integer; UseCGCAmount: Boolean)
    var
        CurrencyFactor: Decimal;
    begin
        BPCount[PeriodIdx] += Contract.COUNT;
        IF Contract.FINDFIRST THEN
            REPEAT
                IF UseCGCAmount THEN
                    BPAmount[PeriodIdx] += Contract."CGC Amount"
                ELSE BEGIN
                    CurrencyFactor := GetCurrencyFactor(Contract."BP Currency", FromDate[PeriodIdx]);
                    BPAmount[PeriodIdx] += ROUND(Contract."BP Amount" * CurrencyFactor, 1);
                END;
            UNTIL Contract.NEXT = 0;
    end;

    procedure GetCurrencyFactor(CurrencyCode: Code[50]; CurrencyDate: Date): Decimal
    var
        CurrencyExchangeRate: Record "Currency Exchange Rate";
    begin
        IF (CurrencyCode = '') THEN
            EXIT(1);

        CurrencyExchangeRate.SETRANGE("Currency Code", CurrencyCode);
        CurrencyExchangeRate.SETRANGE("Starting Date", 0D, CurrencyDate);
        IF NOT CurrencyExchangeRate.FINDLAST THEN BEGIN
            CurrencyExchangeRate.SETRANGE("Starting Date");
            CurrencyExchangeRate.FINDFIRST;
        END;

        EXIT(CurrencyExchangeRate."Relational Exch. Rate Amount");
    end;

    procedure SetApplicationFilter()

    begin
        Application.RESET;
        ContFilter := Parameters.GETFILTER("BDS/BDO");
        IF (ContFilter <> '') THEN
            Application.SETFILTER("BDS/BDO", ContFilter);

        ContFilter := Parameters.GETFILTER(Ownership);
        IF (ContFilter <> '') THEN
            Application.SETFILTER(Ownership, ContFilter);

        ContFilter := Parameters.GETFILTER("Global Dimension 1 Code");
        IF (ContFilter <> '') THEN
            Application.SETFILTER("Global Dimension 1 Code", ContFilter);

        ContFilter := Parameters.GETFILTER("Global Dimension 2 Code");
        IF (ContFilter <> '') THEN
            Application.SETFILTER("Global Dimension 2 Code", ContFilter);

        ContFilter := Parameters.GETFILTER(Gender);
        IF (ContFilter <> '') THEN
            Application.SETFILTER(Gender, ContFilter);

    end;

    procedure SetContractFilter()
    begin
        Contract.RESET;
        ContFilter := Parameters.GETFILTER("BDS/BDO");
        IF (ContFilter <> '') THEN
            Contract.SETFILTER("BDS/BDO", ContFilter);

        ContFilter := Parameters.GETFILTER(Ownership);
        IF (ContFilter <> '') THEN
            Contract.SETFILTER(Ownership, ContFilter);

        ContFilter := Parameters.GETFILTER(Status);
        IF (ContFilter <> '') THEN
            Contract.SETFILTER(Status, ContFilter);

        ContFilter := Parameters.GETFILTER("Global Dimension 1 Code");
        IF (ContFilter <> '') THEN
            Contract.SETFILTER("Global Dimension 1 Code", ContFilter);

        ContFilter := Parameters.GETFILTER("Global Dimension 2 Code");
        IF (ContFilter <> '') THEN
            Contract.SETFILTER("Global Dimension 2 Code", ContFilter);

        ContFilter := Parameters.GETFILTER(Gender);
        IF (ContFilter <> '') THEN
            Contract.SETFILTER(Gender, ContFilter);

    end;
}