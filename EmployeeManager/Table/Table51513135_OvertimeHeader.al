table 51513135 "Overtime Header"
{
    // version PAYROLL
    DataClassification = CustomerContent;
    Caption = 'Overtime Header';

    fields
    {
        field(1; "Code"; Code[10])
        {
        }
        field(2; "Pay Period"; Date)
        {
            TableRelation = "Payroll Period";

            trigger OnValidate();
            begin
                if PayrollPeriod.GET("Pay Period") then
                    Month := PayrollPeriod.Name;
            end;
        }
        field(3; Month; Text[30])
        {
        }
        field(4; Computed; Boolean)
        {
        }
        field(5; "No. Series"; Code[30])
        {
        }
        field(6; Types; Option)
        {
            OptionCaption = ',Overtime,Bonus';
            OptionMembers = ,Overtime,Bonus;
        }
        field(7; Unit; Code[10])
        {
            CaptionClass = '1,2,7';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (7));

            trigger OnValidate();
            begin
                Dims.RESET;
                Dims.SETRANGE("Global Dimension No.", 7);
                Dims.SETRANGE(Code, Unit);
                if Dims.FIND('-') then
                    "Unit Name" := Dims.Name;
            end;
        }
        field(8; "Unit Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(9; Paid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Description; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Approved';
            OptionMembers = Open,Approved;
        }
        field(12; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Date Prepared"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Prepared By"; Text[100])
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
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Overtime No");
            NoSeriesMgt.InitSeries(HumanResSetup."Overtime No", xRec."No. Series", 0D, Code, "No. Series");
        end;
        if UsrSetup.GET(USERID) then begin
            if Emp.GET(UsrSetup."Employee No.") then
                "Prepared By" := Emp."Last Name" + ' ' + Emp."First Name" + ' ' + Emp."Middle Name";
        end;
        "Date Prepared" := TODAY;
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        PayrollPeriod: Record "Payroll Period";
        Dims: Record "Dimension Value";
        UsrSetup: Record "User Setup";
        Emp: Record Employee;
}

