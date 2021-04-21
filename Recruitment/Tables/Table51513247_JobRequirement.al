table 51513247 "Job Requirement"
{
    DataClassification = CustomerContent;
    Caption = 'Job Requirement';
    DrillDownPageId = "Job Requirement Lines";
    LookupPageId = "Job Requirement Lines";

    fields
    {
        field(1; "Job ID"; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Job ID';
            TableRelation = "Company Jobs"."Job ID";
            NotBlank = TRUE;

        }
        field(2; "Qualification Type"; Option)
        {
            OptionMembers = ,Academic,Professional,Technical,Experience,"Personal Attributes";
            DataClassification = CustomerContent;
            Caption = 'Qualification Type';
            NotBlank = true;
        }
        field(3; "Qualification Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Qualification Code';
            NotBlank = true;
            TableRelation = Qualification.Code WHERE ("Qualification Type" = FIELD ("Qualification Type"));


            trigger Onvalidate()

            begin
                QualificationSetUp.RESET;
                QualificationSetUp.SETRANGE(QualificationSetUp.Code, "Qualification Code");
                IF QualificationSetUp.FIND('-') THEN
                    Qualification := QualificationSetUp.Description;
            end;
        }
        field(4; Qualification; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Qualification';
            NotBlank = true;
        }
        field(5; "Job Requirements"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Requirements';
            NotBlank = true;
        }
        field(6; Priority; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Priority';
            OptionMembers = ,High,Medium,Low;
        }
        field(7; "Job Specification"; Option)
        {
            Caption = 'Job Specification';
            OptionMembers = ,Academic,Professional,Technical,Experience;
            DataClassification = CustomerContent;
        }
        field(8; "Score ID"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score ID';
            TableRelation = "Score Setup"."Score ID";
        }
    }

    keys
    {
        key(PK; "Job Id", "Qualification Type", "Qualification Code")
        {
            SumIndexFields = "Score ID";
        }
    }

    var
        QualificationSetUp: Record Qualification;

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