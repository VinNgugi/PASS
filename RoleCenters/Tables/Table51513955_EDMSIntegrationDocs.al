table 51513955 "EDMS Integration Docs"
{
    Caption = 'EDMS Integration Docs';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; DocLinkID; Integer)
        {
            Caption = 'DocLinkID';
            DataClassification = ToBeClassified;
        }
        field(2; DocumentNo; Code[20])
        {
            Caption = 'DocumentNo';
            DataClassification = ToBeClassified;
        }
        field(3; DocID; Integer)
        {
            Caption = 'DocID';
            DataClassification = ToBeClassified;
        }
        field(4; DocSource; Text[50])
        {
            Caption = 'DocSource';
            DataClassification = ToBeClassified;
        }
        field(5; DocFile; Code[30])
        {
            Caption = 'DocFile';
            DataClassification = ToBeClassified;
        }
        field(6; DocLink; Text[150])
        {
            Caption = 'DocLink';
            DataClassification = ToBeClassified;
        }
        field(7; EntryDate; DateTime)
        {
            Caption = 'EntryDate';
            DataClassification = ToBeClassified;
        }
        field(8; InstanceID; Integer)
        {
            Caption = 'InstanceID';
            DataClassification = ToBeClassified;
        }
        field(9; FolderLink; Text[150])
        {
            Caption = 'FolderLink';
            DataClassification = ToBeClassified;
        }

        field(10; PFNumber; Code[20])
        {
            Caption = 'PFNumber';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; DocLinkID)
        {
            Clustered = true;
        }
    }

}
