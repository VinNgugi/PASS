table 51513315 "HR Leave Periods"
{
    // version HR

    Caption = 'Leave Periods';
    DrillDownPageID = "HR Leave Period List";
    LookupPageID = "HR Leave Period List";
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            NotBlank = true;

            trigger OnValidate();
            begin
                Name := FORMAT("Starting Date", 0, Text000);
                "Period Code" := FORMAT(DATE2DMY("Starting Date", 3));
                "Period Description" := "Period Code" + ' Leave Period';
                VALIDATE("Ending Date");
            end;
        }
        field(2; Name; Text[10])
        {
            Caption = 'Name';
            Editable = false;
        }
        field(3; "New Fiscal Year"; Boolean)
        {
            Caption = 'New Fiscal Year';

            trigger OnValidate();
            begin
                TESTFIELD("Date Locked", false);
            end;
        }
        field(4; Closed; Boolean)
        {
            Caption = 'Closed';
            Editable = false;
        }
        field(5; "Date Locked"; Boolean)
        {
            Caption = 'Date Locked';
            Editable = false;
        }
        field(6; "Reimbursement Clossing Date"; Boolean)
        {
        }
        field(7; "Period Description"; Text[150])
        {
        }
        field(8; "Period Code"; Code[10])
        {
        }
        field(9; "Ending Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                "Ending Date" := CALCDATE('1Y-1D', "Starting Date");
            end;
        }
    }

    keys
    {
        key(Key1; "Starting Date", "Period Code")
        {
        }
        key(Key2; "New Fiscal Year", "Date Locked")
        {
        }
        key(Key3; Closed)
        {
        }
        key(Key4; "Period Code")
        {
        }
    }

    fieldgroups
    {
    }

    var
        Text000: Label '<Month Text>';
        AccountingPeriod2: Record "HR Leave Periods";
        InvtSetup: Record "Inventory Setup";

    procedure UpdateAvgItems();
    begin
    end;
}

