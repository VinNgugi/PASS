page 51513600 "LO General Journal"
{
    PageType = ListPart;
    Caption = 'LO General Journal';
    //UsageCategory = Tasks;
    SourceTable = "Lenders Option Journal Line";
    RefreshOnActivate = true;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            grid("Batch Details")
            {
                field(BatchBankCode; BatchBankCode)
                {
                    Caption = 'Financial Institution Code';
                    LookupPageId = "Customer Lookup";
                    Lookup = true;


                    trigger OnLookup(var Text: Text): Boolean
                    var
                        CustomerLookup: Page "Customer Lookup";
                        Bank: Record Customer;
                    begin
                        CustomerLookup.LOOKUPMODE(TRUE);
                        IF CustomerLookup.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            Bank.SetRange("Customer Posting Group", '%1', 'BANK');
                            CustomerLookup.GETRECORD(Bank);
                            BatchBankCode := Bank."No.";
                        END;
                    end;
                }
                field(BankBrach; BankBrach)
                {
                    Caption = 'Bank Branch Name';
                }
                field(Description; BatchDescription)
                {
                    Caption = 'Description';
                }
                field(ReferenceNo; BatchRefNo)
                {
                    Caption = 'Reference No.';
                }
                field(ReferenceDate; BatchRefDate)
                {
                    Caption = 'Reference Date';
                }
                field(Signatory1; Signatory1)
                {
                    Caption = 'Signatory 1 (CGC)';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Signatory: Page "Salespersons/Purchasers";
                        Sig: Record "Salesperson/Purchaser";
                    begin
                        Signatory.LOOKUPMODE(TRUE);
                        IF Signatory.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            Signatory.GETRECORD(Sig);
                            Signatory1 := Sig.Code;
                        END;
                    end;
                }
                field(Signatory2; Signatory2)
                {
                    Caption = 'Signatory 2 CGC';
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Signatory2_: Page "Salespersons/Purchasers";
                        Sig2: Record "Salesperson/Purchaser";
                    begin
                        Signatory2_.LOOKUPMODE(TRUE);
                        IF Signatory2_.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            Signatory2_.GETRECORD(Sig2);
                            Signatory2 := Sig2.Code;
                        END;
                    end;
                }

                field(GuaranteeSource; GuaranteeSource)
                {
                    Caption = 'Guarantee Source';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        SourceLookup: Page "Credit Guarantee Partner List";
                        Source: Record "Credit Guarantee Partner";
                    begin
                        SourceLookup.LOOKUPMODE(TRUE);
                        IF SourceLookup.RUNMODAL = ACTION::LookupOK THEN BEGIN
                            SourceLookup.GETRECORD(Source);
                            GuaranteeSource := Source.Code;
                        END;
                    end;
                }
            }
            repeater(GroupName)
            {
                field("Line No."; "Line No.")
                {
                    Editable = false;
                }
                field("Reference No."; "Reference No.")
                {

                }
                field("Customer No."; "Customer No.")
                {
                    Caption = 'Client No';
                }
                field(Name; Name)
                {

                }
                field("Date of Birth"; "Date of Birth")
                {

                }
                field(Gender; Gender)
                {

                }
                field(Address; Address)
                {

                }
                field("Post Code"; "Post Code")
                {

                }
                field("Global Dimension 1 Code"; "Global Dimension 1 Code")
                {

                }
                field("Phone No."; "Phone No.")
                {

                }
                field("Fax No."; "Fax No.")
                {

                }
                field("E-Mail"; "E-Mail")
                {

                }
                field("Project Description"; "Project Description")
                {

                }
                field("No of Employments Created"; "No of Employments Created")
                {

                }
                field(Ownership; Ownership)
                {

                }
                field("Application Date"; "Application Date")
                {

                }
                field("Contract Signed Date"; "Contract Signed Date")
                {
                    Caption = 'Maturity Date';
                }
                field(Term; "Type of Facility")
                {

                }
                field(Comment; Comment)
                {

                }
                field("Global Dimension 2 Code"; "Global Dimension 2 Code")
                {

                }
                field("Business Type"; "Business Type")
                {

                }
                field(Subsector; Subsector)
                {

                }
                field("Loan No."; "Loan No.")
                {

                }
                field("Requested Amount"; "Requested Amount")
                {

                }
                field("Loan Amount"; "Loan Amount")
                {

                }
                field("Receivables Acc. No."; "Receivables Acc. No.")
                {
                    Caption = 'Bank Acc. No.';
                }
                field("Bank Branch Name"; "Bank Branch Name")
                {

                }
                field("Receivables Acc. Name"; "Receivables Acc. Name")
                {
                    Caption = 'Bank Acc. Name';
                }
                field("Receivables Address"; "Receivables Address")
                {
                    Caption = 'Bank Address';
                }
                field("Receivables Address 2"; "Receivables Address 2")
                {
                    Caption = 'Bank Address 2';
                }
                field("Receivables Contact No."; "Receivables Contact No.")
                {
                    Caption = 'Bank Contact No.';
                }
                field("Receivables Email Address"; "Receivables Email Address")
                {
                    Caption = 'Email Address';
                }
                field("Bank Contact Person"; "Bank Contact Person")
                {
                    Caption = 'Contact Person';
                }
                field("Bank Account No"; "Bank Account No")
                {

                }
                field("BDS/BDO"; "BDS/BDO")
                {

                }
                field("Pct. Guarantee Approved"; "Pct. Guarantee Approved")
                {

                }
                field("Guarantee Source"; "Guarantee Source")
                {

                }
                field("Loan Issued Date"; "Loan Issued Date")
                {

                }
                field("CGC Date"; "CGC Date")
                {

                }
                field("CGC Start Date"; "CGC Start Date")
                {

                }
                field("Signatory 1 (CGC)"; "Signatory 1 (CGC)")
                {

                }
                field("Signatory 2 (CGC)"; "Signatory 2 (CGC)")
                {

                }
                field("Farm Size"; "Farm Size")
                {

                }
                field(Technology; Technology)
                {

                }
                field("Technology Type"; "Technology Type")
                {

                }
                field(Type; Type)
                {

                }
                field("No. of Animals"; "No. of Animals")
                {

                }
                field("Type of Breed"; "Type of Breed")
                {

                }
                field("Farming Method"; "Farming Method")
                {

                }

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Import From Excel")
            {
                Visible = false;
                Image = Excel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction();
                var
                    JournalImport: Report "LO Journal Import";
                begin
                    JournalImport.RUN;
                    CurrPage.UPDATE(TRUE);

                end;
            }
            action("Prepare Individual CGCs")
            {
                Visible = false;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = process;
                PromotedIsBig = true;

                trigger OnAction();

                begin
                    if LOHeader.get("Reference No.") then begin
                        BatchBankCode := LOHeader."Financial Institution Code";
                        BatchDescription := LOHeader.Description;
                        BankBrach := LOHeader."Bank Branch Name";
                        BatchRefNo := LOHeader."Reference No.";
                        Signatory1 := LOHeader."Signatory 1 (CGC)";
                        Signatory2 := LOHeader."Signatory 2 (CGC)";
                        GuaranteeSource := LOHeader."Guarantee Source";

                    END;

                    IF BatchBankCode = '' THEN
                        ERROR(ERR_BatchIssuedBy);
                    IF NOT FinancialInstitution.GET(BatchBankCode) THEN
                        ERROR(ERR_BatchIssuedBy);
                    IF BatchDescription = '' THEN
                        ERROR(ERR_BatchDescription);
                    IF BatchRefNo = '' THEN
                        ERROR(ERR_BatchRefDate);
                    IF BatchRefDate = 0D THEN
                        ERROR(ERR_BatchRefNo);
                    if BankBrach = '' then
                        Error('Bank branch must have a value');
                    if GuaranteeSource = '' then
                        Error('Guarantee source must have a value');

                    PrepareCGCs(TRUE);

                end;
            }
        }
    }
    var
        PassApplications: Codeunit "Guarantee Management";
        LOHeader: Record "Lenders Option Journal Header";
        BatchBankCode: Code[10];
        BatchDescription: Text[200];
        BatchRefNo: Text;
        BatchRefDate: Date;
        FinancialInstitution: Record Customer;
        BankBrach: Text;
        Signatory1: Code[20];
        Signatory2: Code[20];
        GuaranteeSource: Code[20];
        ERR_BatchIssuedBy: TextConst ENU = '<Financial Institution code must be selected for single credit guarantee certificate>';
        ERR_BatchDescription: TextConst ENU = '<Description must be filled in for single credit guarantee certificate>';
        ERR_BatchRefNo: TextConst ENU = '<Reference No. must be filled in for single credit guarantee certificate>';
        ERR_BatchRefDate: TextConst ENU = '<Reference Date must be filled in for single credit guarantee certificate>';


    trigger OnNewRecord(BelowxRec: Boolean)

    begin
        //"Reference No." := BatchRefNo;
    end;

    trigger OnModifyRecord(): Boolean
    var
        LOHeader: Record "Lenders Option Journal Header";
    begin
        if LOHeader.Get(Code) then
            LOHeader.TestField(Status, Status::Open);
    end;

    procedure PrepareCGCs(SingleCertificate: Boolean)
    var
        LendersOptionSingleCGC: Record "Lenders Option Single CGC";
        ProductCodes: Record Products;
        ProductRec: Code[20];
    begin
        IF CONFIRM('Are you sure you want to proceed ?', TRUE) THEN BEGIN
            //RMM 29/08/2018
            //Validate data including option fields
            ProductCodes.Reset();
            ProductCodes.SetRange(Type, ProductCodes.Type::"Lenders Option");
            if ProductCodes.FindFirst() then
                ProductRec := ProductCodes.Code;

            if LendersOptionSingleCGC.Get(BatchRefNo) then
                Error('This batch is already imported');

            Validate("Business Type");
            PassApplications.ValidateImportedApplications(Rec);




            //Create LO Customers, Application and Contracts
            //VEGA/OVJ PASS.D003 24/04/2019
            PassApplications.CreateImportedContracts(Rec, SingleCertificate, LendersOptionSingleCGC, BatchRefNo, GuaranteeSource, BankBrach, BatchBankCode, Signatory1, Signatory2, "Global Dimension 1 Code", ProductRec, ProductCodes.Type);
            //PassApplications.CreateImportedContracts(Rec);
            IF SingleCertificate AND (LendersOptionSingleCGC."No. of Loans" > 0) THEN BEGIN

                //Insert Lenders Option Single Credit Guarantee record for the imported loans
                LendersOptionSingleCGC."Financial Institution Code" := BatchBankCode;
                LendersOptionSingleCGC."Reference No." := BatchRefNo;
                LendersOptionSingleCGC."Reference Date" := BatchRefDate;
                LendersOptionSingleCGC.Description := BatchDescription;
                LendersOptionSingleCGC.INSERT(TRUE);
                BatchBankCode := '';
                BatchRefNo := '';
                BatchRefDate := 0D;
                BatchDescription := '';
                GuaranteeSource := '';
                BankBrach := '';
            END;
            //VEGA/OVJ PASS.D003 24/04/2019 END

            CurrPage.UPDATE(TRUE);
            MESSAGE('Processed');

        END ELSE
            MESSAGE('Cancelled');
    end;

}