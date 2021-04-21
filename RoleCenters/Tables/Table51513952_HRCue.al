table 51513952 "HR Cue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[200])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Employee-Active"; Integer)
        {
            FieldClass = FlowField;
            caption = 'Employee-Active';
            CalcFormula = count (Employee where (Status = filter (Active)));
        }
        field(3; "Employee-Male"; Integer)
        {
            FieldClass = FlowField;
            caption = 'Employee-Male';
            CalcFormula = count (Employee where (Status = filter (Active), Gender = filter (Male)));
        }
        field(4; "Employee-Female"; Integer)
        {
            FieldClass = FlowField;
            caption = 'Employee-Female';
            CalcFormula = count (Employee where (Status = filter (Active), Gender = filter (Female)));
        }

        field(5; "Employee-InActive"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Employee-InActive';
            CalcFormula = count (Employee where (Status = filter (<> Active)));
        }
        field(9; "User Filter"; Code[50])
        {
            FieldClass = FlowFilter;

        }
        field(12; "Requests to Approve"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count ("Approval Entry" WHERE ("Approver ID" = FIELD ("User Filter"), Status = FILTER (Open)));
        }
        field(13; "My Approval Requests"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count ("Approval Entry" WHERE ("Sender ID" = FIELD ("User Filter"), Status = FILTER (Open)));

        }
        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Primary Key")
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