dotnet
{
    assembly(mscorlib)
    {
        type(System.Char; MyChar) { }

    }
    //assembly(Microsoft.Office.Interop.Excel)
    //{

    //  type(Microsoft.Office.Interop.Excel.ApplicationClass; XlApp) { }
    //}
}
Table 51513000 "Guarantee Application"
{

    DataClassification = ToBeClassified;
    Caption = 'Guarantee Application';
    //LookupPageId = "Guarantee Application List";
    //DrillDownPageId = "Guarantee Application List";

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'No.';
            Editable = false;

            trigger OnValidate()

            begin
                IF "No." <> xRec."No." then begin
                    GuaranteeSetup.Get;
                    NoSeriesMgt.TestManual(GuaranteeSetup."Guarantee Application Nos.");
                    "No. Series" := ''
                end;
            end;

        }
        field(2; Name; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Name';

            trigger OnValidate()

            begin
                IF ("Search Name" = UpperCase(xRec.Name)) OR ("Search Name" = '') then
                    "Search Name" := Name;
            end;
        }
        field(3; "Search Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Search Name';
        }
        field(4; "Name 2"; text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Name 2';
        }
        field(5; Address; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(6; "Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Address 2';
        }
        field(7; City; text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code".City ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code".City
            WHERE("Country/Region Code" = FIELD("Country/Region Code"));

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;

            trigger OnLookUp()
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;
        }
        field(8; Contact; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contact';

            trigger Onvalidate()

            begin
                IF RMSetup.Get THEN
                    IF RMSetup."Bus. Rel. Code for Customers" <> '' THEN
                        IF (xRec.Contact = '') and (xRec."Primary Contact No." = '') and (Contact <> '') then begin
                            Modify;

                        end;
            END;

        }
        field(9; "Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;

            trigger OnValidate()

            var
                i: Integer;
                Char: DotNet MyChar;
            begin
                FOR i := 1 TO StrLen("Phone No.") do
                    IF Char.IsLetter("Phone No."[i]) then
                        Error(PhoneNoCannotContainLettersErr);
            end;
        }

        field(16; "Global Dimension 1 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));

            trigger Onvalidate()

            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(17; "Global Dimension 2 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));

            trigger Onvalidate()

            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }

        field(22; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency;

            trigger OnValidate()

            begin
                //Validate("Loan Amount");
                IF "Currency Code" <> '' THEN BEGIN
                    //GetCurrency;
                    IF ("Currency Code" <> xRec."Currency Code") OR
                       ("Application Date" <> xRec."Application Date") OR
                       (CurrFieldNo = FIELDNO("Currency Code")) OR
                       ("Currency Factor" = 0)
                    THEN
                        "Currency Factor" :=
                          CurrExchRate.ExchangeRate("Application Date", "Currency Code");
                END ELSE
                    "Currency Factor" := 0;
                VALIDATE("Currency Factor");
            end;
        }
        field(35; "Country/Region Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";

            trigger onvalidate()
            var
                PostCode: Record "Post Code";
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Post Code", County, "Country/Region Code", xRec."Country/Region Code");

            end;
        }
        field(38; Comment; Boolean)
        {
            FieldClass = FlowField;
            Caption = 'Comment';
            CalcFormula = Exist("Comment Line" WHERE("Table Name" = CONST(Customer), "No." = FIELD("No.")));
        }
        field(53; "Last Modified Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(54; "Last Date Modified"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(84; "Fax No."; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Fax No.';
        }
        field(86; "VAT Registrarion No."; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Registrarion No.';

            trigger Onvalidate()

            begin

                "VAT Registrarion No." := UpperCase("VAT Registrarion No.");
            end;
        }
        field(91; "Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST()) "Post Code" ELSE
            IF ("Country/Region Code" = FILTER(<> '')) "Post Code"
            WHERE("Country/Region Code" = FIELD("Country/Region Code"));
            ValidateTableRelation = false;

            trigger Onvalidate()

            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);
            end;

            trigger OnLookUp()

            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;
        }
        field(92; "County"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
            //CaptionClass = '5,1,' + 'Country/Region Code';
        }
        field(102; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;

            trigger onvalidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail")
            end;

        }
        field(103; "Home Page"; Text[80])
        {
            DataClassification = CustomerContent;
            ExtendedDatatype = URL;
            Caption = 'Home Page';
        }
        field(107; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }

        field(5049; "Primary Contact No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Contact No.';
        }

        field(8000; Id; Guid)
        {
            DataClassification = CustomerContent;
            Caption = 'Id';
        }

        field(50000; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
            DataClassification = CustomerContent;
            Caption = 'Gender';
        }
        field(50001; Status; Option)
        {
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
            DataClassification = CustomerContent;
            Caption = 'Status';
        }

        field(50002; "Loan Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Loan Amount';
            AutoFormatType = 1;
            NotBlank = true;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" = '' THEN
                    "Loan Amount(LCY)" := "Loan Amount"
                ELSE
                    "Loan Amount(LCY)" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Application Date", "Currency Code",
                          "Loan Amount", "Currency Factor"));

                GuaranteeSetup.Get;

                if "Product Type" = "Product Type"::Traditional then begin
                    if "Currency Code" <> '' then begin

                        if "Loan Amount" > GuaranteeSetup."Loan Amount Limit(USD)" then
                            "Charge fees on Guaranteed Amt" := true
                        else begin
                            "Charge fees on Guaranteed Amt" := false;
                            "Applied Guarantee Amount" := 0;
                            "Pct. Guarantee Applied" := 0;
                        end;
                    end else begin
                        if "Loan Amount" > GuaranteeSetup."Loan Amount Limit" then
                            "Charge fees on Guaranteed Amt" := true
                        else begin
                            "Charge fees on Guaranteed Amt" := false;
                            "Applied Guarantee Amount" := 0;
                            "Pct. Guarantee Applied" := 0;
                        end;
                    end;
                end;
            end;
        }
        field(50003; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Application Date';
            NotBlank = true;
        }
        field(50004; Ownership; Option)
        {
            Caption = 'Ownership';
            OptionMembers = " ",Individual,Company,Partnership,Proprietor,"Cooperatives Societies";
            DataClassification = CustomerContent;



        }
        field(50005; "Application Status"; Option)
        {
            OptionMembers = " ","Commitment Paid","Pre-Appraised","Contract Prepared","Contract Signed","Rejected";
            DataClassification = CustomerContent;
            Caption = 'Application Status';

        }
        field(50006; Product; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Product';
            NotBlank = true;
            TableRelation = Products.Code where(Type = field("Product Type"));

            trigger OnValidate()
            var
                ProductRec: Record Products;
            begin
                if ProductRec.Get(Product) then begin

                    if "Product Type" = "Product Type"::"Lenders Option" then
                        ProductRec.TestField("Portfolio Guarantee %");

                    Validate("Receivables Acc. No.");
                    Validate("Loan Amount");
                    Validate("Currency Code");
                end;

            end;

        }
        field(50007; "BDS/BDO"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'BDS/BDO';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50008; "Any Existing Loans"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Any Existing Loans';
        }
        field(50009; "Requested Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Requested Amount';
        }
        field(50010; "No. of Females"; Integer)
        {
            Caption = 'No. of Females';
            DataClassification = CustomerContent;

        }
        field(50011; "No. of Males"; Integer)
        {
            Caption = 'No. of Males';
            DataClassification = CustomerContent;

        }
        field(50012; "Project Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Project Description';
        }
        field(50013; "Loan Amount(LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Loan Amount(LCY)';
            AutoFormatType = 1;



        }
        field(500014; "Currency Factor"; Decimal)
        {
            Editable = false;
            MinValue = 0;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF ("Currency Code" = '') AND ("Currency Factor" <> 0) THEN
                    FIELDERROR("Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION("Currency Code")));
                VALIDATE("Loan Amount");
            end;
        }
        field(500015; "Product Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Traditional,"Lenders Option";

        }
        field(50100; "Application fee Invoiced"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Application fee Invoiced';
        }
        field(50101; "Application fee Invoice Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Application fee Invoice Amount';
            //CalcFormula = Sum ("Sales Invoice Header"."Amount Including VAT" WHERE ("Guarantee Application No." = FIELD ("No."), "Guarantee Entry Type" = FILTER ("Application fee")));
        }
        field(50102; "Application fee Paid"; Decimal)
        {
            caption = 'Application fee Paid';
            DataClassification = CustomerContent;
        }

        field(50103; "Consultancy Fee Invoiced"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Consultancy Fee Invoiced';
        }

        field(50104; "Consultancy Fee Invoice Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Consultancy Fee Invoice Amount';
            //CalcFormula = Sum ("Sales Invoice Header"."Amount Including VAT" WHERE ("Guarantee Application No." = FIELD ("No."), "Guarantee Entry Type" = FILTER ("Application fee")));
        }
        field(50105; "Consultancy Fee Paid"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Consultancy Fee Paid';
            //CalcFormula = Sum ("Sales Invoice Header"."Amount Including VAT" WHERE ("Guarantee Application No." = FIELD ("No."), "Guarantee Entry Type" = FILTER ("Application fee")));
        }

        field(50106; "Repeating Client"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Repeating Client';
        }
        field(50107; "Have Business Plan?"; Boolean)
        {
            Caption = 'Have Business Plan?';
            DataClassification = CustomerContent;
        }
        field(50108; "Receivables Acc. No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Receivables Acc. No.';
            TableRelation = Customer."No." WHERE("Customer Posting Group" = CONST('BANKS'));

            trigger Onvalidate()

            begin
                IF Debtor.GET("Receivables Acc. No.") THEN BEGIN
                    "Receivables Acc. Name" := Debtor.Name;
                    "Receivables Address" := Debtor.Address;
                    "Receivables Address 2" := Debtor."Address 2";
                    "Receivables Contact No." := Debtor."Phone No.";
                    "Receivables Email Address" := Debtor."E-Mail";
                    "Bank Contact Person" := Debtor.Contact;


                    IF "Product Type" = "Product Type"::"Lenders Option" then begin
                        Debtor.TestField("Linkage Risk Sharing fee %");
                        "Risk Sharing Fee %" := Debtor."Linkage Risk Sharing fee %";
                    end else begin
                        Debtor.TestField("Traditional Risk Sharing fee %");
                        "Risk Sharing Fee %" := Debtor."Traditional Risk Sharing fee %";
                    end;

                end else begin
                    "Receivables Acc. Name" := '';
                    "Receivables Address" := '';
                    "Receivables Address 2" := '';
                    "Receivables Contact No." := '';
                    "Receivables Email Address" := '';
                    "Bank Contact Person" := '';
                    "Risk Sharing Fee %" := 0;
                end;
            end;
        }
        field(50109; "Receivables Acc. Name"; Text[100])
        {
            DataClassification = CustomerContent;
            caption = 'Receivables Acc. Name';
        }
        field(50110; "Receivables Address"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Receivables Address';
        }
        field(50111; "Receivables Address 2"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Receivables Address 2';
        }
        field(50112; "Receivables Contact No."; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Receivables Contact No.';
            ExtendedDatatype = PhoneNo;
        }
        field(50113; "Receivables Email Address"; Text[50])
        {
            DataClassification = CustomerContent;
            caption = 'Receivables Email Address';
            ExtendedDatatype = EMail;
        }

        field(50114; "Bank Account No"; Text[20])
        {
            DataClassification = CustomerContent;
            caption = 'Individual Bank Account No';
            Description = 'Individuals Bank Account Number';
        }
        field(50115; "Bank Contact Person"; text[50])
        {
            Caption = 'Bank Contact Person';
            DataClassification = CustomerContent;
        }
        field(50116; "Booked Fee %"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Booked Fee %';
        }
        field(50117; "Bank Branch Name"; Text[50])
        {
            DataClassification = CustomerContent;
            caption = 'Bank Branch';
        }

        field(50118; "Linkage fee Invoiced"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Guarantee fee Invoiced';
        }
        field(50119; "Linkage fee Paid"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Guarantee fee Paid';
        }
        field(50120; "Linkage fee Invoice Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Guarantee fee Invoice Amount';
        }
        field(50121; "Created From Import"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Created From Import';
        }
        field(50122; "Date Created"; Date)
        {
            Caption = 'Date Created';
            DataClassification = CustomerContent;
        }
        field(50123; "Created By"; Code[20])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
        }
        field(50124; "Reference No."; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Reference No.';
        }
        field(50125; "Booked fee Invoiced "; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Booked fee Invoiced';
        }
        field(50126; "BP Reviewed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'BP Reviewed';
        }
        field(50127; "BP Reviewed By"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'BP Reviewed By';
            TableRelation = "User Setup";
        }
        field(50128; "Quality Assurance"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Quality Assurance';
        }
        field(50130; "QA Done By 1"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'QA Done By 1';
            TableRelation = "User Setup";
        }
        field(50131; "QA Done By 2"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'QA Done By 2';
            TableRelation = "User Setup";
        }
        field(50132; "Type of Facility"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type of Facility';
            OptionMembers = "Term Loan",Overdraft,"Letter of Credit","Bank Guarantee";
        }
        field(50133; "Global Dimension 3 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 3 Code';
            CaptionClass = '1,2,3';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

            trigger Onvalidate()

            begin
                ValidateShortcutDimCode(3, "Global Dimension 3 Code");
            end;
        }
        field(50134; "Global Dimension 4 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,2,4';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));

            trigger Onvalidate()

            begin
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            end;
        }
        field(50135; "Charge fees on Guaranteed Amt"; Boolean)
        {
            Caption = 'Charge fees on Guaranteed Amt';
            DataClassification = CustomerContent;
        }
        field(50136; "CheckedforE&SSustainability?"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Checked for E&S Sustainability';
            OptionMembers = " ",formalEnvironmentalImpactAssessment,simplifiedassessmentbyPASS,No;
            OptionCaption = ' ,Yes formal Environmental Impact Assessment,Yes simplified assessment by PASS,No';
        }
        field(50137; "MeetMinimumRequirements?"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Meet minimum requirements?';
            OptionMembers = " ",Yes,Partly,No;
            OptionCaption = ' ,Yes,Partly,No (no investment)';
        }
        field(50138; "MitigationMeasuresAgreed?"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Mitigation measures agreed?';
            OptionMembers = " ",Yes,Partly,No;
            OptionCaption = ' ,Yes,Partly,No';
        }
        field(50139; "InvestmentInGreenSolutions?"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Include Green solutions?';
            OptionMembers = " ",Yes,No;
            OptionCaption = ' ,Yes,No';
        }
        field(50140; "InvestmentInGreenSum"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Green Solutions Summary';

        }
        field(50322; "Previous Status"; Option)
        {
            OptionMembers = " ","Commitment Paid","Pre-Appraised","Contract Prepared","Contract Signed","Rejected";
            DataClassification = CustomerContent;
            Caption = 'Previous Status';

        }
        field(50323; "Previous Status Date"; date)
        {

            DataClassification = CustomerContent;
            Caption = 'Previous Status Date';

        }
        field(50344; "Contract Signed Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Signed Date';
        }
        field(50350; "Code (Reject)"; Code[20])
        {
            Caption = 'Code(Reject)';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;

            trigger OnValidate()
            var
                RejectRec: Record "Standard Text";
            begin
                IF ("Code (Reject)" <> '') THEN
                    IF RejectRec.GET("Code (Reject)") THEN
                        "Reject Reason" := RejectRec.Description;
            end;
        }
        field(50351; "Reject Reason"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Reject Reason';

            trigger OnValidate()

            begin
                "Code (Reject)" := '';
            end;
        }
        field(50400; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.';
            TableRelation = Customer;

            trigger OnValidate()
            var
                Customer: Record Customer;
            begin
                IF ("Customer No." <> '') THEN
                    IF Customer.GET("Customer No.") THEN BEGIN
                        VALIDATE(Name, Customer.Name);
                        "Name 2" := Customer."Name 2";
                        Address := Customer.Address;
                        "Address 2" := Customer."Address 2";
                        City := Customer.City;
                        Contact := Customer.Contact;
                        "Phone No." := Customer."Phone No.";
                        //"Branch Code" := Customer."Territory Code";
                        "Global Dimension 1 Code" := Customer."Global Dimension 1 Code";
                        "Global Dimension 2 Code" := Customer."Global Dimension 2 Code";
                        //"Statistics Group" := Customer."Statistics Group";
                        "Fax No." := Customer."Fax No.";
                        "Post Code" := Customer."Post Code";
                        County := Customer.County;
                        "E-Mail" := Customer."E-Mail";
                        "Home Page" := Customer."Home Page";
                    END;
            end;
        }
        field(50409; "Pct. Guarantee Applied"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Pct. Guarantee Applied';
            MinValue = 0;
            MaxValue = 80;

            trigger Onvalidate()

            begin
                "Applied Guarantee Amount" := ("Pct. Guarantee Applied" * "Loan Amount") / 100;
            end;
        }
        field(50410; "Loan Issued Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Loan Issued Date';

        }
        field(50411; "Approved Loan Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Approved Loan Amount';

        }

        field(50420; "BP Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'BP Amount';
            MinValue = 0;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "Currency Code" = '' THEN
                    "BP Amount LCY" := "BP Amount"
                ELSE
                    "BP Amount LCY" := ROUND(
                        CurrExchRate.ExchangeAmtFCYToLCY(
                          "Application Date", "BP Currency",
                          "BP Amount", "BP Currency Factor"));
            end;
        }
        field(50421; "BP Amount LCY"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'BP Amount LCY';
            MinValue = 0;
        }
        field(50422; "BP Currency"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'BP Currency';
            TableRelation = Currency;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF "BP Currency" <> '' THEN BEGIN
                    //GetCurrency;
                    IF ("BP Currency" <> xRec."BP Currency") OR
                       ("Application Date" <> xRec."Application Date") OR
                       (CurrFieldNo = FIELDNO("BP Currency")) OR
                       ("BP Currency Factor" = 0)
                    THEN
                        "BP Currency Factor" :=
                          CurrExchRate.ExchangeRate("Application Date", "BP Currency");
                END ELSE
                    "BP Currency Factor" := 0;
                VALIDATE("BP Currency Factor");
            end;
        }

        field(50423; "BP Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'BP Currency Factor ';
            Editable = false;
            MinValue = 0;
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF ("BP Currency" = '') AND ("BP Currency Factor" <> 0) THEN
                    FIELDERROR("BP Currency Factor", STRSUBSTNO(Text002, FIELDCAPTION("BP Currency")));
                VALIDATE("BP Amount");
            end;

        }
        field(50426; "Application fee Waived"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Application fee Waived';
            Editable = false;
        }
        field(50427; "Consultancy fee Waived"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Consultancy fee Waived';
            Editable = false;
        }
        field(50428; "Waive all fees"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Waive all fees';
            Editable = false;
        }
        field(50434; "Contract Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Contract Description';
        }
        field(50598; "Signatory 1 (CGC)"; Code[20])
        {
            Caption = 'Signatory 1 (CGC)';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser".Code where("CGC Signatory" = const(true));

            trigger OnValidate()

            begin
                CheckSignatories;
            end;
        }
        field(50599; "Signatory 2 (CGC)"; Code[20])
        {
            Caption = 'Signatory 2 (CGC)';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser".Code where("CGC Signatory" = const(true));

            trigger OnValidate()

            begin
                CheckSignatories;
            end;
        }
        field(50606; "Risk Sharing Fee %"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Risk Sharing Fee %';
        }
        field(50611; "Loan No."; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Loan No.';
        }

        field(50625; "Guarantee Source"; Code[20])
        {
            Caption = 'Guarantee Source';
            DataClassification = CustomerContent;
            TableRelation = "Credit Guarantee Partner" where(Blocked = const(false));

        }
        field(50710; "Date of Birth"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of Birth';


            trigger OnValidate()

            begin
                if "Date of Birth" <> 0D THEN
                    Age := DATE2DMY(TODAY, 3) - DATE2DMY("Date of Birth", 3);
            end;
        }
        field(50717; Age; Integer)
        {
            caption = 'Age';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50718; "Business Ownership Type"; Code[20])
        {
            Caption = 'Business Ownership Type';
            DataClassification = CustomerContent;
            TableRelation = "Type of Business Owership";

            trigger OnValidate()

            begin
                IF BusinessType.GET("Business Ownership Type") then
                    Ownership := BusinessType."Ownership Type";

            end;
        }
        field(50819; Stage; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Stage';
            TableRelation = "Guarantee Application Stages";
        }
        field(50820; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Modified By';
            TableRelation = "User Setup";
        }
        field(50840; "No of Employments Created"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No of Employments Created';
            Editable = false;
        }
        field(50841; "Applied Guarantee Amount"; Decimal)
        {
            Caption = 'Applied Guarantee Amount';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50842; Source; Option)
        {
            OptionMembers = Office,Mobile;
        }
        field(50843; AppID; Integer)
        {

        }
        field(50844; TimeStp; Text[100])
        {

        }
        field(50845; IMEI; Text[100])
        {

        }
        field(50847; "No. of Female Employees(Per)"; Integer)
        {
            Caption = 'No. of Female Employees Permanent';
            DataClassification = CustomerContent;

            trigger onvalidate()

            begin
                "No of Employments Created" := "No. of Female Employees(Per)" + "No. of Male Employees(Per)" + "No. of Female Employees(Cas)" + "No. of Male Employees(Cas)";
            end;
        }
        field(50848; "No. of Male Employees(Per)"; Integer)
        {
            Caption = 'No. of Male Employees Permanent';
            DataClassification = CustomerContent;

            trigger onvalidate()

            begin
                "No of Employments Created" := "No. of Female Employees(Per)" + "No. of Male Employees(Per)" + "No. of Female Employees(Cas)" + "No. of Male Employees(Cas)";
            end;
        }
        field(50849; "No. of Female Employees(Cas)"; Integer)
        {
            Caption = 'No. of Female Employees Casual';
            DataClassification = CustomerContent;

            trigger onvalidate()

            begin
                "No of Employments Created" := "No. of Female Employees(Per)" + "No. of Male Employees(Per)" + "No. of Female Employees(Cas)" + "No. of Male Employees(Cas)";
            end;
        }
        field(50850; "No. of Male Employees(Cas)"; Integer)
        {
            Caption = 'No. of Male Employees Casual';
            DataClassification = CustomerContent;

            trigger onvalidate()

            begin
                "No of Employments Created" := "No. of Female Employees(Per)" + "No. of Male Employees(Per)" + "No. of Female Employees(Cas)" + "No. of Male Employees(Cas)";
            end;
        }
        field(50851; "No. of Female Beneficiaries"; Integer)
        {
            Caption = 'No. of Female Beneficiaries';
            DataClassification = CustomerContent;
            trigger onvalidate()

            begin
                "Total No. of Beneficiaries" := "No. of Male Beneficiaries" + "No. of Female Beneficiaries";
            end;
        }
        field(50852; "No. of Male Beneficiaries"; Integer)
        {
            Caption = 'No. of Male Beneficiaries';
            DataClassification = CustomerContent;

            trigger onvalidate()

            begin
                "Total No. of Beneficiaries" := "No. of Male Beneficiaries" + "No. of Female Beneficiaries";
            end;
        }

        field(50853; "Total No. of Beneficiaries"; Integer)
        {
            Caption = 'Total No. of Beneficiaries';
            DataClassification = CustomerContent;
            Editable = false;

        }
        field(50854; "Client Signature"; Blob)
        {
            Subtype = Bitmap;
            trigger OnValidate()
            var

            begin
                if Source = Source::Mobile then begin

                end;
            end;
        }
        field(50855; SIDA; Boolean)
        {

        }
        field(50856; "Customer TIN"; Code[20])
        {

        }
        field(50857; "Customer VRN"; Code[20])
        {

        }

    }

    keys
    {
        key("No."; "No.")
        {
            Clustered = true;
        }
    }


    var
        CurrExchRate: Record "Currency Exchange Rate";
        Text002: TextConst ENU = 'cannot be specified without %1';
        NoSeriesMgt: Codeunit NoSeriesManagement;
        GuaranteeSetup: Record "Guarantee Management Setup";
        PostCode: Record "Post Code";
        RMSetup: Record "Marketing Setup";
        BusinessType: Record "Type of Business Owership";
        PhoneNoCannotContainLettersErr: TextConst ENU = 'You cannot enter letters in this field.';
        DimMgt: Codeunit DimensionManagement;
        Debtor: Record Customer;
        UserSetup: Record "User Setup";
        ObjGreenSetup: Record "Green Activities Setup";
        ObjGreenEntries: Record "Green Activities Entries";


    trigger OnInsert()
    begin
        IF "No." = '' THEN begin
            GuaranteeSetup.Get;
            GuaranteeSetup.TestField("Loan Amount Limit");
            GuaranteeSetup.TestField("Guarantee Application Nos.");
            NoSeriesMgt.InitSeries(GuaranteeSetup."Guarantee Application Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
        "Last Date Modified" := Today;
        "Last Modified Date Time" := CurrentDateTime;
        "Modified By" := UserId;
        "Created By" := UserId;
        "Date Created" := Today;

        if UserSetup.Get(UserId) then begin
            "BDS/BDO" := UserSetup."BDO Code";
            "Global Dimension 1 Code" := UserSetup."Global Dimension 1 Code";
        end;

        DimMgt.UpdateDefaultDim(
        DATABASE::"Guarantee Application", "No.",
        "Global Dimension 1 Code", "Global Dimension 2 Code");
        //"Risk Sharing Fee %" := GuaranteeSetup."Risk Sharing fee %";


        //**********************InsertGreenActivities*****************************//
        if "No." <> '' then
            FnInsertGreenActivities("No.");


    end;

    trigger OnModify()
    begin
        GuaranteeSetup.Get;
        "Last Date Modified" := Today;
        "Last Modified Date Time" := CurrentDateTime;
        "Modified By" := UserId;
    end;

    trigger OnDelete()
    begin
        Error('Delete data not allowed');
    end;

    trigger OnRename()
    begin
        "Last Date Modified" := Today;
        "Last Modified Date Time" := CurrentDateTime;
        "Modified By" := UserId;
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])

    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Guarantee Application", "No.", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;

    procedure CheckSignatories()

    begin
        IF ("Signatory 1 (CGC)" = '') AND ("Signatory 2 (CGC)" = '') THEN
            EXIT;

        IF ("Signatory 1 (CGC)" = "Signatory 2 (CGC)") THEN
            ERROR('You must enter different signatories.');
    end;

    procedure FnInsertGreenActivities(ContractNo: Code[20])
    var
        myInt: Integer;
    begin
        //************Insert 
        ObjGreenSetup.Reset();
        if ObjGreenSetup.FindSet() then
            repeat
                with ObjGreenEntries do begin
                    Init();
                    "Contract No." := "No.";
                    "Entry Code" := ObjGreenSetup."Entry Code";
                    Description := ObjGreenSetup.Description;
                    Insert();
                end;
            until ObjGreenSetup.Next() = 0;
    end;

    [IntegrationEvent(false, false)]
    procedure OnAttachDocuments(var GuarrApplication: Record "Guarantee Application")
    var
    begin

    end;

    [IntegrationEvent(false, false)]
    procedure OnViewAttachedDocuments(var GuarrApplication: Record "Guarantee Application")
    var
    begin

    end;

}