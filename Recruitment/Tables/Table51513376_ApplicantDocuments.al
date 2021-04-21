table 51513376 "Applicant Documents"
{
    DataClassification = CustomerContent;
    Caption = 'Applicant Documents';

    fields
    {
        field(1; "Applicant No "; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Job Applicants"."No.";
            Caption = 'Applicant No';
            NotBlank = true;


        }
        field(2; "Document Description"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Description';
            NotBlank = true;
        }
        field(3; "Document Link"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Link';
            ExtendedDatatype = url;

            trigger OnValidate()

            begin
                IF "Document Link" <> '' THEN
                    Attached := TRUE
                ELSE
                    Attached := FALSE;

            end;
        }
        field(4; Attached; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Attached';
            Editable = false;
        }
        field(5; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
            AutoIncrement = true;
        }
    }

    keys
    {
        key(PK; "Applicant No ", "Document Description", "Line No.")
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