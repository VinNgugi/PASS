table 51513378 "Stage Shortlist"
{
    DataClassification = CustomerContent;
    Caption = 'Stage Shortlist';

    fields
    {
        field(1; "Need Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Need Code';
            TableRelation = "Recruitment Needs"."No.";
            Editable = false;
            NotBlank = true;

        }
        field(2; "Stage Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Stage Code';
            TableRelation = "Recruitment Stages"."Recruitment Stage";
            Editable = false;
            NotBlank = true;
        }
        field(3; Applicant; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Applicant';
            Editable = false;
            NotBlank = true;
        }
        field(4; "Stage Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Stage Score';
            Editable = false;
        }
        field(5; Qualified; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Qualified';
        }
        field(6; "First Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
            Editable = false;
        }
        field(7; "Middle Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
            Editable = false;
        }
        field(8; "Last Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
            Editable = false;
        }
        field(9; "ID No"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'ID No';
            Editable = false;
        }
        field(10; Gender; Option)
        {
            OptionMembers = Male,Female;
            DataClassification = CustomerContent;
            Caption = 'Gender';
            Editable = false;
        }
        field(11; "Marital Status"; Option)
        {
            Caption = 'Marital Status';
            DataClassification = CustomerContent;
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
            Editable = false;
        }
        field(12; "Manual Change"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Manual Change';
            Editable = false;
        }
        field(13; Employ; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Employ';

            trigger OnValidate()
            var

            begin
                IF Employ THEN BEGIN

                    RequiredDocs.RESET;
                    RequiredDocs.SETRANGE(RequiredDocs."Recruitment Req. No.", "Need Code");
                    RequiredDocs.SETRANGE(Mandatory, TRUE);
                    IF RequiredDocs.FINDFIRST THEN BEGIN
                        REPEAT
                            AppDocuments.RESET;
                            AppDocuments.SETRANGE(AppDocuments."Applicant No ", Applicant);
                            AppDocuments.SETRANGE(AppDocuments."Document Description", RequiredDocs."Document Description");
                            AppDocuments.SETRANGE(AppDocuments.Attached, TRUE);
                            IF NOT AppDocuments.FINDFIRST THEN
                                ERROR('Required document %2 has not been attached for applicant %1', Applicant, RequiredDocs."Document Description");
                        UNTIL RequiredDocs.NEXT = 0;
                    END;


                    RNeeds.RESET;
                    RNeeds.SETFILTER(RNeeds."No.", "Need Code");
                    IF RNeeds.FIND('-') THEN BEGIN

                        IF RNeeds.Position = 1 THEN BEGIN
                            RNeeds."End Date" := TODAY;
                            RNeeds.MODIFY;
                            IF RNeeds."Start Date" <> 0D THEN BEGIN
                                RNeeds."Turn Around Time" := RNeeds."End Date" - RNeeds."Start Date";
                                RNeeds.MODIFY;
                            END;
                        END;
                        IF RNeeds.Position > 0 THEN BEGIN
                            RNeeds.Position := RNeeds.Position - 1;
                            RNeeds.MODIFY;
                        END;
                    END;
                    Date := TODAY;


                    Applicants.RESET;
                    Applicants.SETRANGE(Applicants."No.", Applicant);
                    IF Applicants.FIND('-') THEN
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
                            //Employee."Ethnic Origin":=Applicants."Ethnic Origin";
                            //Employee."First Language (R/W/S)":=Applicants."First Language (R/W/S)";
                            Employee."Driving Licence" := Applicants."Driving Licence";
                            //Employee.Disabled:=Applicants.Disabled;
                            //Employee."Health Assesment?":=Applicants."Health Assesment?";
                            //Employee."Health Assesment Date":=Applicants."Health Assesment Date";
                            Employee."Date Of Birth" := Applicants."Date Of Birth";
                            Employee.Age := Applicants.Age;
                            //Employee."Second Language (R/W/S)":=Applicants."Second Language (R/W/S)";
                            //Employee."Additional Language":=Applicants."Additional Language";
                            Employee."Postal Address2" := Applicants."Postal Address2";
                            Employee."Postal Address3" := Applicants."Postal Address3";
                            Employee."Residential Address2" := Applicants."Residential Address2";
                            Employee."Residential Address3" := Applicants."Residential Address3";
                            Employee."Post Code2" := Applicants."Post Code2";
                            Employee.Citizenship := Applicants.Citizenship;
                            Employee."Passport Number" := Applicants."Passport Number";
                            /*
                            Employee."First Language Read" := Applicants."First Language Read";
                                                        Employee."First Language Write" := Applicants."First Language Write";
                                                        Employee."First Language Speak" := Applicants."First Language Speak";
                                                        Employee."Second Language Read" := Applicants."Second Language Read";
                                                        Employee."Second Language Write" := Applicants."Second Language Write";
                                                        Employee."Second Language Speak" := Applicants."Second Language Speak";
                            */
                            Employee."PIN Number" := Applicants."PIN Number";
                            Employee.Position := Applicants."Job Applied for";
                            Employee."Job Title" := Applicants."Job Applied for Description";
                            Employee."Country/Region Code" := Applicants."Country Code";
                            Employee.INSERT(TRUE);

                            Applicants.Employ := TRUE;
                            Applicants.MODIFY;

                            AppQualifications.RESET;
                            AppQualifications.SETRANGE(AppQualifications."Applicant No.", Applicant);
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
                            END
                        END;
                    /*
                    ELSE BEGIN
                    Employee.RESET;
                    Employee.SETRANGE(Employee."No.",Applicants."Employee No");
                    IF Employee.FIND('-') THEN BEGIN
                    Employee.Position:=Applicants."Job Applied For";
                    Employee.MODIFY;
                    END
                    END
                    */
                END
            end;
        }
        field(14; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(15; Positions; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Position';
        }
        field(16; "Reporting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Reporting Date';
        }
    }

    keys
    {
        key(PK; "Need Code", Applicant, "Stage Code")
        {

        }
    }

    var
        RequiredDocs: Record "Job Required Documents";
        Employee: Record Employee;
        Applicants: Record "Job Applicants";
        EmpQualifications: Record "Employee Qualification";
        RNeeds: Record "Recruitment Needs";
        AppQualifications: Record "Applicants Qualification";
        AppDocuments: Record "Applicant Documents";


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