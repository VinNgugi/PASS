table 51513818 "Residential Selection Test"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; Question; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(3; Comment; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Maximum Score"; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(5; "Incubation Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Incubation;
            Editable = false;
        }
        field(6; Selection; Option)
        {
            //Editable = false;
            OptionMembers = " ","Business Skills","Technical Training","Face to Face Interviews";
        }
    }

    keys
    {
        key(PK; Code, "Incubation Code")
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