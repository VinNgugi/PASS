table 51513283 "Job Professional Need"
{
    DataClassification = CustomerContent;
    Caption = 'Job Professional Need';

    fields
    {
        field(1; "Job ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job ID';

        }
        field(2; "Professional Body"; Code[10])
        {
            Caption = 'Professional Body';
            DataClassification = CustomerContent;

        }
        field(3; "Body Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup ("Professional Body".Description WHERE (Code = FIELD ("Professional Body")));
            Caption = 'Body Name';
        }
        field(4; "Professional Level"; code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Professional Level';
        }
        field(5; "Level Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Level Name';
        }
        field(6; "Professional Qualification"; Code[10])

        {
            DataClassification = CustomerContent;
            Caption = 'Professional Qualification';
            TableRelation = Qualification;

            trigger Onvalidate()

            begin
                QualificationRec.RESET;
                QualificationRec.SETRANGE(Code, "Professional Qualification");
                IF QualificationRec.FINDLAST THEN;
                //"Professional Body" := QualificationRec."Professional Body";

            end;
        }
        field(7; "Line No."; Integer)
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

    var
        QualificationRec: Record Qualification;

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