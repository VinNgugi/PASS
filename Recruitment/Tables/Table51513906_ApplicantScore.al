table 51513906 "Applicant Score"
{
    DataClassification = CustomerContent;
    Caption = 'Applicant Score';

    fields
    {
        field(1; "Applicant No."; Code[20])
        {
            Caption = 'Applicant No.';
            DataClassification = CustomerContent;

        }
        field(2; Score; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Score';
        }
    }

    keys
    {
        key(PK; Score, "Applicant No.")
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