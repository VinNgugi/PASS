table 51513801 "Questionnaire Options"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Question Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Questionnaire Setup"."Question Code" where("Answer Type" = filter("Multiple Choices"), "Incubation Code" = field("Incubation Code"));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                QuestionnaireSetup.Reset();
                QuestionnaireSetup.SetRange("Question Code", Rec."Question Code");
                QuestionnaireSetup.SetRange("Incubation Code", Rec."Incubation Code");
                if QuestionnaireSetup.Find('-') then begin
                    Questionnaire := QuestionnaireSetup.Questionnaire;
                end;
            end;

        }
        field(2; "Answer Code"; code[20])
        {
            Editable = false;
        }
        field(3; "Incubation Code"; Code[20])
        {
            Editable = false;
            TableRelation = "Questionnaire Setup"."Incubation Code";
        }
        field(4; Questionnaire; Text[1000])
        {
            Editable = false;
        }
        field(5; "Answer"; Text[1000])
        {

        }
        field(6; "Weighted Points"; Decimal)
        {

        }

    }

    keys
    {
        key(PK; "Question Code", "Incubation Code", "Answer Code")
        {
            Clustered = true;
        }
    }

    var
        QuestionnaireSetup: Record "Questionnaire Setup";

        QuestionnaireOptions: Record "Questionnaire Options";
        NextEntry: Integer;
        TotalOptions: Integer;

    trigger OnInsert()
    begin
        IF "Answer Code" = '' then begin
            NextEntry := 0;
            QuestionnaireOptions.Reset();
            QuestionnaireOptions.SetRange("Incubation Code", Rec."Incubation Code");
            QuestionnaireOptions.SetRange("Question Code", Rec."Question Code");
            if QuestionnaireOptions.FindSet() then
                TotalOptions := QuestionnaireOptions.Count;

            if (TotalOptions = 0) then
                "Answer Code" := "Question Code" + '/' + Format(1)
            else begin
                NextEntry := TotalOptions + 1;
                "Answer Code" := "Question Code" + '/' + Format(NextEntry);
            end;


        end;
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