table 51513800 "Questionnaire Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Incubation Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Incubation;
            Editable = false;
        }
        field(2; "Question Code"; Code[20])
        {

        }
        field(3; "Questionnaire"; Text[1000])
        {

        }
        field(4; "Answer Type"; Option)
        {
            OptionMembers = "Multiple Choices","Qualitative Answers";

        }
        field(5; "No. Series"; Code[20])
        {
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Incubation Code", "Question Code")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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