table 51513802 "Applicant Questionnaire"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Applicant No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Incubation Code"; Code[20])
        {
            Editable = false;
        }
        field(3; "Question Code"; Code[20])
        {
            Editable = false;
        }
        field(4; "Questionnaire"; Text[1000])
        {

        }
        field(5; "Answer Code"; Code[20])
        {
            TableRelation = "Questionnaire Options"."Answer Code" where("Incubation Code" = field("Incubation Code"), "Question Code" = field("Question Code"));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                QuestionOptions.Reset();
                QuestionOptions.SetRange("Answer Code", Rec."Answer Code");
                if QuestionOptions.Find('-') then begin
                    Rec.Answer := QuestionOptions.Answer;
                    "Weighted Points" := QuestionOptions."Weighted Points";
                end
                else begin
                    Answer := '';
                    "Weighted Points" := 0;
                end;

            end;
        }
        field(6; Answer; text[1000])
        {

        }

        field(7; "Entry No"; Integer)
        {

        }
        field(8; "Answer Type"; Option)
        {
            OptionMembers = "Multiple Choices","Qualitative Answers";
        }
        field(9; "Weighted Points"; Decimal)
        {

        }
    }

    keys
    {
        key(PK; "Applicant No", "Question Code", "Entry No")
        {
            Clustered = true;
        }
    }

    var
        QuestionOptions: Record "Questionnaire Options";

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