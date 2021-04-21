table 51513910 "Guarantee Application Stages"
{
    DataClassification = ToBeClassified;
    caption = 'Guarantee Application Stages';

    fields
    {
        field(1; Code; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code';

        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(3; Stage; Option)
        {
            OptionMembers = " ",Application,"Business Plan";
            DataClassification = CustomerContent;
            Caption = 'Stage';
        }
        field(4; Sequence; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Sequence';
        }
    }

    keys
    {
        key(Code; Code)
        {
            Clustered = true;
        }
        key(key2; Stage, Sequence)
        {
            Unique = true;
        }
    }


}