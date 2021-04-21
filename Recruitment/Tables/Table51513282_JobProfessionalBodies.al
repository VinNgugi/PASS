table 51513282 "Job Professional Bodies"
{
    DataClassification = customercontent;
    Caption = 'Job Professional Bodies';

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job ID';
        }
        field(2; "Professional Body"; code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Professional Body';
            TableRelation = "Professional Body";
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(PK; "Job ID", "Line No.")
        {
            Clustered = true;
        }
    }



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