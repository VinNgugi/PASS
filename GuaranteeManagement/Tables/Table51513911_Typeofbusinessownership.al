table 51513911 "Type of Business Owership"
{
    Caption = 'Type of Business Owership';
    DataClassification = ToBeClassified;
    DrillDownPageId = "Business Type List";
    LookupPageId = "Business Type List";

    fields
    {
        field(1; Code; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;

        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Ownership Type"; Option)
        {
            OptionMembers = " ",Individual,Company,Partnership,Proprietor,"Cooperatives Societies";
            Caption = 'Ownership Type';
            DataClassification = CustomerContent;
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