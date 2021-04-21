table 51513388 "Job Exit Interview"
{
    // version HR

    DrillDownPageID = "Job Exit Interview List";
    LookupPageID = "Job Exit Interview List";
    Caption = 'Job Exit Interview';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No."; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;
        }
        field(3; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; Position; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Supervisor; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Date of Join"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Termination Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Reason for Leaving"; Text[150])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Exit Reason";
        }
        field(9; "Job Satisfying areas"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Job Frustrating Areas"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Complicated Company Policies"; Text[250])
        {
            Caption = '<Complicated Company Policies/Procedures>';
            DataClassification = ToBeClassified;
        }
        field(12; "Future Re-Employment"; Boolean)
        {
            Caption = 'Available for future Re-employment?';
            DataClassification = ToBeClassified;
        }
        field(13; "Recommend To Others"; Boolean)
        {
            Caption = 'Would you recommend CMA to Others?';
            DataClassification = ToBeClassified;
        }
        field(14; "Leaving could have prevented"; Boolean)
        {
            Caption = 'Leaving could have been prevented';
            DataClassification = ToBeClassified;
        }
        field(15; "Preventive Measure Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Other Helpful  Information"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(18; "Document Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "User Id"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(20; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Sent';
            OptionMembers = Open,Sent;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if (Code = '') then begin
            HumanResourcesSetupRec.GET;
            HumanResourcesSetupRec.TESTFIELD(HumanResourcesSetupRec."Exit Interview Nos.");
            //NoSeriesMgt.InitSeries(HumanResourcesSetupRec."Exit Interview Nos.", xRec."No. Series", 0D, Code, "No. Series");
        end;

        "User Id" := USERID;
        "Document Date" := TODAY;
        if UserSetupRec.GET(USERID) then begin
            if EmployeeRec.GET(UserSetupRec."Employee No.") then begin
                "Employee No." := EmployeeRec."No.";
                "Employee Name" := EmployeeRec."Last Name" + ' ' + EmployeeRec."First Name";//+EmployeeRec."Middle Name";
                "Date of Join" := EmployeeRec."Date Of Join";
                Position := EmployeeRec."Job Title";
            end;
        end;

        //Populate employee experience lines
        EmploymentExperienceRatingRec.RESET;
        EmploymentExperienceRatingRec.SETRANGE("Work Experienc Rating", true);
        if EmploymentExperienceRatingRec.FINDFIRST then
            repeat
                EmployeeExperienceRatingRec.INIT;
                EmployeeExperienceRatingRec."Exit Interview Code" := Code;
                EmployeeExperienceRatingRec."Line No." := EmployeeExperienceRatingRec."Line No." + 10000;
                EmployeeExperienceRatingRec.Description := EmploymentExperienceRatingRec.Description;
                EmployeeExperienceRatingRec.INSERT;

            until EmploymentExperienceRatingRec.NEXT = 0;


        EmploymentExperienceRatingRec.RESET;
        EmploymentExperienceRatingRec.SETRANGE("Supervisor Rating", true);
        if EmploymentExperienceRatingRec.FINDFIRST then
            repeat
                SupervisorExperienceRatingRec.INIT;
                SupervisorExperienceRatingRec."Exit Interview Code" := Code;
                SupervisorExperienceRatingRec."Line No." := SupervisorExperienceRatingRec."Line No." + 10000;
                SupervisorExperienceRatingRec.Description := EmploymentExperienceRatingRec.Description;
                SupervisorExperienceRatingRec.INSERT;

            until EmploymentExperienceRatingRec.NEXT = 0;
    end;

    var
        HumanResourcesSetupRec: Record "Human Resources Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetupRec: Record "User Setup";
        EmployeeRec: Record Employee;
        EmployeeExperienceRatingRec: Record "Employee Experience Rating";
        EmploymentExperienceRatingRec: Record "Employment Experience Rating";
        SupervisorExperienceRatingRec: Record "Supervisor Experience Rating";
        LineNo: Integer;
}

