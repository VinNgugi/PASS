table 51513602 "Default Reasons"
{
    Caption = 'Default Reasons';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            Caption = 'Entry No';
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; "Reasons For Default"; Code[30])
        {
            Caption = 'Reasons For Default';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Entry No", "Reasons For Default")
        {
            Clustered = true;
        }
    }

}
