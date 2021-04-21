table 51513913 "Lenders Option Journal Line"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "LO General Journal";
    LookupPageId = "LO General Journal";
    fields
    {
        field(1; "No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';

        }
        field(2; Name; Text[100])
        {
            DataClassification = CustomerContent;
            caption = 'Name';

            trigger Onvalidate()

            begin
                "Search Name" := UPPERCASE(Name);
            end;
        }
        field(3; "Search Name"; Text[50])
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
            TableRelation = IF ("Country/Region Code" = CONST ()) "Post Code".City ELSE
            IF ("Country/Region Code" = FILTER (<> '')) "Post Code".City
            WHERE ("Country/Region Code" = FIELD ("Country/Region Code"));

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
        field(15; "Branch Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Branch Code';
            TableRelation = Territory;
        }
        field(16; "Global Dimension 1 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (1));

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
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (2));

            trigger Onvalidate()

            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }

        field(26; "Statistics Group"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Statistics Group';
        }
        field(22; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code';
            TableRelation = Currency;
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
            CalcFormula = Exist ("Comment Line" WHERE ("Table Name" = CONST (Customer), "No." = FIELD ("No.")));
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

        field(91; "Post Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code';
            TableRelation = IF ("Country/Region Code" = CONST ()) "Post Code" ELSE
            IF ("Country/Region Code" = FILTER (<> '')) "Post Code"
            WHERE ("Country/Region Code" = FIELD ("Country/Region Code"));
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
            TableRelation = Products;

            trigger OnValidate()
            var
                productRec: Record Products;
            begin
                if productRec.Get(Product) then
                    "Product Type" := productRec.Type;
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
        field(500015; "Product Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",Traditional,"Lenders Option";
        }
        field(50107; "Have Business Plan?"; Boolean)
        {
            Caption = 'Have Business Plan?';
            DataClassification = CustomerContent;
        }

        field(50106; "Repeating Client"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Repeating Client';
        }
        field(50108; "Receivables Acc. No."; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Receivables Acc. No.';
            TableRelation = Customer."No." WHERE ("Customer Posting Group" = CONST ('BANKS'));

            trigger Onvalidate()
            var
                Debtor: record Customer;
            begin
                IF Debtor.GET("Receivables Acc. No.") THEN BEGIN
                    "Receivables Acc. Name" := Debtor.Name;
                    "Receivables Address" := Debtor.Address;
                    "Receivables Address 2" := Debtor."Address 2";
                    "Receivables Contact No." := Debtor."Phone No.";
                    "Receivables Email Address" := Debtor."E-Mail";
                    "Bank Contact Person" := Debtor.Contact;
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
            caption = 'Bank Account No';
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
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (3));

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
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (4));

            trigger Onvalidate()

            begin
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            end;
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
                        //"Home Page" := Customer."Home Page";
                    END;
            end;
        }
        field(50410; "Loan Issued Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Loan Issued Date';

        }
        field(50413; "Pct. Guarantee Approved"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Approved % Guarantee';
            MinValue = 0;
            MaxValue = 80;
        }
        field(50598; "Signatory 1 (CGC)"; Code[20])
        {
            Caption = 'Signatory 1 (CGC)';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser" where ("CGC Signatory" = const (true));


        }
        field(50599; "Signatory 2 (CGC)"; Code[20])
        {
            Caption = 'Signatory 2 (CGC)';
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser" where ("CGC Signatory" = const (true));


        }

        field(50600; "CGC Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'CGC Date';

        }
        field(50601; "CGC Start Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'CGC Start Date';
        }

        field(50602; "Loan Maturity Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Loan Maturity Date';


        }
        field(50606; "Risk Sharing Fee %"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Risk Sharing Fee %';
        }
        field(50625; "Guarantee Source"; Code[20])
        {
            Caption = 'Guarantee Source';
            DataClassification = CustomerContent;
            TableRelation = "Credit Guarantee Partner" where (Blocked = const (false));
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

        field(50828; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }



        field(50830; "Reference No."; Code[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Reference No.';
        }
        field(50611; "Loan No."; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Loan No.';
        }
        field(50840; "No of Employments Created"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'No of Employments Created';
        }
        field(50998; "Subsector"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Subsector;
        }
        field(50999; "Business Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Line Of Business";

            trigger OnValidate()
            var
                LineOfBusiness: Record "Line Of Business";
            begin
                if LineOfBusiness.Get("Business Type") then
                    Subsector := LineOfBusiness.Subsector;
            end;
        }
        field(51000; "Farm Size"; Option)
        {
            DataClassification = ToBeClassified;
            caption = 'Farm Size';
            OptionMembers = " ","Less than 1 Acre","Over 1-5 Acres","Over 5-10 Acres","Over 10 Acres";
        }
        field(51001; Technology; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Technology where ("Business Type" = field ("Business Type"));
        }
        field(51002; "Technology Type"; Option)
        {
            DataClassification = ToBeClassified;
            caption = 'Technology Type';
            OptionMembers = " ",Drip,"Centre Pivot","Furrow/Canal",Flooding;
        }
        field(51003; Type; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Types where ("Business Type" = field ("Business Type"), Subsector = field (Subsector));
        }
        field(51004; "No. of Animals"; Integer)
        {
            DataClassification = ToBeClassified;
            caption = 'No. of Animals';
        }
        field(51005; "Type of Breed"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Type of Breed';
            OptionMembers = " ",Improved,Local,Traditional,Layers,Broilers,Kroilers,Sasso;
        }
        field(51006; "Farming Method"; option)
        {
            DataClassification = CustomerContent;
            caption = 'Farmin Method';
            OptionMembers = " ","Fish pond","Fish Cage",Aquaponics,"Community Forest","Private Farm","Zero Grazing","Open Field Grazing","In Cages","Without Cages";
        }
        field(52006; Code; Code[20])
        {

        }
    }

    keys
    {
        key(PK; "Line No.", "Reference No.", Code)
        {
            Clustered = true;
        }

    }

    var
        PhoneNoCannotContainLettersErr: TextConst ENU = 'You cannot enter letters in this field.';
        DimMgt: Codeunit DimensionManagement;
        PostCode: Record "Post Code";
        RMSetup: Record "Marketing Setup";
        BusinessType: Record "Type of Business Owership";


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20])

    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::"Guarantee Application", "No.", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;

}