table 51513998 "Company Shareholders"
{
    DataClassification = CustomerContent;

    fields
    {

        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Share Holders Name"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(4; "VAT No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Licence No."; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Business Registration"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(7; "No. Series"; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(8; Address; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(9; Telephone; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; Fax; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(11; Email; Text[30])
        {

        }

        field(12; "ID No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Share % Allocation"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; Gender; Option)
        {
            OptionMembers = " ",Female,Male;
        }
        field(15; "Date of Birth"; Date)
        {
            trigger OnValidate()

            begin
                if "Date of Birth" <> 0D THEN
                    Age := DATE2DMY(TODAY, 3) - DATE2DMY("Date of Birth", 3);
            end;

        }
        field(16; Age; Integer)
        {
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.", "Share Holders Name")
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