table 51513503 "Investment Company"
{
    DataClassification = CustomerContent;
    Caption = 'Investment Company';
    fields
    {
        field(1; "Company Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Investment Company';

        }
        field(2; "Company Name"; Text[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Company Name';
        }
        field(3; "Company Branch Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Company Branch Code';
        }
        field(4; "Company Branch Name"; Code[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Company Branch Name';
        }
        field(5; Address; Code[150])
        {
            DataClassification = CustomerContent;
            Caption = 'Address';
        }
        field(6; City; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }
        field(7; Telephone; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Telephone';
            ExtendedDatatype = PhoneNo;
        }
        field(8; "E-Mail"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'E-Mail';
            ExtendedDatatype = EMail;
        }
        field(9; "Post Code"; Code[50])
        {
            DataClassification = CustomerContent;
            caption = 'Post Code';
        }
    }

    keys
    {
        key(PK; "Company Code")
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

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}