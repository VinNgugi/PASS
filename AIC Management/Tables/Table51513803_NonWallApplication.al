table 51513803 "Non-Wall Applications"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Application ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(2; "Application Date"; Date)
        {
            Editable = false;
        }
        field(3; "Application Time"; Time)
        {
            Editable = false;
        }
        field(4; "Applicant ID"; Code[20])
        {
            Editable = false;
        }
        field(5; "Business Name"; Text[100])
        {

        }
        field(6; "Business Email"; Text[30])
        {

        }
        field(7; "Business Website"; text[30])
        {

        }
        field(8; Ownership; Option)
        {
            OptionMembers = "",Self,Partnership,Company;

        }
        field(9; "Date of Incorporation"; Date)
        {

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Business Age" := DatesMgmt.DetermineAge("Date of Incorporation", Today);

            end;
        }
        field(10; "Business Age"; Text[50])
        {
            Editable = false;
        }
        field(11; "Business Registration No"; Code[20])
        {

        }
        field(12; "Business Address"; Text[100])
        {

        }
        field(13; "Business Address 2"; text[100])
        {

        }
        field(14; City; Text[30])
        {
            TableRelation = IF ("Country/Region Code" = CONST ()) "Post Code".City ELSE
            IF ("Country/Region Code" = FILTER (<> '')) "Post Code".City WHERE ("Country/Region Code" = FIELD ("Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);

            end;

            trigger OnLookup()
            var
                myInt: Integer;
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");
            end;
        }
        field(15; "Post Code"; Code[20])
        {
            TableRelation = IF ("Country/Region Code" = CONST ()) "Post Code" ELSE
            IF ("Country/Region Code" = FILTER (<> '')) "Post Code" WHERE ("Country/Region Code" = FIELD ("Country/Region Code"));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) AND GUIALLOWED);

            end;

            trigger OnLookup()
            var
                myInt: Integer;
            begin
                PostCode.LookupPostCode(City, "Post Code", County, "Country/Region Code");

            end;

        }
        field(16; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
        }
        field(17; "Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Post Code", County, "Country/Region Code", xRec."Country/Region Code");

            end;

        }
        field(18; "Business Phone No"; Code[10])
        {

        }
        field(19; "Buisness Mobile No."; Code[20])
        {

        }
        field(20; "No. Series"; Code[20])
        {

        }
        field(21; Qualified; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Qualified';
        }
        field(22; "Enterpreneurship Test Score"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Enterprenuership Test Entry".Points where ("Application ID" = field ("Application ID")));
        }

        field(23; Submitted; Boolean)
        {
            Editable = false;
        }
        field(24; "Application fee Paid"; Boolean)
        {


        }
        field(25; "Applicant Name"; text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Applicant Name';
        }
        field(26; "TFDA"; Boolean)
        {

        }
        field(27; TBS; Boolean)
        {

        }
        field(28; "Barcode"; Boolean)
        {

        }
        field(29; "Business License"; Boolean)
        {

        }
        field(30; "Tax Clearance"; Boolean)
        {

        }
        field(31; "WIF Total Score"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("WIF Test Entry".Score where ("Application ID" = field ("Application ID")));

        }
        field(32; "Shortlisted"; Boolean)
        {
            DataClassification = ToBeClassified;

        }
        field(33; "Deep Dive Analysis Done"; boolean)
        {
            DataClassification = ToBeClassified;

        }
    }

    keys
    {
        key(PK; "Application ID")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "Human Resources Setup";
        AICMgmt: Codeunit "AIC Management";
        DatesMgmt: Codeunit "Dates Management";
        PostCode: Record "Post Code";

    trigger OnInsert()
    begin
        //*************************Insert Application ID
        IF "Application ID" = '' THEN BEGIN
            HRSetup.GET;
            HRSetup.TESTFIELD(HRSetup."Non-Wall Numbers");
            NoSeriesMgt.InitSeries(HRSetup."Non-Wall Numbers", xRec."No. Series", 0D, "Application ID", "No. Series");
        end;
        //*************************Insert Application ID
        //*************************Insert Defaults
        "Application Date" := Today;
        "Application Time" := Time;

        if "Application ID" <> '' then
            AICMgmt.PopulateEnterprenuershipTestEntries(Rec);
        //*************************Insert Defaults

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

}