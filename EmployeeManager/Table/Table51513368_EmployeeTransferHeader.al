table 51513368 "Employee Transfer Header"
{
    // version HR

    Caption = 'Employee Transfer Header';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
        }
        field(2; "Date Created"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date Created';
        }
        field(3; "Effective Transfer Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Effective Transfer Date';
        }
        field(4; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionCaption = ',Open,Pending Approval,Released';
            OptionMembers = ,Open,"Pending Approval",Released;
        }
        field(5; "User Id"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "User Setup";
            Caption = 'User Id';
        }
        field(6; "No. Series"; Code[10])
        {
            DataClassification = CustomerContent;
            TableRelation = "No. Series";
            Caption = 'No. Series';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        "User Id" := USERID;
        if "No." = '' then begin
            HumanResSetup.GET;
            //HumanResSetup.TESTFIELD("Employee Transfer Nos");
            // NoSeriesMgt.InitSeries(HumanResSetup."Employee Transfer Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Date Created" := TODAY;
    end;

    var
        HumanResSetup: Record "Human Resources Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
}

