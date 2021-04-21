table 51513816 "WIF Test"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "General Questions on the Offering(s)","Personal Attributes of the Entrepreneur",Operations,Finance,Harvest,"Daunting Negatives","The Story","Carpe Diem";
        }
        field(3; Question; Text[250])
        {
            Caption = 'Question/Statement';
        }
        field(4; "Maximum Score"; Decimal)
        {

        }
        field(5; Comment; Text[250])
        {

        }
    }

    keys
    {
        key(PK; Code)
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