table 51513137 "Overtime Set Up"
{
    // version PAYROLL
    Caption = 'Overtime Set Up';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[40])
        {
        }
        field(2; Description; Text[80])
        {
        }
        field(3; "Rates Normal"; Decimal)
        {
        }
        field(4; Hours; Decimal)
        {

            trigger OnValidate();
            begin
                if Hours > 0 then
                    "Max Hours Per Month" := ROUND(Hours * 52 / 12, 0.01)
            end;
        }
        field(5; "Max Hours Per Month"; Decimal)
        {
        }
        field(6; "Rates Double"; Decimal)
        {
        }
        field(7; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Weekend,Weekday,Holiday';
            OptionMembers = ,Weekend,Weekday,Holiday;
        }
    }

    keys
    {
        key(Key1; "Code")
        {
        }
    }

    fieldgroups
    {
    }
}

