table 51513414 "Job Required Documents"
{
    DataClassification = CustomerContent;
    Caption = 'Job Required Documents';

    fields
    {
        field(1; "Recruitment Req. No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Recruitment Req. No.';
            TableRelation = "Recruitment Needs"."No.";

        }
        field(2; "Document Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Description';
        }
        field(3; Mandatory; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Mandatory';
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            AutoIncrement = true;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Recruitment Req. No.", "Line No.", "Document Description")
        {

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