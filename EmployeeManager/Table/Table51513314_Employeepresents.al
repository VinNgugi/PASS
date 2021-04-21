table 51513314 "Employee presents"
{
    // version HR

    Caption = 'Employee presents';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Employee No."; Text[30])
        {
        }
        field(2; Name; Text[50])
        {
        }
        field(3; Description; Text[200])
        {
            Description = 'To include leave type';
        }
        field(4; "Start date"; Date)
        {
        }
        field(5; "End Date"; Date)
        {
        }
        field(6; Location; Text[120])
        {
        }
    }

    keys
    {
        key(Key1; "Employee No.")
        {
        }
    }

    fieldgroups
    {
    }
}

