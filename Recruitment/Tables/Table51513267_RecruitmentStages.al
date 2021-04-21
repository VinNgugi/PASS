table 51513267 "Recruitment Stages"
{
    DataClassification = CustomerContent;
    Caption = 'Recruitment Stages';
    LookupPageId = "Recruitment Stages";
    DrillDownPageId = "Recruitment Stages";

    fields
    {
        field(1; "Recruitment Stage"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Recruitment Stage';
            NotBlank = true;

        }
        field(2; "Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; "Failed Response Templates"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Failed Response Templates';
            TableRelation = "Interaction Template".Code;
        }
        field(4; "Passed Response Templates"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Passed Response Templates';
            TableRelation = "Interaction Template".Code;
        }
    }

    keys
    {
        key(PK; "Recruitment Stage")
        {
            Clustered = true;
        }
    }


}