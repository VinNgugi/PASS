table 51513150 "Casual Requisition Line"
{
    caption = 'Casual Requisition Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Needs"."No.";
        }
        field(2; "Line No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(3; "First Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            var
                Reason: Text[30];
            begin
            end;
        }
        field(7; "Home Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Cellular Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Work Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "E-Mail"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Postal Address"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Postal Address2"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Residential Address"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Residential Address2"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "NOK Home Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "NOK Cellular Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "NOK Work Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "NOK E-Mail"; Text[120])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "NOK Postal Address"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "NOK Postal Address2"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "NOK Residential Address"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "NOK Residential Address2"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "NOK First Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "NOK Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "NOK Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            var
                Reason: Text[30];
            begin
            end;
        }
    }

    keys
    {
        key(Key1; "Line No")
        {
        }
    }

    fieldgroups
    {
    }
}

