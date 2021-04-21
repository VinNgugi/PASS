table 51513308 "Medical Claim Header"
{
    // version HR

    DrillDownPageID = Attachments;
    LookupPageID = Attachments;

    fields
    {
        field(1; "Claim No"; Code[20])
        {
            Caption = 'Claim No';
            DataClassification = CustomerContent;
        }
        field(2; "Claim Date"; Date)
        {
            Caption = 'Claim Date';
            DataClassification = CustomerContent;
        }
        field(3; "Service Provider"; Code[20])
        {
            Caption = 'Service Provider';
            DataClassification = CustomerContent;
            // TableRelation = Vendor WHERE ("Vendor Type" = FILTER (Medical));

            trigger OnValidate();
            begin
                if VendorRec.GET("Service Provider") then
                    "Service Provider Name" := VendorRec.Name;
            end;
        }
        field(4; "Service Provider Name"; Text[100])
        {
            Caption = 'Service Provider Name';
            DataClassification = CustomerContent;
        }
        field(5; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(6; Claimant; Option)
        {
            Caption = 'Claimant';
            DataClassification = CustomerContent;
            OptionMembers = " ","Service Provider",Employee;
        }
        field(7; Amount; Decimal)
        {
            Caption = 'Amount';
            //DataClassification = CustomerContent;
            CalcFormula = Sum ("Claim Line".Amount WHERE ("Claim No" = FIELD ("Claim No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; Settled; Boolean)
        {
            Caption = 'Settled';
            DataClassification = CustomerContent;
        }
        field(9; "Cheque No"; Code[20])
        {
            Caption = 'Cheque No';
            DataClassification = CustomerContent;
        }
        field(10; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            OptionMembers = Open,Released,"Pending Approval","Pending Prepayment",Rejected;
        }
        field(11; "Transferred to Journal"; Boolean)
        {
            Caption = 'Transferred to Journal';
            DataClassification = CustomerContent;
        }
        field(12; "No. of Approvals"; Integer)
        {
            Caption = 'No. of Approvals';
            CalcFormula = Count ("Approval Entry" WHERE ("Table ID" = CONST (51511183),
                                                        "Document No." = FIELD ("Claim No")));
            FieldClass = FlowField;
        }
        field(13; "Fiscal Year"; Code[50])
        {
            Caption = 'Fiscal Year';
            DataClassification = CustomerContent;
            TableRelation = "G/L Budget Name".Name;
        }
    }

    keys
    {
        key(Key1; "Claim No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        if "Claim No" = '' then begin
            HumanResSetup.GET;
            //   HumanResSetup.TESTFIELD(HumanResSetup."Medical Claim Nos");
            //  NoSeriesMgt.InitSeries(HumanResSetup."Medical Claim Nos", xRec."No. Series", 0D, "Claim No", "No. Series");
        end;

        "Claim Date" := TODAY;
        //ERROR("Claim No");

        GLSetup.RESET;
        GLSetup.GET;
        //  "Fiscal Year" := GLSetup."Current Budget";
    end;

    var
        VendorRec: Record Vendor;
        HumanResSetup: Record "Human Resources Setup";
        // NoSeriesMgt: Codeunit NoSeriesManagement;
        GLSetup: Record "General Ledger Setup";
}

