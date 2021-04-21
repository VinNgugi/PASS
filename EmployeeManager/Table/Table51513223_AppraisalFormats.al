table 51513223 "Appraisal Formats"
{
    // version HR

    Caption = 'Appraisal Formats';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Appraisal Code"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Appraisal Types".Code;
        }
        field(2; Sequence; Integer)
        {
            NotBlank = true;
        }
        field(3; Type; Option)
        {
            OptionMembers = Question,"Heading 2",Category,"Heading 1";
        }
        field(4; "Code"; Code[20])
        {
            NotBlank = true;
        }
        field(5; Description; Text[250])
        {
        }
        field(6; "Entry By"; Code[20])
        {
        }
        field(7; "After Entry Of Prev. Group"; Boolean)
        {
        }
        field(8; "Allow Previous Groups Rights"; Boolean)
        {
        }
        field(9; "In Put"; Option)
        {
            OptionMembers = " ",Grades,Marks,Details;
        }
        field(10; "Appraisal Heading Type"; Option)
        {
            OptionCaption = '" ,Objectives,Core Values,Technical Competencies,Behavioural Competencies,Mid-year Appraisal,Annual Appraisal,Training Needs"';
            OptionMembers = " ",Objectives,"Core Values","Technical Competencies","Behavioural Competencies","Mid-year Appraisal","Annual Appraisal","Training Needs";

            trigger OnValidate();
            begin
                /*
                IF "Appraisal Heading Type"="Appraisal Heading Type"::"Mid-year Appraisal" THEN
                   "Appraisal Type":='Mid Year'
                ELSE IF "Appraisal Heading Type"="Appraisal Heading Type"::"Annual Appraisal" THEN
                    "Appraisal Type":='Annual';
               */

            end;
        }
        field(11; "Appraisal Header"; Text[50])
        {
            TableRelation = "Appraisal Format Header";
        }
        field(12; Value; Text[80])
        {
        }
        field(13; Bold; Boolean)
        {
        }
        field(14; "Line No."; Integer)
        {
        }
        field(15; "Weighting(%)"; Decimal)
        {
        }
        field(22; "Strategic Perspective"; Option)
        {
            OptionCaption = 'Financial,Stakeholder,Internal Business Process,Learning and Growth';
            OptionMembers = Financial,Stakeholder,"Internal Business Process","Learning and Growth";
        }
        field(23; "Performance Ratings(%)"; Decimal)
        {
        }
        field(24; "Weighted Ratings(%)"; Decimal)
        {
        }
    }

    keys
    {
        key(Key1; "Appraisal Code", "Line No.")
        {
        }
        key(Key2; "Appraisal Code", Sequence)
        {
        }
    }

    fieldgroups
    {
    }
}

