tableextension 51513247 "Employee Extension" extends Employee
{
    fields
    {
        field(50094; "Home Phone Number"; Text[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Home Phone Number';
        }
        field(50095; "Cellular Phone Number"; Text[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Cellular Phone Number';
        }
        field(50096; "Work Phone Number"; Text[15])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Phone Number';
        }
        field(50097; "Ext."; Text[7])
        {
            DataClassification = CustomerContent;
            Caption = 'Ext.';
        }
        field(50098; "ID Number"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'ID Number';
            NotBlank = true;

            trigger onValidate()

            begin
                EmployeeRec.RESET;
                EmployeeRec.SETRANGE(EmployeeRec."ID Number", "ID Number");
                IF EmployeeRec.FIND('-') THEN
                    ERROR('You have already created an employee with ID Number %1 in Employee No %2', "ID Number", EmployeeRec."No.");

            end;


        }
        field(50100; "Fax Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Fax Number';
        }
        field(50105; "Position"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Position';
            NotBlank = true;
            TableRelation = "Company Jobs";


            trigger OnValidate()

            begin
                IF CompanyJobsRec.GET(Position) THEN begin
                    "Job Title" := CompanyJobsRec."Job Description";
                    //"Salary Scale":=CompanyJobsRec.Grade;
                    "Notice Period" := CompanyJobsRec."Notice Period";
                end;

            end;


        }
        field(50110; "Marital Status"; Option)
        {
            OptionMembers = ,Single,Married,Separated,Divorced,"Widow(er)",Other;
            DataClassification = ToBeClassified;
            Caption = 'Marital Status';
        }
        field(50113; "Driving Licence"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Driving Licence';
        }

        field(50114; "Date Of Birth"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Of Birth';

            trigger Onvalidate()

            begin
                HumanResSetup.GET;
                "Retirement Date" := CALCDATE(HumanResSetup."Retirement Age", "Date Of Birth");
            end;
        }
        field(50115; Age; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Age';
        }
        field(50129; Citizenship; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Citizenship';
        }
        field(50130; "Passport Number"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Passport Number';
        }
        field(50137; "PIN Number"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'PIN Number';
        }
        field(50238; "Voter ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Voter ID';
        }
        field(50109; "Notice Period"; DateFormula)
        {
        }
        field(50153; "Postal Address"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal Address"';
        }
        field(50154; "Residential Address"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Residential Address';
        }
        field(50155; "Postal Address2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal Address2';
        }
        field(50156; "Postal Address3"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal Address3';
        }
        field(50157; "Residential Address2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Residential Address2';
        }
        field(50158; "Residential Address3"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Residential Address3';
        }
        field(50159; "Post Code2"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Postal Code2';
            TableRelation = "Post Code";
        }
        field(50198; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50230; "Name of Spouse"; Text[50])
        {
            Caption = 'Name of Spouse';
            DataClassification = CustomerContent;

        }
        field(50229; "Spouse Date of Birth"; Date)
        {
            Caption = 'Spouse Birthdate';
            DataClassification = CustomerContent;
        }
        field(50227; "Marriage Date"; Date)
        {

        }
        field(50228; "Marriage Certificate Attached"; Boolean)
        {
            Caption = 'Marriage Certificate Attached';
            DataClassification = CustomerContent;
        }


    }

    var
        EmployeeRec: Record Employee;
        HumanResSetup: Record "Human Resources Setup";
        CompanyJobsRec: Record "Company Jobs";
}