table 51513507 "Investment Interest Buffer"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Investment Interest Buffer";
    DrillDownPageId = "Investment Interest Buffer";

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(2; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(3; "Interest Date"; Date)
        {
            Caption = 'Interest Date';
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(4; "Interest Amount"; Decimal)
        {
            Caption = 'Interest Amount';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(5; "Captured By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(6; Transfered; Boolean)
        {
            Caption = 'Transfered';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Date Transfered"; Date)
        {
            Caption = 'Date Transfered';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Transfered By"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = User."User Name";
        }
        field(9; "W/H Tax Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }

    }

    keys
    {
        key(PK; "Entry No", "Document No.")
        {
            Clustered = true;
        }
    }

}