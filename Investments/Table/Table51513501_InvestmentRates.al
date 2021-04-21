table 51513501 "Investment Rates"
{
    DataClassification = CustomerContent;
    DrillDownPageId = "Investment Rates";
    LookupPageId = "Investment Rates";
    Caption = 'Investment Rates';
    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';

        }
        field(2; Rate; Decimal)
        {
            DataClassification = CustomerContent;
            caption = 'Rate';
        }
        field(3; Type; Option)
        {
            DataClassification = CustomerContent;
            caption = 'Type';
            OptionMembers = ,Interest,"Withholding Tax","Weighted Average";
        }
    }

    keys
    {
        key(PK; Code, Rate)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}