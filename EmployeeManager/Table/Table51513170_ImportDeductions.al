table 51513170 "Import Deductions"
{
    Caption = 'Import Deductions';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Deduction Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Deductions.Code;
        }
        field(3; Description; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Period"."Starting Date";
        }
        field(5; "Deduction Added"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No. Series"; Code[10])
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
            HumanResSetup.TESTFIELD("Deduction Import No");
            NoSeriesMgt.InitSeries(HumanResSetup."Deduction Import No", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

