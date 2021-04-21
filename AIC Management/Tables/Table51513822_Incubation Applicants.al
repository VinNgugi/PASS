table 51513822 "Incubation Applicants"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    AICSetup.Get();
                    NoSeriesMgt.TestManual(AICSetup."Incubation Application Nos.");
                    "No. Series" := '';

                end;
            end;

        }
        field(2; "Application Date"; Date)
        {
            Editable = false;
        }
        field(3; Name; Text[150])
        {

        }
        field(4; "E-Mail"; Text[70])
        {
            DataClassification = CustomerContent;
            Caption = 'Email Address';
            ExtendedDatatype = EMail;

            trigger onvalidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail")
            end;
        }
        field(5; "Post Code"; Code[20])
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
        field(6; "County"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
            //CaptionClass = '5,1,' + 'Country/Region Code';
        }
        field(7; "Country/Region Code"; Code[20])
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
        field(8; City; text[30])
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
        field(9; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
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
        field(18; Address; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Physical Address';
        }
        field(19; "Address 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal Address';
        }
        field(20; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
            DataClassification = CustomerContent;
            Caption = 'Gender';
        }
        field(21; "Date of Birth"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of Birth';


            trigger OnValidate()

            begin
                if "Date of Birth" <> 0D THEN
                    Age := DATE2DMY(TODAY, 3) - DATE2DMY("Date of Birth", 3);
            end;
        }
        field(22; Age; Integer)
        {
            caption = 'Age';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(23; "Marital Status"; Option)
        {
            OptionMembers = ,Single,Married,Separated,Divorced,"Widow(er)",Other;
            DataClassification = CustomerContent;
            Caption = 'Marital Status';
        }
        field(24; "Education Level"; Option)
        {
            OptionMembers = " ","Class 7","Form 4","Form 6","College",University,"I don’t have formal Education";
            DataClassification = CustomerContent;
            Caption = 'Education Level';
        }
        field(25; "Can you read and write?"; Boolean)
        {

        }

        field(26; "Years of Experience in Farming"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Less than 1 Year","1-3 Years","4-6 Years","7-10 Years","Over 10 Years";
        }
        field(27; "Experience in Agri-business"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Less than 1 Year","1-3 Years","4-6 Years","7-10 Years","Over 10 Years";

        }
        field(28; "Why to be part of Incubation?"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Why do you want to join PASS AIC Incubation?';

        }
        field(29; "Agri-business involved?"; option)
        {
            Caption = 'Which agricultural related business are you involved in?';
            OptionMembers = " ","Crop Production","Animal Rearing","Transportation","Agri-business","None of the above";
        }
        field(30; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
            //Editable = false;

            trigger OnValidate()
            begin
                if not "Application fee Paid" then
                    error('Application fee is not paid, kindly make payement before submitting your application');
            end;
        }
        field(31; "Incubation Code"; Code[20])
        {
            TableRelation = Incubation where (Status = filter (Released));
            trigger OnValidate()
            var
                IncuRec: Record Incubation;
            begin
                if IncuRec.Get("Incubation Code") then begin
                    "Incubation Name" := IncuRec.Name;
                    "Global Dimension 1 Code" := IncuRec."Global Dimension 1 Code";
                    "Global Dimension 4 Code" := IncuRec."Global Dimension 4 Code";
                end;
            end;
        }
        field(32; "Incubation Name"; Text[50])
        {
            Editable = false;
        }
        field(33; "Phone Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone Number';
            ExtendedDatatype = PhoneNo;
        }
        field(34; "Application fee Paid"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Application fee Paid';
        }
        field(35; "Submitted Date"; Date)
        {
            Editable = false;
        }
        field(36; "Submitted Time"; Time)
        {
            Editable = false;
        }
        field(37; "Resident Selection"; Boolean)
        {
            Editable = false;

        }
        field(38; Admitted; Boolean)
        {
            Editable = false;
        }
        field(39; "Admission Date"; Date)
        {
            Editable = false;
        }
        field(40; "Admission Time"; Time)
        {
            Editable = false;
        }
        field(41; "Admitted by"; Code[50])
        {
            Editable = false;
        }
        field(42; "Receipt No."; code[20])
        {
            trigger OnValidate()
            begin
                if "Receipt No." <> "Application fee No." then
                    Error('Receipt No. %1 is invalid', "Receipt No.");
            end;
        }
        field(43; "Application fee No."; code[20])
        {
            Editable = false;

        }
        field(130; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";

        }
        field(50000; "Global Dimension 4 Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (4));
            CaptionClass = '1,2,4';

            trigger OnValidate()

            begin
                ValidateShortcutDimCode(4, "Global Dimension 4 Code");
            end;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        AICSetup: Record "AIC Setup";
        DimMgt: Codeunit DimensionManagement;
        PostCode: Record "Post Code";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        IF "No." = '' then begin
            AICSetup.get;
            AICSetup.TestField("Incubation Application Nos.");
            NoSeriesMgt.InitSeries(AICSetup."Incubation Application Nos.", xRec."No. Series"
            , 0D, "No.", "No. Series");
            "Application Date" := Today;

        end;
    end;

    trigger OnModify()
    begin
        "Last Date Modified" := Today;
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
        DimMgt.SaveDefaultDim(DATABASE::"Incubation Applicants", "No.", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;
}