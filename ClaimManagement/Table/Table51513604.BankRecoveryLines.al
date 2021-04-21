table 51513604 "Bank Recovery Lines"
{
    Caption = 'Bank Recovery Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Claim No."; Code[20])
        {
            Caption = 'Claim No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(2; "Contract No."; Code[20])
        {
            Caption = 'Contract No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(3; "CGC No."; Code[30])
        {
            Caption = 'CGC No.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(4; "SetupEntryNo."; Integer)
        {
            Caption = 'SetupEntryNo.';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(5; "Document Required"; Text[50])
        {
            Caption = 'Document Required';
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(6; "Document Provided"; Option)
        {
            Caption = 'Document Provided';
            DataClassification = ToBeClassified;
            OptionMembers = " ",No,Yes;
        }
        field(7; "Brief Explanation"; Text[100])
        {
            Caption = 'Brief Explanation';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "Claim No.", "Contract No.", "SetupEntryNo.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin

    end;

    trigger OnDelete()
    var
        myInt: Integer;
    begin

    end;

    trigger OnModify()
    var
        myInt: Integer;
    begin

    end;

    procedure FnInsertBankRecoveryLines(var ClaimNo: Code[20]; var ContractNo: Code[20]; Var CGCNo: Code[30])
    var
        ObjRecSetup: Record "Bank Recovery Doc Setup";

    begin
        ObjRecSetup.Reset();
        if ObjRecSetup.FindSet() then
            repeat
                Init();
                "Claim No." := ClaimNo;
                "Contract No." := ContractNo;
                "CGC No." := CGCNo;
                "SetupEntryNo." := ObjRecSetup."Entry No";
                "Document Required" := ObjRecSetup."Required Document";
                Insert();
            until ObjRecSetup.Next() = 0;
    end;

}
