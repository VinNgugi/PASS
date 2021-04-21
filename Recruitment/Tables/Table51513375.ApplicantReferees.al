table 51513375 "Applicant Referees"
{
    DataClassification = CustomerContent;
    Caption = 'Applicant Referees';

    fields
    {
        field(1; No; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No';

        }
        field(2; Names; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Names';
        }
        field(3; Designation; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Designation';
        }
        field(4; Company; Text[100])
        {
            Caption = 'Company';
            DataClassification = CustomerContent;
        }
        field(5; Address; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(6; "Telephone No"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Telephone No';
            ExtendedDatatype = PhoneNo;
        }
        field(7; "E-Mail"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(8; "Line No"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No';
            AutoIncrement = true;
        }
        field(9; Notes; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Notes';
        }
    }

    keys
    {
        key(PK; No, "Line No")
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