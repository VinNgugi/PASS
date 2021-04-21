table 51513912 "Required Documents"
{
    DataClassification = CustomerContent;
    Caption = 'Required Documents';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            TableRelation = "Type of Business Owership";

        }
        field(2; "Line No."; integer)
        {
            DataClassification = CustomerContent;
            caption = 'Line No.';
            AutoIncrement = true;
        }
        field(3; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(4; Mandatory; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Mandatory';

        }
    }

    keys
    {
        key(PK; Code, "Line No.", Description)
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