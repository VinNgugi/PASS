table 51513133 "Email Sent"
{
    // version PAYROLL
    Caption = 'Email Sent';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {

            trigger OnValidate();
            begin
                if Code <> xRec.Code then begin
                    HRSetup.GET;
                    NoSeriesMgt.TestManual(HRSetup."Email Nos");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Recepient Email"; Text[50])
        {
        }
        field(3; "Sender Email"; Text[50])
        {
        }
        field(4; "Subject REF"; Text[100])
        {
        }
        field(5; "Date Sent"; Date)
        {
        }
        field(6; Sender; Code[100])
        {
        }
        field(7; "Time Sent"; Time)
        {
        }
        field(8; "No. Series"; Code[50])
        {
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
            HRSetup.GET;
            HRSetup.TESTFIELD("Email Nos");
            NoSeriesMgt.InitSeries(HRSetup."Email Nos", xRec."No. Series", 0D, Code, "No. Series");
        end;
    end;

    var
        NoSeriesMgt: Codeunit NoSeriesManagement;
        HRSetup: Record "Human Resources Setup";
}

