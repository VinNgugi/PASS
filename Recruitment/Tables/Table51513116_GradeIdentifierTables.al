table 51513116 "Grade Identifier Tables"
{
    DataClassification = CustomerContent;
    Caption = 'Grade Identifier Tables';

    fields
    {
        field(1; "Identifier Code"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Identifier Code';

        }
        field(2; "Identifier Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Identifier Description';
        }
        field(3; "Effective Starting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Starting Date';
        }
        field(4; "Effective End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective End Date';
        }
        field(5; Annual; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Annual';
        }
    }

    keys
    {
        key(IdentifierCode; "Identifier Code")
        {
            Clustered = true;
        }
    }



}