table 51513812 "Incubates Register"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "First Name"; Text[30])
        {

        }
        field(3; "Middle Name"; Text[30])
        {

        }
        field(4; "Last Name"; Text[30])
        {

        }
        field(5; "Name"; Text[100])
        {

        }
        field(6; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
        }
        field(7; "ID Number"; Text[20])
        {

        }
        field(8; "Drivers Licence No"; Text[20])
        {

        }
        field(9; "Passport No"; Text[20])
        {

        }
        field(10; "Marital Status"; Option)
        {
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
            DataClassification = CustomerContent;
            Caption = 'Marital Status';
        }
        field(11; "Date of Bitrh"; Date)
        {

        }
        field(12; "Address"; Text[100])
        {

        }

        field(13; City; Text[30])
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
        field(14; "Post Code"; Code[20])
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
        field(15; County; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code";
        }
        field(16; "Country/Region Code"; Code[10])
        {
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Post Code", County, "Country/Region Code", xRec."Country/Region Code");

            end;

        }
        field(17; "Address 2"; Text[100])
        {

        }
        field(18; "City 2"; Text[30])
        {
            TableRelation = IF ("Country/Region Code 2" = CONST ()) "Post Code".City ELSE
            IF ("Country/Region Code 2" = FILTER (<> '')) "Post Code".City WHERE ("Country/Region Code" = FIELD ("Country/Region Code 2"));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                PostCode.ValidateCity("City 2", "Post Code 2", "County 2", "Country/Region Code 2", (CurrFieldNo <> 0) AND GUIALLOWED);

            end;

            trigger OnLookup()
            var
                myInt: Integer;
            begin
                PostCode.LookupPostCode("City 2", "Post Code 2", "County 2", "Country/Region Code 2");
            end;
        }
        field(19; "Post Code 2"; Code[20])
        {
            TableRelation = IF ("Country/Region Code 2" = CONST ()) "Post Code" ELSE
            IF ("Country/Region Code 2" = FILTER (<> '')) "Post Code" WHERE ("Country/Region Code" = FIELD ("Country/Region Code 2"));
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                PostCode.ValidatePostCode("City 2", "Post Code 2", "County 2", "Country/Region Code 2", (CurrFieldNo <> 0) AND GUIALLOWED);

            end;

            trigger OnLookup()
            var
                myInt: Integer;
            begin
                PostCode.LookupPostCode("City 2", "Post Code 2", "County 2", "Country/Region Code 2");

            end;

        }
        field(20; "County 2"; Text[30])
        {
            CaptionClass = '5,1,' + "Country/Region Code 2";
        }
        field(21; "Country/Region Code 2"; Code[10])
        {
            TableRelation = "Country/Region";

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                PostCode.CheckClearPostCodeCityCounty(City, "Post Code", County, "Country/Region Code", xRec."Country/Region Code");

            end;

        }
        field(22; Disabled; Boolean)
        {

        }
        field(23; "Disability Details"; Text[100])
        {

        }
        field(24; "E-mail"; Text[30])
        {

        }
        field(25; "Website"; text[30])
        {

        }
        field(26; Ownership; Option)
        {
            OptionMembers = "",Self,Partnership,Company;

        }
        field(27; "Date of Incorporation"; Date)
        {

            /*trigger OnValidate()
            var
                myInt: Integer;
            begin
                "Business Age" := DatesMgmt.DetermineAge("Date of Incorporation", Today);

            end;*/
        }
        field(28; "Business Registration No"; Code[20])
        {

        }
        field(29; "Phone No"; Code[10])
        {

        }
        field(30; "Cellular/Mobile No."; Code[20])
        {

        }
        field(31; "Incubate Type"; Option)
        {
            OptionMembers = " ",Wall,"Non-Wall";

        }
        field(32; "No. Series"; Code[20])
        {

        }
        field(33; "Date of Exit"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Date of Exit';
        }
        field(34; "Reason for Exit"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Reason for Exit';
            OptionMembers = " ",Desertion,Termination,Death,"Incubation Project Closure";
        }
        field(35; Details; text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Details';
        }
        field(36; "Incubation Start Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Incubation Start Date';
            Editable = false;
        }
        field(37; "Incubation Period"; DateFormula)
        {
            DataClassification = CustomerContent;
            caption = 'Incubation Period';
            Editable = false;
        }
        field(38; "Incubation End Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Incubation End Date';
            Editable = false;
        }
        field(39; "Job ID"; Code[50])
        {
            trigger OnValidate()
            begin
                if JobId.Get("Job ID") then begin
                    "Incubation Period" := JobId."Incubation Period";
                    "Incubation End Date" := JobId."Incubation End Date";
                    "Incubation Start Date" := JobId."Incubation Start Date";
                    "Job Description" := JobId."Job Description";
                end;
            end;
        }
        field(40; "Job Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Description';
            Editable = false;
        }
        field(41; "Exit Business Plan Attached"; Boolean)
        {

        }
        field(42; "Proceed to Non-Wall Program"; Boolean)
        {
            DataClassification = ToBeClassified;

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
        PostCode: Record "Post Code";
        JobId: Record "Company Jobs";

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

}