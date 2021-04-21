codeunit 51513000 "Guarantee Management"
{
    trigger OnRun()
    begin

    end;

    var
        BatchNo: Code[20];
        LOBatchHeader: Record "Lenders Option Journal Header";
        Text001: TextConst ENU = 'No %1 has already been imported with Application Date %2';
        Counter: Integer;
        ERR_NO_IMP_APPL: TextConst ENU = 'No imported applications';
        TEXT_VAL_PROGRESS: TextConst ENU = 'Validating transactions @1@@@@@@@@@@@@@';
        ERR_FIELD_LOANAMOUNT: TextConst ENU = 'Loan Amount Applied must be greater than 0 on application %1 (%2).';
        Window: Dialog;
        TotalRec: Integer;
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesSetup: Record "Sales & Receivables Setup";
        ProductCharges: Record "Product Charges";
        Cust: Record Customer;
        NoSeriesManagement: Codeunit NoSeriesManagement;
        NoSeries: Record "No. Series";
        GuaranteeSetup: Record "Guarantee Management Setup";
        GuaranteeContract: Record "Guarantee Contracts";
        GuaranteeApp: Record "Guarantee Application";
        ERR_CUSTOMER_NOT_EXIST: TextConst ENU = 'Customer %1 does not exist.', ENG = 'Customer %1 does not exist.';
        ERR_FIELD: TextConst ENU = '%1 must be entered for application %2.', ENG = '%1 must be entered for application %2.';
        TEXT_CREATE_PROGRESS: TextConst ENU = 'Creating accounts @1@@@@@@@@@@@@@';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ProductType: Record Products;
        LoanAmount: Decimal;
        StageRec: Record "Guarantee Application Stages";

    procedure GenderCount(var Rec: Record "Guarantee Application")
    var
        GroupMember: Record "Group Member";
    begin
        //counting gender for group and company members 
        WITH Rec DO BEGIN
            "No. of Females" := 0;
            "No. of Males" := 0;
            CASE Ownership OF
                Ownership::Individual:
                    IF Gender = Gender::Female THEN
                        "No. of Females" := 1
                    ELSE
                        IF Gender = Gender::Male THEN
                            "No. of Males" := 1;
                Ownership::Partnership, Ownership::"Cooperatives Societies", Ownership::Company:
                    BEGIN
                        GroupMember.SETRANGE("No.", "No.");
                        GroupMember.SetRange(Gender, Gender::Female);

                        IF GroupMember.FINDFIRST THEN begin
                            "No. of Females" := GroupMember.Count;
                            Modify();
                            Message(Format("No. of Females"));
                        end;
                        GroupMember.SETRANGE("No.", "No.");
                        GroupMember.SetRange(Gender, Gender::Male);
                        IF GroupMember.FINDFIRST THEN
                            "No. of Males" := GroupMember.Count;
                        Modify();
                    END;
            END;
        end;
    END;

    procedure CreateApplicationFeeAndCustNo(var Rec: Record "Guarantee Application")

    var
        ERR_INSERT_CUSTOMER: TextConst ENU = 'Cannot create client record for application %1 (%2).', ENG = 'Cannot create client record for application %1 (%2).';
        ChargedAmount: Decimal;
        ProductType: Record Products;
        Cust1: Record Customer;
        LoanAmount: Decimal;
        Feetype: option " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee";
    begin
        SalesSetup.GET;
        GuaranteeSetup.Get;
        with Rec Do begin
            //create customer if not exists 
            IF (Rec."Customer No." <> '') THEN BEGIN
                IF NOT Cust.GET("Customer No.") THEN
                    ERROR(ERR_CUSTOMER_NOT_EXIST, Rec."Customer No.");
            END ELSE
                WITH Cust DO BEGIN
                    INIT;
                    TRANSFERFIELDS(Rec);
                    "No." := NoSeriesManagement.GetNextNo(SalesSetup."Customer Nos.",
                                                           TODAY, TRUE);
                    "Gen. Bus. Posting Group" := GuaranteeSetup."Gen. Bus. Posting Group";
                    "VAT Bus. Posting Group" := GuaranteeSetup."VAT Bus. Posting Group";
                    "Customer Posting Group" := GuaranteeSetup."Customer Posting Group";

                    IF NOT INSERT THEN
                        ERROR(ERR_INSERT_CUSTOMER, Rec."No.", Rec.Name)
                    ELSE
                        MESSAGE('Customer No.: %1 created', Cust."No.");
                    VALIDATE("Global Dimension 1 Code");
                    VALIDATE("Global Dimension 2 Code");

                    Rec."Customer No." := Cust."No.";
                    Modify;
                END;
            //end creating customer 

            IF ProductType.Get(Rec.Product) then begin

                if ((ProductType.Type = ProductType.Type::Traditional) and NOT ("Application fee Invoiced")) then begin
                    //Create invoice.

                    if "Charge fees on Guaranteed Amt" then
                        LoanAmount := "Applied Guarantee Amount"
                    else
                        LoanAmount := "Loan Amount";

                    GuaranteeAppFees(Rec, Feetype::"Application Fee", LoanAmount, "Charge fees on Guaranteed Amt", "Customer No.", "Currency Code");

                end else begin
                    if ((ProductType.Type = ProductType.Type::"Lenders Option") and Not (Rec."Booked fee Invoiced ")) then begin
                        //Create invoice.
                        "Have Business Plan?" := true;
                        Modify;
                        TestField("Receivables Acc. No.");
                        if Cust1.get("Receivables Acc. No.") then
                            GuaranteeAppFees(Rec, Feetype::"Booked Fee", "Loan Amount", "Charge fees on Guaranteed Amt", Rec."Receivables Acc. No.", "Currency Code");

                    end;
                end;

            end;
        end;
    end;
    //<<end Application fee

    //Create Contract
    procedure CreateContract(var Rec: Record "Guarantee Application")
    var
        App: Record "Guarantee Contracts";
        ChargedAmount: Decimal;
        Feetype: option " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee";

    begin
        SalesSetup.GET;
        GuaranteeSetup.Get;
        with Rec do begin

            //Create invoice.
            IF not (("Have Business Plan?") and not ("Consultancy Fee Invoiced")) THEN BEGIN
                if "Charge fees on Guaranteed Amt" then
                    GuaranteeAppFees(Rec, Feetype::Consultancy, "Applied Guarantee Amount", "Charge fees on Guaranteed Amt", "Customer No.", "Currency Code")
                else
                    GuaranteeAppFees(Rec, Feetype::Consultancy, "BP Amount", "Charge fees on Guaranteed Amt", "Customer No.", "BP Currency")

            end;
            Rec."Application Status" := Rec."Application Status"::"Contract Signed";
            Rec.Modify;
            App.TransferFields(Rec);
            App.Status := Status::Open;
            if ProductType.Get(Rec.Product) then begin
                if ProductType.Type = ProductType.Type::"Lenders Option" then begin
                    App."Pct. Guarantee Approved" := ProductType."Portfolio Guarantee %";
                    App."Contract Status" := app."Contract Status"::"Loan Granted";
                    App."Approved Loan Amount" := Rec."Loan Amount";
                    App."Approved Loan Currency" := Rec."Currency Code";
                    App."Approved Loan Currency Factor" := Rec."Currency Factor";
                    App.Validate("Pct. Guarantee Approved");
                end else begin
                    App."Contract Status" := App."Contract Status"::"BP in Progress";

                    StageRec.Reset;
                    StageRec.SetRange(Stage, StageRec.Stage::"Business Plan");
                    StageRec.SetRange(Sequence, 1);
                    if StageRec.FindFirst() then
                        Stage := StageRec.Code;
                end;
            end;
            App."Modified By" := UserId;
            App.Insert(true);
        end;
    end;

    procedure BDO_Appraisal(App: Record "Guarantee Application")

    begin
        ValidateFields(App, App."Application Status"::"Pre-Appraised")
    end;

    procedure Contract_Prepared(App: Record "Guarantee Application")

    begin
        ValidateFields(App, App."Application Status"::"Contract Prepared")
    end;

    procedure BDO_SignContracts(App: Record "Guarantee Application")
    var
        FinancialInfo: Record "Guarantee App Financial Info";
    begin
        FinancialInfo.Reset();
        FinancialInfo.SetRange("Application No.", App."No.");
        IF FinancialInfo.FindFirst() then
            ValidateFields(App, App."Application Status"::"Contract Signed")
        else
            Error('Kindly fill in financial infomation for %1', App."No.");

    end;

    local procedure GetNoSeriesCode(): Code[20]
    var
        NoSeriesCode: Code[20];
    begin
        NoSeriesCode := SalesSetup."Invoice Nos.";

        EXIT(NoSeriesManagement.GetNoSeriesWithCheck(NoSeriesCode, TRUE, SalesHeader."No. Series"));
    end;

    procedure ValidateFields(PASSApplication: Record "Guarantee Application"; NewStatus: Integer): Text[30]
    var
        FieldWithError: Text[30];
        Appinv: Decimal;
        Appfeepaid: Decimal;
        ProductType: Record Products;
    begin
        //Returns name of field required; blank if ok
        FieldWithError := '';

        WITH PASSApplication DO BEGIN
            //CalcFields("Application fee Invoice Amount");
            Appinv := "Application fee Invoice Amount";
            Appfeepaid := "Application fee Paid";
            IF (NewStatus >= "Application Status"::"Commitment Paid") AND (NewStatus < "Application Status"::Rejected) THEN BEGIN
                IF (Name = '') THEN
                    FieldWithError := FIELDCAPTION(Name)
                ELSE
                    IF (Address = '') THEN
                        FieldWithError := FIELDCAPTION(Address)
                    ELSE
                        IF (City = '') THEN
                            FieldWithError := FIELDCAPTION(City)

                        //    ELSE IF ("Branch Code" = '') THEN
                        //      FieldWithError := FIELDCAPTION ("Branch Code")
                        ELSE
                            IF ("Global Dimension 1 Code" = '') THEN
                                FieldWithError := FIELDCAPTION("Global Dimension 1 Code")
                            ELSE
                                IF ("BDS/BDO" = '') THEN
                                    FieldWithError := FIELDCAPTION("BDS/BDO")
                                ELSE
                                    IF ("Project Description" = '') THEN
                                        FieldWithError := FIELDCAPTION("Project Description")
                                    ELSE
                                        IF ("Loan Amount" = 0) THEN
                                            FieldWithError := FIELDCAPTION("Loan Amount")
                                        ELSE
                                            IF (PASSApplication."Application Date" = 0D) THEN
                                                FieldWithError := FIELDCAPTION("Application Date")
                                            else
                                                if (PASSApplication.Product = '') then
                                                    FieldWithError := FieldCaption(Product)
                                                else
                                                    if ProductType.Get(Product) then begin
                                                        if ProductType.Type = ProductType.Type::"Lenders Option" then begin
                                                            TestField("Receivables Acc. Name");
                                                            TestField("Receivables Acc. No.");
                                                            TestField("Receivables Address");
                                                            TestField("Bank Branch Name");
                                                        end;

                                                    end;
                if (PASSApplication."Business Ownership Type" = '') then
                    FieldWithError := FieldCaption("Business Ownership Type")
                else
                    IF Status <> Status::Open THEN BEGIN

                        if ProductType.Type = ProductType.Type::Traditional then begin
                            if ("CheckedforE&SSustainability?" = "CheckedforE&SSustainability?"::" ") then
                                FieldWithError := FieldCaption("CheckedforE&SSustainability?")
                            else
                                if ("MeetMinimumRequirements?" = "MeetMinimumRequirements?"::" ") then
                                    FieldWithError := FieldCaption("MeetMinimumRequirements?")
                                else
                                    if ("MitigationMeasuresAgreed?" = "MitigationMeasuresAgreed?"::" ") then
                                        FieldWithError := FieldCaption("MitigationMeasuresAgreed?")
                                    else
                                        if ("InvestmentInGreenSolutions?" = "InvestmentInGreenSolutions?"::" ") then
                                            FieldWithError := FieldCaption("InvestmentInGreenSolutions?")
                                        else
                                            if ("InvestmentInGreenSolutions?" = "InvestmentInGreenSolutions?"::Yes) then
                                                if (InvestmentInGreenSum = '') then
                                                    FieldWithError := FieldCaption(InvestmentInGreenSum)
                        end;

                        if "Application fee Invoiced" = false then
                            Error('Application fee must be created')
                        else
                            if "Application fee Invoice Amount" = 0 then
                                Error('Application fee invoice is not posted')
                            else
                                if not "Application fee Waived" and not "Waive all fees" then begin
                                    if "Application fee Paid" = 0 then
                                        Error('Application fee not paid')
                                    else
                                        if Appfeepaid < Appinv then
                                            Error('Application fee is not fully paid')
                                end;
                    END else
                        if (PASSApplication.Ownership = PASSApplication.Ownership::Individual) then begin
                            PASSApplication.TestField(Gender);
                            PASSApplication.TestField("Date of Birth");

                        END;


            END;

            IF (FieldWithError = '')
               AND (NewStatus >= "Application Status"::"Contract Prepared") AND (NewStatus < "Application Status"::Rejected) THEN BEGIN
                IF ("BP Amount" = 0) THEN
                    FieldWithError := FIELDCAPTION("BP Amount");
            END;

            IF (FieldWithError = '') AND (NewStatus = "Application Status"::"Contract Signed") THEN BEGIN
                IF ("Contract Signed Date" = 0D) THEN
                    FieldWithError := FIELDCAPTION("Contract Signed Date");
                /*IF ("Consultancy Fee %" = 0) THEN
                    FieldWithError := FIELDCAPTION("Consultancy Fee %");*/
            END;

            IF (FieldWithError = '') AND (NewStatus = "Application Status"::Rejected) THEN
                IF ("Reject Reason" = '') THEN
                    FieldWithError := FIELDCAPTION("Reject Reason");


            IF (FieldWithError > '') THEN
                ERROR(ERR_FIELD, FieldWithError, PASSApplication."No.");

        END;
    end;
    //Contract
    procedure ValidateContractFields(Contract: Record "Guarantee Contracts"; NewStatus: Integer): text[30]
    var
        FieldWithError: text[30];
        ERR_FIELD_CONTRACT: TextConst ENU = '%1 must be entered for contract %2.';
        ERR_FIELD_CUSTOMER: TextConst ENU = '%1 must be entered for customer %2.';
        banks: Record Banks;
    begin
        FieldWithError := '';
        WITH Contract DO BEGIN

            IF (NewStatus IN ["Contract Status"::"BP in Progress",
                              "Contract Status"::"BP with Bank",
                              "Contract Status"::"Loan Granted",
                              "Contract Status"::"CGC Prepared",
                              "Contract Status"::"CGC Issued"]) THEN BEGIN
                //CALCFIELDS(Name, Address, City, "Global Dimension 1 Code");

                IF (Name = '') THEN
                    FieldWithError := FIELDCAPTION(Name)
                ELSE
                    IF (Address = '') THEN
                        FieldWithError := FIELDCAPTION(Address)
                    ELSE
                        IF (City = '') THEN
                            FieldWithError := FIELDCAPTION(City)
                        //    ELSE IF ("Branch Code" = '') THEN
                        //      FieldWithError := FIELDCAPTION ("Branch Code")
                        ELSE
                            IF ("Global Dimension 1 Code" = '') THEN
                                FieldWithError := 'Region Code';

                IF (FieldWithError > '') THEN
                    ERROR(ERR_FIELD_CUSTOMER, FieldWithError, "Customer No.");

                IF ("BDS/BDO" = '') THEN
                    FieldWithError := FIELDCAPTION("BDS/BDO")
                ELSE
                    IF ("Project Description" = '') THEN
                        FieldWithError := FIELDCAPTION("Project Description")
                    ELSE
                        IF ("Loan Amount" = 0) THEN
                            FieldWithError := FIELDCAPTION("Loan Amount")

                        ELSE
                            IF ("Customer No." = '') THEN
                                FieldWithError := FIELDCAPTION("Customer No.");

                IF (FieldWithError > '') THEN
                    ERROR(ERR_FIELD_CONTRACT, FieldWithError, "No.");

                IF (NewStatus >= "Contract Status"::"BP with Bank") THEN BEGIN
                    if ProductType.Get(Product) then
                        if ProductType.Type <> ProductType.Type::"Lenders Option" then begin
                            IF ("Submit to Bank Date" = 0D) THEN
                                FieldWithError := FIELDCAPTION("Submit to Bank Date")
                            ELSE
                                IF ("BP Amount" = 0) THEN
                                    FieldWithError := FIELDCAPTION("BP Amount")
                                ELSE
                                    IF ("Pct. Guarantee Applied" = 0) THEN
                                        FieldWithError := FIELDCAPTION("Pct. Guarantee Applied")
                        end;
                    if "Product Type" = "Product Type"::Traditional then begin
                        banks.Reset();
                        banks.SetRange("No.", "No.");
                        if banks.FindFirst() then begin
                            IF (banks."Bank Name" = '') THEN
                                FieldWithError := banks.FIELDCAPTION("Bank Name")
                            ELSE
                                IF (banks.Branch = '') THEN
                                    FieldWithError := banks.FIELDCAPTION(Branch)
                        end else
                            Error('Kindly specify banks that you are submitting this business proposal to.');

                    end else begin
                        if Bank = '' then
                            FieldWithError := FieldCaption(Bank)
                        else
                            if "Bank Branch Name" = '' then
                                FieldWithError := FieldCaption("Bank Branch Name");
                    end;
                    IF ("Loan Amount" = 0) THEN
                        FieldWithError := FIELDCAPTION("Loan Amount")

                    ELSE
                        if not (("Have Business Plan?")) then begin
                            IF "Consultancy Fee Invoiced" = false then
                                Error('Consultancy Fee must be Invoiced')
                            else
                                if "Consultancy Fee Invoice Amount" = 0 then
                                    Error('Consultancy Fee Invoice must be posted')
                                else
                                    if not "Consultancy fee Waived" and not "Waive all fees" then begin
                                        IF ("Consultancy Fee Paid" <= 0) THEN
                                            FieldWithError := FIELDCAPTION("Consultancy Fee Paid")
                                        else
                                            if ("Consultancy Fee Paid") < ("Consultancy Fee Invoice Amount") then
                                                Error('Consultancy is not fully paid');
                                    end;
                        end;
                    IF (FieldWithError > '') THEN
                        ERROR(ERR_FIELD_CONTRACT, FieldWithError, "No.");

                    /*CALCFIELDS("Consult Balance");
                    IF ("Consult Balance" > "Consult Paymt From Loan") THEN
                        ERROR(ERR_CONSULT_BALANCE, "Consult Balance" - "Consult Paymt From Loan", "No.")
*/
                END;

                IF ((NewStatus >= "Contract Status"::"Loan Granted") AND (NewStatus <> "Contract Status"::"CGC Cancelled")) THEN BEGIN
                    IF ("Loan Issued Date" = 0D) THEN
                        FieldWithError := FIELDCAPTION("Loan Issued Date")
                    ELSE
                        IF ("Loan No." = '') THEN
                            FieldWithError := FIELDCAPTION("Loan No.")
                        ELSE
                            IF ("Approved Loan Amount" = 0) THEN
                                FieldWithError := FIELDCAPTION("Approved Loan Amount")
                            ELSE
                                IF ("Pct. Guarantee Approved" = 0) THEN
                                    FieldWithError := FIELDCAPTION("Pct. Guarantee Approved")
                                else
                                    if ("Guarantee Source" = '') then
                                        FieldWithError := FieldCaption("Guarantee Source")
                                    else
                                        if ("Receivables Acc. No." = '') then
                                            FieldWithError := FieldCaption("Receivables Acc. No.")
                                        else
                                            if ("Bank Branch Name" = '') then
                                                FieldWithError := FieldCaption("Bank Branch Name");


                    IF (FieldWithError > '') THEN
                        ERROR(ERR_FIELD_CONTRACT, FieldWithError, "No.");
                END;

                IF ((NewStatus >= "Contract Status"::"CGC Prepared") AND (NewStatus <> "Contract Status"::"CGC Cancelled")) THEN BEGIN
                    IF ("CGC No." = '') THEN
                        FieldWithError := FIELDCAPTION("CGC No.")
                    ELSE
                        IF ("CGC Amount" = 0) THEN
                            FieldWithError := FIELDCAPTION("CGC Amount")
                        ELSE
                            IF ("CGC Date" = 0D) THEN
                                FieldWithError := FIELDCAPTION("CGC Date")
                            ELSE
                                IF ("CGC Seq.No." = '') THEN
                                    FieldWithError := FIELDCAPTION("CGC Seq.No.")
                                ELSE
                                    IF ("CGC No." = '') THEN
                                        FieldWithError := FIELDCAPTION("CGC No.")
                                    ELSE
                                        IF ("CGC Start Date" = 0D) THEN
                                            FieldWithError := FIELDCAPTION("CGC Start Date")
                                        ELSE
                                            IF ("Loan Maturity Date" = 0D) THEN
                                                FieldWithError := FIELDCAPTION("Loan Maturity Date")
                                            ELSE
                                                IF ("CGF %" = 0) THEN
                                                    FieldWithError := FIELDCAPTION("CGF %")
                                                ELSE
                                                    IF ("Risk Sharing Fee %" = 0) THEN
                                                        FieldWithError := FIELDCAPTION("Risk Sharing Fee %")
                                                    ELSE
                                                        IF ("Signatory 1 (CGC)" = '') THEN
                                                            FieldWithError := FIELDCAPTION("Signatory 1 (CGC)")
                                                        ELSE
                                                            IF ("Signatory 2 (CGC)" = '') THEN
                                                                FieldWithError := FIELDCAPTION("Signatory 2 (CGC)")
                                                            else

                                                                IF (FieldWithError > '') THEN
                                                                    ERROR(ERR_FIELD_CONTRACT, FieldWithError, "No.")
                                                                else

                                                                    if "Product Type" = "Product Type"::Traditional then begin
                                                                        IF "Linkage fee Invoiced" = false then
                                                                            Error('Linkage fee mast be Invoiced')
                                                                        else
                                                                            if "Linkage fee Invoice Amount" = 0 then
                                                                                Error('Linkage Fee Invoice must be posted')
                                                                            else
                                                                                if not "Linkage fee Waived" and not "Waive all fees" then begin
                                                                                    IF ("Linkage fee Paid" <= 0) THEN
                                                                                        FieldWithError := FIELDCAPTION("Linkage fee Paid")
                                                                                    else
                                                                                        if ("Linkage fee Paid") < ("Linkage fee Invoice Amount") then
                                                                                            Error('Linkage fee is not fully paid');
                                                                                end;

                                                                    end;


                END;

            END;

            IF (FieldWithError = '') AND (NewStatus = "Contract Status"::Rejected) THEN
                IF ("Reject Reason" = '') THEN
                    FieldWithError := FIELDCAPTION("Reject Reason");

            //VEGA OVJ 19/06/2012
            IF (FieldWithError = '') AND (NewStatus = "Contract Status"::"CGC Cancelled") THEN BEGIN
                IF ("CGC Cancel Date" = 0D) THEN
                    FieldWithError := FIELDCAPTION("CGC Cancel Date")
                /* ELSE
                     IF ("CGC Cancel Reason" = '') THEN
                         FieldWithError := FIELDCAPTION("CGC Cancel Reason")*/
                ELSE
                    IF ("CGC Cancel Reason" = "CGC Cancel Reason"::"Claim Paid") AND ("Claim Amount" = 0) THEN
                        FieldWithError := FIELDCAPTION("Claim Amount")
            END;

            //  IF (FieldWithError = '') AND ("Guarantee Source" = "Guarantee Source"::CGF) AND ("Reason Using CGF" = '') THEN
            //    FieldWithError := FIELDCAPTION ("Reason Using CGF");
            //VEGA OVJ 19/06/2012 End

            IF (FieldWithError > '') THEN
                ERROR(ERR_FIELD_CONTRACT, FieldWithError, "No.");

        END;

    end;

    procedure SubmitTobank(var Contracts: Record "Guarantee Contracts")
    var
        Feetype: option " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee";
    begin
        with Contracts do begin
            ValidateContractFields(Contracts, Contracts."Contract Status"::"BP with Bank");


        end;
    end;

    procedure LoanGranted(var Contract: Record "Guarantee Contracts")

    var
        GuaranteeAmt: Decimal;
        Feetype: option " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee";
    begin
        GuaranteeAmt := Contract."PASS Guarantee Amount" + Contract."SIDA Guarantee Amount";
        ValidateContractFields(Contract, Contract."Contract Status"::"Loan Granted");
        if not Contract."Linkage fee Invoiced" then begin
            if Contract."Charge fees on Guaranteed Amt" then
                GuaranteeFees(Contract, Feetype::"Linkage Banking", GuaranteeAmt, Contract."Charge fees on Guaranteed Amt", Contract."Approved Loan Currency")
            else
                GuaranteeFees(Contract, Feetype::"Linkage Banking", Contract."Approved Loan Amount", Contract."Charge fees on Guaranteed Amt", Contract."Approved Loan Currency");
        end;

    end;

    procedure PrepareCGC(var Contract: Record "Guarantee Contracts")

    begin
        ValidateContractFields(Contract, Contract."Contract Status"::"CGC Prepared");

    end;

    procedure IssueCGC(var Contract: Record "Guarantee Contracts")

    begin

        if Contract."Product Type" <> contract."Product Type"::"Lenders Option" then
            ValidateContractFields(Contract, Contract."Contract Status"::"CGC Issued");

    end;

    procedure GuaranteeFees(var Rec: Record "Guarantee Contracts"; Feetype: option " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee"; LoanAmount: Decimal; ChargeOnGuaranteeAmount: Boolean; CurrencyCode: Code[20])
    var

        ChargedAmount: Decimal;

    begin

        SalesSetup.GET;
        GuaranteeSetup.Get;
        with Rec do begin

            //Create invoice.

            IF Cust.GET("Customer No.") THEN BEGIN
                SalesHeader.INIT;

                SalesSetup.TESTFIELD("Invoice Nos.");
                SalesSetup.TESTFIELD("Posted Invoice Nos.");

                NoSeries.GET(GetNoSeriesCode);
                SalesHeader."No." := NoSeriesManagement.GetNextNo(NoSeries.Code, TODAY, TRUE);
                SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                IF ((SalesHeader."No. Series" <> '') AND (SalesSetup."Invoice Nos." = SalesSetup."Posted Invoice Nos.")) THEN
                    SalesHeader."Posting No. Series" := SalesHeader."No. Series"
                ELSE
                    NoSeriesManagement.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Invoice Nos.");
                IF SalesSetup."Shipment on Invoice" THEN
                    NoSeriesManagement.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Shipment Nos.");

                SalesHeader.VALIDATE("Currency Code", CurrencyCode);
                SalesHeader.Validate("Salesperson Code", "BDS/BDO");
                SalesHeader.VALIDATE("Sell-to Customer No.", Rec."Customer No.");
                SalesHeader."Sell-to Customer No." := Rec."Customer No.";
                SalesHeader."Shipment Date" := Today;
                SalesHeader."Order Date" := Today;
                SalesHeader."Posting Date" := Today;
                SalesHeader."Document Date" := Today;
                SalesHeader."Prices Including VAT" := true;
                SalesHeader."Posting Description" := FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No.";

                SalesHeader."Guarantee Entry Type" := Feetype;
                SalesHeader."Guarantee Application No." := Rec."No.";

                ProductCharges.RESET;
                ProductCharges.SETRANGE("Product Code", Product);
                ProductCharges.SetRange("Charge on Guarantee Amt", ChargeOnGuaranteeAmount);
                ProductCharges.SetRange("Charge Type", Feetype);
                ProductCharges.SetRange("Currency Code", CurrencyCode);

                If ProductCharges.FindFirst then begin
                    IF SalesHeader.INSERT THEN
                        MESSAGE('Invoice No.: %1 created', SalesHeader."No.")
                    ELSE
                        MESSAGE('Invoice No.: %1 not created', SalesHeader."No.");
                    repeat
                        ProductCharges.TestField("G/L Account");

                        SalesLine.INIT;
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
                        SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                        SalesLine."Shortcut Dimension 1 Code" := rec."Global Dimension 1 Code";
                        SalesLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        SalesLine."Guarantee Application No." := Rec."No.";
                        SalesLine."Guarantee Entry Type" := Feetype;
                        SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
                        SalesLine.VALIDATE("No.", ProductCharges."G/L Account");
                        SalesLine.VALIDATE(Quantity, 1);
                        IF ((LoanAmount > ProductCharges."Minimum Amount") AND (LoanAmount <= ProductCharges."Maximum Amount")) THEN BEGIN
                            IF ProductCharges."Use Perc" THEN BEGIN
                                ChargedAmount := (LoanAmount * ProductCharges.Percentage / 100) + ProductCharges.Amount;

                                IF ((ProductCharges."Minimum Charge" <> 0) OR (ProductCharges."Maximum Charge" <> 0)) THEN BEGIN
                                    IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Minimum Charge" <> 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                    IF ((ChargedAmount >= ProductCharges."Minimum Charge") AND (ChargedAmount < ProductCharges."Maximum Charge")) THEN
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                    IF ((ChargedAmount > ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                    IF ((ChargedAmount >= ProductCharges."Maximum Charge") AND (ProductCharges."Maximum Charge" <> 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Maximum Charge");
                                    IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                END ELSE
                                    SalesLine.VALIDATE("Unit Price", ChargedAmount);
                            END ELSE
                                SalesLine.VALIDATE("Unit Price", ProductCharges.Amount);

                        END ELSE
                            IF ((ProductCharges."Minimum Amount" = 0) AND (ProductCharges."Maximum Amount" = 0)) THEN BEGIN
                                IF ProductCharges."Use Perc" THEN BEGIN
                                    ChargedAmount := (LoanAmount * ProductCharges.Percentage / 100) + ProductCharges.Amount;
                                    IF ((ProductCharges."Minimum Charge" <> 0) OR (ProductCharges."Maximum Charge" <> 0)) THEN BEGIN
                                        IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Minimum Charge" <> 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                        IF ((ChargedAmount >= ProductCharges."Minimum Charge") AND (ChargedAmount < ProductCharges."Maximum Charge")) THEN
                                            SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                        IF ((ChargedAmount > ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                        IF ((ChargedAmount >= ProductCharges."Maximum Charge") AND (ProductCharges."Maximum Charge" <> 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Maximum Charge");
                                        IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                    END ELSE
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                END ELSE
                                    SalesLine.VALIDATE("Unit Price", ProductCharges.Amount);
                            END ELSE
                                SalesLine.VALIDATE("Unit Price", ProductCharges.Amount);



                        SalesHeader.Validate("Gen. Bus. Posting Group", Cust."Gen. Bus. Posting Group");
                        SalesHeader.Validate("VAT Bus. Posting Group", Cust."VAT Bus. Posting Group");
                        SalesHeader.Validate("Customer Posting Group", Cust."Customer Posting Group");

                        SalesHeader.Validate("Prices Including VAT");
                        SalesLine.VALIDATE("Currency Code", CurrencyCode);
                        IF SalesLine."Unit Price" > 0 then
                            SalesLine.INSERT
                        ELSE
                            Error('Unit Price cannot be zero');

                        COMMIT;

                    UNTIL ProductCharges.NEXT = 0;

                    IF Feetype = Feetype::"Linkage Banking" then
                        Rec."Linkage fee Invoiced" := true
                    else
                        if Feetype = Feetype::"Application Fee" then
                            Rec."Application fee Invoiced" := true
                        else
                            if Feetype = Feetype::Consultancy then
                                Rec."Consultancy Fee Invoiced" := true;
                    Modify;
                end;
            end;
        end;
    end;

    procedure GuaranteeAppFees(var Rec: Record "Guarantee Application"; Feetype: option " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee"; LoanAmount: Decimal; ChargeOnGuaranteeAmount: Boolean; CustNo: Code[20]; CurrencyCode: Code[20])
    var

        ChargedAmount: Decimal;
    begin


        SalesSetup.GET;
        GuaranteeSetup.Get;
        with Rec do begin


            //Create invoice.

            IF Cust.GET(CustNo) THEN BEGIN
                SalesHeader.INIT;

                SalesSetup.TESTFIELD("Invoice Nos.");
                SalesSetup.TESTFIELD("Posted Invoice Nos.");

                NoSeries.GET(GetNoSeriesCode);
                SalesHeader."No." := NoSeriesManagement.GetNextNo(NoSeries.Code, TODAY, TRUE);
                SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                IF ((SalesHeader."No. Series" <> '') AND (SalesSetup."Invoice Nos." = SalesSetup."Posted Invoice Nos.")) THEN
                    SalesHeader."Posting No. Series" := SalesHeader."No. Series"
                ELSE
                    NoSeriesManagement.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Invoice Nos.");
                IF SalesSetup."Shipment on Invoice" THEN
                    NoSeriesManagement.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Shipment Nos.");


                SalesHeader.VALIDATE("Currency Code", CurrencyCode);
                SalesHeader.Validate("Salesperson Code", "BDS/BDO");
                SalesHeader.VALIDATE("Sell-to Customer No.", CustNo);
                SalesHeader."Sell-to Customer No." := CustNo;
                SalesHeader."Shipment Date" := Today;
                SalesHeader."Order Date" := Today;
                SalesHeader."Posting Date" := Today;
                SalesHeader."Document Date" := Today;
                SalesHeader."Prices Including VAT" := true;
                SalesHeader."Posting Description" := FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No.";

                SalesHeader."Guarantee Entry Type" := Feetype;
                SalesHeader."Guarantee Application No." := Rec."No.";

                ProductCharges.RESET;
                ProductCharges.SETRANGE("Product Code", Product);
                ProductCharges.SetRange("Charge on Guarantee Amt", ChargeOnGuaranteeAmount);
                ProductCharges.SetRange("Charge Type", Feetype);
                ProductCharges.SetRange("Currency Code", CurrencyCode);
                If ProductCharges.FindFirst then begin

                    IF SalesHeader.INSERT THEN
                        MESSAGE('Invoice No.: %1 created', SalesHeader."No.")
                    ELSE
                        MESSAGE('Invoice No.: %1 not created', SalesHeader."No.");
                    repeat
                        ProductCharges.TestField("G/L Account");

                        SalesLine.INIT;
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
                        SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                        SalesLine."Shortcut Dimension 1 Code" := rec."Global Dimension 1 Code";
                        SalesLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        SalesLine."Guarantee Application No." := Rec."No.";
                        SalesLine."Guarantee Entry Type" := Feetype;
                        SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
                        SalesLine.VALIDATE("No.", ProductCharges."G/L Account");
                        SalesLine.VALIDATE(Quantity, 1);
                        IF ((LoanAmount > ProductCharges."Minimum Amount") AND (LoanAmount <= ProductCharges."Maximum Amount")) THEN BEGIN
                            IF ProductCharges."Use Perc" THEN BEGIN
                                ChargedAmount := (LoanAmount * ProductCharges.Percentage / 100) + ProductCharges.Amount;

                                IF ((ProductCharges."Minimum Charge" <> 0) OR (ProductCharges."Maximum Charge" <> 0)) THEN BEGIN
                                    IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Minimum Charge" <> 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                    IF ((ChargedAmount >= ProductCharges."Minimum Charge") AND (ChargedAmount < ProductCharges."Maximum Charge")) THEN
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                    IF ((ChargedAmount > ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                    IF ((ChargedAmount >= ProductCharges."Maximum Charge") AND (ProductCharges."Maximum Charge" <> 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Maximum Charge");
                                    IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                END ELSE
                                    SalesLine.VALIDATE("Unit Price", ChargedAmount);

                            END ELSE
                                SalesLine.VALIDATE("Unit Price", ProductCharges.Amount);

                        END ELSE
                            IF ((ProductCharges."Minimum Amount" = 0) AND (ProductCharges."Maximum Amount" = 0)) THEN BEGIN
                                IF ProductCharges."Use Perc" THEN BEGIN
                                    ChargedAmount := (LoanAmount * ProductCharges.Percentage / 100) + ProductCharges.Amount;
                                    IF ((ProductCharges."Minimum Charge" <> 0) OR (ProductCharges."Maximum Charge" <> 0)) THEN BEGIN
                                        IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Minimum Charge" <> 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                        IF ((ChargedAmount >= ProductCharges."Minimum Charge") AND (ChargedAmount < ProductCharges."Maximum Charge")) THEN
                                            SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                        IF ((ChargedAmount > ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                        IF ((ChargedAmount >= ProductCharges."Maximum Charge") AND (ProductCharges."Maximum Charge" <> 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Maximum Charge");
                                        IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                    END ELSE
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                END ELSE
                                    SalesLine.VALIDATE("Unit Price", ProductCharges.Amount);
                            END;


                        SalesHeader.Validate("Gen. Bus. Posting Group", Cust."Gen. Bus. Posting Group");
                        SalesHeader.Validate("VAT Bus. Posting Group", Cust."VAT Bus. Posting Group");
                        SalesHeader.Validate("Customer Posting Group", Cust."Customer Posting Group");

                        SalesHeader.Validate("Prices Including VAT");
                        SalesLine.VALIDATE("Currency Code", CurrencyCode);
                        IF SalesLine."Unit Price" > 0 then
                            SalesLine.INSERT
                        ELSE
                            Error('Unit Price cannot be zero');

                        COMMIT;

                    UNTIL ProductCharges.NEXT = 0;

                    IF Feetype = Feetype::"Application Fee" then begin
                        Rec."Customer No." := Cust."No.";
                        Rec."Previous Status" := "Application Status";
                        Rec."Application fee Invoiced" := true;
                        Rec."Application Status" := Rec."Application Status"::"Commitment Paid";

                    end else
                        if Feetype = Feetype::"Booked Fee" then begin
                            Rec."Customer No." := Cust."No.";
                            Rec."Booked fee Invoiced " := true;
                            Rec."Previous Status" := "Application Status";
                            CreateContract(Rec);
                        END else
                            if Feetype = Feetype::Consultancy then
                                Rec."Consultancy Fee Invoiced" := true;
                    Modify;
                end;
            end;
        end;
    end;


    procedure LOBatchFees(var Rec: Record "Lenders Option Single CGC"; Feetype: option " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee"; LoanAmount: Decimal; ChargeOnGuaranteeAmount: Boolean; CustNo: Code[20]; CurrencyCode: Code[20])
    var

        ChargedAmount: Decimal;
        ProductType: Record Products;
        Product: Code[50];
    begin

        ProductType.Reset();
        ProductType.SetRange(Type, ProductType.Type::"Lenders Option");
        if ProductType.FindFirst() then
            Product := ProductType.Code;

        SalesSetup.GET;
        GuaranteeSetup.Get;
        with Rec do begin


            //Create invoice.

            IF Cust.GET(CustNo) THEN BEGIN
                SalesHeader.INIT;

                SalesSetup.TESTFIELD("Invoice Nos.");
                SalesSetup.TESTFIELD("Posted Invoice Nos.");

                NoSeries.GET(GetNoSeriesCode);
                SalesHeader."No." := NoSeriesManagement.GetNextNo(NoSeries.Code, TODAY, TRUE);
                SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                IF ((SalesHeader."No. Series" <> '') AND (SalesSetup."Invoice Nos." = SalesSetup."Posted Invoice Nos.")) THEN
                    SalesHeader."Posting No. Series" := SalesHeader."No. Series"
                ELSE
                    NoSeriesManagement.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Invoice Nos.");
                IF SalesSetup."Shipment on Invoice" THEN
                    NoSeriesManagement.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Shipment Nos.");


                SalesHeader.VALIDATE("Currency Code", CurrencyCode);
                //SalesHeader.Validate("Salesperson Code", "BDS/BDO");
                SalesHeader.VALIDATE("Sell-to Customer No.", CustNo);
                SalesHeader."Sell-to Customer No." := CustNo;
                SalesHeader."Shipment Date" := Today;
                SalesHeader."Order Date" := Today;
                SalesHeader."Posting Date" := Today;
                SalesHeader."Document Date" := Today;
                SalesHeader."Prices Including VAT" := true;
                SalesHeader."Posting Description" := FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No.";
                SalesHeader."External Document No." := "Reference No.";
                SalesHeader."Guarantee Entry Type" := Feetype;
                // SalesHeader."Guarantee Application No." := Rec."No.";

                ProductCharges.RESET;
                ProductCharges.SETRANGE("Product Code", Product);
                ProductCharges.SetRange("Charge on Guarantee Amt", ChargeOnGuaranteeAmount);
                ProductCharges.SetRange("Charge Type", Feetype);
                ProductCharges.SetRange("Currency Code", CurrencyCode);
                If ProductCharges.FindFirst then begin

                    IF SalesHeader.INSERT THEN
                        MESSAGE('Invoice No.: %1 created', SalesHeader."No.")
                    ELSE
                        MESSAGE('Invoice No.: %1 not created', SalesHeader."No.");
                    repeat
                        ProductCharges.TestField("G/L Account");

                        SalesLine.INIT;
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
                        SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                        SalesLine."Shortcut Dimension 1 Code" := rec."Global Dimension 1 Code";
                        SalesLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        //SalesLine."Guarantee Application No." := Rec."No.";
                        SalesLine."Guarantee Entry Type" := Feetype;
                        SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
                        SalesLine.VALIDATE("No.", ProductCharges."G/L Account");
                        SalesLine.VALIDATE(Quantity, 1);
                        IF ((LoanAmount > ProductCharges."Minimum Amount") AND (LoanAmount <= ProductCharges."Maximum Amount")) THEN BEGIN
                            IF ProductCharges."Use Perc" THEN BEGIN
                                ChargedAmount := (LoanAmount * ProductCharges.Percentage / 100) + ProductCharges.Amount;

                                IF ((ProductCharges."Minimum Charge" <> 0) OR (ProductCharges."Maximum Charge" <> 0)) THEN BEGIN
                                    IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Minimum Charge" <> 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                    IF ((ChargedAmount >= ProductCharges."Minimum Charge") AND (ChargedAmount < ProductCharges."Maximum Charge")) THEN
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                    IF ((ChargedAmount > ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                    IF ((ChargedAmount >= ProductCharges."Maximum Charge") AND (ProductCharges."Maximum Charge" <> 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Maximum Charge");
                                    IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                END ELSE
                                    SalesLine.VALIDATE("Unit Price", ChargedAmount);

                            END ELSE
                                SalesLine.VALIDATE("Unit Price", ProductCharges.Amount);

                        END ELSE
                            IF ((ProductCharges."Minimum Amount" = 0) AND (ProductCharges."Maximum Amount" = 0)) THEN BEGIN
                                IF ProductCharges."Use Perc" THEN BEGIN
                                    ChargedAmount := (LoanAmount * ProductCharges.Percentage / 100) + ProductCharges.Amount;
                                    IF ((ProductCharges."Minimum Charge" <> 0) OR (ProductCharges."Maximum Charge" <> 0)) THEN BEGIN
                                        IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Minimum Charge" <> 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                        IF ((ChargedAmount >= ProductCharges."Minimum Charge") AND (ChargedAmount < ProductCharges."Maximum Charge")) THEN
                                            SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                        IF ((ChargedAmount > ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                        IF ((ChargedAmount >= ProductCharges."Maximum Charge") AND (ProductCharges."Maximum Charge" <> 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Maximum Charge");
                                        IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                    END ELSE
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                END ELSE
                                    SalesLine.VALIDATE("Unit Price", ProductCharges.Amount);
                            END;


                        SalesHeader.Validate("Gen. Bus. Posting Group", Cust."Gen. Bus. Posting Group");
                        SalesHeader.Validate("VAT Bus. Posting Group", Cust."VAT Bus. Posting Group");
                        SalesHeader.Validate("Customer Posting Group", Cust."Customer Posting Group");

                        SalesHeader.Validate("Prices Including VAT");
                        SalesLine.VALIDATE("Currency Code", CurrencyCode);
                        IF SalesLine."Unit Price" > 0 then
                            SalesLine.INSERT
                        ELSE
                            Error('Unit Price cannot be zero');

                        COMMIT;

                    UNTIL ProductCharges.NEXT = 0;

                end;
            end;
        end;
    end;


    procedure RestructuringFee(var Rec: Record "Restructuring Memo Header"; Feetype: option " ",Consultancy,"Risk-Sharing Fee",Other,"Linkage Banking","Lenders Option","Booked Fee","Application Fee","Restructuring Fee"; LoanAmount: Decimal; ChargeOnGuaranteeAmount: Boolean; CustNo: Code[20]; CurrencyCode: Code[20])
    var

        ChargedAmount: Decimal;
        ContractRec: Record "Guarantee Contracts";
    begin


        SalesSetup.GET;
        GuaranteeSetup.Get;
        with Rec do begin


            //Create invoice.

            IF Cust.GET(CustNo) THEN BEGIN
                SalesHeader.INIT;

                SalesSetup.TESTFIELD("Invoice Nos.");
                SalesSetup.TESTFIELD("Posted Invoice Nos.");

                NoSeries.GET(GetNoSeriesCode);
                SalesHeader."No." := NoSeriesManagement.GetNextNo(NoSeries.Code, TODAY, TRUE);
                SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
                IF ((SalesHeader."No. Series" <> '') AND (SalesSetup."Invoice Nos." = SalesSetup."Posted Invoice Nos.")) THEN
                    SalesHeader."Posting No. Series" := SalesHeader."No. Series"
                ELSE
                    NoSeriesManagement.SetDefaultSeries(SalesHeader."Posting No. Series", SalesSetup."Posted Invoice Nos.");
                IF SalesSetup."Shipment on Invoice" THEN
                    NoSeriesManagement.SetDefaultSeries(SalesHeader."Shipping No. Series", SalesSetup."Posted Shipment Nos.");


                SalesHeader.VALIDATE("Currency Code", CurrencyCode);
                //SalesHeader.Validate("Salesperson Code", "BDS/BDO");
                SalesHeader.VALIDATE("Sell-to Customer No.", CustNo);
                SalesHeader."Sell-to Customer No." := CustNo;
                SalesHeader."Shipment Date" := Today;
                SalesHeader."Order Date" := Today;
                SalesHeader."Posting Date" := Today;
                SalesHeader."Document Date" := Today;
                SalesHeader."Prices Including VAT" := true;
                SalesHeader."Posting Description" := FORMAT(SalesHeader."Document Type") + ' ' + SalesHeader."No.";

                SalesHeader."Guarantee Entry Type" := Feetype;
                SalesHeader."Guarantee Application No." := Rec."Contract No.";

                ProductCharges.RESET;
                ProductCharges.SETRANGE("Product Code", Product);
                ProductCharges.SetRange("Charge on Guarantee Amt", ChargeOnGuaranteeAmount);
                ProductCharges.SetRange("Charge Type", Feetype);
                ProductCharges.SetRange("Currency Code", CurrencyCode);
                If ProductCharges.FindFirst then begin

                    IF SalesHeader.INSERT THEN
                        MESSAGE('Invoice No.: %1 created', SalesHeader."No.")
                    ELSE
                        MESSAGE('Invoice No.: %1 not created', SalesHeader."No.");
                    repeat
                        ProductCharges.TestField("G/L Account");

                        SalesLine.INIT;
                        SalesLine."Document No." := SalesHeader."No.";
                        SalesLine."Document Type" := SalesLine."Document Type"::Invoice;
                        SalesLine."Sell-to Customer No." := SalesHeader."Sell-to Customer No.";
                        SalesLine."Shortcut Dimension 1 Code" := rec."Global Dimension 1 Code";
                        SalesLine."Shortcut Dimension 2 Code" := Rec."Global Dimension 2 Code";
                        SalesLine."Guarantee Application No." := Rec."Contract No.";
                        SalesLine."Guarantee Entry Type" := Feetype;
                        SalesLine.VALIDATE(Type, SalesLine.Type::"G/L Account");
                        SalesLine.VALIDATE("No.", ProductCharges."G/L Account");
                        SalesLine.VALIDATE(Quantity, 1);
                        IF ((LoanAmount > ProductCharges."Minimum Amount") AND (LoanAmount <= ProductCharges."Maximum Amount")) THEN BEGIN
                            IF ProductCharges."Use Perc" THEN BEGIN
                                ChargedAmount := (LoanAmount * ProductCharges.Percentage / 100) + ProductCharges.Amount;

                                IF ((ProductCharges."Minimum Charge" <> 0) OR (ProductCharges."Maximum Charge" <> 0)) THEN BEGIN
                                    IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Minimum Charge" <> 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                    IF ((ChargedAmount >= ProductCharges."Minimum Charge") AND (ChargedAmount < ProductCharges."Maximum Charge")) THEN
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                    IF ((ChargedAmount > ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                    IF ((ChargedAmount >= ProductCharges."Maximum Charge") AND (ProductCharges."Maximum Charge" <> 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Maximum Charge");
                                    IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                        SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                END ELSE
                                    SalesLine.VALIDATE("Unit Price", ChargedAmount);

                            END ELSE
                                SalesLine.VALIDATE("Unit Price", ProductCharges.Amount);

                        END ELSE
                            IF ((ProductCharges."Minimum Amount" = 0) AND (ProductCharges."Maximum Amount" = 0)) THEN BEGIN
                                IF ProductCharges."Use Perc" THEN BEGIN
                                    ChargedAmount := (LoanAmount * ProductCharges.Percentage / 100) + ProductCharges.Amount;
                                    IF ((ProductCharges."Minimum Charge" <> 0) OR (ProductCharges."Maximum Charge" <> 0)) THEN BEGIN
                                        IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Minimum Charge" <> 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                        IF ((ChargedAmount >= ProductCharges."Minimum Charge") AND (ChargedAmount < ProductCharges."Maximum Charge")) THEN
                                            SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                        IF ((ChargedAmount > ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                        IF ((ChargedAmount >= ProductCharges."Maximum Charge") AND (ProductCharges."Maximum Charge" <> 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Maximum Charge");
                                        IF ((ChargedAmount <= ProductCharges."Minimum Charge") AND (ProductCharges."Maximum Charge" = 0)) THEN
                                            SalesLine.VALIDATE("Unit Price", ProductCharges."Minimum Charge");
                                    END ELSE
                                        SalesLine.VALIDATE("Unit Price", ChargedAmount);
                                END ELSE
                                    SalesLine.VALIDATE("Unit Price", ProductCharges.Amount);
                            END;


                        SalesHeader.Validate("Gen. Bus. Posting Group", Cust."Gen. Bus. Posting Group");
                        SalesHeader.Validate("VAT Bus. Posting Group", Cust."VAT Bus. Posting Group");
                        SalesHeader.Validate("Customer Posting Group", Cust."Customer Posting Group");

                        SalesHeader.Validate("Prices Including VAT");
                        SalesLine.VALIDATE("Currency Code", CurrencyCode);
                        IF SalesLine."Unit Price" > 0 then
                            SalesLine.INSERT
                        ELSE
                            Error('Unit Price cannot be zero');

                        COMMIT;

                    UNTIL ProductCharges.NEXT = 0;
                    if ContractRec.Get(Rec."Contract No.") then begin
                        ContractRec.Restructured := true;
                        ContractRec.Modify();
                    end;

                end;
            end;
        end;
    end;

    procedure GetLOClientNo(LoanNo: Code[20]) ClientNo: Code[20]
    var

        LOContract: Record "Guarantee Contracts";
        "PASS Setup": Record "Guarantee Management Setup";

    begin
        IF LoanNo = '' THEN
            EXIT('');
        //GET Existing Client No
        WITH LOContract DO BEGIN
            SETRANGE("Loan No.", LoanNo);
            IF FINDFIRST THEN
                EXIT(LOContract."Customer No.");
        END;
    end;

    procedure ValidateImportedApplications(LOJournalLine: Record "Lenders Option Journal Line")
    var
        LOHeader: Code[20];
        COUNT1: Integer;
    begin
        LOHeader := LOJournalLine.Code;

        LOJournalLine.Reset();
        LOJournalLine.SetRange(Code, LOHeader);
        IF NOT LOJournalLine.FIND('-') THEN BEGIN
            ERROR(ERR_NO_IMP_APPL);
        END ELSE BEGIN

            Window.OPEN(
              TEXT_VAL_PROGRESS);
            Window.UPDATE(1, Counter);
            REPEAT
                TotalRec := COUNT1 + 1;
                if LOJournalLine.Code <> LOHeader then
                    exit;

                LOJournalLine.TESTFIELD(Name);
                LOJournalLine.TESTFIELD(Address);
                //TESTFIELD("Global Dimension 1 Code");
                LOJournalLine.TESTFIELD("Global Dimension 2 Code");
                if LOJournalLine.Ownership = LOJournalLine.Ownership::Individual then
                    LOJournalLine.TESTFIELD(Gender);
                //TestField("Date of Birth");
                //TestField("Global Dimension 3 Code");
                //TestField("Global Dimension 4 Code");
                LOJournalLine.TESTFIELD(Ownership);
                LOJournalLine.TESTFIELD("Loan Amount");
                //TESTFIELD("Consultancy Fee %");
                //TESTFIELD("Receivables Acc. No.");
                // TESTFIELD("Bank Contact Person");
                //TESTFIELD("Bank Branch Name");
                LOJournalLine.TESTFIELD("Pct. Guarantee Approved");
                // TESTFIELD("Guarantee Source");
                LOJournalLine.TESTFIELD("Loan Issued Date");
                LOJournalLine.TESTFIELD("Loan No.");
                LOJournalLine.TESTFIELD("Loan Amount");
                LOJournalLine.TESTFIELD("Business Type");
                // TESTFIELD("CGC Start Date");
                //TESTFIELD("Signatory 1 (CGC)");
                //TESTFIELD("Signatory 2 (CGC)");
                LOJournalLine.TESTFIELD(City);
                LOJournalLine.TESTFIELD("Loan Amount");
                //TESTFIELD("CGF %");
                //TESTFIELD("Risk Sharing Fee %");
                LOJournalLine.Validate("Business Type");
                LOJournalLine.Validate(Product);
                LOJournalLine.VALIDATE(Name);
                // VALIDATE("Global Dimension 1 Code");
                LOJournalLine.VALIDATE("Global Dimension 2 Code");
                LOJournalLine.VALIDATE("Receivables Acc. No.");

                IF (LOJournalLine."Loan Amount" <= 0) THEN
                    ERROR(ERR_FIELD_LOANAMOUNT, LOJournalLine."No.", LOJournalLine.Name);

                IF LOJournalLine."Customer No." <> '' THEN BEGIN
                    IF Cust.GET(LOJournalLine."Customer No.") THEN BEGIN
                        //IF UPPERCASE(LoCust.Name)<>UPPERCASE(Name) THEN
                        //ERROR(ERR_VAL_NAME,"LO Client No.",Serial);
                    END;
                END;
                //Check if file already imported before
                //Applns
                WITH GuaranteeApp DO BEGIN
                    SETRANGE("Loan No.", LOJournalLine."Loan No.");
                    SETRANGE("Application Date", LOJournalLine."Loan Issued Date");
                    IF FIND('-') THEN
                        ERROR(Text001, LOJournalLine."Loan No.", LOJournalLine."Loan Issued Date");
                END;

                //Contracts
                WITH GuaranteeContract DO BEGIN
                    SETRANGE("Loan No.", LOJournalLine."Loan No.");
                    SETRANGE("Application Date", LOJournalLine."Loan Issued Date");
                    IF FIND('-') THEN
                        ERROR(Text001, LOJournalLine."Loan No.", LOJournalLine."Loan Issued Date");
                END;

                Counter += 1;
            //Window.UPDATE(1, ROUND(Counter / TotalRec * 10000, 1));
            UNTIL LOJournalLine.NEXT = 0;
            Window.CLOSE;
        END;
    END;
    //end;

    procedure CreateImportedContracts(LOJournalline: Record "Lenders Option Journal Line"; SingleCGC: Boolean; VAR LendersOptionSingleCGC: Record "Lenders Option Single CGC"; var "Ref No.": text[200];
    var GuaranteeSource: code[20]; var BankBrach: text; var BatchBankCode: code[20]; var Signatory1: Code[20]; var Signatory2: code[20]; Var BranchCode: code[20]; var ProductCode: code[20]; var ProductTypes: Option Traditional,"Lenders Option")
    var

        ERR_INSERT_PASS_APPL: TextConst ENU = 'Cannot create application %1 (%2).';
        ModifyRecord: Boolean;
        GuaranteeApp2: Record "Guarantee Application";
        ERR_INSERT_CUSTOMER: TextConst ENU = 'Cannot create client record for application %1 (%2)';
        ERR_CUST_POSTING_GROUP: TextConst ENU = 'Please define Gen. Bus. Posting Group, VAT Bus. Posting Group and Customer Posting Group in PASS Setup.';

        TEXT_COMPLETED: TextConst ENU = 'Process completed successfully';
        ERR_INSERT_PASS_CLIENT: TextConst ENU = 'Cannot create record for application %1 (%2).';
        cust: Record Customer;
        BusinessTypes: Record "Subsector & Line of Business";
        BatchNo: Code[20];
        COUNT1: Integer;
    begin
        GuaranteeSetup.Get;
        SalesSetup.Get;
        BatchNo := LOJournalline.Code;

        IF (GuaranteeSetup."Gen. Bus. Posting Group" = '')
           OR (GuaranteeSetup."VAT Bus. Posting Group" = '')
           OR (GuaranteeSetup."Customer Posting Group" = '') THEN
            ERROR(ERR_CUST_POSTING_GROUP);

        SalesSetup.TestField("Customer Nos.");

        LOJournalline.Reset();
        LOJournalline.SetRange(Code, BatchNo);
        IF LOJournalline.FIND('-') THEN BEGIN

            Counter := 0;
            Window.OPEN(TEXT_CREATE_PROGRESS);
            Window.UPDATE(1, Counter);
            LOJournalline."Global Dimension 1 Code" := BranchCode;
            REPEAT
                TotalRec := COUNT1 + 1;
                if LOJournalline.Code <> BatchNo then
                    exit;
                //Create lo client account
                IF (LOJournalline."Customer No." <> '') THEN BEGIN
                    IF NOT Cust.GET(LOJournalline."Customer No.") THEN
                        ERROR(ERR_CUSTOMER_NOT_EXIST, LOJournalline."Customer No.");

                    //Update missing data
                    IF Cust.GET(LOJournalline."Customer No.") THEN BEGIN
                        ModifyRecord := FALSE;
                        IF Cust.City = '' THEN BEGIN
                            Cust.City := LOJournalline.City;
                            ModifyRecord := TRUE;
                        END;
                        IF Cust.Address = '' THEN BEGIN
                            Cust.Address := LOJournalline.Address;
                            ModifyRecord := TRUE;
                        END;
                        IF ModifyRecord THEN
                            Cust.MODIFY;
                    END;
                    //End update missing cust data
                END ELSE
                    WITH Cust DO BEGIN
                        INIT;
                        "No." := NoSeriesManagement.GetNextNo(SalesSetup."Customer Nos.", TODAY, TRUE);
                        "Gen. Bus. Posting Group" := GuaranteeSetup."Gen. Bus. Posting Group";
                        "VAT Bus. Posting Group" := GuaranteeSetup."VAT Bus. Posting Group";
                        "Customer Posting Group" := GuaranteeSetup."Customer Posting Group";
                        Name := LOJournalline.Name;
                        VALIDATE(Name);
                        Address := LOJournalline.Address;
                        City := LOJournalline.City;
                        "Post Code" := LOJournalline."Post Code";
                        VALIDATE("Post Code");
                        "Phone No." := LOJournalline."Phone No.";
                        "Fax No." := LOJournalline."Fax No.";
                        "E-Mail" := LOJournalline."E-Mail";
                        "Global Dimension 1 Code" := LOJournalline."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := LOJournalline."Global Dimension 2 Code";
                        //"Created From Import" := TRUE;
                        //"Date Created" := TODAY;
                        //"Created By" := USERID;

                        IF NOT INSERT THEN
                            ERROR(ERR_INSERT_CUSTOMER, "No.", Name);
                    END;

                //Create PASS Application

                GuaranteeApp.INIT;
                GuaranteeApp.TRANSFERFIELDS(LOJournalline);
                /*IF ("Customer No." <> '') THEN BEGIN
                    //GET Existing Appln No
                    WITH GuaranteeApp2 DO BEGIN
                        RESET;
                        SETCURRENTKEY("No.");
                        SETRANGE("Customer No.", LOJournalline."Customer No.");
                        IF FINDLAST THEN BEGIN
                            IF (STRPOS("No.", '/') = 0) THEN
                                GuaranteeApp."No." := "No." + '/01'
                            ELSE
                                GuaranteeApp."No." := INCSTR("No.");
                        END;
                    END;
                END ELSE*/


                GuaranteeApp."No." := NoSeriesMgt.GetNextNo(GuaranteeSetup."Guarantee Application Nos.", TODAY, TRUE);
                GuaranteeApp.VALIDATE("Post Code");
                //PassApplication."Group Count" := "PASS Setup"."Commitment Fee";
                //PassApplication."Status Date" := TODAY;
                GuaranteeApp.Status := GuaranteeApp.Status::Released;
                GuaranteeApp."Last Date Modified" := TODAY;
                GuaranteeApp."Application Status" := LOJournalline."Application Status"::"Contract Signed";
                GuaranteeApp."Customer No." := Cust."No.";
                GuaranteeApp."Receivables Acc. No." := BatchBankCode;
                GuaranteeApp.VALIDATE("Receivables Acc. No.");
                GuaranteeApp."Loan Amount" := LOJournalline."Requested Amount";
                GuaranteeApp.Validate("Requested Amount");
                GuaranteeApp."Approved Loan Amount" := LOJournalline."Loan Amount";
                GuaranteeApp.Validate("Approved Loan Amount");
                GuaranteeApp.Validate("Business Ownership Type");
                GuaranteeApp."Guarantee Source" := GuaranteeSource;
                GuaranteeApp.Validate("Guarantee Source");
                //PassApplication.VALIDATE("Line of Business");
                GuaranteeApp.Validate("Date of Birth");
                GuaranteeApp.City := LOJournalline.City;
                IF LOJournalline."Receivables Address" <> '' THEN
                    GuaranteeApp."Receivables Address" := LOJournalline."Receivables Address";
                IF GuaranteeApp."Receivables Address 2" <> '' THEN
                    GuaranteeApp."Receivables Address 2" := LOJournalline."Receivables Address 2";
                IF LOJournalline."Receivables Contact No." <> '' THEN
                    GuaranteeApp."Receivables Contact No." := LOJournalline."Receivables Contact No.";
                IF LOJournalline."Receivables Email Address" <> '' THEN
                    GuaranteeApp."Application Date" := LOJournalline."Application Date";
                IF LOJournalline."Bank Contact Person" <> '' THEN
                    GuaranteeApp."Bank Contact Person" := LOJournalline."Bank Contact Person";

                GuaranteeApp."Bank Branch Name" := BankBrach;
                GuaranteeApp.Validate("Bank Branch Name");

                GuaranteeApp."Created From Import" := TRUE;
                GuaranteeApp."Date Created" := TODAY;
                GuaranteeApp."Created By" := USERID;
                GuaranteeApp."No of Employments Created" := LOJournalline."No of Employments Created";
                GuaranteeApp."Signatory 1 (CGC)" := Signatory1;
                GuaranteeApp.Validate("Signatory 1 (CGC)");
                GuaranteeApp."Signatory 2 (CGC)" := Signatory2;
                GuaranteeApp.Validate("Signatory 2 (CGC)");
                GuaranteeApp.Validate("Risk Sharing Fee %");
                // PassApplication.Status := Status::"CGC Prepared";
                //PassApplication."Status Date" := TODAY;
                GuaranteeApp.Product := ProductCode;
                GuaranteeApp."Product Type" := ProductTypes;
                GuaranteeApp.Validate(Product);

                IF GuaranteeApp."Currency Code" <> '' THEN
                    GuaranteeApp.VALIDATE("Currency Code");

                GuaranteeApp."Reference No." := "Ref No.";

                //guaranteeApp."Risk Sharing Fee %" := GuaranteeSetup."Risk Sharing Fee %";
                IF NOT GuaranteeApp.INSERT THEN
                    ERROR(ERR_INSERT_PASS_APPL, LOJournalline."No.", LOJournalline.Name);

                GenderCount(GuaranteeApp);
                //Inset Subsector and business Type
                BusinessTypes.Init();
                BusinessTypes."Client No." := GuaranteeApp."No.";
                BusinessTypes.Subsector := LOJournalline.Subsector;
                BusinessTypes."Line of Business" := LOJournalline."Business Type";
                BusinessTypes.Validate("Line of Business");
                BusinessTypes."No. of Animals" := LOJournalline."No. of Animals";
                BusinessTypes."Type of Breed" := LOJournalline."Type of Breed";
                BusinessTypes."Farming Method" := LOJournalline."Farming Method";
                BusinessTypes."Farm Size" := LOJournalline."Farm Size";
                BusinessTypes.Technology := LOJournalline.Technology;
                BusinessTypes."Technology Type" := LOJournalline."Technology Type";
                BusinessTypes.Type := LOJournalline.Type;
                if not BusinessTypes.Insert() then
                    Error('Subsector and Business type not inserted');


                //Create LO PASS Contract
                GuaranteeContract.INIT;
                GuaranteeContract.TRANSFERFIELDS(LOJournalline);
                GuaranteeContract."No." := GuaranteeApp."No.";
                GuaranteeContract."Customer No." := Cust."No.";
                GuaranteeContract."Contract Status" := GuaranteeContract."Contract Status"::"Loan Granted";
                GuaranteeContract."Loan Amount" := LOJournalline."Requested Amount";
                GuaranteeContract.VALIDATE("Loan Amount");
                GuaranteeContract."Approved Loan Amount" := LOJournalline."Loan Amount";
                GuaranteeContract.Validate("Approved Loan Amount");
                //"PASS Contract"."Consultancy Fee" := ROUND("Consultancy Fee %" * "BP Amount" / 100, 0.01);
                //"PASS Contract"."Booked Fee %" := "Booked Fee %";
                //"PASS Contract".District := District;
                GuaranteeContract."No of Employments Created" := LOJournalline."No of Employments Created";
                // "PASS Contract".Select := TRUE;
                //"PASS Contract"."Select User ID" := USERID;
                //GuaranteeContract.CALCFIELDS(Name);
                //GuaranteeContract."Name (at Bank)" := UPPERCASE(Name);
                GuaranteeContract."Loan Maturity Date" := LOJournalline."Contract Signed Date";
                GuaranteeContract."Application Date" := LOJournalline."Application Date";
                //"PASS Contract".VALIDATE("Line of Business");
                GuaranteeContract."Created From Import" := TRUE;
                GuaranteeContract."Date Created" := TODAY;
                GuaranteeContract."Created By" := USERID;
                GuaranteeContract."Loan Amount" := LOJournalline."Requested Amount";
                GuaranteeContract."Approved Loan Amount" := LOJournalline."Loan Amount";
                GuaranteeContract.Validate("Approved Loan Amount");
                GuaranteeContract."Guarantee Source" := GuaranteeSource;
                GuaranteeContract.Validate("Guarantee Source");
                GuaranteeContract."CGC Date" := Today;
                GuaranteeContract.Validate("CGC Date");
                GuaranteeContract."CGC Start Date" := Today;
                GuaranteeContract.Validate("CGC Start Date");
                GuaranteeContract."Receivables Acc. No." := BatchBankCode;
                GuaranteeContract.Product := ProductCode;
                GuaranteeContract."Product Type" := ProductTypes;
                GuaranteeApp.Validate(Product);
                GuaranteeContract.VALIDATE("Receivables Acc. No.");
                GuaranteeContract."Bank Branch Name" := BankBrach;
                GuaranteeContract.Validate("Bank Branch Name");
                GuaranteeContract.Validate("Date of Birth");
                //"PASS Contract"."Status Date" := TODAY;
                GuaranteeContract."Risk Sharing Fee %" := GuaranteeApp."Risk Sharing Fee %";
                GuaranteeContract.Validate("Risk Sharing Fee %");

                GuaranteeContract."Signatory 1 (CGC)" := Signatory1;
                GuaranteeContract.Validate("Signatory 1 (CGC)");
                GuaranteeContract."Signatory 2 (CGC)" := Signatory2;
                GuaranteeContract.Validate("Signatory 2 (CGC)");
                if ProductType.Get(ProductCode) then
                    GuaranteeContract."Pct. Guarantee Approved" := ProductType."Portfolio Guarantee %";
                GuaranteeContract.VALIDATE("CGC Date");
                GuaranteeContract.VALIDATE("Loan Amount");
                GuaranteeContract.VALIDATE("Approved Loan Amount");
                GuaranteeContract.Validate("Pct. Guarantee Approved");
                GuaranteeContract.VALIDATE("CGF %");
                IF GuaranteeContract."Currency Code" <> '' THEN
                    GuaranteeContract.VALIDATE("Currency Code");


                IF SingleCGC THEN BEGIN

                    LendersOptionSingleCGC."Credit Guarantee %" := GuaranteeContract."CGF %";
                    LendersOptionSingleCGC."Global Dimension 1 Code" := GuaranteeContract."Global Dimension 1 Code";
                    LendersOptionSingleCGC."Global Dimension 2 Code" := GuaranteeContract."Global Dimension 2 Code";


                END;

                GuaranteeContract."Reference No." := "Ref No.";

                IF NOT GuaranteeContract.INSERT THEN
                    ERROR(ERR_INSERT_PASS_CLIENT, LOJournalline."No.", LOJournalline.Name);

                GuaranteeContract.COPYLINKS(LOJournalline);

                COMMIT;

                Counter += 1;
                Window.UPDATE(1, ROUND(Counter / TotalRec * 10000, 1));
            UNTIL LOJournalline.NEXT = 0;
            Window.CLOSE;
        END;

        IF SingleCGC THEN
            LendersOptionSingleCGC."No. of Loans" := Counter;

        //Change CGC Status to Issued
        //GuaranteeContract.PrepareImportedCGCSilent;

        //MESSAGE(TEXT_COMPLETED);
        // LOJournalline.SetRange(Code;);
        //LOJournalline.DELETEALL;
    END;
    //end;


    Procedure PrintCGC(Contract: Record "Guarantee Contracts"; CheckFields: Boolean)
    var
        "CGC Report": Report "CGC Default";
        Bank: Record Customer;
    begin
        IF CheckFields THEN
            WITH Contract DO BEGIN
                TestField("Contract Status", "Contract Status"::"CGC Issued");
                TestField("Loan No.");
                TestField("Loan Issued Date");
                TestField("Approved Loan Amount");
                TestField("Pct. Guarantee Approved");
                TestField("CGC No.");
                TestField("CGC Amount");
                TestField("CGC Date");
                TestField("CGC Start Date");
                TestField("Loan Maturity Date");
                TestField(Bank);
                TestField("Signatory 1 (CGC)");
                TestField("Signatory 2 (CGC)");
            END;

        //Bank."CGC Format" := Bank."CGC Format"::Default;
        IF (Contract.Bank <> '') THEN
            IF Bank.GET(Contract.Bank) THEN;
        Contract.SETRANGE("No.", Contract."No.");
        REPORT.RUN(REPORT::"CGC Default", TRUE, FALSE, Contract);
        /*CASE Bank."CGC Format" OF

          Bank."CGC Format"::Default:
            

          Bank."CGC Format"::EXIM:
            ERROR ('CGC %1 is being developed for %2.', Bank."CGC Format", Bank.Name);*/

        //END;
    end;

    procedure PostCGCAging(var CGCAging: Record "Loan Account Journal Line")
    var
        CGCEntries: Record "Loan Account Entries";
        CGCContract: Record "Guarantee Contracts";
    begin
        with CGCAging do begin
            SetRange(Validated, true);
            if FindSet() then
                repeat
                    CGCAging.Reset;
                    CGCContract.SetRange("No.", "Contract No.");
                    CGCContract.SetRange("Loan No.", "Account No.");
                    if CGCContract.FindFirst then begin
                        repeat
                            CGCEntries.TransferFields(CGCAging);
                            CGCEntries.Insert(true);
                        until CGCAging.Next = 0;

                    end;
                until Next() = 0;




        end; //ELSE
             //Error('Contract No. %1 and or Loan No. %2 does not exist', "Contract No.", "Loan No");
    end;


    procedure ValidateCGCAging(var CGCAging: Record "Loan Account Journal Line")
    var
        CGCEntries: Record "Loan Account Entries";
        CGCContract: Record "Guarantee Contracts";
    begin
        with CGCAging do begin
            if CGCAging.FindSet() then
                repeat
                    Message(Format(CGCAging."Customer Name"));
                    CGCContract.Reset;
                    CGCContract.SetRange("Loan No.", "Account No.");
                    // CGCContract.SetRange("Contract Status", CGCContract."Contract Status"::"CGC Issued");
                    if CGCContract.Find('-') then begin
                        Validated := true;
                        "Contract No." := CGCContract."No.";
                        Message(Format(CGCContract.Name));
                        Modify(true);
                        CGCContract."Contract Status" := CGCContract."Contract Status"::"CGC Issued";
                        CGCContract.Modify(true);
                    end;
                until CGCAging.Next = 0;

        end;


    end;

    procedure PostCGCAgingNew(var CGCAging: Record "Validation Lines")
    var
        CGCEntries: Record "Loan Account Entries";
        CGCContract: Record "Guarantee Contracts";
    begin
        with CGCAging do begin
            SetRange(Validated, true);
            if FindSet() then
                repeat
                    CGCAging.Reset;
                    CGCContract.SetRange("No.", "Contract No.");
                    CGCContract.SetRange("Loan No.", "Account No.");
                    if CGCContract.FindFirst then begin
                        repeat
                            CGCEntries.TransferFields(CGCAging);
                            CGCEntries.Insert(true);
                        until CGCAging.Next = 0;

                    end;
                until Next() = 0;




        end; //ELSE
             //Error('Contract No. %1 and or Loan No. %2 does not exist', "Contract No.", "Loan No");
    end;


    procedure ValidateCGCAgingNew(var CGCAging: Record "Validation Lines")
    var
        CGCEntries: Record "Loan Account Entries";
        CGCContract: Record "Guarantee Contracts";
    begin
        with CGCAging do begin
            if CGCAging.FindSet() then
                repeat
                    CGCContract.Reset;
                    CGCContract.SetRange("Loan No.", "Account No.");
                    // CGCContract.SetRange("Contract Status", CGCContract."Contract Status"::"CGC Issued");
                    if CGCContract.Find('-') then begin
                        Validated := true;
                        "Contract No." := CGCContract."No.";
                        Modify(true);
                        CGCContract."Contract Status" := CGCContract."Contract Status"::"CGC Issued";
                        CGCContract.Modify(true);
                    end;
                until CGCAging.Next = 0;

        end;


    end;

    procedure FnGetDateFilters(var DateParsed: Date) DateFilter: Text[50];
    var
        RunDate: Date;
        Month: Integer;
        StartDate: Date;
        EndDate: Date;
        Quarter: Text;
        PrevPeriod: Date;
    begin
        Month := Date2DMY(DateParsed, 2);

        if Month <= 3 then begin
            StartDate := CalcDate('-CY', DateParsed);
            EndDate := CalcDate('3M-1D', StartDate);
            DateFilter := Format(StartDate) + '..' + Format(EndDate);
        end else
            if (Month > 3) and (Month <= 6) then begin
                StartDate := CalcDate('-CY+3M', DateParsed);
                EndDate := CalcDate('3M-1D', StartDate);
                DateFilter := Format(StartDate) + '..' + Format(EndDate);
            end else
                if (Month > 6) and (Month <= 9) then begin
                    StartDate := CalcDate('-CY+6M', DateParsed);
                    EndDate := CalcDate('3M-1D', StartDate);
                    DateFilter := Format(StartDate) + '..' + Format(EndDate);
                end else
                    if (Month > 9) and (Month <= 12) then begin
                        StartDate := CalcDate('-CY+9M', DateParsed);
                        EndDate := CalcDate('CY', StartDate);
                        DateFilter := Format(StartDate) + '..' + Format(EndDate);
                    end;

        exit(DateFilter);
    end;

    procedure FnGetPeriodQuarter(var DateParsed: Date) Quarter: Text[20];
    var

        Month: Integer;

    begin
        Month := Date2DMY(DateParsed, 2);
        Quarter := '';

        if Month <= 3 then begin
            Quarter := 'Q1';
        end else
            if (Month > 3) and (Month <= 6) then begin
                Quarter := 'Q2';
            end else
                if (Month > 6) and (Month <= 9) then begin
                    Quarter := 'Q3';
                end else
                    if (Month > 9) and (Month <= 12) then begin
                        Quarter := 'Q4';
                    end;

        exit(Quarter);
    end;

    procedure ConvertBase64toBlob()
    var
        Base64CU: Codeunit "DotNet_Convert";
        DataBASE64: Text;
        VarOutStream: OutStream;
        GuaranteeApp: Record "Guarantee Application";
        DotNetArray: Codeunit "DotNet_Array";
    begin
        GuaranteeApp.CalcFields("Client Signature");
        GuaranteeApp."Client Signature".CreateOutStream(VarOutStream);
        Base64CU.FromBase64String(DataBASE64, DotNetArray);
    end;




}