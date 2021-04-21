table 51513377 "Applicant Comments/Views"
{
    DataClassification = CustomerContent;
    Caption = 'Applicant Comments/Views';

    fields
    {
        field(1; "Applicant No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Applicant No';

        }
        field(2; Date; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date';
        }
        field(3; "Views/Comments"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Views/Comments';
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.';
        }
    }

    keys
    {
        key(PK; "Applicant No", "Line No.")
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