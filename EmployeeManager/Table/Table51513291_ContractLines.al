table 51513291 "Contract Lines"
{
    // version HR
    Caption = 'Contract Lines';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Contract No"; Code[20])
        {
        }
        field(2; Cost; Decimal)
        {
        }
        field(3; Quantity; Integer)
        {
        }
        field(4; "Posting Date"; Date)
        {
        }
        field(5; Descriptison; Text[100])
        {
        }
        field(6; "Line no"; Integer)
        {
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Contract No", "Line no")
        {
        }
    }

    fieldgroups
    {
    }
}

