table 51513819 "Residential Assessment"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Application ID"; Code[20])
        {
            Editable = false;
            DataClassification = ToBeClassified;
            TableRelation = "Incubation Applicants";

        }
        field(3; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Residential Selection Test";

        }
        field(4; Question; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(5; Comment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Score"; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                Message(Code);
                if AssScore.Get(Code) then begin

                    if Score > AssScore."Maximum Score" then
                        Error('Score can not be greater than %1', AssScore."Maximum Score");
                end;
            end;

        }
        field(7; "Incubation Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Incubation;
            Editable = false;
        }
        field(8; Selection; Option)
        {
            Editable = false;
            OptionMembers = " ","Business Skills","Technical Training","Face to Face Interviews";
        }
        field(9; "Residential Selection No."; Code[20])
        {
            TableRelation = "Residential Selection Header";
            Editable = false;
        }
        field(10; Submitted; Boolean)
        {

        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(PK2; Code, "Application ID", "Incubation Code")
        {
            Unique = true;
        }
    }

    var
        AssScore: Record "Residential Selection Test";

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