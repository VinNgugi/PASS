table 51513311 "HR Company or Other Training"
{
    // version HR

    // LookupPageID = "Vehicle Allocations";

    fields
    {
        field(1; "Employee No."; Code[10])
        {
            NotBlank = true;
            TableRelation = Employee."No.";
        }
        field(2; "Course Title"; Integer)
        {
            AutoIncrement = true;
            NotBlank = true;

            trigger OnValidate();
            begin
                if TrainingNeeds.GET("Course Title") then
                    Description := TrainingNeeds.Description;
            end;
        }
        field(3; "Cost Incurred By Employee"; Decimal)
        {

            trigger OnValidate();
            begin
                if Posted then begin
                    if Results <> xRec.Results then begin
                        MESSAGE('%1', 'You cannot change the costs after posting');
                        Results := xRec.Results;
                    end
                end
            end;
        }
        field(4; "Educaion Credits"; Decimal)
        {
        }
        field(5; "Training Credits"; Decimal)
        {
        }
        field(6; "Certificate Number"; Code[20])
        {
        }
        field(7; Results; Text[15])
        {
        }
        field(8; Competency; Option)
        {
            OptionMembers = " ",Competent,"Not yet competent";

            trigger OnValidate();
            begin
                if Competency <> xRec.Competency then begin
                    if Competency = Competency::Competent then begin
                        if TrainingNeeds.GET("Course Title") then begin
                            if Qualifications.GET(TrainingNeeds.Qualification) then begin
                                EmpQualifications.INIT;
                                EmpQualifications."Employee No." := "Employee No.";
                                //           EmpQualifications."Qualification Type":=Qualifications.Type;
                                EmpQualifications."Qualification Code" := Qualifications.Code;
                                EmpQualifications.VALIDATE(EmpQualifications."Qualification Code");
                                EmpQualifications."From Date" := TrainingNeeds."Start Date";
                                EmpQualifications."To Date" := TrainingNeeds."End Date";
                                EmpQualifications.Type := EmpQualifications.Type::Internal;
                                EmpQualifications."Institution/Company" := TrainingNeeds.Provider;
                                EmpQualifications.INSERT;

                            end;
                        end;
                    end;
                end;

                if Competency <> xRec.Competency then begin
                    if Competency <> Competency::Competent then begin
                        if xRec.Competency = Competency::Competent then begin
                            if TrainingNeeds.GET("Course Title") then begin
                                if EmpQualifications.GET("Employee No.", TrainingNeeds.Qualification) then
                                    EmpQualifications.DELETE;
                            end;

                        end;
                    end;
                end;
            end;
        }
        field(9; "Date of re-assessment"; Date)
        {
        }
        field(10; Post; Boolean)
        {
        }
        field(11; Posted; Boolean)
        {
            Editable = true;
        }
        field(12; Description; Text[250])
        {

            trigger OnValidate();
            begin
                //IF (Need Source=CONST(HOD)) "Training Needs".Description WHERE (Employee No=FIELD(Employee No.)) ELSE IF (Need Source=CONST(Employee)) "Training Problems Faced"."Employee No." WHERE (Field17=FIELD(Employee No.)) ELSE IF (Need Source=CONST(Apprais
            end;
        }
        field(13; "Need Source"; Option)
        {
            OptionCaption = '" ,Appraisal,Employee,HOD"';
            OptionMembers = " ",Appraisal,Employee,HOD;
        }
        field(14; Approved; Boolean)
        {
        }
        field(27; fsdf; Text[30])
        {
        }
        field(28; "Training Evaluation"; Text[250])
        {
        }
        field(29; "Request No"; Code[20])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.", "Course Title")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        // if TrainingReq.GET("Request No") then
        //  "Employee No.":=TrainingReq."Employee No";
    end;

    var
        Employee: Record Employee;
        OK: Boolean;
        TrainingNeeds: Record "Training Needs";
        Qualifications: Record Qualification;
        EmpQualifications: Record "Employee Qualification";
        //TrainingReq : Record "Training Request";
}

