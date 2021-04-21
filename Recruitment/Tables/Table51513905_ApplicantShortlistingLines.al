table 51513905 "Applicant Shortlisting Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Applicant Shortlisting Lines';

    fields
    {
        field(1; "Line Number"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Number';
            Editable = false;

        }
        field(2; Code; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            Editable = false;
        }
        field(3; "Recruitment Code"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Recruitment Code';
            Editable = false;
        }
        field(4; "Applicant ID"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Applicant ID';
            Editable = false;
        }
        field(5; "Interview Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Interview Type';
            OptionMembers = " ","Oral Interview","Technical Interview";
            Editable = false;
        }
        field(6; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            Editable = false;
        }
        field(7; "Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }
        field(8; Score; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
            trigger onValidate()
            var

            begin
                IF Score > "Maximamum Score" THEN
                    ERROR('The Score Cannot be More than %1', "Maximamum Score");

            end;
        }
        field(9; "Maximamum Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximamum Score';
            Editable = false;
        }
        field(10; Submitted; Boolean)
        {
            DataClassification = CustomerContent;
            caption = 'Submitted';
        }
        field(11; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(12; "Stage Code"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Stage Code';
            TableRelation = "Recruitment Stages"."Recruitment Stage";
            Editable = false;
        }
    }

    keys
    {
        key(ke; "Line Number", Code)
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
        IF "User ID" <> USERID THEN
            ERROR('You have No Rights To make changes to this Oral Interview!');

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}