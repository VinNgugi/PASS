table 51513110 "Bracket Tables"
{
    // version PAYROLL

    DrillDownPageID = "Bracket Tables";
    LookupPageID = "Bracket Tables";
    Caption = 'Bracket Tables';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Bracket Code"; Code[10])
        {
            Caption = 'Bracket Code';
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; "Bracket Description"; Text[80])
        {
            Caption = 'Bracket Description';
            DataClassification = CustomerContent;
        }
        field(3; "Effective Starting Date"; Date)
        {
            Caption = 'Effective Starting Date';
            DataClassification = CustomerContent;
        }
        field(4; "Effective End Date"; Date)
        {
            Caption = 'Effective End Date';
            DataClassification = CustomerContent;
        }
        field(5; Annual; Boolean)
        {
            Caption = 'Annual';
            DataClassification = CustomerContent;
        }
        field(6; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Fixed,Graduating Scale';
            OptionMembers = "Fixed","Graduating Scale";
        }
        field(7; NHIF; Boolean)
        {
            Caption = 'NHIF';
            DataClassification = CustomerContent;
        }
        field(8; "Tax Computation Method"; Option)
        {
            Caption = 'Tax Computation Method';
            DataClassification = CustomerContent;
            OptionCaption = '" ,Tax Bracket,Progressive"';
            OptionMembers = " ","Tax Bracket",Progressive;
        }
        field(9; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = CustomerContent;
            TableRelation = "Country/Region";
        }
    }

    keys
    {
        key(Key1; "Bracket Code")
        {
        }
    }

    fieldgroups
    {
    }
}

