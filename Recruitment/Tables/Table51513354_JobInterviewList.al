table 51513354 "Job Interview List"
{
    DataClassification = ToBeClassified;
    Caption = 'ob Interview List';

    fields
    {
        field(1; "Recruitment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Recruitement No.';
            TableRelation = "Recruitment Needs";
            Editable = false;

        }
        field(2; "Interview Type"; Option)
        {
            OptionMembers = " ","Oral Interview","Technical Interview";
            DataClassification = CustomerContent;
            Caption = 'Interview Type';
        }
        field(3; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(4; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(5; Score; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }
        field(6; "Maximum Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Score';
        }
        field(7; "Stage Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Stage Code';
            TableRelation = "Recruitment Stages"."Recruitment Stage";
        }
    }

    keys
    {
        key(PK; "Recruitment No.", "Interview Type", "Line No")
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