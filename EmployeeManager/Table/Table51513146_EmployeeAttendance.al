table 51513146 "Employee Attendance"
{
    Caption = 'Employee Attendance';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            Editable = false;

            trigger OnValidate();
            begin
                if Code <> xRec.Code then begin
                    HumanResourcesSetup.GET;
                    NoSeriesMgt.TestManual(HumanResourcesSetup."Time Sheet Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Staff No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate();
            begin
                if Employee.GET("Staff No") then begin
                    "Staff Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";

                    "Time In" := TIME;
                end;
            end;
        }
        field(3; "Staff Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Date; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(6; "Time In"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(7; "Time Out"; Time)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(8; "Entry No"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(9; Offense; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Disciplinary Offenses".Code;

            trigger OnValidate();
            begin
                Offen.RESET;
                Offen.SETRANGE(Offen.Code, Code);
                if Offen.FIND('-') then begin
                    "Offense Detail" := Offen.Description;
                end;
            end;
        }
        field(10; "Offense Detail"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Actual Time In"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Actual Time Out"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Disciplinary Measure"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Disciplinary Actions".Code;
        }
        field(14; "Hours Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
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

    trigger OnInsert();
    begin
        if Code = '' then begin
            HumanResourcesSetup.GET;
            HumanResourcesSetup.TESTFIELD("Time Sheet Nos");
            NoSeriesMgt.InitSeries(HumanResourcesSetup."Time Sheet Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;

    var
        HumanResourcesSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Employee: Record Employee;
        Offen: Record "Disciplinary Offenses";
}

