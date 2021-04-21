table 51513219 "Employee Appraisals"
{
    // version HR

    //DrillDownPageID = "Employee Appraisals List";
    // LookupPageID = "Employee Linked Docs";
    Caption = 'Employee Appraisals';
    DataClassification = CustomerContent;
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
                AppraisalFormat.RESET;
                AppraisalFormat.SETRANGE(AppraisalFormat."Employee No", "Employee No");
                AppraisalFormat.SETRANGE(AppraisalFormat."Appraisal Period", "Appraisal Period");
                AppraisalFormat.SETRANGE(AppraisalFormat.Approved, true);
                //AppraisalFormat.SETFILTER(AppraisalFormat."Appraisal Heading Type",'<>%1',AppraisalFormat."Appraisal Heading Type"::Objectives);
                if AppraisalFormat.FIND('-') then
                    repeat

                        AppraisalLines.INIT;
                        AppraisalLines."Appraisal No" := "Appraisal No";
                        AppraisalLines."Employee No" := "Employee No";
                        AppraisalLines."Appraisal Category" := "Appraisal Category";
                        AppraisalLines."Appraisal Period" := "Appraisal Period";
                        AppraisalLines."Appraisal Year" := "Appraisal Year";
                        AppraisalLines.Objective := AppraisalFormat.Objective;
                        AppraisalLines.Measure := AppraisalFormat.Measure;
                        AppraisalLines."Weighting(%)" := AppraisalFormat."Weighting(%)";
                        AppraisalLines."Line No" := AppraisalLines."Line No" + 1000;
                        AppraisalLines."Appraisal Heading Type" := AppraisalFormat."Appraisal Heading Type";
                        AppraisalLines.VALIDATE(AppraisalLines."Appraisal Heading Type");
                        AppraisalLines."Appraisal Header" := AppraisalFormat."Appraisal Header";
                        AppraisalLines."Strategic Perspective" := AppraisalFormat."Strategic Perspective";
                        AppraisalLines.Bold := AppraisalFormat.Bold;
                        if not AppraisalLines.GET(AppraisalLines."Appraisal No", AppraisalLines."Line No") then
                            AppraisalLines.INSERT;

                        ObjectiveMeasures.RESET;
                        ObjectiveMeasures.SETRANGE(ObjectiveMeasures."Appraisal No", AppraisalFormat."Appraisal No");
                        ObjectiveMeasures.SETRANGE(ObjectiveMeasures.ObjectiveID, AppraisalFormat."Line No");
                        if ObjectiveMeasures.FIND('-') then
                            repeat
                                ObjectivePerformanceMeasures.INIT;
                                ObjectivePerformanceMeasures.MeasureID:=ObjectivePerformanceMeasures.MeasureID+1000;
                                ObjectivePerformanceMeasures.ObjectiveID := AppraisalLines."Line No";
                                ObjectivePerformanceMeasures."Appraisal No" := "Appraisal No";
                                ObjectivePerformanceMeasures."Measure Description" := ObjectiveMeasures."Measure Description";
                                ObjectivePerformanceMeasures."Weighting(%)" := ObjectiveMeasures."Weighting(%)";
                                ObjectivePerformanceMeasures.Approved:=ObjectiveMeasures.Approved;
                                ObjectivePerformanceMeasures.Targets:=ObjectiveMeasures.Targets;
                                ObjectivePerformanceMeasures."Five-Year Targets":=ObjectiveMeasures."Five-Year Targets";
                                ObjectivePerformanceMeasures."Appraisal Period Target":=ObjectiveMeasures."Appraisal Period Target";
                                ObjectivePerformanceMeasures.Initiatives:=ObjectiveMeasures.Initiatives;
                                ObjectivePerformanceMeasures."Appraisal Period Actuals":=ObjectiveMeasures."Appraisal Period Actuals";
                                ObjectivePerformanceMeasures.INSERT;
                            until ObjectiveMeasures.NEXT = 0;


                    until AppraisalFormat.NEXT = 0;
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
            TableRelation = "Appraisal Grades".Grade;

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
        field(20; "Appraisal No"; Code[20])
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
        field(28; "Deapartment Code"; Code[20])
        {
        }
        field(29; "Appraisal Type"; Text[120])
        {
            TableRelation = "Appraisal Category"."Appraissal Category";
        }
        field(30; "Wizard Step"; Option)
        {
            OptionMembers = ,"1","2";
        }
        field(31; "FP Weighting"; Decimal)
        {
            CalcFormula = Sum ("Appraisal Lines"."Weighting(%)" WHERE ("Appraisal No" = FIELD ("Appraisal No"), "Strategic Perspective" = filter (Financial)));
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                /*HumanResSetup.GET;
                CALCFIELDS("TC Weighted Ratings") ;
                "TC Overall Score":=HumanResSetup."Technical Competence Overall %"*("TC Weighted Ratings"/100);
                */

            end;
        }
        field(32; "FP  Weighted Ratings"; Decimal)
        {
            CalcFormula = Sum ("Appraisal Lines"."Weighted Ratings(%)" WHERE ("Appraisal No" = FIELD ("Appraisal No"),
                                                                                       "Strategic Perspective" = filter (Financial)));
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                /*HumanResSetup.GET;
                CALCFIELDS("BC Weighted Ratings") ;
                "BC Overall Score":=HumanResSetup."Behaviour Competence Overall %"*("BC Weighted Ratings"/100);
                */

            end;
        }
        field(33; "TC Overall Score"; Decimal)
        {
        }
        field(34; "BC Overall Score"; Decimal)
        {
        }
        field(35; "Appraisal Year"; Code[20])
        {
        }
        field(36; "Department Name"; Text[50])
        {
        }
        field(37; "Directorate Code"; Code[20])
        {
        }
        field(38; "Directorate Name"; Text[50])
        {
        }
        field(39; "Predefined Objectives"; Code[50])
        {
            TableRelation = "Employee Appraisal Objectives" WHERE ("Employee No" = FIELD ("Employee No"),
                                                                   "Appraisal Period" = FIELD ("Appraisal Period"));

            trigger OnValidate();
            begin
                EmpObjective.RESET;
                EmpObjective.SETRANGE("Objective No", "Predefined Objectives");
                if EmpObjective.FIND('-') then begin

                    AppraisalFormat.RESET;
                    AppraisalFormat.SETRANGE("Appraisal No", EmpObjective."Objective No");
                    if AppraisalFormat.FIND('-') then begin
                        repeat

                            AppraisalLines1.INIT;
                            AppraisalLines1."Appraisal No" := "Appraisal No";
                            AppraisalLines1."Line No" := AppraisalFormat."Line No";
                            AppraisalLines1."Employee No" := AppraisalFormat."Employee No";
                            AppraisalLines1."Appraisal Period" := AppraisalFormat."Appraisal Period";
                            AppraisalLines1.Objective := AppraisalFormat.Objective;
                            AppraisalLines1."Agreed Target Date" := AppraisalFormat."Agreed Target Date";
                            AppraisalLines1."Review Comments/ Achievements" := AppraisalFormat."Review Comments/ Achievements";
                            AppraisalLines1."Appraisal Heading Type" := AppraisalFormat."Appraisal Heading Type";
                            AppraisalLines1."Resources Required" := AppraisalFormat."Resources Required";
                            if not AppraisalLines1.GET(AppraisalLines1."Appraisal No", AppraisalLines1."Line No") then
                                AppraisalLines1.INSERT(true)
                            else
                                AppraisalLines1.MODIFY(true);

                        until AppraisalFormat.NEXT = 0;
                    end;

                    //Core Competency/Skills
                    CoreSkillsSetup.RESET;
                    if CoreSkillsSetup.FIND('-') then begin
                        repeat

                            CoreSkillsEmp.INIT;
                            CoreSkillsEmp."Employee No" := "Employee No";
                            CoreSkillsEmp."Competency Code" := CoreSkillsSetup."Competency Code";
                            CoreSkillsEmp.Competencies := CoreSkillsSetup.Competencies;
                            CoreSkillsEmp.Description := CoreSkillsSetup.Description;
                            CoreSkillsEmp.Type := CoreSkillsSetup.Type;
                            if not CoreSkillsEmp.GET(CoreSkillsEmp."Employee No", CoreSkillsEmp."Competency Code") then
                                CoreSkillsEmp.INSERT(true)
                            else
                                CoreSkillsEmp.MODIFY(true);

                        until CoreSkillsSetup.NEXT = 0;
                    end;


                    //Appraisee Questions
                    AppraiseeSetup.RESET;
                    if AppraiseeSetup.FIND('-') then begin
                        repeat

                            AppraiseeEmp.INIT;
                            AppraiseeEmp."Employee No" := "Employee No";
                            AppraiseeEmp.Question := AppraiseeSetup.Question;
                            if not AppraiseeEmp.GET(AppraiseeEmp."Employee No", AppraiseeEmp.Question) then
                                AppraiseeEmp.INSERT(true)
                            else
                                AppraiseeEmp.MODIFY(true);

                        until AppraiseeSetup.NEXT = 0;
                    end;


                end;
            end;
        }
        field(40; "Performance Appraisal Ratings"; Decimal)
        {
            CalcFormula = Sum ("Appraisal Lines"."Super Performance  Ratings(%)" WHERE ("Appraisal No" = FIELD ("Appraisal No")));
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                /*HumanResSetup.GET;
                CALCFIELDS("BC Weighted Ratings") ;
                "BC Overall Score":=HumanResSetup."Behaviour Competence Overall %"*("BC Weighted Ratings"/100);
                */

            end;
        }
        field(41; "Mean Score/Appraisal Score %"; Decimal)
        {
        }
        field(42; "Appraisal Score for Previous y"; Decimal)
        {
        }
        field(43; "Performance Review"; Text[250])
        {
        }
        field(44; "Target Varied Mid Year"; Boolean)
        {
        }
        field(45; "If Varied Explain"; Text[250])
        {
        }
        field(46; "Second Supervisor Comment"; Text[250])
        {
        }
        field(47; "Months Bonus on Basic  Salary"; Boolean)
        {
        }
        field(48; "Recommendation Sanction - Poor"; Boolean)
        {
        }
        field(49; "Other Recommendations"; Text[250])
        {
        }
        field(50; "Recommendations to DG by HRM"; Text[250])
        {
        }
        field(51; "Comments by Authorized Officer"; Text[250])
        {
        }
        field(52; "Appraisee Training Need"; Text[250])
        {
        }
        field(53; "Stakeholder Weighting"; Decimal)
        {
            CalcFormula = Sum ("Appraisal Lines"."Weighting(%)" WHERE ("Appraisal No" = FIELD ("Appraisal No"), "Strategic Perspective" = filter (Stakeholder)));
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                /*HumanResSetup.GET;
                CALCFIELDS("TC Weighted Ratings") ;
                "TC Overall Score":=HumanResSetup."Technical Competence Overall %"*("TC Weighted Ratings"/100);
                */

            end;
        }
        field(54; "Stakeholder Weighted Ratings"; Decimal)
        {
            CalcFormula = Sum ("Appraisal Lines"."Weighted Ratings(%)" WHERE ("Appraisal No" = FIELD ("Appraisal No"),
                                                                                       "Strategic Perspective" = filter (Stakeholder)));
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                /*HumanResSetup.GET;
                CALCFIELDS("BC Weighted Ratings") ;
                "BC Overall Score":=HumanResSetup."Behaviour Competence Overall %"*("BC Weighted Ratings"/100);
                */

            end;
        }
        field(55; "IBP Weighting"; Decimal)
        {
            CalcFormula = Sum ("Appraisal Lines"."Weighting(%)" WHERE ("Appraisal No" = FIELD ("Appraisal No"), "Strategic Perspective" = filter ("Internal Business Process")));
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                /*HumanResSetup.GET;
                CALCFIELDS("TC Weighted Ratings") ;
                "TC Overall Score":=HumanResSetup."Technical Competence Overall %"*("TC Weighted Ratings"/100);
                */

            end;
        }
        field(56; "IBP Weighted Ratings"; Decimal)
        {
            CalcFormula = Sum ("Appraisal Lines"."Weighted Ratings(%)" WHERE ("Appraisal No" = FIELD ("Appraisal No"),
                                                                                       "Strategic Perspective" = filter ("Internal Business Process")));
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                /*HumanResSetup.GET;
                CALCFIELDS("BC Weighted Ratings") ;
                "BC Overall Score":=HumanResSetup."Behaviour Competence Overall %"*("BC Weighted Ratings"/100);
                */

            end;
        }
        field(58; "L&G Weighting"; Decimal)
        {
            CalcFormula = Sum ("Appraisal Lines"."Weighting(%)" WHERE ("Appraisal No" = FIELD ("Appraisal No"), "Strategic Perspective" = filter ("Learning and Growth")));
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                /*HumanResSetup.GET;
                CALCFIELDS("TC Weighted Ratings") ;
                "TC Overall Score":=HumanResSetup."Technical Competence Overall %"*("TC Weighted Ratings"/100);
                */

            end;
        }
        field(57; "L&G  Weighted Ratings"; Decimal)
        {
            CalcFormula = Sum ("Appraisal Lines"."Weighted Ratings(%)" WHERE ("Appraisal No" = FIELD ("Appraisal No"),
                                                                                       "Strategic Perspective" = filter ("Learning and Growth")));
            FieldClass = FlowField;

            trigger OnValidate();
            begin
                /*HumanResSetup.GET;
                CALCFIELDS("BC Weighted Ratings") ;
                "BC Overall Score":=HumanResSetup."Behaviour Competence Overall %"*("BC Weighted Ratings"/100);
                */

            end;
        }
    }

    keys
    {
        key(Key1; "Appraisal No")
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
        if Status <> Status::Open then
            ERROR('You cannot delete a document that is already approved or pending approval');
    end;

    trigger OnInsert();
    begin
        IF "Appraisal No" = '' THEN BEGIN
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD(HumanResSetup."Appraisal Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Appraisal Nos", xRec."No. series", 0D, "Appraisal No", "No. series");
        END;


        Date := TODAY;
        /*
         ApraisalPeriods.RESET;
        // ApraisalPeriods.SETRANGE(ApraisalPeriods."End Date",0D,);
         IF ApraisalPeriods.FIND('-') THEN BEGIN
         REPEAT
             IF (ApraisalPeriods."Start Date"<=Date) AND (ApraisalPeriods."End Date">=Date)THEN
               "Appraisal Period":=ApraisalPeriods.Period;
          UNTIL ApraisalPeriods.NEXT=0;
          END;
        */
        ApraisalYears.RESET;
        // ApraisalPeriods.SETRANGE(ApraisalPeriods."End Date",0D,);
        IF ApraisalYears.FIND('-') THEN BEGIN
            REPEAT
                IF (ApraisalYears."Start Date" <= Date) AND (ApraisalYears."End Date" >= Date) THEN
                    "Appraisal Year" := ApraisalYears.Period;
            UNTIL ApraisalYears.NEXT = 0;
        END;



        IF UserSetup.GET(USERID) THEN BEGIN

            "Appraisee ID" := UserSetup."User ID";
            "Appraiser ID" := UserSetup."Immediate Supervisor";
            IF Employee.GET(UserSetup."Employee No.") THEN BEGIN
                "Employee No" := Employee."No.";
                "Appraisee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                "Job Group" := Employee."Salary Scale";
                "Appraisee's Job Title" := Employee."Job Title";
                "Deapartment Code" := Employee."Global Dimension 2 Code";
                "Directorate Code" := Employee."Global Dimension 1 Code";


                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue."Dimension Code", 'DEPARTMENT');
                DimensionValue.SETRANGE(DimensionValue.Code, "Directorate Code");
                IF DimensionValue.FIND('-') THEN
                    "Directorate Name" := DimensionValue.Name;


                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue."Dimension Code", 'WORKSTATION');
                DimensionValue.SETRANGE(DimensionValue.Code, "Deapartment Code");
                IF DimensionValue.FIND('-') THEN
                    "Department Name" := DimensionValue.Name;

            END;

            AppraisalType.RESET;
            IF AppraisalType.FIND('-') THEN
                REPEAT
                    // IF ((Employee."Salary Scale">=AppraisalType."Minimum Job Group") AND (Employee."Salary Scale"<=AppraisalType."Maximum Job Group"
                    // )) THEN BEGIN
                    "Appraisal Category" := AppraisalType.Code;
                    VALIDATE("Appraisal Category");
                    // END;
                UNTIL AppraisalType.NEXT = 0;

            IF UserSetupSup.GET(UserSetup."Immediate Supervisor") THEN
                IF Employee.GET(UserSetupSup."Employee No.") THEN BEGIN
                    "Appraiser No" := Employee."No.";
                    "Appraisers Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Appraiser's Job Title" := Employee."Job Title";
                END;

        END;
        /*
        EmpAppraisal.RESET;
        EmpAppraisal.SETRANGE(EmpAppraisal."Employee No","Employee No");
        EmpAppraisal.SETRANGE(EmpAppraisal."Appraisal Category","Appraisal Category");
        EmpAppraisal.SETRANGE(EmpAppraisal."Appraisal Period","Appraisal Period");
        EmpAppraisal.SETRANGE(EmpAppraisal."Appraisal Type","Appraisal Type");
        IF EmpAppraisal.FIND('-') THEN
        ERROR('You have already created %1 appraisal for %2',"Appraisal Type","Appraisal Period");
        */


    end;

    trigger OnModify();
    begin
        /*HumanResSetup.GET;
         CALCFIELDS("TC Weighted Ratings") ;
         "TC Overall Score":=HumanResSetup."Technical Competence Overall %"*("TC Weighted Ratings"/100);
        
        
         HumanResSetup.GET;
         CALCFIELDS("BC Weighted Ratings") ;
         "BC Overall Score":=HumanResSetup."Behaviour Competence Overall %"*("BC Weighted Ratings"/100);
        */
        IF Status <> Status::Open THEN
            ERROR('You cannot modify a document that is already approved or pending approval');


    end;

    var
        Employee: Record Employee;
        AppraisalGrades: Record "Appraisal Grades";
        AppraisalLines: Record "Appraisal Lines";
        AppraisalFormat: Record "Appraisal Objectives Lines";
        UserSetup: Record "User Setup";
        UserSetupSup: Record "User Setup";
        AppraisalType: Record "Appraisal Types";
        //CompanyJobs: Record "Commitment Entries";
        HRsetup: Record "Human Resources Setup";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpAppraisal: Record "Employee Appraisals";
        ApraisalPeriods: Record "Appraisal Periods";
        ApraisalYears: Record "Full Year Appraisal Periods";
        DimensionValue: Record "Dimension Value";
        ObjectiveMeasures: Record "Objectives Measures";
        ObjectivePerformanceMeasures: Record "Objective Performance Measures";
        EmpObjective: Record "Employee Appraisal Objectives";
        AppraisalLines1: Record "Appraisal Lines";
        CoreSkillsSetup: Record "Competencies/Core Skills-Setup";
        CoreSkillsEmp: Record "Competencies/Core Skills";
        AppraiseeEmp: Record "Appraisee's Questions";
        AppraiseeSetup: Record "Appraisee's Questions-Setup";

    procedure StartWizard2();
    var
        InteractionTmplSetup: Record "Interaction Template Setup";
        Campaign: Record Campaign;
    begin
        //InteractionTmplSetup.GET;
        //InteractionTmplSetup.TESTFIELD(InteractionTmplSetup."Outg. Calls");

        //"Wizard Step" := "Wizard Step"::"0";
        /*
        IF Date = 0D THEN
          Date := TODAY;
        "Time of Interaction" := TIME;
        "Interaction Successful" := TRUE;
        "Dial Contact" := TRUE;
        
        IF Campaign.GET(GETFILTER("Campaign No.")) THEN
          "Campaign Description" := Campaign.Description;
        "Wizard Contact Name" := GetContactName;
         */
        INSERT;
        //VALIDATE("Interaction Template Code",InteractionTmplSetup."Outg. Calls");
        //FORM.RUNMODAL(FORM::"Make Phone Call",Rec,"Contact Via");

    end;

    procedure PerformNextWizardStatus2();
    var
        InteractTmpl: Record "Interaction Template";
    begin
        "Wizard Step" := "Wizard Step" + 1;
    end;

    procedure PerformPrevWizardStatus2();
    begin
        "Wizard Step" := "Wizard Step" - 1;
    end;

    procedure PerformPostStep2();
    begin
        /*
        CASE "Wizard Step" OF
          "Wizard Step"::"2":
        
            IF "Dial Contact" THEN BEGIN
              IF TAPIManagement.Dial("Contact Via") THEN
                "Dial Contact" := FALSE;
            END ELSE
              ERROR(Text010);
        
        END;
         */

    end;

    procedure CheckStatus2();
    var
        InteractTmpl: Record "Interaction Template";
        Attachment: Record Attachment;
        SalutationFormula: Record "Salutation Formula";
    begin
        /*
        IF "Wizard Step" = "Wizard Step"::"1" THEN BEGIN
          IF "Dial Contact" AND ("Contact Via" = '') THEN
            ERROR(Text013);
          IF Date = 0D THEN
            ErrorMessage(FIELDCAPTION(Date));
          IF Description = '' THEN
            ErrorMessage(FIELDCAPTION(Description));
          IF "Salesperson Code" = '' THEN
            ErrorMessage(FIELDCAPTION("Salesperson Code"));
        END;
        */

    end;

    procedure FinishWizard2(): Boolean;
    var
        SegManagement: Codeunit SegManagement;
        TempAttachment: Record Attachment temporary;
        SegLine: Record "Appraisee's Questions-Setup";
    begin
        //"Attempt Failed" := NOT "Interaction Successful";

        //SegManagement.LogInteraction(Rec,TempAttachment,InterLogEntryCommentLineTmp,FALSE,FALSE);
        /*
        IF SegLine.GET("Appraisal No") THEN BEGIN
          SegLine.LOCKTABLE;
        //  SegLine."Contact Via" := "Contact Via";
          SegLine."Wizard Step" := SegLine."Wizard Step"::" ";
          SegLine.MODIFY;
        END;
         */

    end;

    procedure StartWizard();
    var
        Opp: Record Opportunity;
    begin
        /*
         IF Campaign.GET("Campaign No.") THEN
          "Campaign Description" := Campaign.Description;
         IF Opp.GET("Opportunity No.") THEN
          "Opportunity Description" := Opp.Description;
          "Wizard Contact Name" := GetContactName;
        */
        //"Wizard Step" := "Wizard Step"::"0";
        /*
         "Interaction Successful" := TRUE;
         VALIDATE(Date,WORKDATE);
         INSERT;
         PAGE.RUNMODAL(PAGE::"Create Interaction",Rec,"Interaction Template Code");
        */

    end;

    procedure PerformNextWizardStatus();
    begin

        case "Wizard Step" of
        // "Wizard Step"::"0":
        // BEGIN
        //  InteractTmpl.GET("Interaction Template Code");
        // IF InteractTmpl."Wizard Action" <> InteractTmpl."Wizard Action"::" " THEN
        // "Wizard Step" := "Wizard Step"::"1";
        // END
        // ELSE

        //IF "Wizard Step" = "Wizard Step"::"2" THEN
        end;

        //"Wizard Step" := "Wizard Step" + 1;
    end;

    procedure PerformPrevWizardStatus();
    begin
        case "Wizard Step" of
            "Wizard Step"::"1":
                //  "Wizard Step" := "Wizard Step"::"0";
                //else
                "Wizard Step" := "Wizard Step" - 1;
        end;
    end;

    procedure CheckStatus();
    var
        InteractTmpl: Record "Interaction Template";
        Attachment: Record Attachment;
        SalutationFormula: Record "Salutation Formula";
    begin
        /*
        CASE "Wizard Step" OF
          "Wizard Step"::"1":
            BEGIN
              IF "Contact No." = '' THEN
                ERROR(Text006);
              IF "Interaction Template Code" = '' THEN
                ErrorMessage(FIELDCAPTION("Interaction Template Code"));
              IF"Salesperson Code" = '' THEN
                ErrorMessage(FIELDCAPTION("Salesperson Code"));
              IF Date = 0D THEN
                ErrorMessage(FIELDCAPTION(Date));
              IF Description = '' THEN
                ErrorMessage(FIELDCAPTION(Description));
        
              InteractTmpl.GET("Interaction Template Code");
              IF InteractTmpl."Wizard Action" = InteractTmpl."Wizard Action"::Open THEN
                IF "Attachment No." = 0 THEN
                  ErrorMessage(Attachment.TABLECAPTION);
        
              Cont.GET("Contact No.");
              SalutationFormula.GET(Cont."Salutation Code","Language Code",0);
              SalutationFormula.GET(Cont."Salutation Code","Language Code",1);
            END;
          "Wizard Step"::"2":;
          "Wizard Step"::"3":
            BEGIN
              IF AttachmentTemp.FIND('-') THEN
                AttachmentTemp.CALCFIELDS(Attachment);
              IF ("Correspondence Type" = "Correspondence Type"::"E-Mail") AND
                 ("Attachment No." = 0)
              THEN
                ERROR(Text008);
            END;
          "Wizard Step"::"4":;
        END;
           */

    end;

    procedure FinishWizard(IsFinish: Boolean; var AttachmentTmp: Record Attachment): Boolean;
    var
        SegManagement: Codeunit SegManagement;
        send: Boolean;
        Flag: Boolean;
    begin
        /*
        Flag := FALSE;
        IF IsFinish THEN
          Flag := TRUE
        ELSE
          Flag := CONFIRM(Text007);
        
        IF Flag THEN BEGIN
          AttachmentTemp.COPY(AttachmentTmp);
          "Attempt Failed" := NOT "Interaction Successful";
          Subject := Description;
          ProcessPostponedAttachment;
          send := (IsFinish AND ("Correspondence Type" <> "Correspondence Type"::" "));
          SegManagement.LogInteraction(Rec,AttachmentTemp,InterLogEntryCommentLineTmp,send,NOT IsFinish)
        END;
        DELETE
         */

    end;

    procedure ErrorMessage(FieldName: Text[1024]);
    begin
        //ERROR(Text005,FieldName);
    end;
}

