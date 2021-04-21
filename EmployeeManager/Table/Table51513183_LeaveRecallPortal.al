table 51513183 "Leave Recall Portal"
{
    Caption = 'Leave Recall Portal';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Leave Application No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Days Applied"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Supervisor Emp No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Leave Code"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Leave Application No")
        {
        }
    }

    fieldgroups
    {
    }
}

