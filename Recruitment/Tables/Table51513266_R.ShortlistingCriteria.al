table 51513266 "R. Shortlisting Criteria"
{
    DataClassification = CustomerContent;
    Caption = 'R. Shortlisting Criteria';

    fields
    {
        field(1; "Need Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Need Code';
            TableRelation = "Recruitment Needs"."No.";

        }
        field(2; "Stage Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Stage Code';
            TableRelation = "Recruitment Stages"."Recruitment Stage";
        }
        field(3; "Job ID"; code[20])
        {
            Caption = 'Job ID';
            DataClassification = CustomerContent;
            TableRelation = "Company Jobs"."Job ID";
        }
        field(4; "Qualification Type"; Option)
        {
            OptionMembers = ,Academic,Professional,Technical,Experience,"Personal Attributes","Professional Membership";
            Caption = 'Qualification Type';
            DataClassification = CustomerContent;
        }
        field(5; Qualification; Code[20])
        {
            Caption = 'Qualification';
            DataClassification = CustomerContent;
            TableRelation = "Job Requirement"."Qualification Code" WHERE ("Qualification Type" = FIELD ("Qualification Type"), "Job Id" = FIELD ("Job ID"));

            trigger onvalidate()

            begin

                QualificationsRec.RESET;
                IF QualificationsRec.GET(Qualification) THEN
                    "Qualification Description" := QualificationsRec.Description;

                JobRec.Reset();
                JobRec.SetRange(Qualification, JobRec."Qualification Code");
                if JobRec.FindFirst() then
                    "Desired Core" := JobRec."Score ID";

            end;
        }
        field(6; "Desired Core"; Decimal)
        {
            Caption = 'Desired Core';
            DataClassification = CustomerContent;
            TableRelation = "Score Setup"."Score ID";

        }
        field(7; "Qualification Description"; Text[250])
        {
            Caption = 'Qualification Description';
            DataClassification = CustomerContent;
        }
        field(8; "Criterion"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortlisting Criterion';
            TableRelation = "Shortlisting Criterion";

            trigger OnValidate()

            begin
                IF CriterionRec.GET(Criterion) THEN
                    "Criterion Description" := CriterionRec.Description;
            end;
        }
        field(9; "Criterion Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Criterion Description';
        }

    }

    keys
    {
        key(PK; "Need Code", "Stage Code", "Job ID", "Qualification Type", Qualification)
        {
            Clustered = true;
            SumIndexFields = "Desired Core";
        }
    }

    var
        QualificationsRec: Record Qualification;
        CriterionRec: Record "Shortlisting Criterion";
        JobRec: Record "Job Requirement";

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