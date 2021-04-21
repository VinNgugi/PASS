table 51513356 "Applicant Interview Lines"
{
    DataClassification = CustomerContent;
    Caption = 'Applicant Interview Lines';

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
            Caption = 'Recruitment Code';
            Editable = false;
        }
        field(4; "Applicant ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Applicant ID';
            Editable = false;
        }
        field(5; "Interview Type"; Option)
        {
            OptionMembers = " ","Oral Interview","Technical Interview";
            Caption = 'Interview Type';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(6; "User ID"; Code[80])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            Editable = false;
        }
        field(7; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
            Editable = false;
        }
        field(8; Score; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';

            trigger OnValidate()

            begin
                IF Score > "Maximum Score" THEN
                    ERROR('The Score Cannot be More than %1', "Maximum Score");

            end;
        }
        field(9; "Maximum Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Maximum Score';
            Editable = false;
        }
        field(10; Remarks; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(11; Submitted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Submitted';
        }
        field(12; "Stage Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Stage Code';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Line Number", Code)
        {

        }
    }



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