tableextension 51513109 "User Setup Ext" extends "User Setup"
{
    fields
    {
        field(50004; "BDO Code"; Code[20])
        {
            TableRelation = "Salesperson/Purchaser".Code;
        }
        field(50005; "Start Code"; Text[250])
        {
            DataClassification = ToBeClassified;

        }
        field(50006; "Global Dimension 1 Code"; code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Global Dimension 1 Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where ("Global Dimension No." = const (1));
        }

    }
}