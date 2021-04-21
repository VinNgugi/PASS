table 51513173 "Employment Provisions"
{
    Caption = 'Employment Provisions';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Staff Group"; Code[20])
        {
            Caption = 'Staff Group';
            DataClassification = CustomerContent;
        }
        field(2; Provision; Code[20])
        {
            Caption = 'Provision';
            DataClassification = CustomerContent;
            TableRelation = IF (Type = CONST (Earning)) Earnings.Code
            ELSE
            IF (Type = CONST (Deduction)) Deductions.Code WHERE (Provision = CONST (true));
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionMembers = ,Earning,Deduction;
        }
        field(4; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Staff Group", Provision)
        {
        }
    }

    fieldgroups
    {
    }
}

