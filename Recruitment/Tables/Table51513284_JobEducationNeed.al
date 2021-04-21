table 51513284 "Job Education Need"
{
    DataClassification = CustomerContent;
    Caption = 'Job Education Need';

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job ID';
            TableRelation = "Company Jobs";

        }
        field(2; "Education Level"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Education Level';
            TableRelation = "Academic Education Level";

            trigger OnValidate()

            begin
                AcademicEducationLevelRec.RESET;
                AcademicEducationLevelRec.SETRANGE("Level Code", "Education Level");
                IF AcademicEducationLevelRec.FINDFIRST THEN
                    "Education Level Name" := AcademicEducationLevelRec."Level Name";

            end;
        }
        field(3; "Education Level Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Educational Level Name';
        }
        field(25; Grade; Text[250])
        {
            Caption = 'Grade';
            DataClassification = CustomerContent;
        }
        field(26; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Job ID", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        AcademicEducationLevelRec: Record "Academic Education Level";

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