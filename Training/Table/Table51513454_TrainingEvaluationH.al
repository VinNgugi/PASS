table 51513454 "Training Evaluation H"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;

        }
        field(2; "No. Series"; Code[20])
        {
            Editable = false;
        }
        field(3; "Document Date"; Date)
        {
            Editable = false;
        }
        field(4; "Created By"; Code[20])
        {
            Editable = false;
        }
        field(5; "Employee No"; Code[20])
        {
            Editable = false;
        }
        field(6; "Employee Name"; Text[100])
        {
            Editable = false;
        }
        field(7; "Training No."; Code[20])
        {
            TableRelation = "Training Participants Lines"."Training Header No." where ("Employee No." = field ("Employee No"));
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if TrainingHeader.Get("Training No.") then begin
                    "Training Description" := TrainingHeader."Training Description";
                    "Training Provider" := TrainingHeader."Training Provider";
                    "Provider Name" := TrainingHeader."Training Provider Name";

                    TrainingMgmt.FnInsertEvaluationEntries(Rec);

                end
                else begin
                    "Training Description" := '';
                    "Training Provider" := '';
                    "Provider Name" := '';

                end;
            end;
        }
        field(8; "Training Description"; Text[100])
        {
            Editable = false;
        }
        field(9; "Training Provider"; Code[20])
        {
            Editable = false;
        }
        field(10; "Provider Name"; Text[100])
        {
            Editable = false;
        }
        field(11; "Trainer Name"; Text[100])
        {

        }

    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    var
        Employee: Record Employee;
        UserSetup: Record "User Setup";
        TrainingHeader: Record "Training Plan";
        TrainingMgmt: Codeunit "Training Management";
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin

        if "No." = '' then begin
            HumanResSetup.GET;
            HumanResSetup.TESTFIELD(HumanResSetup."Training Evaluation Nos");
            NoSeriesMgt.InitSeries(HumanResSetup."Training Evaluation Nos", xRec."No. Series", 0D, "No.", "No. Series");

            "Document Date" := Today;
            "Created By" := UserId;

            if UserSetup.Get("Created By") then begin
                UserSetup.TestField("Employee No.");
                "Employee No" := UserSetup."Employee No.";
                if Employee.Get("Employee No") then begin
                    "Employee Name" := Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                end;
            end;

        end;

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