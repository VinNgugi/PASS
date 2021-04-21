table 51513194 "Age Based Calculations"
{
    Caption = 'Age Based Calculations';
    DataClassification = CustomerContent;

    fields
    {
        field(1; No; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Earning,Deduction';
            OptionMembers = ,Earning,Deduction;
        }
        field(3; "Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST (Earning)) Earnings.Code WHERE ("Calculation Method" = CONST ("Based on Age"))
            ELSE
            IF (Type = CONST (Deduction)) Deductions.Code WHERE ("Calculation Method" = CONST ("Based on Age"));
        }
        field(4; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
        }
    }

    fieldgroups
    {
    }
}

