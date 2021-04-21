table 51513180 "Casuals Payments"
{
    Caption = 'Casuals Payments';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                if Code <> xRec.Code then begin
                    HumanResSetup.GET;
                    NoSeriesMgt.TestManual(HumanResSetup."Casuals Payment Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Period"."Starting Date" WHERE (Closed = CONST (false));
        }
        field(3; Unit; Code[10])
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (7));

            trigger OnValidate();
            begin
                Dims.RESET;
                Dims.SETRANGE(Code, Unit);
                Dims.SETRANGE("Global Dimension No.", 7);
                if Dims.FIND('-') then
                    "Unit Name" := Dims.Name;
            end;
        }
        field(4; "Date Prepared"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Unit Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Approved,Rejected';
            OptionMembers = Open,Approved,Rejected;
        }
        field(8; "Prepared By"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Batch No"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Batches"."Batch No" WHERE (Status = CONST (Open));
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
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Casuals Payment Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Casuals Payment Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
        if UserSetup.GET(USERID) then begin
            if Emp.GET(UserSetup."Employee No.") then
                "Prepared By" := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
        end;
        "Date Prepared" := TODAY;
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        UserSetup: Record "User Setup";
        Emp: Record Employee;
        Dims: Record "Dimension Value";
}

