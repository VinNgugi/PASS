tableextension 51513248 "Employee Extension_2" extends Employee
{
    fields
    {
        field(480; "Dimension Set ID"; Integer)
        {

        }
        field(50000; "Pays SSF"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pays SSF';
        }
        field(50001; "Pays tax"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pays tax';
        }
        field(50002; "Section/Location"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Section/Location';
        }
        field(50010; "Employee's Bank"; code[20])
        {
            DataClassification = CustomerContent;
            caption = 'Employee Bank';
            NotBlank = true;
        }
        field(50019; "Posting Group"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Group';
            TableRelation = "Staff Posting Group";
        }
        field(50021; "Bank Account Number"; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Account Number';
        }
        field(50022; "Bank Branch"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bank Branch';
        }
        field(50023; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            //ValidateTableRelation = false;
        }
        field(50029; "Cumm. Basic Pay"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum ("Assignment Matrix".amount WHERE (Type = CONST (Payment), "Payroll Period" = FIELD ("Pay Period Filter"), "Employee No" = FIELD ("No."), "Basic Salary Code" = const (true)));
        }
        field(50037; "N.H.I.F No"; Code[20])
        {
        }
        field(50050; "Home Ownership Status"; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Home Ownership Status';
            OptionMembers = None,"Owner Occupier","Home Savings";
        }
        field(50087; Basic; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE (Type = CONST (Payment),
                                                                "Employee No" = FIELD ("No."),
                                                                "Payroll Period" = FIELD ("Pay Period Filter"),
                                                                "Basic Salary Code" = CONST (true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50160; "Incremental Month"; text[30])
        {
            DataClassification = CustomerContent;
            caption = 'Incremental Month';
        }
        field(50174; "Basic Arrears"; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE (Type = CONST (Payment),
                                                                "Employee No" = FIELD ("No."),
                                                                "Payroll Period" = FIELD ("Pay Period Filter"),
                                                                "Basic Pay Arrears" = CONST (true)));
            FieldClass = FlowField;
        }
        field(50039; "Daily Rate"; Decimal)
        {
        }
        field(50196; "No of Dependants"; Integer)
        {
            FieldClass = Normal;
        }
        field(50015; "Total Allowances"; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE (Type = CONST (Payment),
                                                                "Employee No" = FIELD ("No."),
                                                                "Payroll Period" = FIELD ("Pay Period Filter"),
                                                                "Non-Cash Benefit" = CONST (false),
                                                                "Normal Earnings" = CONST (true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50166; Insurance; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE (Type = CONST (Deduction),
                                                                "Employee No" = FIELD ("No."),
                                                                "Payroll Period" = FIELD ("Pay Period Filter"),
                                                                "Insurance Code" = CONST (true)));
            FieldClass = FlowField;
        }
        field(50012; "Taxable Allowance"; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE (Taxable = CONST (true),
                                                                "Employee No" = FIELD ("No."),
                                                                "Payroll Period" = FIELD ("Pay Period Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50013; "Tax Deductible Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE ("Tax Deductible" = CONST (true), "Employee No" = FIELD ("No."), "Payroll Period" = FIELD ("Pay Period Filter"), "Non-Cash Benefit" = CONST (false)));
            // DataClassification = CustomerContent;
            caption = 'Tax Deductible Amount';
            Editable = false;
        }
        field(50003; "Basic Pay"; Decimal)
        {
        }

        field(50016; "Total Deductions"; Decimal)
        {
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE (Type = FILTER (Deduction | Loan),
                                                                "Employee No" = FIELD ("No."),
                                                                "Payroll Period" = FIELD ("Pay Period Filter"),
                                                                Information = CONST (false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50033; "Cumm. PAYE"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE ("Employee No" = FIELD ("No."), "Payroll Period" = FIELD ("Pay Period Filter"), Paye = CONST (true)));
            caption = 'Cumm. PAYE';
            Editable = false;
        }
        field(50034; "Cumm. Net Pay"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Cumm. Net Pay';
            Editable = false;
        }
        field(50038; "Hourly Rate"; Decimal)
        {
        }
        field(50045; "Benefits-Non Cash"; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum ("Assignment Matrix".Amount WHERE ("Employee No" = FIELD ("No."), "Payroll Period" = FIELD ("Pay Period Filter"), "Non-Cash Benefit" = CONST (true), Type = CONST (Payment), Taxable = CONST (true)));
            caption = 'Benefits-Non Cash';

        }
        field(50046; "Pay Mode"; Option)
        {
            OptionMembers = Bank,Cash,Cheque,"Bank Transfer";
        }
        field(50067; Overtime; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Overtime';
            Editable = false;
        }
        field(50083; "Working Hours"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Working Hours';
        }
        field(50084; "No. Of Days Worked"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'No. Of Days Worked';
            Editable = false;
        }
        field(50085; "No. of Hours"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'No. of Hours';
            Editable = false;
        }
        field(50086; "No. Of Hours Weekend"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'No. Of Hours Weekend';
            Editable = false;
        }
        field(50107; "Contract Type"; Code[20])
        {
            TableRelation = "Employment Contract";

            trigger OnValidate();
            begin
                /*      CareerEvent.SetMessage('Contract Type Changed');
                      CareerEvent.RUNMODAL;
                       OK:= CareerEvent.ReturnResult;
                      // IF OK THEN BEGIN
                          HRCareerHistoryRec.INIT;
                          IF NOT HRCareerHistoryRec.FIND('-') THEN
                           HRCareerHistoryRec."Line No.":=1
                         ELSE
                 BEGIN
                           HRCareerHistoryRec.FIND('+');
                           HRCareerHistoryRec."Line No.":=HRCareerHistoryRec."Line No."+1;
                       END;

                          HRCareerHistoryRec."Employee No.":= "No.";
                          HRCareerHistoryRec."Date Of Event":= TODAY;
                          HRCareerHistoryRec."Career Event":= 'Contract Type Changed';
                          HRCareerHistoryRec."Job Title":= "Job Title";
                          HRCareerHistoryRec."Employee First Name":= "Known As";
                          HRCareerHistoryRec."Employee Last Name":= "Last Name";
                          HRCareerHistoryRec.Reason:=CareerEvent.ReturnReason;
                          HRCareerHistoryRec.INSERT;
                       //END;
               */

            end;
        }
        field(50108; "Contract End Date"; Date)
        {
        }
        field(50118; "End Of Probation Date"; Date)
        {
        }
        field(50119; "Pension Scheme Join"; Date)
        {

            trigger OnValidate();
            begin
                /*  IF ("Date Of Leaving" <> 0D) AND ("Pension Scheme Join" <> 0D) THEN
                   "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");

            */

            end;
        }
        field(50121; "Medical Scheme Join"; Date)
        {

            trigger OnValidate();
            begin
                /*  IF  ("Date Of Leaving" <> 0D) AND ("Medical Scheme Join" <> 0D) THEN
                   "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");
                */

            end;
        }
        field(50123; "Date Of Leaving"; Date)
        {

            trigger OnValidate();
            begin
                /*
                 IF ("Date Of Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
                  "Length Of Service":= Dates.DetermineAge("Date Of Join","Date Of Leaving");
                 IF ("Pension Scheme Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
                  "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
                 IF ("Medical Scheme Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
                  "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");


                 IF ("Date Of Leaving" <> 0D) AND ("Date Of Leaving" <> xRec."Date Of Leaving") THEN BEGIN
                    ExitInterviews.SETRANGE("Employee No.","No.");
                    OK:= ExitInterviews.FIND('-');
                    IF OK THEN BEGIN
                      ExitInterviews."Date Of Leaving":= "Date Of Leaving";
                      ExitInterviews.MODIFY;
                    END;
                    COMMIT();
                 END;

                  */

                if ("Date Of Leaving" <> 0D) and ("Date Of Leaving" <> xRec."Date Of Leaving") then begin

                    CareerEvent.SetMessage('Left The Company');
                    CareerEvent.RUNMODAL;
                    //OK:= CareerEvent.ReturnResult;
                    // IF OK THEN BEGIN
                    HRCareerHistoryRec.INIT;
                    if not HRCareerHistoryRec.FIND('-') then
                        HRCareerHistoryRec."Line No." := 1
                    else begin
                        HRCareerHistoryRec.FIND('+');
                        HRCareerHistoryRec."Line No." := HRCareerHistoryRec."Line No." + 1;
                    end;

                    HRCareerHistoryRec."Employee No." := "No.";
                    HRCareerHistoryRec."Date Of Event" := "Date Of Leaving";
                    HRCareerHistoryRec."Career Event" := 'Left The Company';
                    HRCareerHistoryRec."Employee First Name" := "First Name";
                    HRCareerHistoryRec."Employee Last Name" := "Last Name";

                    HRCareerHistoryRec.INSERT;
                    //  END;

                end;

                /*
                ExitInterviewTemplate.RESET;
                //TrainingEvalTemplate.SETRANGE(TrainingEvalTemplate."AIT/Evaluation",TrainingEvalTemplate."AIT/Evaluation"::AIT);
                IF ExitInterviewTemplate.FIND('-') THEN
                REPEAT
                ExitInterviewLines.INIT;
                ExitInterviewLines."Employee No":="No.";
                ExitInterviewLines.Question:=ExitInterviewTemplate.Question;
                ExitInterviewLines."Line No":=ExitInterviewTemplate."Line No";
                ExitInterviewLines.Bold:=ExitInterviewTemplate.Bold;
                ExitInterviewLines."Answer Type":=ExitInterviewTemplate."Answer Type";
                IF NOT ExitInterviewLines.GET(ExitInterviewLines."Line No",ExitInterviewLines."Employee No") THEN
                ExitInterviewLines.INSERT


                UNTIL ExitInterviewTemplate.NEXT=0;
                                      */

                //KKB 13/09/2017
                if "Date Of Leaving" <> 0D then begin
                    AssMatrix.RESET;
                    AssMatrix.SETFILTER("Employee No", "No.");
                    AssMatrix.SETFILTER("Payroll Period", '%1', CALCDATE('-CM', "Date Of Leaving"));
                    AssMatrix.SETFILTER(Closed, '%1', false);
                    if AssMatrix.FINDSET then begin
                        ansmsg := 'Employee No: ' + "No." + '- ' + "First Name" + ' ' + "Last Name" + ' already has Payroll Data For Period ' +
                        FORMAT(CALCDATE('-CM', "Date Of Leaving")) + '\Do you want to Clear his or her Payroll Entries?\If you Select Yes Entries will be Cleared.';
                        ans := CONFIRM(ansmsg);
                        if FORMAT(ans) = 'Yes' then begin
                            repeat
                                AssMatrix.DELETE;
                            until AssMatrix.NEXT = 0;
                        end;
                    end;
                end;
                //==================================================

            end;
        }
        field(50126; "Termination Category"; Option)
        {
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate();
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
                //**Added by ACR 12/08/2002
                //**Block resource if Terminated

                if "Resource No." <> '' then begin
                    OK := "Lrec Resource".GET("Resource No.");
                    "Lrec Resource".Blocked := true;
                    "Lrec Resource".MODIFY;
                end;

                //**
            end;
        }
        field(50144; "Position To Succeed"; Code[20])
        {
            TableRelation = "Company Jobs"."Job ID";

            trigger OnValidate();
            begin
                /*CompanyJobsRec.RESET;
                IF CompanyJobsRec.GET("Position To Succeed") THEN
                  "Position To Succeed Name":=CompanyJobsRec."Job Description";
                
                SuccessionGap.RESET;
                SuccessionGap.SETRANGE(SuccessionGap."Employee No","No.");
                IF SuccessionGap.FIND('-') THEN
                SuccessionGap.DELETEALL;
                
                JobReq.RESET;
                JobReq.SETRANGE(JobReq."Job Id","Position To Succeed");
                IF JobReq.FIND('-') THEN
                BEGIN
                REPEAT
                EmpQualification.RESET;
                EmpQualification.SETRANGE(EmpQualification."Employee No.","No.");
                EmpQualification.SETRANGE(EmpQualification."Qualification Code",JobReq."Qualification Code");
                //IF NOT EmpQualification.GET("No.",JobReq."Qualification Code") THEN
                IF NOT EmpQualification.FIND('-') THEN
                BEGIN
                
                SuccessionGap.INIT;
                SuccessionGap."Employee No":="No.";
                SuccessionGap."Job Id":=JobReq."Job Id";
                SuccessionGap."Qualification Type":=JobReq."Qualification Type";
                SuccessionGap."Qualification Code":=JobReq."Qualification Code";
                SuccessionGap.Qualification:=JobReq.Qualification;
                SuccessionGap.Priority:=JobReq.Priority;
                SuccessionGap.INSERT;
                END;
                UNTIL JobReq.NEXT = 0;
                END;
                */

            end;
        }
        field(50145; "Succesion Date"; Date)
        {
        }
        field(50146; "Send Alert to"; Code[50])
        {
        }
        field(50149; "Served Notice Period"; Boolean)
        {
        }
        field(50152; "Allow Re-Employment In Future"; Boolean)
        {
        }
        field(50170; "Date OfJoining Payroll"; Date)
        {
        }
        field(50172; "Pro-Rata Calculated"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Pro-Rata Calculated';
        }
        field(50175; "Relief Amount"; Decimal)
        {
            CalcFormula = - Sum ("Assignment Matrix".Amount WHERE ("Employee No" = FIELD ("No."),
                                                                 "Payroll Period" = FIELD ("Pay Period Filter"),
                                                                 "Non-Cash Benefit" = CONST (true),
                                                                 Type = CONST (Payment),
                                                                 "Tax Deductible" = CONST (true),
                                                                 "Tax Relief" = CONST (false),
                                                                 "Manual Entry" = CONST (false)));
            FieldClass = FlowField;
        }
        field(50195; "Payroll Currency"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Currency.Code;
        }
        field(50031; "P.I.N"; Code[20])
        {
            NotBlank = true;
        }
        field(50138; "NSSF No."; Code[20])
        {
        }
        field(50139; "NHIF No."; Code[20])
        {
        }
        field(50142; "HELB No"; Text[30])
        {
        }
        field(50143; "Co-Operative No"; Text[30])
        {
        }
        field(50162; Present; code[30])
        {
            TableRelation = "Salary Pointers";

            trigger OnValidate();
            begin
                /* GetPayPeriod;
                 Earnings.RESET;
                 Earnings.SETRANGE(Earnings."Pay Type",Earnings."Pay Type"::Recurring);
                 IF Earnings.FIND('-') THEN BEGIN
                 ScaleBenefits.RESET;
                 ScaleBenefits.SETRANGE(ScaleBenefits."Salary Scale","Salary Scale");
                 ScaleBenefits.SETRANGE(ScaleBenefits."Salary Pointer",Present);
                 ScaleBenefits.SETRANGE(ScaleBenefits."ED Code",Earnings.Code);
                 IF ScaleBenefits.FIND('-') THEN
                 REPEAT
                  AssMatrix.INIT;
                  AssMatrix."Employee No":="No.";
                  AssMatrix.VALIDATE(AssMatrix."Employee No");
                  AssMatrix.Type:=AssMatrix.Type::Payment;
                  AssMatrix.Code:=ScaleBenefits."ED Code";
                  AssMatrix.VALIDATE(AssMatrix.Code);
                  AssMatrix."Payroll Period":=Begindate;
                  AssMatrix.Amount:=ScaleBenefits.Amount;
                  IF NOT AssMatrix.GET(AssMatrix."Employee No",AssMatrix.Type,AssMatrix.Code,AssMatrix."Payroll Period",
                  AssMatrix."Reference No") THEN  BEGIN
                  IF  AssMatrix.Amount<>ScaleBenefits.Amount THEN
                  AssMatrix.INSERT;
                  END;
                 UNTIL ScaleBenefits.NEXT=0;
                 END;
                
                
                 {
                 CareerEvent.SetMessage('Salary Pointer Changed');
                       CareerEvent.RUNMODAL;
                        OK:= CareerEvent.ReturnResult;
                       // IF OK THEN BEGIN
                           HRCareerHistoryRec.INIT;
                           IF NOT HRCareerHistoryRec.FIND('-') THEN
                            HRCareerHistoryRec."Line No.":=1
                          ELSE
                  BEGIN
                            HRCareerHistoryRec.FIND('+');
                            HRCareerHistoryRec."Line No.":=HRCareerHistoryRec."Line No."+1;
                        END;
                
                           HRCareerHistoryRec."Employee No.":= "No.";
                           HRCareerHistoryRec."Date Of Event":= TODAY;
                           HRCareerHistoryRec."Career Event":= 'Salary Pointer Changed';
                           HRCareerHistoryRec."Job Title":= "Job Title";
                           HRCareerHistoryRec."Employee First Name":= "Known As";
                           HRCareerHistoryRec."Employee Last Name":= "Last Name";
                           HRCareerHistoryRec.Reason:=CareerEvent.ReturnReason;
                           HRCareerHistoryRec.INSERT;
                        //END;
                 }
                 */
            end;
        }
        field(50163; Previous; Code[30])
        {
            TableRelation = "Salary Pointers";
        }
        field(50164; Halt; Code[20])
        {
        }
        field(50222; "Pension Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Pension Rate';
        }
        field(50226; "Tax Rate Percentage"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Tax Rate Percentage';
        }
        field(50205; "Payroll Subcategory"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scales"."Payroll Category" WHERE (Scale = FIELD ("Salary Scale"));
        }
        field(50206; "Employment Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Probation,Confirmed';
            OptionMembers = " ",Probation,Confirmed;
        }
        field(50106; "Full / Part Time"; Option)
        {
            OptionMembers = "Full Time"," Part Time";

            trigger OnValidate();
            begin
                /*
                 IF ("Full / Part Time" <> xRec."Full / Part Time") THEN BEGIN
                    CareerEvent.SetMessage('Full / Part Time Changed');
                    CareerEvent.RUNMODAL;
                    OK:= CareerEvent.ReturnResult;
                     IF OK THEN BEGIN
                        HRCareerHistoryRec.INIT;
                        IF NOT HRCareerHistoryRec.FIND('-') THEN
                         HRCareerHistoryRec."Line No.":=1
                       ELSE BEGIN
                         HRCareerHistoryRec.FIND('+');
                         HRCareerHistoryRec."Line No.":=HRCareerHistoryRec."Line No."+1;
                       END;

                        HRCareerHistoryRec."Employee No.":= "No.";
                        HRCareerHistoryRec."Date Of Event":= TODAY;
                        HRCareerHistoryRec."Career Event":= 'Full / Part Time Changed';
                        HRCareerHistoryRec."Full/Part Time":= "Full / Part Time";
                        HRCareerHistoryRec."Employee First Name":= "Known As";
                        HRCareerHistoryRec."Employee Last Name":= "Last Name";
                        HRCareerHistoryRec.INSERT;
                     END;
                 END;
             */

            end;
        }
        field(50150; "Exit Interview Date"; Date)
        {
            CalcFormula = Lookup ("Job Exit Interview"."Document Date" WHERE (Code = FIELD ("Exit Interview")));
            FieldClass = FlowField;
        }
        field(50151; "Exit Interview Done by"; Code[20])
        {
            TableRelation = "User Setup";
        }
        field(50165; "Salary Scale"; Code[20])
        {
            TableRelation = "Salary Scales".Scale;

            trigger OnValidate();
            begin

                if SalaryScalesRec.GET("Salary Scale") then begin
                    Halt := SalaryScalesRec."Maximum Pointer";
                    "Payroll Subcategory" := SalaryScalesRec."Payroll Category";
                end;
                CareerEvent.SetMessage('Salary Scale/Grade Changed');
                CareerEvent.RUNMODAL;
                // OK:= CareerEvent.ReturnResult;
                // IF OK THEN BEGIN
                HRCareerHistoryRec.INIT;
                if not HRCareerHistoryRec.FIND('-') then
                    HRCareerHistoryRec."Line No." := 1
                else begin
                    HRCareerHistoryRec.FIND('+');
                    HRCareerHistoryRec."Line No." := HRCareerHistoryRec."Line No." + 1;
                end;

                HRCareerHistoryRec."Employee No." := "No.";
                HRCareerHistoryRec."Date Of Event" := TODAY;
                HRCareerHistoryRec."Career Event" := 'Salary Scale/Grade Changed';
                HRCareerHistoryRec."Job Title" := "Job Title";
                HRCareerHistoryRec."Employee First Name" := "First Name";
                HRCareerHistoryRec."Employee Last Name" := "Last Name";
                HRCareerHistoryRec.Reason := CareerEvent.ReturnReason;
                HRCareerHistoryRec.INSERT;
                //END;
            end;
        }
        field(50116; "Date Of Join"; Date)
        {
            NotBlank = true;

            trigger OnValidate();
            begin
                if "Date Of Join" <> 0D then
                    "Employment Date" := "Date Of Join";

                HumanResSetup.GET;
                DateInt := DATE2DMY("Date Of Join", 1);
                "Pro-Rata on Joining" := HumanResSetup."No. Of Days in Month" - DateInt + 1;
                PayPeriod.RESET;
                PayPeriod.SETRANGE(PayPeriod."Starting Date", 0D, "Date Of Join");
                PayPeriod.SETRANGE(PayPeriod."New Fiscal Year", true);
                if PayPeriod.FIND('+') then begin
                    FiscalStart := PayPeriod."Starting Date";
                    MaturityDate := CALCDATE('1Y', PayPeriod."Starting Date") - 1;
                    //MESSAGE('Maturity %1',MaturityDate)
                end;

                if ("Posting Group" = 'PERMANENT') or ("Posting Group" = 'DG') then begin
                    //MESSAGE('Date of join %1',"Date Of Join") ;
                    Entitlement := ROUND(((MaturityDate - "Date Of Join") / 30), 1) * 2.5;

                    EmpLeaves.RESET;
                    EmpLeaves.SETRANGE(EmpLeaves."Employee No", "No.");
                    EmpLeaves.SETRANGE(EmpLeaves."Maturity Date", MaturityDate);
                    if not EmpLeaves.FIND('-') then begin
                        EmpLeaves."Employee No" := "No.";
                        EmpLeaves."Leave Code" := 'ANNUAL';
                        EmpLeaves."Maturity Date" := MaturityDate;
                        EmpLeaves.Entitlement := Entitlement;
                        if not EmpLeaves.GET("No.", 'ANNUAL', MaturityDate) then
                            EmpLeaves.INSERT;
                    end;

                end;


                /*
                      CareerEvent.SetMessage('Joined Organisation');
                      CareerEvent.RUNMODAL;
                       OK:= CareerEvent.ReturnResult;
                      // IF OK THEN BEGIN
                          HRCareerHistoryRec.INIT;
                          IF NOT HRCareerHistoryRec.FIND('-') THEN
                           HRCareerHistoryRec."Line No.":=1
                         ELSE
                 BEGIN
                           HRCareerHistoryRec.FIND('+');
                           HRCareerHistoryRec."Line No.":=HRCareerHistoryRec."Line No."+1;
                       END;

                          HRCareerHistoryRec."Employee No.":= "No.";
                          HRCareerHistoryRec."Date Of Event":= "Date Of Join";
                          HRCareerHistoryRec."Career Event":= 'Joined Organisation';
                          HRCareerHistoryRec."Job Title":= "Job Title";
                          HRCareerHistoryRec."Employee First Name":= "Known As";
                          HRCareerHistoryRec."Employee Last Name":= "Last Name";
                          HRCareerHistoryRec.Reason:=CareerEvent.ReturnReason;
                          HRCareerHistoryRec.INSERT;
                       //END;
                */

                //HumanResSetup.GET;
                //"End Of Probation Date":=CALCDATE(HumanResSetup."Probation Period(Months)","Date Of Join");
                /*   AccPeriod.RESET;
                   AccPeriod.SETRANGE(AccPeriod."Starting Date",0D,TODAY);
                   AccPeriod.SETRANGE(AccPeriod."New Fiscal Year",TRUE);
                   IF AccPeriod.FIND('+') THEN
                     EndYearDate:=CALCDATE('1Y',AccPeriod."Starting Date")-1;
                  // MESSAGE('EndYear=%1',EndYearDate);

                     NoofMonthsToWork:=0;

                   AccPeriod.RESET;
                   AccPeriod.SETRANGE(AccPeriod."Starting Date",0D,TODAY);
                   AccPeriod.SETRANGE(AccPeriod."New Fiscal Year",TRUE);
                   IF AccPeriod.FIND('+') THEN
                    IF "Date Of Join"<AccPeriod."Starting Date" THEN
                     StartDate:=AccPeriod."Starting Date"
                    ELSE
                     StartDate:="Date Of Join";

                    NextDate:=StartDate;
                   REPEAT
                     NextDate:=CALCDATE('1M',NextDate);
                     NoofMonthsToWork:=NoofMonthsToWork+1;
                   UNTIL NextDate>=EndYearDate;
                     NoofMonthsToWork:=NoofMonthsToWork-1;

                    LeaveTypes.RESET;
                    LeaveTypes.SETRANGE(LeaveTypes."Annual Leave",TRUE);
                    IF LeaveTypes.FIND('-') THEN BEGIN

                      LeaveCode:=LeaveTypes.Code;
                      LeaveEarnedtoDate:=ROUND(((LeaveTypes.Days/12)*((EndYearDate-StartDate)/30)),1);//NoofMonthsToWork
                      Entitlement:=ROUND(((EndYearDate-StartDate)/30),1)*2.5;
                    END;

                   EmpLeave.RESET;
                   EmpLeave."Leave Code":=LeaveCode;
                   EmpLeave."Maturity Date":=EndYearDate;
                   EmpLeave."Employee No":="No.";
                   EmpLeave.Entitlement:=LeaveEarnedtoDate;
                   IF NOT EmpLeave.GET(EmpLeave."Employee No",EmpLeave."Leave Code",EmpLeave."Maturity Date") THEN
                   EmpLeave.INSERT
                   ELSE
                   EmpLeave.MODIFY;  */

                //  MESSAGE('%1',LeaveEarnedtoDate);

                /*AccPeriod.RESET;
                    AccPeriod.SETRANGE(AccPeriod."Starting Date",0D,TODAY);
                    AccPeriod.SETRANGE(AccPeriod."New Fiscal Year",TRUE);
                    IF AccPeriod.FIND('+') THEN
                      EndYearDate:=CALCDATE('1Y',AccPeriod."Starting Date")-1;
                   // MESSAGE('EndYear=%1',EndYearDate);

                      NoofMonthsToWork:=0;

                    AccPeriod.RESET;
                    AccPeriod.SETRANGE(AccPeriod."Starting Date",0D,TODAY);
                    AccPeriod.SETRANGE(AccPeriod."New Fiscal Year",TRUE);
                    IF AccPeriod.FIND('+') THEN
                     IF "Date Of Join" > AccPeriod."Starting Date" THEN
                      NextDate:="Date Of Join"
                     ELSE
                      NextDate:=AccPeriod."Starting Date";

                    REPEAT
                      NextDate:=CALCDATE('1M',NextDate);
                      NoofMonthsToWork:=NoofMonthsToWork+1;
                    UNTIL NextDate>=EndYearDate;
                      NoofMonthsToWork:=NoofMonthsToWork-1;

                     LeaveTypes.RESET;
                     LeaveTypes.SETRANGE(LeaveTypes."Annual Leave",TRUE);
                     IF LeaveTypes.FIND('-') THEN BEGIN

                       LeaveCode:=LeaveTypes.Code;
                       LeaveEarnedtoDate:=ROUND(((LeaveTypes.Days/12)*((EndYearDate-"Date Of Join")/30)),1);//NoofMonthsToWork
                       //Entitlement:=ROUND(((MaturityDate-"Date Of Join")/30),1)*2.5;
                     END;

                    EmpLeave.RESET;
                    EmpLeave."Leave Code":=LeaveCode;
                    EmpLeave."Maturity Date":=EndYearDate;
                    EmpLeave."Employee No":="No.";
                    EmpLeave.Entitlement:=LeaveEarnedtoDate;
                    IF NOT EmpLeave.GET(EmpLeave."Employee No",EmpLeave."Leave Code",EmpLeave."Maturity Date") THEN
                    EmpLeave.INSERT
                    ELSE
                    EmpLeave.MODIFY;
                    */

            end;
        }
        field(50168; "Pro-Rata on Joining"; Decimal)
        {
        }
        field(50169; "Pro-rata on Leaving"; Decimal)
        {
        }
        field(50189; "Exit Interview"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Job Exit Interview";
        }
        field(50184; "Contract Start Date"; Date)
        {
        }
        field(50185; "Contract Number"; Code[30])
        {
            TableRelation = "Employee Contracts"."Contract No" WHERE ("Employee No" = FIELD ("No."),
                                                                      Status = CONST (Active));

            trigger OnValidate();
            begin
                /*TESTFIELD("Contract Type");
                IF "Contract Type"<>'PERM' THEN BEGIN
                 EmployeeContracts.RESET;
                 EmployeeContracts.SETRANGE(EmployeeContracts."Contract No",FORMAT("Contract Number"));
                 IF EmployeeContracts.FIND('-') THEN BEGIN
                   "Contract Start Date":=EmployeeContracts."Contract Start Date";
                   "Contract End Date":=EmployeeContracts."Contract End Date";
                   "Retirement Date":=EmployeeContracts."Contract End Date";
                 END;
                END ELSE BEGIN
                   "Contract Start Date":="Date Of Join";
                   HumanResSetup.GET;
                   "Contract End Date":=CALCDATE(FORMAT(HumanResSetup."Retirement Age")+'Y',"Date Of Join");
                   "Retirement Date":=CALCDATE(FORMAT(HumanResSetup."Retirement Age")+'Y',"Date Of Join");
                END;
                */

            end;
        }
        field(50193; "Base Calendar Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Base Calendar";
        }
        field(50213; "Leave Type Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Multi- Comp Leave Types";
        }
        field(50214; "Total Leavedays Allocated"; Decimal)
        {
            CalcFormula = Sum ("HR Leave Ledger Entries"."No. of days" WHERE ("Staff No." = FIELD ("No."),
                                                                             "Posting Date" = FIELD ("Date Filter"),
                                                                             "Leave Type" = FIELD ("Leave Type Filter"),
                                                                             "Transaction Type" = FILTER (Allocation)));
            FieldClass = FlowField;
        }
        field(50215; "Total Leavedays Taken"; Decimal)
        {
            CalcFormula = - Sum ("HR Leave Ledger Entries"."No. of days" WHERE ("Staff No." = FIELD ("No."),
                                                                              "Posting Date" = FIELD ("Date Filter"),
                                                                              "Leave Type" = FIELD ("Leave Type Filter"),
                                                                              "Transaction Type" = FILTER ("Leave Applied" | Reversal)));
            FieldClass = FlowField;
        }
        field(50216; "Total Recalled Days"; Decimal)
        {
            CalcFormula = Sum ("HR Leave Ledger Entries"."No. of days" WHERE ("Staff No." = FIELD ("No."),
                                                                             "Posting Date" = FIELD ("Date Filter"),
                                                                             "Leave Type" = FIELD ("Leave Type Filter"),
                                                                             "Transaction Type" = FILTER ("Leave Recall")));
            FieldClass = FlowField;
        }
        field(50217; "Total Credited Back"; Decimal)
        {
            CalcFormula = Sum ("HR Leave Ledger Entries"."No. of days" WHERE ("Staff No." = FIELD ("No."),
                                                                             "Posting Date" = FIELD ("Date Filter"),
                                                                             "Leave Type" = FIELD ("Leave Type Filter"),
                                                                             "Transaction Type" = FILTER ("Credit Back")));
            FieldClass = FlowField;
        }
        field(50218; "Leave Balance"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum ("HR Leave Ledger Entries"."No. of days" WHERE ("Staff No." = FIELD ("No."),
                                                                             "Posting Date" = FIELD ("Date Filter"),
                                                                             "Leave Type" = FIELD ("Leave Type Filter")));
        }
        field(50220; "Balance Carried Forward"; Decimal)
        {
            CalcFormula = Sum ("HR Leave Ledger Entries"."No. of days" WHERE ("Staff No." = FIELD ("No."),
                                                                             "Posting Date" = FIELD ("Date Filter"),
                                                                             "Leave Type" = FIELD ("Leave Type Filter"),
                                                                             "Transaction Type" = FILTER ("Carry Forward")));
            FieldClass = FlowField;
        }

        field(50147; Religion; Code[20])
        {

            trigger OnValidate();
            begin
                /*       CareerEvent.SetMessage('Religion Changed');
                       CareerEvent.RUNMODAL;
                        OK:= CareerEvent.ReturnResult;
                       // IF OK THEN BEGIN
                           HRCareerHistoryRec.INIT;
                           IF NOT HRCareerHistoryRec.FIND('-') THEN
                            HRCareerHistoryRec."Line No.":=1
                          ELSE
                  BEGIN
                            HRCareerHistoryRec.FIND('+');
                            HRCareerHistoryRec."Line No.":=HRCareerHistoryRec."Line No."+1;
                        END;
                
                           HRCareerHistoryRec."Employee No.":= "No.";
                           HRCareerHistoryRec."Date Of Event":= TODAY;
                           HRCareerHistoryRec."Career Event":= 'Religion Changed';
                           HRCareerHistoryRec."Job Title":= "Job Title";
                           HRCareerHistoryRec."Employee First Name":= "Known As";
                           HRCareerHistoryRec."Employee Last Name":= "Last Name";
                           HRCareerHistoryRec.Reason:=CareerEvent.ReturnReason;
                           HRCareerHistoryRec.INSERT;
                        //END;
                */

            end;
        }
        field(50190; "Is Intern"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50191; "On Contract"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50192; "Is Permanent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50194; "WCF Number"; Code[20])
        {

        }
        field(50200; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;

            trigger OnValidate()
            var
                RespCenter: Record "Responsibility Center";
            begin
                if RespCenter.Get("Responsibility Center") then
                    "Center Description" := RespCenter.Name
                else
                    "Center Description" := '';
            end;
        }
        field(50201; "Center Description"; Text[50])
        {
            Editable = false;
        }
        field(50202; "Imprest Code"; Code[20])
        {
            TableRelation = "Imprest Rates"."Imprest Code";
        }
        field(50203; "Customer Acc No."; Code[20])
        {
            TableRelation = Customer."No." where ("Customer Posting Group" = filter ('STAFF'));
        }
        field(50221; "Gratuity Accumulated"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Assignment Matrix"."Employer Amount" where (Type = CONST (Deduction), "Payroll Period" = FIELD ("Pay Period Filter"), "Employee No" = FIELD ("No."), gratuity = const (true)));
        }
        field(50223; "Gratuity Paid Out"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum ("Assignment Matrix".Amount where (Type = CONST (Payment), "Payroll Period" = FIELD ("Pay Period Filter"), "Employee No" = FIELD ("No."), gratuity = const (true)));
        }

    }

    var
        HRCareerHistoryRec: Record "HR Career History";
        HumanResSetup: Record "Human Resources Setup";
        Res: Record Resource;
        PostCode: Record "Post Code";
        AlternativeAddr: Record "Alternative Address";
        EmployeeQualification: Record "Employee Qualification";
        Relative: Record "Employee Relative";
        EmployeeAbsence: Record "Employee Absence";
        MiscArticleInformation: Record "Misc. Article Information";
        ConfidentialInformation: Record "Confidential Information";
        HumanResComment: Record "Human Resource Comment Line";
        SalespersonPurchaser: Record "Salesperson/Purchaser";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmployeeResUpdate: Codeunit "Employee/Resource Update";
        EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
        DimMgt: Codeunit DimensionManagement;
        Text000: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
        CompanyJobsRec: Record "Company Jobs";

        EmployeeRec: Record Employee;
        SalaryScalesRec: Record "Salary Scales";

        AssMatrix: Record "Assignment Matrix";
        ansmsg: Text;
        ans: Boolean;
        EmployeePostingGroupRec: Record "Staff Posting Group";
        DateInt: Integer;
        PayPeriod: Record "Payroll Period";
        FiscalStart: Date;
        MaturityDate: Date;
        Entitlement: Integer;
        CareerEvent: Page "HR Career Event Option Box";
        EmpLeaves: Record "Employee Leave Entitlement";

    trigger OnInsert()

    begin
        IF ("On Contract" = TRUE) THEN BEGIN
            IF "No." = '' THEN BEGIN
                HumanResSetup.GET;
                HumanResSetup.TESTFIELD("Employee On Contract Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Employee On Contract Nos", xRec."No. Series", 0D, "No.", "No. Series");
            END;
            //insert the posting group
            EmployeePostingGroupRec.RESET;
            EmployeePostingGroupRec.SETRANGE("Is Contract", TRUE);
            IF EmployeePostingGroupRec.FINDFIRST THEN
                "Posting Group" := EmployeePostingGroupRec.Code;

        END;
        IF ("Is Intern" = TRUE) THEN BEGIN
            IF "No." = '' THEN BEGIN
                HumanResSetup.GET;
                HumanResSetup.TESTFIELD("Intern Nos");
                NoSeriesMgt.InitSeries(HumanResSetup."Intern Nos", xRec."No. Series", 0D, "No.", "No. Series");
            END;

            //insert the posting group
            EmployeePostingGroupRec.RESET;
            EmployeePostingGroupRec.SETRANGE("Is Intern", TRUE);
            IF EmployeePostingGroupRec.FINDFIRST THEN
                "Posting Group" := EmployeePostingGroupRec.Code;
        END;

        "Last Modified Date Time" := CURRENTDATETIME;
        IF "Is Permanent" THEN BEGIN
            IF "No." = '' THEN BEGIN
                HumanResSetup.GET;
                HumanResSetup.TESTFIELD("Employee Nos.");
                NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
            END;
            //insert the posting group

            EmployeePostingGroupRec.RESET;
            EmployeePostingGroupRec.SETRANGE("Is Permanent", TRUE);
            IF EmployeePostingGroupRec.FINDFIRST THEN
                "Posting Group" := EmployeePostingGroupRec.Code;

        END;
        DimMgt.UpdateDefaultDim(
          DATABASE::Employee, "No.",
          "Global Dimension 1 Code", "Global Dimension 2 Code");
        UpdateSearchName;
    end;

    local procedure UpdateSearchName();
    var
        PrevSearchName: Code[250];
    begin
        PrevSearchName := xRec.FullName + ' ' + xRec.Initials;
        if ((("First Name" <> xRec."First Name") or ("Middle Name" <> xRec."Middle Name") or ("Last Name" <> xRec."Last Name") or
             (Initials <> xRec.Initials)) and ("Search Name" = PrevSearchName))
        then
            "Search Name" := SetSearchNameToFullnameAndInitials;
    end;

    local procedure SetSearchNameToFullnameAndInitials(): Code[250];
    begin
        exit(FullName + ' ' + Initials);
    end;
}