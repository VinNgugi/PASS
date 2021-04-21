table 51513161 "Payroll Batches"
{
    Caption = 'Payroll Batches';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Batch No"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin

                if "Batch No" <> xRec."Batch No" then begin
                    HumanResSetup.GET;
                    NoSeriesMgt.TestManual(HumanResSetup."Vehicle Filling No");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Batch Name"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Pay Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Closed,Discarded,Paid';
            OptionMembers = Open,Closed,Discarded,Paid;
        }
        field(5; "Payroll Period"; Date)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payroll Period"."Starting Date";
        }
        field(6; "Payroll Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Staff Posting Group".Code;
        }
        field(7; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Batch No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "Batch No" = '' then begin
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD("Vehicle Filling No");
            NoSeriesMgt.InitSeries(HumanResSetup."Vehicle Filling No", xRec."No. Series", 0D, "Batch No", "No. Series");
        end;
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
}

