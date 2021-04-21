table 51513006 "Group Member"
{
    DataClassification = CustomerContent;
    Caption = 'Group Member';

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            //TableRelation = "Guarantee Application";
            //Editable = false;

        }
        field(2; "Member Code"; code[10])
        {
            Caption = 'Member Code';
            DataClassification = CustomerContent;
        }
        field(3; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(4; "Gender"; Option)
        {
            OptionMembers = ,Male,Female;
            DataClassification = CustomerContent;
            caption = 'Gender';
        }

        field(5; "Applied Amount"; Decimal)
        {
            Caption = 'Applied Amount';
            DataClassification = CustomerContent;

        }
        field(50600; "CGC Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'CGC Date';
        }
        field(50601; "Certificate Start Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Certificate Start Date';
        }
        field(50602; "Certificate Expiry Date"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Certificate Expiry Date';
        }
        field(50603; "Certificate No."; Text[50])
        {
            DataClassification = CustomerContent;
            caption = 'Certificate No.';
        }
        field(50604; "Certificate Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Certificate Amount';
        }
        field(50605; "CGF %"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'CGF %';
        }
        field(50606; "Comm. %"; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Comm. %';
        }
        field(50608; "Loan No."; code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Loan No.';
        }
        field(50609; "Date of Birth"; Date)
        {
            DataClassification = CustomerContent;
            caption = 'Date of Birth';

            trigger OnValidate()

            begin
                if "Date of Birth" <> 0D THEN
                    Age := DATE2DMY(TODAY, 3) - DATE2DMY("Date of Birth", 3);

            end;
        }
        field(50610; Age; Integer)
        {
            Caption = 'Age';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50611; Education; Text[100])
        {
            Caption = 'Education';
            DataClassification = CustomerContent;
        }
        field(50612; Occupation; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Occupation';
        }
        field(50613; Position; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Position';
        }

    }

    keys
    {
        key(PK; "No.", "Member Code")
        {

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