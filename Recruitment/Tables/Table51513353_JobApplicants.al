table 51513353 "Job Applicants"
{
    DataClassification = CustomerContent;
    Caption = 'Job Applicants';
    LookupPageId = "Applicants List";
    DrillDownPageId = "Applicants List";
    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            //NotBlank = true;
            Editable = false;

            trigger Onvalidate()
            begin
                IF "No." <> xRec."No." THEN BEGIN
                    case "Job Function" of
                        "Job Function"::"AIC Job":
                            begin
                                HumanResSetup.GET;
                                NoSeriesMgt.TestManual(HumanResSetup."AIC Applicant Nos.");
                                "No. Series" := '';
                            end;
                        "Job Function"::"Normal Job":
                            begin
                                HumanResSetup.GET;
                                NoSeriesMgt.TestManual(HumanResSetup."Applicants Nos.");
                                "No. Series" := '';
                            end;

                    end;

                END;
            end;
        }
        field(2; "First Name"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';

        }
        field(3; "Middle Name"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';

        }
        field(4; "Last Name"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
        }
        field(5; Initials; Text[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Initials';
        }
        field(6; "Search Name"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Search Name';
        }
        field(7; "Postal Address"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal Address';
        }
        field(8; "Residential Address"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Residential Address';
        }
        field(9; City; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }
        field(10; "Post Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code';
            TableRelation = "Post Code";
            ValidateTableRelation = false;

        }
        field(11; County; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'County';
        }
        field(12; "Home Phone Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Home Phone Number';
            ExtendedDatatype = PhoneNo;
        }
        field(13; "Cellular Phone Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Cellular Phone Number';
            ExtendedDatatype = PhoneNo;
        }
        field(14; "Work Phone Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Phone Number';
            ExtendedDatatype = PhoneNo;
        }
        field(15; "Ext."; Text[7])
        {
            DataClassification = CustomerContent;
            Caption = 'Ext.';
        }
        field(16; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(17; Picture; Blob)
        {
            DataClassification = CustomerContent;
            Caption = 'Picture';
            Subtype = Bitmap;
        }
        field(18; "ID Number"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Number';

            trigger Onvalidate()

            begin
                Applicant.RESET;
                Applicant.SETRANGE(Applicant."ID Number", "ID Number");
                IF Applicant.FIND('-') THEN
                    ERROR('There is already a profile with a similar ID Number %1', "ID Number");

                Emp.RESET;
                Emp.SETRANGE("ID Number", "ID Number");
                IF Emp.FIND('-') THEN BEGIN
                    MESSAGE('The Applicant has worked for the company before');
                    "Previous Employee" := TRUE;
                END;
            end;

        }
        field(19; Gender; Option)
        {
            OptionMembers = " ",Male,Female;
            DataClassification = CustomerContent;
            Caption = 'Gender';
        }
        field(20; "Country Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Country Code';
            TableRelation = "Country/Region";
        }
        field(21; Status; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;

        }
        field(22; Comment; Boolean)
        {

            FieldClass = FlowField;
            CalcFormula = Exist ("HR Human Resource Comments" WHERE("Table Name" = CONST(Employee), "No." = FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
        }
        field(23; "Fax Number"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Fax Number';
        }
        field(24; "Marital Status"; Option)
        {
            OptionMembers = ,Single,Married,Separated,Divorced,"Widow(er)",Other;
            DataClassification = CustomerContent;
            Caption = 'Marital Status';
        }
        field(25; "Ethnic Origin"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Ethnic Origin';
            TableRelation = "Ethnic Groups";
        }
        field(26; "Driving Licence"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Driving Licence';
        }
        field(27; Disabled; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Disabled';
        }
        field(28; "Health Assesment"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Health Assesment';
        }
        field(29; "Health Assesment Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Health Assesment Date';
        }
        field(30; "Date Of Birth"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Of Birth';


            trigger OnValidate()
            var
                DatesMgmt: Codeunit "Dates Management";
            begin
                Age := DatesMgmt.DetermineAge("Date Of Birth", TODAY);
            end;
        }
        field(31; Age; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Age';
            Editable = false;

        }
        field(33; "Primary Skills Category"; Option)
        {
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
            DataClassification = CustomerContent;
            Caption = 'Primary Skills Category';
        }
        field(34; "Postal Address2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal Address2';

        }
        field(35; "Postal Address3"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal Address3';
        }
        field(36; "Residential Address2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Residential Address2';
        }
        field(37; "Residential Address3"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Residential Address3';
        }
        field(38; "Post Code2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Code2';
            TableRelation = "Post Code";
        }
        field(39; Citizenship; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Citizenship';
            TableRelation = "Country/Region".Code;
        }
        field(40; "Disability Details"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Disability Details';
        }
        field(41; "Disability Grade"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Disability Grade';
        }
        field(42; "Passport Number"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Passport Number';
        }
        field(43; "2nd Skills Category"; Option)
        {
            OptionMembers = ,Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
            DataClassification = CustomerContent;
            Caption = '2nd Skills Category';
        }
        field(44; "3rd Skills Category"; Option)
        {
            OptionMembers = ,Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
            DataClassification = CustomerContent;
            Caption = '3rd Skills Category';
        }
        field(45; Region; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Region';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(46; "PIN Number"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'PIN Number';
        }
        field(47; Employ; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Employ';
        }
        field(48; "No. Series"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'No. Series';
        }
        field(49; "Employee No"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Employee No';
            TableRelation = Employee;
        }
        field(50; "Applicant Type"; Option)
        {
            OptionMembers = External,Internal;
            DataClassification = CustomerContent;
            Caption = 'Applicant Type';
            Editable = true;
        }
        field(51; DateEmployed; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'DateEmployed';
        }
        field(52; "Previous Employee"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Previous Employee';
        }

        field(71; "Voter ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Voter ID';
        }
        field(72; Nationality; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Nationality';
            TableRelation = "Country/Region".Code;
        }
        field(73; "Place of Domicile"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Place of Domicile';
            TableRelation = "Country/Region".Code;
        }
        field(50000; "Highest Level Education"; Option)
        {
            OptionMembers = " ",PhD,"Masters Degree","Bachelors Degree","Higher/Advance Diploma",Cerificate,"High School","Primary School","No Education";
            DataClassification = CustomerContent;
            Caption = 'Highest Level Education';
        }
        field(50001; "Job ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Job ID';
            TableRelation = if ("Job Function" = filter("AIC Job")) "Recruitment Needs"."No." WHERE(Status = FILTER(Released), "Dept Requisition Type" = filter("AIC Emp"))
            else
            if ("Job Function" = filter("Normal Job")) "Recruitment Needs"."No." WHERE(Status = FILTER(Released), "Dept Requisition Type" = filter("Normal Employment"));

            trigger OnValidate()

            begin
                IF Needs.GET("Job ID") THEN
                    "Job Applied for" := Needs."Job ID";
                "Job Applied for Description" := Needs.Description;
            end;
        }
        field(50002; Submitted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Submitted';
        }
        field(50003; Shortlist; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Shortlist';
        }
        field(50004; "Date of Interview"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of Interview';
        }
        field(50005; "Interview Start Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Interview Start Time';
        }
        field(50006; "Interview End Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Interview End Time';
        }
        field(50007; Venue; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Venue';
        }
        field(50008; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Application Date';
        }
        field(50009; "Job Applied for"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Applied for';
            Editable = false;
            TableRelation = "Recruitment Needs"."Job ID" WHERE("No." = FIELD("Job ID"));
        }
        field(50010; Qualified; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Qualified';
        }
        field(50011; "Interview Invitation Sent"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Interview Invitation Sent';
        }
        field(50012; "Job Applied for Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Applied for Description';
            Editable = false;
        }
        field(50013; "Interview Type"; Option)
        {
            Caption = 'Interview Type';
            DataClassification = CustomerContent;
            OptionMembers = ,"Oral Interview","Technical Interview";
        }
        field(50014; "Employment Type"; Option)
        {
            OptionMembers = ,Permanent,Temporary,Voluntary,Intern,Casual;
            DataClassification = CustomerContent;
            Caption = 'Employment Type';
        }
        field(50016; "Oral Interview Total Score"; Decimal)
        {
            Caption = 'Oral Interview Total Score';
            FieldClass = FlowField;
            CalcFormula = Average ("Applicant Interview Lines".Score WHERE("Applicant ID" = FIELD("No."), "Interview Type" = FILTER("Oral Interview"), Submitted = CONST(true)));
        }
        field(50021; "Tech Interview Total Score"; Decimal)
        {
            Caption = 'Tech Interview Total Score';
            FieldClass = FlowField;
            CalcFormula = Average ("Applicant Interview Lines".Score WHERE("Applicant ID" = FIELD("No."), "Interview Type" = FILTER("Technical Interview"), Submitted = CONST(true)));
        }
        field(50017; "Passed Oral Interview"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Passed Oral Interview';
        }
        field(50018; "Offer Letter of Appointment"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Offer Letter of Appointment';
        }
        field(50019; "Offer Letter Accepted"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Offer Letter Accepted';
        }
        field(50022; "Shortlisting Total Score"; Decimal)
        {
            //DataClassification = CustomerContent;
            Caption = 'Shortlisting Total Score';
            FieldClass = FlowField;
            CalcFormula = Average ("Applicant Shortlisting Lines".Score WHERE("Applicant ID" = FIELD("No."), Submitted = CONST(true)));
        }
        field(50023; "Job Function"; Option)
        {
            OptionMembers = "Normal Job","AIC Job";

        }
        field(50024; "Application Time"; Time)
        {

        }
        field(50025; "Submitted Date"; Date)
        {

        }
        field(50026; "Submitted Time"; Time)
        {

        }
        field(50027; "Resident Selection"; Boolean)
        {

        }
        field(50028; "Passed Tech Interview"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Passed Tech Interview';
        }
        field(50029; "Application fee Paid"; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Application fee Paid';
        }

        field(50030; "Farming Experience"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "No Experience","Less than 1 Year","1-3 Years","3-5 Years","More than 5 years";
        }
        field(50031; "Agri-Business Experience"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "No Experience","Less than 1 Year","1-3 Years","3-5 Years","More than 5 years";

        }
        field(50032; "Why to be part of Incubation?"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Why do you want to be part of PASS AIC Incubation?';

        }
        field(50033; "Buiness Skills Total Score"; Decimal)
        {

        }
        field(50034; "Technical Training Total Score"; Decimal)
        {

        }
        field(50035; "F2F Interview Total Score"; Decimal)
        {

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
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Needs: Record "Recruitment Needs";
        Emp: Record Employee;
        Applicant: Record "Job Applicants";
        EmpQualifications: Record "Employee Qualification";
        AppQualifications: Record "Applicants Qualification";

    trigger OnInsert()
    begin
        IF "No." = '' THEN BEGIN
            case "Job Function" of
                "Job Function"::"AIC Job":
                    begin
                        HumanResSetup.GET;
                        HumanResSetup.TESTFIELD(HumanResSetup."AIC Applicant Nos.");
                        NoSeriesMgt.InitSeries(HumanResSetup."AIC Applicant Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                    end;
                "Job Function"::"Normal Job":
                    begin
                        HumanResSetup.GET;
                        HumanResSetup.TESTFIELD(HumanResSetup."Applicants Nos.");
                        NoSeriesMgt.InitSeries(HumanResSetup."Applicants Nos.", xRec."No. Series", 0D, "No.", "No. Series");
                    end;
            end;

        END;
        "Application Date" := TODAY;
        "Application Time" := Time;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        Error('delete not allowed');
    end;

    trigger OnRename()
    begin

    end;

    procedure EmployApplicant(var Applicants: Record "Job Applicants"; var JobApplied: Code[30]; var Description: Text[100])
    var
        Employee: Record Employee;
    begin
        IF Applicants."Applicant Type" = Applicants."Applicant Type"::External THEN BEGIN
            ;
            Employee."No." := '';
            Employee."First Name" := Applicants."First Name";
            Employee."Middle Name" := Applicants."Middle Name";
            Employee."Last Name" := Applicants."Last Name";
            Employee.Initials := Applicants.Initials;
            Employee."Search Name" := Applicants."Search Name";
            Employee."Postal Address" := Applicants."Postal Address";
            Employee."Residential Address" := Applicants."Residential Address";
            Employee.City := Applicants.City;
            Employee."Post Code" := Applicants."Post Code";
            Employee.County := Applicants.County;
            Employee."Home Phone Number" := Applicants."Home Phone Number";
            Employee."Cellular Phone Number" := Applicants."Cellular Phone Number";
            Employee."Work Phone Number" := Applicants."Work Phone Number";
            Employee."Ext." := Applicants."Ext.";
            Employee."E-Mail" := Applicants."E-Mail";
            Employee."ID Number" := Applicants."ID Number";
            Employee.Gender := Applicants.Gender;
            Employee."Country/Region Code" := Applicants."Country Code";
            Employee."Fax Number" := Applicants."Fax Number";
            Employee."Marital Status" := Applicants."Marital Status";
            Employee."Driving Licence" := Applicants."Driving Licence";
            Employee."Date Of Birth" := Applicants."Date Of Birth";
            Employee.Age := Applicants.Age;
            Employee."Postal Address2" := Applicants."Postal Address2";
            Employee."Postal Address3" := Applicants."Postal Address3";
            Employee."Residential Address2" := Applicants."Residential Address2";
            Employee."Residential Address3" := Applicants."Residential Address3";
            Employee."Post Code2" := Applicants."Post Code2";
            Employee.Citizenship := Applicants.Citizenship;
            Employee."Passport Number" := Applicants."Passport Number";
            Employee."PIN Number" := Applicants."PIN Number";
            Employee.Position := "Job Applied for";
            //Employee."Global Dimension 1 Code":=JobApplied;
            Employee."Job Title" := "Job Applied for Description";
            Employee."Country/Region Code" := Applicants."Country Code";
            Employee.INSERT(TRUE);

            Applicants.Employ := TRUE;
            Applicants.MODIFY;

            AppQualifications.RESET;
            AppQualifications.SETRANGE(AppQualifications."Applicant No.", "No.");
            IF AppQualifications.FIND('-') THEN BEGIN
                REPEAT
                    EmpQualifications.INIT;
                    EmpQualifications."Employee No." := Employee."No.";
                    EmpQualifications."Line No." := EmpQualifications."Line No." + 10000;
                    EmpQualifications."Qualification Type" := AppQualifications."Qualification Type";
                    EmpQualifications."Qualification Code" := AppQualifications."Qualification Code";
                    EmpQualifications."From Date" := AppQualifications."From Date";

                    EmpQualifications."To Date" := AppQualifications."To Date";
                    EmpQualifications.Type := AppQualifications.Type;
                    EmpQualifications.Description := AppQualifications.Description;
                    EmpQualifications."Institution/Company" := AppQualifications."Institution/Company";
                    //EmpQualifications.CourseType:=AppQualifications.Qualification;
                    EmpQualifications."Score ID" := AppQualifications."Score ID";
                    EmpQualifications.Comment := AppQualifications.Comment;
                    EmpQualifications.VALIDATE(EmpQualifications."Qualification Code");

                    EmpQualifications.INSERT;

                UNTIL AppQualifications.NEXT = 0
            END;
            //END;
            //IF Employee.INSERT=TRUE THEN BEGIN
            MESSAGE('Employee Number %1 Successfully Created', Employee."No.");
            // END;
        END ELSE BEGIN
            MESSAGE('Sorry!, %1 Is Already A Staff', Applicants."Middle Name");
        END;
        ;

    end;
}