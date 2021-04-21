table 51513241 "Employee Appraisal Objectives"
{
    // version HR

    //DrillDownPageID = "Employee Absence Card";
    //LookupPageID = "Employee Absence Card";
    DataClassification = CustomerContent;
    Caption = 'Employee Appraisal Objectives';
    fields
    {
        field(1; "Employee No"; Code[20])
        {
            NotBlank = false;
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                IF Employee.GET("Employee No") THEN
                    "Job ID" := Employee.Position;


            end;
        }
        field(2; "Appraisal Category"; Code[20])
        {
            TableRelation = "Appraisal Types".Code;
        }
        field(3; "Appraisal Period"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Appraisal Periods";

            trigger OnValidate();
            begin
                EmpAppraisal.RESET;
                EmpAppraisal.SETRANGE(EmpAppraisal."Employee No", "Employee No");
                EmpAppraisal.SETRANGE(EmpAppraisal."Appraisal Period", "Appraisal Period");
                IF EmpAppraisal.FIND('-') THEN
                    ERROR('You have already setup objectives for %1 on %2', EmpAppraisal."Appraisal Period", EmpAppraisal.Date);

                /*
                                AppraisalFormat.RESET;
                                AppraisalFormat.SETRANGE(AppraisalFormat."Appraisal Code", "Appraisal Category");
                                // AppraisalFormat.SETRANGE(AppraisalFormat."Appraisal Heading Type",AppraisalFormat."Appraisal Heading Type"::Objectives);
                                IF AppraisalFormat.FIND('-') THEN
                                    REPEAT
                                        AppraisalLines.INIT;
                                        AppraisalLines."Appraisal No" := "Objective No";
                                        AppraisalLines."Employee No" := "Employee No";
                                        // AppraisalLines."No.":=AppraisalFormat."Line No.";
                                        AppraisalLines."Appraisal Type" := "Appraisal Category";
                                        AppraisalLines."Appraisal Period" := "Appraisal Period";
                                        // AppraisalLines.Objective:=;
                                        // AppraisalLines.Measure:=;
                                        AppraisalLines."Weighting(%)" := AppraisalFormat."Weighting(%)";
                                        AppraisalLines.Description := AppraisalFormat.Value;
                                        AppraisalLines."Line No" := AppraisalLines."Line No" + 1000;
                                        AppraisalLines."Appraisal Heading Type" := AppraisalFormat."Appraisal Heading Type";
                                        AppraisalLines."Strategic Perspective" := AppraisalFormat."Strategic Perspective";
                                        // MESSAGE('PERSPECTIVE=%1',AppraisalFormat."Strategic Perspective");
                                        AppraisalLines."Appraisal Header" := AppraisalFormat."Appraisal Header";
                                        AppraisalLines.Bold := AppraisalFormat.Bold;
                                        IF NOT AppraisalLines.GET(AppraisalLines."Appraisal No", AppraisalLines."Line No") THEN
                                            AppraisalLines.INSERT;


                                    UNTIL AppraisalFormat.NEXT = 0;
                */

            end;
        }
        field(4; "No. Supervised (Directly)"; Integer)
        {
        }
        field(5; "No. Supervised (In-Directly)"; Integer)
        {
        }
        field(6; "Job ID"; Code[20])
        {
            TableRelation = "Company Jobs"."Job ID";

        }
        field(7; "Agreement With Rating"; Option)
        {
            OptionMembers = Entirely,Mostly,"To some extent","Not at all";
        }
        field(8; "General Comments"; Text[250])
        {
        }
        field(9; Date; Date)
        {
        }
        field(10; Rating; Code[10])
        {
            TableRelation = "Appraisal Grades";

            trigger OnValidate();
            begin
                if AppraisalGrades.GET(Rating) then
                    "Rating Description" := AppraisalGrades.Description;
            end;
        }
        field(11; "Rating Description"; Text[150])
        {
        }
        field(12; "Appraiser No"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate();
            begin
                if Employee.GET("Appraiser No") then
                    "Appraisers Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(13; "Appraisers Name"; Text[50])
        {
        }
        field(14; "Appraisee ID"; Code[30])
        {
        }
        field(15; "Appraiser ID"; Code[30])
        {
        }
        field(16; "Appraisee Name"; Text[50])
        {
        }
        field(17; "Job Group"; Code[10])
        {
        }
        field(18; "Appraiser's Job Title"; Text[100])
        {
        }
        field(19; "Appraisee's Job Title"; Text[100])
        {
        }
        field(20; "Objective No"; Code[20])
        {
        }
        field(21; "No. series"; Code[10])
        {
        }
        field(27; Status; Option)
        {
            Editable = false;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment";
        }
        field(28; "Workstation Code"; Code[20])
        {
        }
        field(29; "Department Code"; Code[20])
        {
        }
        field(30; "Workstation Name"; Text[50])
        {
            CalcFormula = Lookup ("Dimension Value".Name WHERE (Code = FIELD ("Workstation Code")));
            FieldClass = FlowField;
        }
        field(31; "Department Name"; Text[50])
        {
            CalcFormula = Lookup ("Dimension Value".Name WHERE (Code = FIELD ("Department Code")));
            FieldClass = FlowField;
        }
        field(32; "No. of Approvers"; Integer)
        {
            CalcFormula = Count ("Approval Entry" WHERE ("Document No." = FIELD ("Objective No")));
            FieldClass = FlowField;
        }
        field(33; "Contract type"; Code[20])
        {
            //CalcFormula = Lookup (Employee. WHERE ("No." = FIELD ("Employee No")));
            FieldClass = FlowField;
        }
        field(34; "Supervisor's Name"; Text[100])
        {
        }
        field(35; "Supervisor's Designation"; Text[100])
        {
        }
        field(36; "Appraisal End Date"; Date)
        {
            CalcFormula = Lookup ("Full Year Appraisal Periods"."End Date" WHERE (Period = FIELD ("Appraisal Period")));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Objective No")
        {
        }
        key(Key2; "Employee No", "Appraisal Category", "Appraisal Period")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete();
    begin
        Error('Not Allowed');
        if Status <> Status::Open then
            ERROR('You cannot delete a document that is already approved or pending approval');
    end;

    trigger OnInsert();
    begin

        IF "Objective No" = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD(HumanResSetup."Appraisal Objective Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Appraisal Objective Nos", xRec."No. series", 0D, "Objective No", "No. series");
        END;

        Date := TODAY;

        ApraisalPeriods.RESET;
        ApraisalPeriods.SetFilter(ApraisalPeriods."End Date", '<>%!', 0D);
        IF ApraisalPeriods.FIND('-') THEN BEGIN
            REPEAT
                IF (ApraisalPeriods."Start Date" <= Date) AND (ApraisalPeriods."End Date" >= Date) THEN
                    "Appraisal Period" := ApraisalPeriods.Period;
                // Message('%1\%2\%3',Date,"Appraisal Period",ApraisalPeriods.Period);
            UNTIL ApraisalPeriods.NEXT = 0;
        END;



        IF UserSetup.GET(USERID) THEN BEGIN

            "Appraisee ID" := UserSetup."User ID";
            "Appraiser ID" := UserSetup."Immediate Supervisor";
            IF Employee.GET(UserSetup."Employee No.") THEN BEGIN
                "Employee No" := Employee."No.";
                "Appraisee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                "Job Group" := Employee."Salary Scale";
                "Job ID" := Employee.Position;
                "Appraisee's Job Title" := Employee."Job Title";
                "Workstation Code" := Employee."Global Dimension 2 Code";
                "Department Code" := Employee."Global Dimension 1 Code";


                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue."Dimension Code", 'DEPARTMENT');
                DimensionValue.SETRANGE(DimensionValue.Code, "Department Code");
                IF DimensionValue.FIND('-') THEN
                    "Department Name" := DimensionValue.Name;


                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue."Dimension Code", 'WORKSTATION');
                DimensionValue.SETRANGE(DimensionValue.Code, "Workstation Code");
                IF DimensionValue.FIND('-') THEN
                    "Workstation Name" := DimensionValue.Name;

                AppraisalType.RESET;
                IF AppraisalType.FIND('-') THEN
                    REPEAT
                        IF ((Employee."Salary Scale" >= AppraisalType."Minimum Job Group") AND (Employee."Salary Scale" <= AppraisalType."Maximum Job Group"
                        )) THEN BEGIN
                            "Appraisal Category" := AppraisalType.Code;
                            VALIDATE("Appraisal Category");
                        END;
                    UNTIL AppraisalType.NEXT = 0;

            END;

            IF UserSetupSup.GET(UserSetup."Immediate Supervisor") THEN
                IF Employee.GET(UserSetupSup."Employee No.") THEN BEGIN
                    "Appraiser No" := Employee."No.";
                    "Appraisers Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Appraiser's Job Title" := Employee."Job Title";
                END;

        END;

        // VALIDATE("Appraisal Period");
        //Message('added')


    end;

    trigger OnModify();
    begin
        IF Status <> Status::Open THEN
            ERROR('You cannot modify a document that is already approved or pending approval');
    end;

    var
        Employee: Record Employee;
        AppraisalGrades: Record "Appraisal Grades";
        AppraisalLines: Record "Appraisal Objectives Lines";
        AppraisalFormat: Record "Appraisal Formats";
        UserSetup: Record "User Setup";
        UserSetupSup: Record "User Setup";
        AppraisalType: Record "Appraisal Types";
        //CompanyJobs: Record "Commitment Entries";
        HRsetup: Record "Human Resources Setup";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpAppraisal: Record "Employee Appraisal Objectives";
        ApraisalPeriods: Record "Full Year Appraisal Periods";
        DimensionValue: Record "Dimension Value";

}

