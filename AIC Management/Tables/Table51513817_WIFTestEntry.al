table 51513817 "WIF Test Entry"
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
            TableRelation = "Non-Wall Applications";

        }
        field(3; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "WIF Test";
        }
        field(4; "Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "General Questions on the Offering(s)","Personal Attributes of the Entrepreneur",Operations,Finance,Harvest,"Daunting Negatives","The Story","Carpe Diem";
            Editable = false;
        }
        field(5; Question; Text[250])
        {
            Caption = 'Question/Statement';
            Editable = false;
        }
        field(6; "Maximum Score"; Decimal)
        {
            Editable = false;
        }
        field(7; Comment; Text[250])
        {

        }
        field(8; Score; Decimal)
        {
            trigger OnValidate()
            begin
                if WIF.Get(Code) then begin
                    if Score > WIF."Maximum Score" then
                        Error('Score can not be greater than %1', WIF."Maximum Score");
                end;
            end;

        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(PK2; "Application ID", Code)
        {
            Unique = true;
        }
    }

    var
        WIF: Record "WIF Test";

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