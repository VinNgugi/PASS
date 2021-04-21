table 51513904 "Applicant Shortlisting Table"
{
    DataClassification = CustomerContent;
    Caption = 'Applicant Shortlisting Table';

    fields
    {
        field(1; code; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Code';
            Editable = false;

        }
        field(2; "Recruitment Code"; Code[40])
        {
            DataClassification = CustomerContent;
            Caption = 'Recruitment Code';
            Editable = false;
        }
        field(3; "Applicant ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Applicant ID';
            Editable = false;
        }
        field(4; "Interview Type"; Option)
        {
            OptionMembers = " ","Oral Interview","Technical Interview";
            DataClassification = CustomerContent;
            Caption = 'Interview Type';
            Editable = false;
        }
        field(5; "Applicant Name"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Applicant Name';
            Editable = false;
        }
        field(6; "Number of Panel"; Integer)
        {
            //DataClassification = CustomerContent;
            FieldClass = FlowField;
            CalcFormula = count ("Job Interviewers" WHERE ("Recruitment Need" = FIELD ("Recruitment Code"), "Interview Type" = CONST ("Oral Interview")));
            Caption = 'Number of Panel';
            Editable = false;
        }
        field(7; "Average Score"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Average Score';
            Editable = false;
        }
        field(8; "Stage Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Stage Code';
            TableRelation = "Recruitment Stages"."Recruitment Stage";
            Editable = false;
        }

    }

    keys
    {
        key(PK; Code)
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